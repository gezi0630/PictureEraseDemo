//
//  ViewController.m
//  图片擦除
//
//  Created by MAC on 2017/7/18.
//  Copyright © 2017年 GuoDongge. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


/**
 带有完整图片的那个imageView
 */
@property (weak, nonatomic) IBOutlet UIImageView *imageViewA;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建pan手势
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    
    [self.view addGestureRecognizer:pan];
    
    
}

-(void)pan:(UIPanGestureRecognizer *)pan
{

    //获取当前点
    CGPoint curP = [pan locationInView:self.view];
    //获取擦除的矩形的范围
    CGFloat wh = 100;
    CGFloat x = curP.x - wh * 0.5;
    CGFloat y = curP.y - wh * 0.5;
    
    CGRect clearRect = CGRectMake(x, y, wh, wh);
    
    //开启上下文
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, 0);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //控件的layer渲染上去
    [_imageViewA.layer renderInContext:ctx];
    
    //擦除图片
    CGContextClearRect(ctx, clearRect);
    
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    //重新赋值
    _imageViewA.image = image;
    
    //关闭上下文
    UIGraphicsEndImageContext();
    
    
}





@end
