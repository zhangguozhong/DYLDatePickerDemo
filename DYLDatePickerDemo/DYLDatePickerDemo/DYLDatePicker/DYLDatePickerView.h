//
//  DYLDatePickerView.h
//  DYLDatePickerDemo
//
//  Created by mannyi on 2017/6/15.
//  Copyright © 2017年 mannyi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DYLDatePickerView;

typedef NS_ENUM(NSInteger, DYLDateType) {
    DYLDateTypeStartDate = 0,
    DYLDateTypeEndDate
};

@protocol DYLDatePickerViewDelegate <NSObject>

@optional
- (void)callback:(DYLDatePickerView *)datePickerView beginDateStr:(NSString *)beginDateStr endDateStr:(NSString *)endDateStr;

@end

typedef void(^CallbackCompleteBlock)(NSString *beginDateStr, NSString *endDateStr);

@interface DYLDatePickerView : UIView

@property (assign, nonatomic) NSInteger maximumIntervalDay;

@property (strong, nonatomic) NSString *minLimitDate;

@property (assign, nonatomic) NSTimeInterval duration;

@property (weak, nonatomic) id<DYLDatePickerViewDelegate> delegate;

@property (copy, nonatomic) CallbackCompleteBlock completeBlock;

- (void)show;

- (void)hide;

@end
