//
//  ZXCoreMotion.h
//  weiPhone
//
//  Created by 张旭 on 16/7/15.
//  Copyright © 2016年 zhangXu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>
typedef void (^openAcceleratedGravityUpBlock)(float x,float y,float z);
typedef void (^openGravityUpBlock)(float x,float y,float z);
typedef void (^openDeviceMotionUpBlock)(float x,float y,float z);
@interface ZXCoreMotion : NSObject
@property (nonatomic,strong)CMMotionManager *manager;
/**
 *  时间间隔
 */
@property (nonatomic ,assign)float timeInterval;
@property (nonatomic ,copy)openAcceleratedGravityUpBlock block;
@property (nonatomic ,copy)openGravityUpBlock gravityblock;
@property (nonatomic ,copy)openDeviceMotionUpBlock deviceMotionblock;
+(ZXCoreMotion*)shareInstance;

/**
 *  开启重力加速度 使用block 返回xyz
 */

//-(void)openAcceleratedGravityUpBlock:(void(^)(float x,float y,float z))block;

-(void)openAccelerteGravity:(openAcceleratedGravityUpBlock)block;

/**
 *  开启重力感应
 */

-(void)openGravity:(openGravityUpBlock)block;

/**
 *  开启陀螺仪
 */

-(void)openDeviceMotion:(openDeviceMotionUpBlock)block;

/**
 *  停止
 */

-(void)stop;


@end
