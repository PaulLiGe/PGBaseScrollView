# iOS开发-UIScrollView的底层实现-

###起始

做开发也有一段时间了，经历了第一次完成项目的激动，也经历了天天调用系统的API的枯燥，于是就有了探索底层实现的想法。

###关于scrollView的思考

在iOS开发中我们会大量用到scrollView这个控件，我们使用的tableView/collectionview/textView都继承自它。scrollView的频繁使用让我对它的底层实现产生了兴趣，它到底是如何工作的？如何实现一个scrollView？读完本篇博客，相信你一定也可以自己实现一个简易的scrollView。

我们首先来思考以下几个问题：

* scrollView继承自谁，它如何检测到手指滑动？

*  scrollView如何实现滚动？

* scrollView里的各种属性是如何实现的？如contentSize/contentOffSet......

通过一步步解决上边的问题，我们就能实现一个自己的scrollView。

###一步一步实现scrollView
 ######1.毫无疑问我们都知道scrollView继承自UIView，检测手指滑动应该是在view上放置了一个手势识别，实现代码如下：

````
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] init];
        [panGesture addTarget:self action:@selector(panGestureAction:)];
        [self addGestureRecognizer:panGesture];
    }
    return self;
}
````
  ######2.要搞清楚第二个问题，首先我们必须理解frame和bounds的概念。

提到它们，大家都知道frame是相对于父视图坐标系来说自己的位置和尺寸，bounds相对于自身坐标系来说的位置和尺寸，并且origin一般为（0，0）。但是bounds的origin有什么用处？改变它会出现什么效果呢？
 
当我们尝试改变bounds的origin时，我们就会发现视图本身没有发生变化，但是它的子视图的位置却发生了变化，why？？？其实当我们改变bounds的origin的时候，视图本身位置没有变化，但是由于origin的值是基于自身的坐标系，所以自身坐标系的位置被我们改变了。而子视图的frame正是基于父视图的坐标系，当我们更改父视图bounds中origin的时候子视图的位置就发生了变化，这就是实现scrollView的关键点！！！

是不是很好理解？
基于这点我们很容易实现一个简单的最初级版本的scrollView，代码如下：

````
- (void)panGestureAction:(UIPanGestureRecognizer *)pan {
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
````

 ######3.理解了上边内容的关键点，下边我们将对我们实现的scrollView做一个简单的优化。
 通过contentSize限制scrollView的内部空间，实现代码如下
 
 ````
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
 ````
 通过contentOffset设置scrollView的初始偏移量，相信大家已经懂了如何设置偏移量了吧？没错我们只需设置view自身bounds的origin是实现代码如下：
 
 ````
 - (void)setContentOffset:(CGPoint)contentOffset {
    _contentOffset = contentOffset;
    CGRect newBounds = self.bounds;
    newBounds.origin = contentOffset;
    self.bounds = newBounds;
 }
 ````
 防止scrollView的子视图超出scrollView
 
````
self.layer.masksToBounds = YES;
````
###总结
UIScrollView还有很多其它强大的功能，以上我们只是完成了一个特别简单的scrollView，以后如果有时间我会对它进行完善。当然如果你有兴趣，你完全可以对它进行扩展,[下载地址放在这里](https://github.com/PaulLiGe/PGBaseScrollView)。同时我也会继续研究UIKit中其它控件的底层实现，欢迎您的持续关注！