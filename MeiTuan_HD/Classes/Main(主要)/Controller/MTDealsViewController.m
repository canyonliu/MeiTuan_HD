//
//  MTDealsViewController.m
//  MeiTuan_HD
//
//  Created by WayneLiu on 15/8/22.
//  Copyright (c) 2015年 WayneLiu. All rights reserved.
// 团购列表控制器


#import "MTDealsViewController.h"
#import "MJRefresh.h"
#import "DPAPI.h"
#import "MTDealCell.h"
#import "UIView+AutoLayout.h"
#import "MTConst.h"
#import "MJExtension.h"
#import "MTDeal.h"
#import "UIView+Extension.h"
#import "MBProgressHUD+MJ.h"

@interface MTDealsViewController ()<DPRequestDelegate>

/** 所有的团购数据*/
@property (nonatomic, strong)NSMutableArray *deals;
/** 没有数据时显示的图片*/
@property (nonatomic ,weak) UIImageView  *noDataView;



/**  记录当前页码*/
@property (nonatomic, assign)int currentPage;
/**总数**/
@property (nonatomic, assign)int totalCount;
/**  保存最后一个请求*/
@property (nonatomic ,weak) DPRequest  *lastRequest;


@end

@implementation MTDealsViewController


static NSString * const reuseIdentifier = @"deal";


-(NSMutableArray *)deals{
    if(!_deals){
        self.deals = [[NSMutableArray alloc]init];
    }
    return _deals;
}

-(UIImageView *)noDataView{
    if(!_noDataView){
        
        //添加一个 "没有数据"的提醒
        UIImageView *noDataView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_deals_empty"]];
        //            noDataView.hidden = YES;
        [self.view addSubview:noDataView];
        [noDataView autoCenterInSuperview];
        self.noDataView = noDataView;
    }
    return _noDataView;
}




- (instancetype)init{
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc]init];
    //cell的大小
    flowlayout.itemSize = CGSizeMake(305, 305);
    //    在下面监听到频幕旋转的时候在设置内边距
    //    CGFloat inset = 15;
    //    flowlayout.sectionInset = UIEdgeInsetsMake(inset, inset, inset, inset);
    return [self initWithCollectionViewLayout:flowlayout];
}




- (void)viewDidLoad {
    [super viewDidLoad];
    //设置背景色
    self.collectionView.backgroundColor = MTGlobalBg;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"MTDealCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    //让collectionView的竖直方向永远有弹簧效果
    self.collectionView.alwaysBounceVertical = YES;
    
    

    
    //添加上拉加载更多(这个应用添加下拉刷新的意义不大)(但是后来又添加了下拉刷新)
    [self.collectionView addFooterWithTarget:self action:@selector(loadMoreDeals)];
    [self.collectionView addHeaderWithTarget:self action:@selector(loadNewDeals)];

}


/**
 *  当频幕旋转,控制器view的尺寸发生改变调用
 */
-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    MTLog(@"%@",NSStringFromCGSize(size));
    
    // 根据屏幕宽度决定列数
    int cols = (size.width == 1024) ? 3 : 2;
    
    // 根据列数计算内边距
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
    CGFloat inset = (size.width - cols * layout.itemSize.width) / (cols + 1);
    layout.sectionInset = UIEdgeInsetsMake(inset, inset, inset, inset);
    
    // 设置每一行之间的间距
    layout.minimumLineSpacing = inset;
    
}




#pragma mark -m 刷新表格数据(跟服务器交互)

- (void)loadDeals{
    DPAPI *api = [[DPAPI alloc]init];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [self setupParams:params];
    //每页的条数
    params[@"limit"] = @5;

    //页码
    params[@"page"] = @(self.currentPage);
    
    self.lastRequest = [api requestWithURL:@"v1/deal/find_deals" params:params delegate:self];
    
    MTLog(@"请求参数是:::: %@",params);
    
}

- (void)loadMoreDeals{
    self.currentPage++;
    [self loadDeals];
}


- (void)loadNewDeals{
    self.currentPage = 1;
    [self loadDeals];
    
}

-(void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result{
    //    MTLog(@"请求成功 --- %@",result);
    if(request != self.lastRequest ){
        return;
    }
    
    self.totalCount = [result[@"total_count"] intValue];
    //1. 取出团购的字典数组
    NSArray *newDeals = [MTDeal objectArrayWithKeyValuesArray:result[@"deals"]];
    if (self.currentPage == 1) {
        //清除之前的旧数据
        [self.deals removeAllObjects];
    }
    
    [self.deals addObjectsFromArray:newDeals];
    MTLog(@"请求成功 --- %@",newDeals);
    
    //2.刷新表格
    [self.collectionView reloadData];
    //3,结束上拉加载
    [self.collectionView footerEndRefreshing];
    [self.collectionView headerEndRefreshing];
    
    
}

-(void)request:(DPRequest *)request didFailWithError:(NSError *)error{
    MTLog(@"请求失败 --- %@",error);
    
    if(request != self.lastRequest ){
        return;
    }
    
    //1.提醒失败
#warning  在支持横竖屏的情况下,HUD信息最好不要添加到window上
    [MBProgressHUD showError:@"网络繁忙,请稍候再试" toView:self.view];
    //2.结束上拉加载
    [self.collectionView footerEndRefreshing];
    [self.collectionView headerEndRefreshing];
    //3.如果上拉加载失败了
    if(self.currentPage > 1 ){
        self.currentPage-- ;
    }
}







#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete method implementation -- Return the number of sections
    //计算一遍内间距
    [self viewWillTransitionToSize:CGSizeMake(collectionView.width, 0) withTransitionCoordinator:nil];
    
    //控制尾部刷新控件的显示与隐藏
    self.collectionView.footerHidden =  self.totalCount == self.deals.count;
    self.collectionView.headerHidden =  self.totalCount == self.deals.count;
    //控制"没有数据"时的提醒
    self.noDataView.hidden = (self.deals.count != 0);
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete method implementation -- Return the number of items in the section
    return self.deals.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MTDealCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.deal = self.deals[indexPath.item];
    // Configure the cell
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

@end
