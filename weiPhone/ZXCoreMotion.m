//
//  ZXCoreMotion.m
//  weiPhone
//
//  Created by 张旭 on 16/7/15.
//  Copyright © 2016年 zhangXu. All rights reserved.
//

#import "ZXCoreMotion.h"

@implementation ZXCoreMotion
{
    NSOperationQueue *_queue;//开启线程

    void (^_openAcceleratedGravityUpBlock)(float x,float y,float z);
    void (^_openGravityUpBlock)(float x,float y,float z);
    void (^_openDeviceMotionUpBlock)(float x,float y,float z);
}
+ (ZXCoreMotion *)shareInstance{
    
    static ZXCoreMotion *coreMotin = nil;
    static dispatch_once_t one;
    dispatch_once(&one, ^{
        coreMotin = [[self alloc]init];
    });
    return coreMotin;
    
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self configGravity];
    }
    return self;
}




-(void)configGravity{
    
    _manager = [[CMMotionManager alloc]init];
    
    //添加线程队列
    _queue = [[NSOperationQueue alloc]init];
    
}


- (void)openGravity:(openGravityUpBlock)block{
    
    //重力感应
    if (_manager.gyroAvailable) {
        //更新速度
        _manager.gyroUpdateInterval = _timeInterval;
        
        
        [_manager startGyroUpdatesToQueue:_queue withHandler:^(CMGyroData * _Nullable gyroData, NSError * _Nullable error) {
            if (error) {
                //停止重力感应更新
                [_manager stopGyroUpdates];
                NSLog(@"%@",[NSString stringWithFormat:@"gryerror:%@",error]);
            }else{
            
                _openGravityUpBlock = block;
                //回主线程
                [self performSelectorOnMainThread:@selector(gyroUpdate:) withObject:gyroData waitUntilDone:NO];

            }
            
        }];
  
    }else{
        NSLog(@"该设备没有重力感应");
    }
 
}

- (void)openAccelerteGravity:(openAcceleratedGravityUpBlock)block{
    
    //加速度
    if (_manager.accelerometerAvailable) {
        //更新速度
        _manager.accelerometerUpdateInterval = _timeInterval;
        
        [_manager startAccelerometerUpdatesToQueue:_queue withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
            _openAcceleratedGravityUpBlock = block;
            if (error) {
                [_manager stopAccelerometerUpdates];
                NSLog(@"%@",error.localizedDescription);

            }
            else{
                [self performSelectorOnMainThread:@selector(accelerometerUpdate:) withObject:accelerometerData waitUntilDone:NO];
                
            }
        }];
        
    }else{
        NSLog(@"设备没有加速器");
    }
    
}

- (void)openDeviceMotion:(openDeviceMotionUpBlock)block{
    
    //判断陀螺仪
    if (_manager.deviceMotionAvailable) {
        //更新
        _manager.deviceMotionUpdateInterval = _timeInterval;
        [_manager startDeviceMotionUpdatesToQueue:_queue withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
            _openDeviceMotionUpBlock  = block;
            if (error) {
                [_manager stopDeviceMotionUpdates];
                NSLog(@"%@",error.localizedDescription);
            }else{
                [self performSelectorOnMainThread:@selector(deviceMotionUpdate:) withObject:motion waitUntilDone:NO];
            }
            
        }];
    }else{
        NSLog(@"设备没有陀螺仪");
    }
}

-(void)gyroUpdate:(CMGyroData *)gyroData{
    //分量
    _openGravityUpBlock(gyroData.rotationRate.x,gyroData.rotationRate.y,gyroData.rotationRate.z);
}

-(void)accelerometerUpdate:(CMAccelerometerData*)accelerometerData{
    //重力加速度三维分量
    _openAcceleratedGravityUpBlock(accelerometerData.acceleration.x,accelerometerData.acceleration.y,accelerometerData.acceleration.z);
    
}
-(void)deviceMotionUpdate:(CMDeviceMotion *)motionData{
    _openDeviceMotionUpBlock(motionData.rotationRate.x,motionData.rotationRate.y,motionData.rotationRate.z);
}

- (void)stop{
    [_manager stopGyroUpdates];
    [_manager stopDeviceMotionUpdates];
    [_manager stopAccelerometerUpdates];

}



@end
