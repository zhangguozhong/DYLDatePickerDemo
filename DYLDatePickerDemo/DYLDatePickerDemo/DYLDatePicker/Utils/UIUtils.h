//
//  UIUtils.h
//  DYLDatePickerDemo
//
//  Created by mannyi on 2017/6/15.
//  Copyright © 2017年 mannyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIUtils : NSObject

+ (UILabel *)labelTextColor:(UIColor *)textColor fontSize:(CGFloat)size;
+ (UILabel *)labelWithText:(NSString *)text fontSize:(CGFloat)size;
+ (UILabel *)labelWithTextColor:(UIColor *)textColor numberOfLines:(NSInteger)numberOfLines text:(NSString *)text fontSize:(CGFloat)size;
+ (UILabel *)labelWithTextColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment text:(NSString *)text fontSize:(CGFloat)size;
+ (UILabel *)labelWithBackgroudColor:(UIColor *)backgroundColor textColor:(UIColor *)textColor numberOfLines:(NSInteger)numberOfLines textAlignment:(NSTextAlignment)textAlignment text:(NSString *)text fontSize:(CGFloat)size;


+ (UIButton *)buttonWithTitle:(NSString *)title fontSize:(CGFloat)size;
+ (UIButton *)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor fontSize:(CGFloat)size cornerRadius:(CGFloat)cornerRadius;
+ (UIButton *)buttonWithBackgroundColor:(UIColor *)backgroundColor titleColor:(UIColor *)titleColor selectedColor:(UIColor *)selectedColor title:(NSString *)title fontSize:(CGFloat)size cornerRadius:(CGFloat)cornerRadius;


+ (UIView *)viewWithBackgroudColor:(UIColor *)backgroundColor;
+ (UISegmentedControl *)segmentViewWithTintColor:(UIColor *)tintColor items:(NSArray *)items;


+ (UIDatePicker *)datePickerWithLocale:(NSString *)locale datePickerMode:(UIDatePickerMode)datePickerMode;

@end
