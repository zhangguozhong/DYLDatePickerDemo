//
//  ViewController.m
//  DYLDatePickerDemo
//
//  Created by mannyi on 2017/6/15.
//  Copyright © 2017年 mannyi. All rights reserved.
//

#import "ViewController.h"
#import "DYLDatePickerView.h"

@interface ViewController ()

@property (strong, nonatomic) UIButton *showDateButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor  = [UIColor whiteColor];
    self.showDateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.showDateButton.frame = CGRectMake(20, 100, 240, 40);
    [self.showDateButton setTitle:@"时间" forState:UIControlStateNormal];
    [self.showDateButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.showDateButton addTarget:self action:@selector(handleAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.showDateButton];
}



- (void)handleAction:(UIButton *)sender
{
    DYLDatePickerView *datePickerView = [[DYLDatePickerView alloc] init];
    datePickerView.maximumIntervalDay = 90;
    datePickerView.minLimitDate = @"2014-04-01";
    
    __weak typeof(self) weakSelf = self;
    datePickerView.completeBlock = ^(NSString *beginDateStr, NSString *endDateStr) {
        [weakSelf.showDateButton setTitle:[NSString stringWithFormat:@"%@-%@", beginDateStr, endDateStr] forState:UIControlStateNormal];
    };
    [datePickerView show];
}

@end
