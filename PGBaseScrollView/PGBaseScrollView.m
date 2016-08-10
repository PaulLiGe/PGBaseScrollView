//
//  PGBaseScrollView.m
//  PGBaseScrollView
//
//  Created by 李蒙 on 16/8/4.
//  Copyright © 2016年 PG. All rights reserved.
//

#import "PGBaseScrollView.h"

@interface PGBaseScrollView ()
@property (nonatomic, assign) CGPoint startLocation;
@end

@implementation PGBaseScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] init];
        [panGesture addTarget:self action:@selector(panGestureAction:)];
        [self addGestureRecognizer:panGesture];
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)panGestureAction:(UIPanGestureRecognizer *)pan {
    if (pan.state == UIGestureRecognizerStateBegan) {
        self.startLocation = self.bounds.origin;
        NSLog(@"%@", NSStringFromCGPoint(self.startLocation));
    }
    
    // 相对于初始触摸点的偏移量
    CGPoint point = [pan translationInView:self];
    NSLog(@"%@", NSStringFromCGPoint(point));
    CGFloat newOriginalX = self.startLocation.x - point.x;
    CGFloat newOriginalY = self.startLocation.y - point.y;
    
    if (newOriginalX < 0) {
        newOriginalX = 0;
    } else {
        CGFloat maxMoveWidth = self.contentSize.width - self.bounds.size.width;
        if (newOriginalX > maxMoveWidth) {
            newOriginalX = maxMoveWidth;
        }
    }
    if (newOriginalY < 0) {
        newOriginalY = 0;
    } else {
        CGFloat maxMoveHeight = self.contentSize.height - self.bounds.size.height;
        if (newOriginalY > maxMoveHeight) {
            newOriginalY = maxMoveHeight;
        }
    }
    
    CGRect bounds = self.bounds;
    bounds.origin = CGPointMake(newOriginalX, newOriginalY);
    self.bounds = bounds;
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:1.0 animations:^{
            
        }];
    }
}
- (void)panGestureAction2:(UIPanGestureRecognizer *)pan {
    // 记录每次滑动开始时的初始位置
    if (pan.state == UIGestureRecognizerStateBegan) {
        self.startLocation = self.bounds.origin;
        NSLog(@"%@", NSStringFromCGPoint(self.startLocation));
    }
    // 相对于初始触摸点的偏移量
    if (pan.state == UIGestureRecognizerStateChanged) {
        CGPoint point = [pan translationInView:self];
        NSLog(@"%@", NSStringFromCGPoint(point));
        CGFloat newOriginalX = self.startLocation.x - point.x;
        CGFloat newOriginalY = self.startLocation.y - point.y;
        
        CGRect bounds = self.bounds;
        bounds.origin = CGPointMake(newOriginalX, newOriginalY);
        self.bounds = bounds;
    }
}

@end
