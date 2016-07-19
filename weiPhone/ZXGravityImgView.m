//
//  ZXGravityImgView.m
//  weiPhone
//
//  Created by 张旭 on 16/7/18.
//  Copyright © 2016年 zhangXu. All rights reserved.
//

#import "ZXGravityImgView.h"
#import "ZXCoreMotion.h"

#define SPEED 50
@implementation ZXGravityImgView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self updateUI];
    }
    
    
    return self;
}

-(void)updateUI{
    
    _fengImgView  =[[UIImageView alloc]init];
    [self addSubview:_fengImgView];
    
    
}


- (void)setFengImg:(UIImage *)fengImg{
    
    _fengImg = fengImg;
    _fengImgView.image = fengImg;
    [_fengImgView sizeToFit];
    _fengImgView.frame = CGRectMake(0, 0, self.frame.size.height *(_fengImgView.frame.size.width / _fengImgView.frame.size.height), self.frame.size.height);

    _fengImgView.center = CGPointMake(self.frame.size.width/2,self.frame.size.height/2);
}

- (void)startGravity{
    
    float scrollSpeed = (_fengImgView.frame.size.width-self.frame.size.width)/2/25;
    [ZXCoreMotion shareInstance].timeInterval = 0.01;
    [[ZXCoreMotion shareInstance]openDeviceMotion:^(float x, float y, float z) {
       [UIView animateKeyframesWithDuration:0.3 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeDiscrete animations:^{
           if (_fengImgView.frame.origin.x<=0&&_fengImgView.frame.origin.x>=self.frame.size.width-_fengImgView.frame.size.width) {
               float invertedYRotationRate = y* 0.1;
               float interpretedXoffset = _fengImgView.frame.origin.x+invertedYRotationRate *(_fengImgView.frame.size.width/[UIScreen mainScreen].bounds.size.width) *scrollSpeed+_fengImgView.frame.size.width/2;
               
               
               _fengImgView.center = CGPointMake(interpretedXoffset, _fengImgView.center.y);
           }
           if (_fengImgView.frame.origin.x>0) {
                _fengImgView.frame = CGRectMake(0, _fengImgView.frame.origin.y, _fengImgView.frame.size.width, _fengImgView.frame.size.height);
           }
           
           if (_fengImgView.frame.origin.x<self.frame.size.width-_fengImgView.frame.size.width) {
                _fengImgView.frame = CGRectMake(self.frame.size.width - _fengImgView.frame.size.width, _fengImgView.frame.origin.y, _fengImgView.frame.size.width, _fengImgView.frame.size.height);
           }
           
           
           
       } completion:^(BOOL finished) {
           
       }];
        
        
    }];
    
}

- (void)stopGravity{
    
    [[ZXCoreMotion shareInstance]stop];
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
