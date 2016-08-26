//
//  ZSTabBarButton.m
//  test
//
//  Created by 张森 on 15/9/28.
//  Copyright (c) 2015年 张森. All rights reserved.
//

#import "ZSTabBarButton.h"
#import "UIView+Frame.h"

//图片距离上部的距离
#define kImageViewYOffset 0
//图片视图高度
#define kImageViewHeight 49
//徽标label的高度
#define kBadgeLabelHeight 14
//徽标的字体大小
#define kBadgeLabelFont 13
//徽标最大宽度
#define kBadgeLabelMaxWidth 20


@interface ZSTabBarButton()

/**
 *  图片
 */
@property (nonatomic, weak) UIImageView *imageView;

/**
 *  文字
 */
@property (nonatomic, weak) UILabel *titleLabel;

///**
// *  徽标
// */
//@property (nonatomic, weak) UILabel *badgeLabel;

@end

@implementation ZSTabBarButton
- (UIImageView *)imageView
{
    if (!_imageView)
    {
        UIImageView *imageView = [[UIImageView alloc] init];
        //最佳比例显示，保证图片不拉伸
        imageView.contentMode = UIViewContentModeCenter;
        [self addSubview:imageView];
        
        _imageView = imageView;
    }
    
    return _imageView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        UILabel *label = [self createLabelWithTextColor:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentCenter];
        label.backgroundColor = [UIColor greenColor];
        [self addSubview:label];
        
        _titleLabel = label;
    }
    
    return _titleLabel;
}

-(UILabel *)badgeLabel
{
    if (!_badgeLabel)
    {
        UILabel * badge = [self createLabelWithTextColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:8] textAlignment:NSTextAlignmentCenter];
        badge.backgroundColor = [UIColor redColor];
        [self addSubview:badge];
        _badgeLabel = badge;
    }
    return _badgeLabel;
}

+(id)tabBarButtonWithAddView:(UIView *)view
{
    ZSTabBarButton * tabBarButton = [[ZSTabBarButton alloc]init];
    [view addSubview:tabBarButton];
    return tabBarButton;
}

#pragma mark - 重写父类setSelected:方法
- (void)setSelected:(BOOL)selected
{
    
    UIImage *image = nil;
    UIColor *textColor = nil;
    
    //选中
    if (selected)
    {
        image = _tabBarItem.selectedImage;
        textColor = [UIColor orangeColor];
    }
    else
    {
        image = _tabBarItem.image;
        textColor = [UIColor lightGrayColor];
    }
    //赋值
    self.imageView.image = image;
    self.titleLabel.textColor = textColor;
}


-(void)setTabBarItem:(UITabBarItem *)tabBarItem
{
    _tabBarItem = tabBarItem;
    
    //赋值
    self.imageView.image = tabBarItem.image;
    self.titleLabel.text = tabBarItem.title;
    
    if (tabBarItem.badgeValue)
    {
        //1.显示
        self.badgeLabel.hidden = NO;
        
        //2.赋值
        self.badgeLabel.text = tabBarItem.badgeValue;
        
        //3/重新设置徽标的label的坐标大小
        [self resetBadgeLabelFrame];
        
    }
    else
    {
        //隐藏
        self.badgeLabel.hidden = YES;
    }
}

#pragma mark --- 布局
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //设置frame
    self.imageView.frame = CGRectMake(0, 0, self.width, kImageViewHeight);
    self.titleLabel.frame = CGRectMake(0, kImageViewYOffset + kImageViewHeight, self.width, self.height - kImageViewHeight - kImageViewYOffset);
    /**
     *  重新设置徽标的label的坐标大小
     */
    [self resetBadgeLabelFrame];
}
/**
 *  重新设置徽标的label的坐标大小
 */
- (void)resetBadgeLabelFrame
{
    //计算文字宽度
   // CGFloat width = [self.tabBarItem.badgeValue boundingRectWithSize:CGSizeMake(kBadgeLabelMaxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kBadgeLabelFont]} context:nil].size.width;
    
    if ([self.badgeLabel.text isEqualToString:@"0"])
    {
        self.badgeLabel.hidden = YES;
        //return;
    }
    
    //调整徽标的宽度
    CGRect frame = self.badgeLabel.frame;
    if ([self.badgeLabel.text isEqualToString:@""])
    {
        frame.size.height = kBadgeLabelHeight / 2;
        frame.size.width = frame.size.height;
        frame.origin.x = self.width - frame.size.width * 3;
    }
    else
    {
        frame.size.height = kBadgeLabelHeight;
//        frame.size.width = width > frame.size.height ? width + 10 : MAX(frame.size.height, width + 10);
//        frame.origin.x = width > frame.size.height ? self.width - frame.size.width - frame.size.height : width > 10 ? self.width - frame.size.width * 1.6 : self.width - frame.size.width * 2;
        frame.size.width = kBadgeLabelHeight;
        //图片定宽40
        frame.origin.x = self.width *0.5+10;
    }
    frame.origin.y = 5;
    self.badgeLabel.frame = frame;
    
    self.badgeLabel.layer.cornerRadius = frame.size.height / 2;
    self.badgeLabel.layer.masksToBounds = YES;
}

- (UILabel *)createLabelWithTextColor:(UIColor *)textColor font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment
{
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = textAlignment;
    label.textColor = textColor;
    
    if (!font)
    {
        label.font = [UIFont systemFontOfSize:17];
    }
    else
    {
        label.font = font;
    }
    
    return label;
}
@end
