//
//  NavigationController.m
//  WitnessSystem
//
//  Created by 张森 on 16/1/7.
//  Copyright © 2016年 张森. All rights reserved.
//

#import "NavigationController.h"
#import "AppDelegate.h"

@interface NavigationController ()

@end

@implementation NavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.translucent = NO;//设置成半透明
    self.interactivePopGestureRecognizer.enabled = NO;
    [self.navigationBar setBarTintColor:kORANGECOLOR];
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:kTITLEFONT};
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [self.navigationBar setBarTintColor:[UIColor whiteColor]];
    ZSTabBarController * tabbar = (ZSTabBarController *) [UIApplication sharedApplication].keyWindow.rootViewController;
    tabbar.tabBarView.hidden = YES;
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated{
    if (self.viewControllers.count == 2) {
        [self.navigationBar setBarTintColor:kORANGECOLOR];
        AppDelegate *app = [UIApplication sharedApplication].delegate;
        app.tabbar.tabBarView.hidden = NO;
        self.navigationBarHidden = NO;
    }
    if (self.viewControllers.count == 3) {
        self.navigationBarHidden = YES;

    }
    return [super popViewControllerAnimated:animated];
}

- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated{
    [self.navigationBar setBarTintColor:kORANGECOLOR];
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    app.tabbar.tabBarView.hidden = NO;
    self.navigationBarHidden = NO;
    return [super popToRootViewControllerAnimated:animated];
}

@end
