//
//  ViewController.m
//  语法糖测试
//
//  Created by tusm on 2016/10/26.
//  Copyright © 2016年 cleven. All rights reserved.
//

#import "ViewController.h"
#import "NSBundle+CLObjcSugar.h"
#import "LocalPushCenter.h"
#import "UIImage+Extension.h"
#import "UIView+Shake.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *path = [[NSBundle mainBundle]cl_appIconPath];
    
    NSLog(@"===%@",path);
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 200, 100, 200)];
    
    imageView.image = [UIImage imageNamed:@"1"];
    
    [imageView.image cornerImageWithSize:imageView.bounds.size fillColor:[UIColor redColor] cornerRadius:20 completion:^(UIImage *image) {
       
        imageView.image = image;
    }];
    
    [imageView shakeWithOptions:SCShakeOptionsDirectionHorizontal force:1 duration:1 iterationDuration:1 completionHandler:nil];
    
    [self.view addSubview:imageView];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
