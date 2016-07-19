//
//  ViewController.m
//  weiPhone
//
//  Created by 张旭 on 16/7/14.
//  Copyright © 2016年 zhangXu. All rights reserved.
//

#import "ViewController.h"
#import "ZXCoreMotion.h"
#import "ZXGravityImgView.h"
#import "ZXGuideView.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *fengImgView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor cyanColor];
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    NSString *version = [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"];
//    BOOL show = [userDefaults boolForKey:[NSString stringWithFormat:@"version_%@", version]];
//    
//    ZXGuideView *guideView = [[ZXGuideView alloc]initWithFrame:self.view.frame];
//    if (!show ) {
//        
//        [self.view addSubview:guideView];
//        
//        
//        [userDefaults setBool:YES forKey:[NSString stringWithFormat:@"version_%@", version]];
//        [userDefaults synchronize];
//    }

    
    
    ZXGravityImgView *imgView = [[ZXGravityImgView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    NSString  *path = [[NSBundle mainBundle]pathForResource:@"bg_landscape" ofType:@"jpg"];
    
    imgView.fengImg = [UIImage imageWithContentsOfFile:path];
    [_fengImgView addSubview:imgView.fengImgView];
    
    [imgView startGravity];
//    ZXGuideView *guideView = [[ZXGuideView alloc]initWithFrame:self.view.frame];
//    [self.view addSubview:guideView];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
