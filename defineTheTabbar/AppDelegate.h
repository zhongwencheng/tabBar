//
//  AppDelegate.h
//  WitnessSystem
//
//  Created by 张森 on 15/12/30.
//  Copyright © 2015年 张森. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZSTabBarController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    UINavigationController *navigationController;
    
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ZSTabBarController * tabbar;
-(void)showWindowHome:(NSString*)windowType;
@end

