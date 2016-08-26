//
//  ViewController.m
//  defineTheTabbar
//
//  Created by 钟文成(外包) on 16/8/26.
//  Copyright © 2016年 钟文成(外包). All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor purpleColor];
    
}
-(instancetype)init{
    self=[super init];
    if (self) {
        self.tabBarItem.image = [UIImage imageNamed:@"manage2"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"manage"];
    }
    return self;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
