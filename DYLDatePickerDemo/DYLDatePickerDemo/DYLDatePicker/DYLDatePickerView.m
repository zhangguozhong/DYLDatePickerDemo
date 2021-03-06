//
//  DYLDatePickerView.m
//  DYLDatePickerDemo
//
//  Created by mannyi on 2017/6/15.
//  Copyright © 2017年 mannyi. All rights reserved.
//

#import "DYLDatePickerView.h"
#import "UIUtils.h"
#import <Masonry.h>
#import "DYLDatePickerManager.h"

#define mScreenWidth  ([UIScreen mainScreen].bounds.size.width)
#define mScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define mEmptyStr @""

#define mBlueColor [UIColor colorWithRed:50.0/255.0 green:162.0/255.0 blue:248.0/255.0 alpha:1.0]
#define mGrayColor [UIColor colorWithRed:165/255.0 green:165/255.0 blue:165/255.0 alpha:1.0]

static CGFloat const DYLDatePickerAnimationDuration = 0.25;
static CGFloat const DYLDatePickerButtonHeight = 30;

@interface DYLDatePickerView ()

@property (strong, nonatomic) UIView *bgView;
@property (strong, nonatomic) UISegmentedControl *dateSegmentView;
@property (assign, nonatomic) DYLDateType dateType;

@property (strong, nonatomic) UIView *sureDateView;
@property (strong, nonatomic) UIButton *sureDateButton;
@property (strong, nonatomic) UILabel *tipLabel;

@property (strong, nonatomic) UIDatePicker *datePicker;

@property (strong, nonatomic) UIView *bottomView;
@property (strong, nonatomic) UIButton *completeRefreshButton;

@property (copy, nonatomic) NSString *beginDateStr;
@property (copy, nonatomic) NSString *endDateStr;

@end

@implementation DYLDatePickerView

#pragma mark - lifeCicle
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, mScreenHeight, mScreenWidth, 320);
        self.backgroundColor = [UIColor whiteColor];
        
        [self commonInit];
        [self createBgView];
        [self createDatePickerView];
        [self configDatePickerView];
    }
    return self;
}


#pragma mark - Private Method
- (void)commonInit
{
    self.duration = DYLDatePickerAnimationDuration;
    self.showTopSegmentedControl = YES;
}

- (void)createBgView
{
    self.bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.bgView.hidden = YES;
    self.bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    [self.bgView addGestureRecognizer:tapGesture];
}

- (void)createDatePickerView
{
    self.dateSegmentView = [UIUtils segmentViewWithTintColor:mBlueColor items:@[@"开始时间", @"结束时间"]];
    self.dateSegmentView.selectedSegmentIndex = 0;
    [self.dateSegmentView addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.dateSegmentView];
    
    
    self.sureDateView = [UIUtils viewWithBackgroudColor:[UIColor whiteColor]];
    [self addSubview:self.sureDateView];
    
    self.sureDateButton = [UIUtils buttonWithTitle:@"确定" titleColor:mBlueColor fontSize:15.f cornerRadius:0.f];
    [self.sureDateButton addTarget:self action:@selector(sureDateButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.sureDateView addSubview:self.sureDateButton];
    
    self.tipLabel = [UIUtils labelWithTextColor:mGrayColor textAlignment:NSTextAlignmentLeft text:@"开始选择时间" fontSize:14.f];
    [self.sureDateView addSubview:self.tipLabel];
    
    
    self.datePicker = [UIUtils datePickerWithLocale:@"zh-CN" datePickerMode:UIDatePickerModeDate];
    [self addSubview:self.datePicker];
    
    
    self.bottomView = [UIUtils viewWithBackgroudColor:[UIColor whiteColor]];
    [self addSubview:self.bottomView];
    
    self.completeRefreshButton = [UIUtils buttonWithBackgroundColor:mBlueColor titleColor:[UIColor whiteColor] selectedColor:[UIColor lightGrayColor] title:@"确定" fontSize:15.f cornerRadius:3.f];
    self.completeRefreshButton.enabled = NO;
    [self.completeRefreshButton addTarget:self action:@selector(callback) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:self.completeRefreshButton];
}

- (void)configDatePickerView
{
    [self.dateSegmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@15);
        make.width.equalTo(@200);
        make.height.equalTo(@(DYLDatePickerButtonHeight));
        make.centerX.equalTo(self);
    }];
    
    [self.sureDateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dateSegmentView.mas_bottom).offset(15);
        make.left.and.right.equalTo(self);
        make.height.equalTo(@40);
    }];
    
    [self.sureDateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.right.equalTo(self.mas_right);
        make.width.equalTo(@60);
        make.bottom.equalTo(self.sureDateView.mas_bottom);
    }];
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@15);
        make.right.equalTo(self.sureDateButton.mas_left).offset(-15);
        make.bottom.equalTo(self.sureDateView.mas_bottom);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@60);
        make.left.and.right.equalTo(self);
        make.bottom.equalTo(self);
    }];
    
    [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sureDateView.mas_bottom).offset(15);
        make.left.and.right.equalTo(self);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
    
    [self.completeRefreshButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(50);
        make.right.equalTo(self.mas_right).offset(-50);
        make.height.mas_equalTo(35);
        make.centerY.equalTo(self.bottomView.mas_centerY);
    }];
}

