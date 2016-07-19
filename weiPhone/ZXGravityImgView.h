//
//  ZXGravityImgView.h
//  weiPhone
//
//  Created by 张旭 on 16/7/18.
//  Copyright © 2016年 zhangXu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXGravityImgView : UIView

@property (nonatomic ,strong,readonly)UIImageView *fengImgView;
@property (nonatomic ,strong)UIImage *fengImg;

/**
 *  开始重力感应
 */

-(void)startGravity;

/**
 *  停止重力感应
 */
-(void)stopGravity;


@end
