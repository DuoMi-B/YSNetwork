//
//  ViewController.m
//  YSNetworkDemo
//
//  Created by YS on 2020/7/16.
//  Copyright © 2020 DuoMi-B. All rights reserved.
//

#import "ViewController.h"
#import "DemoNetworkService.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[DemoNetworkService shareService] registerHttps];
    [[DemoNetworkService shareService] sendSmsCodeWithUrl:@"https://*****" params:nil method:HTTPMethod_GET callBack:^(BOOL isSuccess, NSDictionary * _Nullable responseObject) {
        if (isSuccess) {
            NSLog(@"%@",responseObject.description);
        }
    }];
}


@end
