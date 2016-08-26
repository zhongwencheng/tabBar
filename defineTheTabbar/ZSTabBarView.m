//
//  ZSTabBarView.m
//  test
//
//  Created by 张森 on 15/9/28.
//  Copyright (c) 2015年 张森. All rights reserved.
//

#import "ZSTabBarView.h"
#import "ZSTabBarButton.h"

@interface ZSTabBarView ()
{
    //保存所有item对象
    NSArray *_items;
    
    TabBarViewDidSelectedIndexBlock _block;
}
@end

@implementation ZSTabBarView

#pragma setter方法
- (void)setTabBarViewDidSelectedIndexWithBlock:(TabBarViewDidSelectedIndexBlock)block
{
    _block = block;
}
- (instancetype)init{
    if (self = [super init]) {
    
    }
    return self;
}
- (void)setTabBarItems:(NSArray *)items
{
    if (items.count == 0)
    {
        return;
    }
    
    _items = items;
    
    //按钮宽度
    CGFloat buttonWidth = self.frame.size.width / items.count;
//    for (int i = 0; i<self.subviews.count; i++) {
//        [[self viewWithTag:i+1]removeFromSuperview];
//    }
    //创建GPTabbarButton对象
    for (int i = 0; i < items.count; i++)
    {
        ZSTabBarButton *button = [[ZSTabBarButton alloc] initWithFrame:CGRectMake(buttonWidth * i, 0, buttonWidth, kTabBarViewHeight)];
        //设置图片，文字，选中的图片，徽标
        button.tabBarItem = items[i];
        //设置tag
        button.tag = i + 1;
        //添加事件
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        //第一个默认选中
        if (i == 0)
        {
            button.selected = YES;
        }
    }

}

- (void)setSelectTag:(NSUInteger)selectTag{
    _selectTag = selectTag;
    
    for (int i = 0; i < _items.count; i++)
    {
        ZSTabBarButton *unSelectedButton = (ZSTabBarButton *)[self viewWithTag:i+1];
        unSelectedButton.selected = NO;
    }
    ZSTabBarButton * tabbarButton = [self viewWithTag:selectTag+1];
    tabbarButton.selected = YES;
}

#pragma mark - tabbarButton点击事件处理
- (void)buttonClick:(ZSTabBarButton *)clickButton
{
    //1.先把所有的按钮改为未选中状态
    for (int i = 0; i < _items.count; i++)
    {
        ZSTabBarButton *unSelectedButton = (ZSTabBarButton *)[self viewWithTag:i+1];
        unSelectedButton.selected = NO;
    }
    
    //2.再把当前点击的按钮改为选中状态
    clickButton.selected = YES;
    
    //3.回调
    if (_block)
    {
        _block(clickButton.tag - 1);
    }
}

- (void)hiddenBadgeLabel:(BOOL)hidden{
     ZSTabBarButton *button = (ZSTabBarButton *)[self viewWithTag:_items.count];
    button.badgeLabel.text = button.tabBarItem.badgeValue;
    button.badgeLabel.hidden = hidden;
    
}
- (void)changeBadgeNumber:(NSString *)content{
    ZSTabBarButton *button = (ZSTabBarButton *)[self viewWithTag:_items.count];
    button.badgeLabel.text = content;
    if (content.integerValue > 0) {
        button.badgeLabel.hidden = NO;
    }else{
        button.badgeLabel.hidden = YES;
    }
}
@end
