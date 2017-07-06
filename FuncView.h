//
//  FuncView.h
//  portal
//
//  Created by apple on 16/11/17.
//  Copyright © 2016年 yantian. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FuncView;
@protocol FuncViewDelegate <NSObject>
- (void) funcViewWillTap:(FuncView * _Nonnull) sender;
- (void) funcViewDidTap:(FuncView * _Nonnull) sender;
- (BOOL) funcViewShouldTap:(FuncView * _Nonnull) sender;
@end

@interface FuncView : UIView
@property (assign, nonatomic) BOOL isFitShen;//是否仅深户可预约
@property (assign, nonatomic) BOOL isAvailable;//是否可预约

@property (strong, nonatomic) UILabel * _Nonnull funcLabel;//去预约、不可预约
@property (strong, nonatomic) UILabel * _Nonnull limitLabel;//是否深户可预约

@property (weak, nonatomic) id <FuncViewDelegate> delegate;

- (void)addTarget:(_Nonnull id)target action:(nonnull SEL)action;
@end