- (void)setMinLimitDate:(NSString *)minLimitDate
{
    _minLimitDate = minLimitDate;
    self.datePicker.minimumDate = [[DYLDatePickerManager sharedManager].formatter dateFromString:minLimitDate];
}

- (void)setShowTopSegmentedControl:(BOOL)showTopSegmentedControl
{
    _showTopSegmentedControl = showTopSegmentedControl;
    if (showTopSegmentedControl && self.dateSegmentView.isHidden) {
        self.dateSegmentView.hidden = !showTopSegmentedControl;
        [self.sureDateView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.dateSegmentView.mas_bottom).offset(15);
            make.left.and.right.equalTo(self);
            make.height.equalTo(@40);
        }];
    } else {
        if (!showTopSegmentedControl && !self.dateSegmentView.isHidden) {
            self.dateSegmentView.hidden = !showTopSegmentedControl;
            [self.sureDateView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.and.left.and.right.equalTo(self);
                make.height.equalTo(@40);
            }];
        }
    }
}

- (void)sureDateButtonClick:(UIButton *)sender
{
    switch (_dateType) {
        case DYLDateTypeStartDate: {
            self.beginDateStr = [[DYLDatePickerManager sharedManager].formatter stringFromDate:self.datePicker.date];
            break;
        }
        case DYLDateTypeEndDate: {
            self.endDateStr = [[DYLDatePickerManager sharedManager].formatter stringFromDate:self.datePicker.date];
            break;
        }
        default:
            break;
    }
    
    [self refreshDatePickerView];
}

- (void)segmentAction:(UISegmentedControl *)sender
{
    self.dateType = sender.selectedSegmentIndex;
    switch (_dateType) {
        case DYLDateTypeStartDate: {
            if (_beginDateStr) {
                [self.datePicker setDate:[[DYLDatePickerManager sharedManager].formatter dateFromString:_beginDateStr] animated:YES];
            }
            break;
        }
        case DYLDateTypeEndDate: {
            if (_endDateStr) {
                [self.datePicker setDate:[[DYLDatePickerManager sharedManager].formatter dateFromString:_endDateStr] animated:YES];
            }
            break;
        }
        default:
            break;
    }
}

- (void)refreshDatePickerView
{
    NSString *beginDateStr = _beginDateStr ? _beginDateStr : mEmptyStr;
    NSString *endDateStr = _endDateStr ? _endDateStr : mEmptyStr;
    
    if (self.showTopSegmentedControl) {
        self.tipLabel.text = [NSString stringWithFormat:@"%@,%@", beginDateStr, endDateStr];
        self.completeRefreshButton.enabled = _beginDateStr && _endDateStr;
    } else {
        self.tipLabel.text = beginDateStr;
        self.completeRefreshButton.enabled = _beginDateStr || _endDateStr;
    }
    
    if (self.completeRefreshButton.enabled) {
        if (self.showTopSegmentedControl) {
            NSInteger distanceDays = [[DYLDatePickerManager sharedManager] distanceFrom:_beginDateStr to:_endDateStr];
            if (distanceDays > self.maximumIntervalDay) {
                self.completeRefreshButton.enabled = NO;
                [self.completeRefreshButton setTitle:@"超过规定时间间隔" forState:UIControlStateDisabled];
            } else {
                if (distanceDays < 0) {
                    self.completeRefreshButton.enabled = NO;
                    [self.completeRefreshButton setTitle:@"开始时间须小于结束时间" forState:UIControlStateDisabled];
                } else {
                    [self.completeRefreshButton setTitle:@"确定" forState:UIControlStateNormal];
                }
            }
        }
    }
}

- (void)callback
{
    if ([self.delegate respondsToSelector:@selector(callback:beginDateStr:endDateStr:)]) {
        [self.delegate callback:self beginDateStr:self.beginDateStr endDateStr:self.endDateStr];
    } else {
        if (self.completeBlock) {
            self.completeBlock(self.beginDateStr, self.endDateStr);
        }
    }
}

- (void)show
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.bgView];
    [window addSubview:self];
}

- (void)didMoveToWindow
{
    if (self.window) {
        [UIView animateWithDuration:self.duration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.bgView.hidden = NO;
            CGRect newFrame = self.frame;
            newFrame.origin.y = mScreenHeight - CGRectGetHeight(self.frame);
            self.frame = newFrame;
        } completion:^(BOOL finished) {
            if (finished) {
                
            }
        }];
    }
}

- (void)hide
{
    [UIView animateWithDuration:self.duration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        CGRect newFrame = self.frame;
        newFrame.origin.y = mScreenHeight;
        self.frame = newFrame;
    } completion:^(BOOL finished) {
        if (finished) {
            self.bgView.hidden = YES;
            [self.bgView removeFromSuperview];
            [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [self removeFromSuperview];
        }
    }];
}

@end
