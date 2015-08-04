//
//  MTHomeLeftTopMenu.m
//  MeiTuan_HD
//
//  Created by WayneLiu on 15/7/17.
//  Copyright (c) 2015年 WayneLiu. All rights reserved.
//

#import "MTHomeLeftTopMenu.h"

@interface MTHomeLeftTopMenu()

@property (weak, nonatomic) IBOutlet UIButton *iconButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;


@end


@implementation MTHomeLeftTopMenu

+(instancetype)item{
    return [[[NSBundle mainBundle]loadNibNamed:@"MTHomeLeftTopMenu" owner:nil options:nil]firstObject];
}

-(void)awakeFromNib{
    self.autoresizingMask =UIViewAutoresizingNone;
}


-(void)addTarget:(id)target action:(SEL)action{
    
    [self.iconButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

-(void)setIcon:(NSString *)icon highlighedIcon:(NSString *)highlighedIcon{
    [self.iconButton setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [self.iconButton setImage:[UIImage imageNamed:highlighedIcon] forState:UIControlStateHighlighted];
}

- (void)setTitle:(NSString *)title{
    self.titleLabel.text = title;
}

- (void)setSubTitle:(NSString *)subTitle{
    self.subTitleLabel.text = subTitle;
}

@end

