//
//  AppDelegate.m
//  WitnessSystem
//
//  Created by 张森 on 15/12/30.
//  Copyright © 2015年 张森. All rights reserved.
//

#import "AppDelegate.h"
#import "NavigationController.h"
#import "ViewController.h"
#import "ViewController1.h"
#import "ViewController2.h"
@interface AppDelegate ()<UIAlertViewDelegate>{
    ZSTabBarController *_loginTabbar;
    NavigationController * _navigation;
    NavigationController * _infoNavigation;
    NavigationController * _managerNavigation;
    NSString * _downLoadPath;
    NSInteger _badgeValue;
    BOOL _isNotification;
   
}
@property (nonatomic,assign)BOOL isLocation;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    _tabbar = [[ZSTabBarController alloc]init];
    ViewController * viewController = [[ViewController alloc]init];
    _navigation = [[NavigationController alloc]initWithRootViewController:viewController];
    ViewController1 * infoViewController = [[ViewController1 alloc]init];
    _infoNavigation = [[NavigationController alloc]initWithRootViewController:infoViewController];
    _managerNavigation = [[NavigationController alloc]initWithRootViewController:[[ViewController2 alloc]init]];
    _tabbar.viewControllers = @[_navigation,_infoNavigation,_managerNavigation];
    self.window.rootViewController = _tabbar;
    return YES;
}
- (void)requestVersion{
//    @"http://itunes.apple.com/lookup"
    NSString * urlString = [NSString stringWithFormat:@"https://test-nts-ows-gzh.pa18.com:33443/apk/lookup.do?id=%@",@"com.pingan.RunWitnessSystemTest"];
    NSURL * url = [NSURL URLWithString:urlString];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:20];//设置超时时间
    [request setHTTPMethod:@"POST"];//设置请求方式
    NSOperationQueue *queue=[[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (!connectionError) {
           NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&connectionError];
            [self isUpdateVersion:dict];
        }
    }];
}

- (void)isUpdateVersion:(id)responseObject{
    for (NSDictionary * dict in responseObject[@"results"]) {
        if (![[[NSBundle mainBundle]infoDictionary][@"CFBundleShortVersionString"] isEqualToString:dict[@"version"]]) {
            _downLoadPath = dict[@"trackViewUrl"];
            [self promptUpdateVersion:dict];
            break;
        }
    }
}

- (void)promptUpdateVersion:(NSDictionary *)dict{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"%@有新版本%@，需要更新后使用",dict[@"trackName"],dict[@"version"]] delegate:self cancelButtonTitle:@"退出" otherButtonTitles:@"更新", nil];
    dispatch_async(dispatch_get_main_queue(), ^{
       [alert show];
    });
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self exitApplication];
    }else{
        UIApplication *application = [UIApplication sharedApplication];
        [application openURL:[NSURL URLWithString:_downLoadPath]];
//        @"https://itunes.apple.com/cn/app/id414478124?mt=8"
        [self exitApplication];
    }
}

- (void)exitApplication{
    
    [UIView animateWithDuration:0.25 animations:^{
        self.window.alpha = 0;
        self.window.frame = CGRectMake(self.window.bounds.size.width*0.5, self.window.bounds.size.width, 0, 0);
    } completion:^(BOOL finished) {
        exit(0);
    }];
    
}

- (void)roleChange:(NSNotification *)notification{
    if ([notification.object containsString:@"角色"]) {
        if([notification.object isEqualToString:@"管理角色"]){
            _tabbar.viewControllers = @[_navigation,_managerNavigation,_infoNavigation];
            _tabbar.selectedIndex = 2;
        }else{
            _tabbar.viewControllers = @[_navigation,_infoNavigation];
            _tabbar.selectedIndex = 1;
        }
    }else{
    if ([notification.object containsString:@"管理"]) {
        _tabbar.viewControllers = @[_navigation,_managerNavigation,_infoNavigation];
    }else{
        _tabbar.viewControllers = @[_navigation,_infoNavigation];
    }
    }
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if (![change[@"new"] isKindOfClass:[NSNull class]]||![change[@"old"] isKindOfClass:[NSNull class]]) {
        
        if ([change[@"new"] isEqualToString:change[@"old"]]) {
            return;
        }else if([change[@"new"] isEqualToString:@"管理员"]){
            _tabbar.viewControllers = @[_navigation,_managerNavigation,_infoNavigation];
            _tabbar.selectedIndex = 2;
        }else{
            _tabbar.viewControllers = @[_navigation,_infoNavigation];
            _tabbar.selectedIndex = 1;
        }

    }
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.

}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    UIView *promptView = [self.window viewWithTag:11000 + 1];//提示栏
    if (promptView) {
        [promptView removeFromSuperview];
    }
    UIView *infosView = [self.window viewWithTag:11000 + 2];//查看更过页
    if (infosView) {
        [infosView removeFromSuperview];
    }
    UIView *acDeclareView = [self.window viewWithTag:11000 + 3];//账户任务确认页
    if (acDeclareView) {
        [acDeclareView removeFromSuperview];
    }
    UIView *inDeclareView = [self.window viewWithTag:11000 + 4];//面签任务确认页
    if (inDeclareView) {
        [inDeclareView removeFromSuperview];
    }
    
    UIView *progressHUD = [self.window viewWithTag:11000 + 5];//菊花页
    if (progressHUD.superview) {
        [progressHUD removeFromSuperview];
    }
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    _badgeValue = 0;
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"present" object:nil];
    //[self requestVersion];
}
- (void)showWindowHome:(NSString *)windowType{
    if ([windowType isEqualToString:@"logout"]) {
        //重置角色选择
        //[[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"changedRole"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"gestureOne"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"gestureTwo"];
       
        [_tabbar setSelectedIndex:0];
        self.window.rootViewController = _tabbar;
        
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    application.applicationIconBadgeNumber = 0;
//    if (_isNotification == NO) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"requestMessage" object:nil];
//    }
    [self requestVersion];
   

}
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
