//
//  ZXGuideView.m
//  weiPhone
//
//  Created by 张旭 on 16/7/19.
//  Copyright © 2016年 zhangXu. All rights reserved.
//

#import "ZXGuideView.h"
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
@implementation ZXGuideView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self updateUI];
    }
    
    
    return self;
}

-(void)updateUI{
    
    self.guideScorlView = [[UIScrollView alloc]initWithFrame:self.frame];
    self.guideScorlView.backgroundColor = [UIColor redColor];
    self.guideScorlView.contentSize = CGSizeMake(SCREEN_WIDTH*3, SCREEN_HEIGHT);
    self.guideScorlView.bounces = NO;
    self.guideScorlView.pagingEnabled = YES;
    self.guideScorlView.showsHorizontalScrollIndicator = NO;
    self.guideScorlView.delegate = self;
    [self addSubview:_guideScorlView];
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH*3, SCREEN_HEIGHT)];
    NSString  *path = [[NSBundle mainBundle]pathForResource:@"AppReleaseInfo-568h" ofType:@"jpg"];
    
    imgView.image = [UIImage imageWithContentsOfFile:path];
    [self.guideScorlView addSubview:imgView];
    
    

}


/*
 
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
