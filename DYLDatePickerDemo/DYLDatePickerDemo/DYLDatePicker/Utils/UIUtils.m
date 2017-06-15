//
//  UIUtils.m
//  DYLDatePickerDemo
//
//  Created by mannyi on 2017/6/15.
//  Copyright © 2017年 mannyi. All rights reserved.
//

#import "UIUtils.h"
#import "UIImage+ImageWithColor.h"

@implementation UIUtils

+ (UILabel *)labelWithText:(NSString *)text fontSize:(CGFloat)size
{
    return [self labelWithBackgroudColor:[UIColor clearColor] textColor:[UIColor blackColor] numberOfLines:1 textAlignment:NSTextAlignmentLeft text:text fontSize:size];
}

+ (UILabel *)labelTextColor:(UIColor *)textColor fontSize:(CGFloat)size
{
    return [self labelWithBackgroudColor:[UIColor clearColor] textColor:textColor numberOfLines:1 textAlignment:NSTextAlignmentLeft text:nil fontSize:size];
}

+ (UILabel *)labelWithTextColor:(UIColor *)textColor numberOfLines:(NSInteger)numberOfLines text:(NSString *)text fontSize:(CGFloat)size
{
    return [self labelWithBackgroudColor:[UIColor clearColor] textColor:textColor numberOfLines:numberOfLines textAlignment:NSTextAlignmentLeft text:text fontSize:size];
}

+ (UILabel *)labelWithTextColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment text:(NSString *)text fontSize:(CGFloat)size
{
    return [self labelWithBackgroudColor:[UIColor clearColor] textColor:textColor numberOfLines:1 textAlignment:textAlignment text:text fontSize:size];
}

+ (UILabel *)labelWithBackgroudColor:(UIColor *)backgroundColor textColor:(UIColor *)textColor numberOfLines:(NSInteger)numberOfLines textAlignment:(NSTextAlignment)textAlignment text:(NSString *)text fontSize:(CGFloat)size
{
    UILabel *label = [[UILabel alloc] init];
    label.layer.backgroundColor = backgroundColor.CGColor;
    label.textColor = textColor;
    label.numberOfLines = numberOfLines;
    label.textAlignment = textAlignment;
    label.text = text;
    label.font = [UIFont systemFontOfSize:size];
    return label;
}


+ (UIButton *)buttonWithTitle:(NSString *)title fontSize:(CGFloat)size
{
    return [self buttonWithTitle:title titleColor:[UIColor whiteColor] fontSize:size cornerRadius:0.f];
}

+ (UIButton *)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor fontSize:(CGFloat)size cornerRadius:(CGFloat)cornerRadius
{
    return [self buttonWithBackgroundColor:[UIColor clearColor] titleColor:titleColor selectedColor:[UIColor clearColor] title:title fontSize:size cornerRadius:cornerRadius];
}

+ (UIButton *)buttonWithBackgroundColor:(UIColor *)backgroundColor titleColor:(UIColor *)titleColor selectedColor:(UIColor *)selectedColor title:(NSString *)title fontSize:(CGFloat)size cornerRadius:(CGFloat)cornerRadius
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    button.layer.cornerRadius = cornerRadius;
    button.clipsToBounds = YES;
    button.titleLabel.font = [UIFont systemFontOfSize:size];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateSelected];
    [button setBackgroundImage:[UIImage imageWithColor:backgroundColor] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithColor:selectedColor] forState:UIControlStateDisabled];
    [button setBackgroundImage:[UIImage imageWithColor:selectedColor] forState:UIControlStateSelected];
    return button;
}


+ (UIView *)viewWithBackgroudColor:(UIColor *)backgroundColor
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = backgroundColor;
    return view;
}


+ (UISegmentedControl *)segmentViewWithTintColor:(UIColor *)tintColor items:(NSArray *)items
{
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:items];
    segment.tintColor = tintColor;
    [segment setDividerImage:[UIImage imageWithColor:tintColor] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    return segment;
}


+ (UIDatePicker *)datePickerWithLocale:(NSString *)locale datePickerMode:(UIDatePickerMode)datePickerMode
{
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:locale];
    datePicker.datePickerMode = datePickerMode;
    return datePicker;
}

@end
