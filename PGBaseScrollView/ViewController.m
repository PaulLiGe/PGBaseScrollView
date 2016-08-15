//
//  ViewController.m
//  PGBaseScrollView
//
//  Created by PaulLiGe on 16/8/4.
//  Copyright © 2016年 PG. All rights reserved.
//

#import "ViewController.h"
#import "PGLScrollView.h"

@interface ViewController ()
@property (nonatomic, strong) NSArray *colors;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureTopScrollView];
    
    [self configureBottomScrollView];
}

- (void)configureTopScrollView {
    PGLScrollView *scrollView = [[PGLScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 3, 200);
    [self.view addSubview:scrollView];
    scrollView.backgroundColor = [UIColor cyanColor];
    
    for (int i = 0; i < 5; i++) {
        CGFloat x = 20 + i * 120;
        CGFloat y = 20;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(x, y, 80, 100)];
        view.backgroundColor = self.colors[i];
        [scrollView addSubview:view];
    }
    
    scrollView.contentOffset = CGPointMake(250, 0);
}

- (void)configureBottomScrollView {
    PGLScrollView *scrollView = [[PGLScrollView alloc] initWithFrame:CGRectMake(0, 240, self.view.frame.size.width, 300)];
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, 800);
    [self.view addSubview:scrollView];
    scrollView.backgroundColor = [UIColor cyanColor];
    
    for (int i = 0; i < 5; i++) {
        CGFloat x = 20;
        CGFloat y = 20 + i * 120;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(x, y, 200, 100)];
        view.backgroundColor = self.colors[i];
        [scrollView addSubview:view];
    }
}

#pragma mark - property
- (NSArray *)colors {
    if (_colors == nil) {
        _colors = @[[UIColor redColor],[UIColor greenColor], [UIColor blueColor], [UIColor purpleColor], [UIColor yellowColor]];
    }
    return _colors;
}
@end
