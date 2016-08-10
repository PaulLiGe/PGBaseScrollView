//
//  ViewController.m
//  PGBaseScrollView
//
//  Created by 李蒙 on 16/8/4.
//  Copyright © 2016年 PG. All rights reserved.
//

#import "ViewController.h"
#import "PGBaseScrollView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureTopScrollView];
    
    [self configureBottomScrollView];
}

- (void)configureTopScrollView {
    PGBaseScrollView *scrollView = [[PGBaseScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 3, 200);
    [self.view addSubview:scrollView];
    scrollView.backgroundColor = [UIColor orangeColor];
    
    for (int i = 0; i < 5; i++) {
        CGFloat x = 20 + i * 120;
        CGFloat y = 20;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(x, y, 80, 100)];
        view.backgroundColor = [UIColor redColor];
        [scrollView addSubview:view];
    }
}

- (void)configureBottomScrollView {
    PGBaseScrollView *scrollView = [[PGBaseScrollView alloc] initWithFrame:CGRectMake(0, 240, self.view.frame.size.width, 300)];
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, 800);
    [self.view addSubview:scrollView];
    scrollView.backgroundColor = [UIColor greenColor];
    
    for (int i = 0; i < 5; i++) {
        CGFloat x = 20;
        CGFloat y = 20 + i * 120;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(x, y, 200, 100)];
        view.backgroundColor = [UIColor redColor];
        [scrollView addSubview:view];
    }
}
@end
