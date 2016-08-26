//
//  ZSTabBarController.h
//  test
//
//  Created by 张森 on 15/9/28.
//  Copyright (c) 2015年 张森. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZSTabBarView.h"

//双击回调
typedef void(^didSelectedBarBlock)();

@interface ZSTabBarController : UITabBarController
@property(nonatomic,weak)ZSTabBarView * tabBarView;

/**
 *  刷新控制器的回调,在viewWillAppear调用
 *
 *  @param block <#block description#>
 */
-(void)setDidSelectedBarBlock:(didSelectedBarBlock)block;
- (void)changeBadgeWithHidden:(BOOL)hidden;
@end
