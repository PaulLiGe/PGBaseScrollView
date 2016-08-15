//
//  PGBaseScrollView.m
//  PGBaseScrollView
//
//  Created by PaulLiGe on 16/8/4.
//  Copyright © 2016年 PG. All rights reserved.
//

#import "PGLScrollView.h"

@interface PGLScrollView ()
@property (nonatomic, assign) CGPoint startLocation;
@end

@implementation PGLScrollView

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
    } else if (pan.state == UIGestureRecognizerStateChanged) {
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
    } else if (pan.state == UIGestureRecognizerStateEnded) {
        // 手指离开屏幕后减速滑动到停止的效果
        
    }
}

- (void)setContentOffset:(CGPoint)contentOffset {
    _contentOffset = contentOffset;
    CGRect newBounds = self.bounds;
    newBounds.origin = contentOffset;
    self.bounds = newBounds;
}
@end
