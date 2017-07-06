//
//  FuncView.m
//  portal
//
//  Created by apple on 16/11/17.
//  Copyright © 2016年 yantian. All rights reserved.
//
//  可预约 不可预约 按钮
//

#import "FuncView.h"
#import "Colors.h"
#import "Masonry.h"
#import "Constants.h"

@interface FuncView ()
@property (nonatomic,weak) id target;
@property (nonatomic, assign) SEL action;

@end

@implementation FuncView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init {
    if (self = [super init]) {
        [self setBackgroundColor:NaviBarColor];
        [self.layer setCornerRadius:5];
        [self.layer setMasksToBounds:YES];
        [self settingAutoLayout];
    }
    return self;
}

- (void)settingAutoLayout {
    WS(weakSelf);
    [self.funcLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf);
    }];
    
    [self.limitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf);
        make.right.bottom.mas_equalTo(weakSelf);
        make.height.mas_equalTo(15);
    }];
}

- (void)setIsFitShen:(BOOL)isFitShen {
    [self.limitLabel setHidden:!isFitShen];
}

- (void)setIsAvailable:(BOOL)isAvailable {
    if (_isAvailable != isAvailable) {
        _isAvailable = isAvailable;
    }
    if (!isAvailable) {
        self.backgroundColor = [UIColor grayColor];
        [self.funcLabel setText:@"不可预约"];
        [self.limitLabel setHidden:!isAvailable];
    } else {
        [self.limitLabel setHidden:!self.isFitShen];
        self.backgroundColor = NaviBarColor;
        [self.funcLabel setText:@"去预约"];
    }
   
}

- (UILabel *)funcLabel {
    if (!_funcLabel) {
        _funcLabel = [[UILabel alloc]init];
        [_funcLabel setTextColor:[UIColor whiteColor]];
        [_funcLabel setFont:[UIFont systemFontOfSize:15]];
        [_funcLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_funcLabel];
    }
    return _funcLabel;
}

- (UILabel *)limitLabel {
    if (!_limitLabel) {
        _limitLabel = [[UILabel alloc]init];
        [_limitLabel setText:@"仅深户可预约"];
        [_limitLabel setFont:[UIFont systemFontOfSize:10]];
        [_limitLabel setBackgroundColor:UIColorBar];
        [_limitLabel setTextColor:[UIColor whiteColor]];
        [_limitLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_limitLabel];
    }
    return _limitLabel;
}

- (void)addTarget:(id)target action:(SEL)action {
    self.target = target;
    self.action = action;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([self.delegate respondsToSelector:@selector(funcViewShouldTap:)]) {
        if ([self.delegate funcViewShouldTap:self]) {
            
            if ([self.delegate respondsToSelector:@selector(funcViewWillTap:)]) {
                [self.delegate funcViewWillTap:self];
            }
            
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{

    if (self.isAvailable) {
        //获取触摸对象
        UITouch *touche = [touches anyObject];
        //获取touche的位置
        CGPoint point = [touche locationInView:self];
        
        //判断点是否在button中
        if (CGRectContainsPoint(self.bounds, point))
        {
            //执行action
            [self.target performSelector:self.action withObject:self];
            
        }

    }
    
}

@end
