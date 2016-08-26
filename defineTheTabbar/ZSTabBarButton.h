//
//  ZSTabBarButton.h
//  test
//
//  Created by 张森 on 15/9/28.
//  Copyright (c) 2015年 张森. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZSTabBarButton : UIControl

@property(nonatomic,strong)UITabBarItem * tabBarItem;
/**
 *  徽标
 */
@property (nonatomic, weak) UILabel *badgeLabel;
+(id)tabBarButtonWithAddView:(UIView *)view;

@end
