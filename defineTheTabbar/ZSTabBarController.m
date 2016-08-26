//
//  ZSTabBarController.m
//  test
//
//  Created by 张森 on 15/9/28.
//  Copyright (c) 2015年 张森. All rights reserved.
//

#import "ZSTabBarController.h"
#import "UIView+Frame.h"

@interface ZSTabBarController ()
{
    didSelectedBarBlock _block;
    NSDateFormatter *_dateFormatter;
    NSString *_userName;
    NSInteger _successNumber;
}
//保存每个控制器的UITabbarItem对象
@property (nonatomic, strong) NSMutableArray *items;
@end

@implementation ZSTabBarController
- (NSMutableArray *)items
{
    if (!_items)
    {
        _items = [NSMutableArray array];
    }
    
    return _items;
}

/**
 *  创建tabbarView对象
 *
 *  @return <#return value description#>
 */
- (ZSTabBarView *)tabBarView
{
    if (!_tabBarView)
    {
        ZSTabBarView *tabBarView = [[ZSTabBarView alloc] initWithFrame:CGRectMake(-1, self.view.height - kTabBarViewHeight, self.view.width+1, kTabBarViewHeight)];
        //设置层的内容
        tabBarView.layer.contents = (id)[UIImage imageNamed:@"bg-tab"].CGImage;
        [self.view addSubview:tabBarView];
        
        _tabBarView = tabBarView;
    }
    
    return _tabBarView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc]init];
        [_dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    /*
     系统tabbar高度是49
     */
    
    //1.隐藏系统tabbar
    self.tabBar.hidden = YES;
    
}

-(void)setViewControllers:(NSArray *)viewControllers
{
    
    //1.调用父类的setter方法
    [super setViewControllers:viewControllers];
    [self.items removeAllObjects];
    [self.tabBarView removeFromSuperview];
    self.tabBarView = nil;
    //2.遍历获取UITabbarItem
    for (int i = 0; i < viewControllers.count; i++)
    {
        UIViewController *vc = viewControllers[i];
        
        [self.items addObject:vc.tabBarItem];
    }
    self.tabBarView.layer.borderWidth = 1;
    self.tabBarView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.tabBarView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    
    //    2.创建tabbarView,并且添加tabbarButton
    [self.tabBarView setTabBarItems:self.items];
    
    //3.设置回调
    //    __weak typeof(self) selfTmp = self;
    [self.tabBarView setTabBarViewDidSelectedIndexWithBlock:^(NSInteger currentIndex)
     {
         //双击tabbar刷新
         [self didSelectedButtonFrom:self.selectedIndex to:currentIndex];
     }];
}

-(void)setDidSelectedBarBlock:(didSelectedBarBlock)block
{
    _block = block;
}

- (void)didSelectedButtonFrom:(NSInteger)from to:(NSInteger)to
{
    if (self.selectedIndex == to)
    {
        if (_block)
        {
            //回调控制器的刷新
            _block();
        }
    }
    //切换控制器
    self.selectedIndex = to;
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex{
    [super setSelectedIndex:selectedIndex];
    _tabBarView.selectTag = selectedIndex;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.selectedViewController beginAppearanceTransition: YES animated: animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.selectedViewController endAppearanceTransition];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.selectedViewController beginAppearanceTransition: NO animated: animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [self.selectedViewController endAppearanceTransition];
}
- (void)changeBadgeWithHidden:(BOOL)hidden{
    [self.tabBarView hiddenBadgeLabel:hidden];
}

- (void)changeBadgeNumber{
    [self.tabBarView changeBadgeNumber:[NSString stringWithFormat:@"%ld",_successNumber]];
}
@end
