//
//  ViewController2.m
//  defineTheTabbar
//
//  Created by 钟文成(外包) on 16/8/26.
//  Copyright © 2016年 钟文成(外包). All rights reserved.
//

#import "ViewController2.h"

@interface ViewController2 ()

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    
}
-(instancetype)init{
    self=[super init];
    if (self) {
        self.tabBarItem.image = [UIImage imageNamed:@"teskMan2"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"teskMan"];
    }
    return self;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
