//
//  ViewController1.m
//  defineTheTabbar
//
//  Created by 钟文成(外包) on 16/8/26.
//  Copyright © 2016年 钟文成(外包). All rights reserved.
//

#import "ViewController1.h"

@interface ViewController1 ()

@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blueColor];
   
}
-(instancetype)init{
    self=[super init];
    if (self) {
        self.tabBarItem.image = [UIImage imageNamed:@"person1"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"person2"];
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
