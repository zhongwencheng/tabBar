//
//  ZSTabBarView.h
//  test
//
//  Created by 张森 on 15/9/28.
//  Copyright (c) 2015年 张森. All rights reserved.
//

#import <UIKit/UIKit.h>
//tabbar高度
#define kTabBarViewHeight 49

//点击tabbarButton的回调
typedef void(^TabBarViewDidSelectedIndexBlock)(NSInteger currentIndex);

@interface ZSTabBarView : UIView
@property (nonatomic ,assign) NSUInteger selectTag;
//设置tabbarItem
- (void)setTabBarItems:(NSArray *)items;

/**
 *  设置回调
 *
 *  @param block <#block description#>
 */
- (void)setTabBarViewDidSelectedIndexWithBlock:(TabBarViewDidSelectedIndexBlock)block;

- (void)hiddenBadgeLabel:(BOOL)hidden;
- (void)changeBadgeNumber:(NSString*)content;
@end
