//
//  ViewController.m
//  TJTestSubspecExcample
//
//  Created by malai on 2017/7/11.
//  Copyright © 2017年 malai. All rights reserved.
//

#import "ViewController.h"
#import <TJTestSubspec/TJModule1.h>

@interface ViewController ()

@property (nonatomic, strong) TJModule1 *module1;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    TJModule1 *modulel1 = [[TJModule1 alloc] init];
    
    _module1 = modulel1;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
