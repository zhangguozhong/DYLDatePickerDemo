//
//  DYLDatePickerManager.m
//  DYLDatePickerDemo
//
//  Created by mannyi on 2017/6/15.
//  Copyright © 2017年 mannyi. All rights reserved.
//

#import "DYLDatePickerManager.h"

static CGFloat const DYLDatePickerDistanceTimeInterval = 86400;

@interface DYLDatePickerManager ()

@property (strong, nonatomic) NSDateFormatter *formatter;

@end

@implementation DYLDatePickerManager

+ (instancetype)sharedManager
{
    static dispatch_once_t onceDatePickerToken;
    static DYLDatePickerManager *datePickerManager;
    
    dispatch_once(&onceDatePickerToken, ^{
        datePickerManager = [[DYLDatePickerManager alloc] init];
    });
    return datePickerManager;
}

- (NSDateFormatter *)formatter
{
    if (!_formatter) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd";
        _formatter = formatter;
    }
    return _formatter;
}


- (NSInteger)distanceFrom:(NSString *)beginDateStr to:(NSString *)endDateStr
{
    if (beginDateStr && endDateStr) {
        NSTimeInterval distance = [[self.formatter dateFromString:endDateStr] timeIntervalSinceReferenceDate] - [[self.formatter dateFromString:beginDateStr] timeIntervalSinceReferenceDate];
        
        return (distance / DYLDatePickerDistanceTimeInterval);
    }
    return 0;
}

@end
