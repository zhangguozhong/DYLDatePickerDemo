//
//  DYLDatePickerManager.h
//  DYLDatePickerDemo
//
//  Created by mannyi on 2017/6/15.
//  Copyright © 2017年 mannyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DYLDatePickerManager : NSObject

+ (instancetype)sharedManager;

- (NSDateFormatter *)formatter;

- (NSInteger)distanceFrom:(NSString *)beginDateStr to:(NSString *)endDateStr;

@end
