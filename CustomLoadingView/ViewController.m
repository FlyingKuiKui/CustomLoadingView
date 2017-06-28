//
//  ViewController.m
//  CustomLoadingView
//
//  Created by 王盛魁 on 2017/6/28.
//  Copyright © 2017年 WangShengKui. All rights reserved.
//

#import "ViewController.h"
#import "WSKLoadingView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *testBtn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 50)];
    testBtn.backgroundColor = [UIColor blueColor];
    [testBtn addTarget:self action:@selector(testBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:testBtn];

    // Do any additional setup after loading the view, typically from a nib.
}
- (void)testBtnAction{
    [WSKLoadingView showLoadingView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
