//
//  AppDelegate.h
//  WitnessSystem
//
//  Created by 张森 on 15/12/30.
//  Copyright © 2015年 张森. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMKMapManager.h"
#import "ZSTabBarController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    UINavigationController *navigationController;
    BMKMapManager* _mapManager;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ZSTabBarController * tabbar;
-(void)showWindowHome:(NSString*)windowType;
@end

