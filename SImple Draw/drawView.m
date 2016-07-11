//
//  drawView.m
//  简易画板
//
//  Created by 赵子龙 on 16/5/11.
//  Copyright © 2016年 赵子龙. All rights reserved.
//

#import "drawView.h"
#import "PathModel.h"
@interface drawView ()


// 当前正在绘制的路径
@property (nonatomic,assign)CGMutablePathRef path;

// 已经绘制过的路径
@property (nonatomic,strong)NSMutableArray *pathArray;
// 判断当前路径是否被释放
@property (nonatomic,assign) BOOL isReleasePath;

@end



@implementation drawView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.drawColor = [UIColor blackColor];
        
        self.drawlinewidth = 10;
        
    }
    
    return self;
    
}

- (void)drawRect:(CGRect)rect{

    // 1.获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    [self drawView:context];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    CGPoint point = [[touches anyObject]locationInView:self];
   
    // 路径新创建时，将isReleasePath设置为NO，表明当前路径没有被释放
    
    self.isReleasePath = NO;
    

    // 2.创建路径
     _path = CGPathCreateMutable();
    
    // 2.1.设置路径
    
      // 路径的起点
    CGPathMoveToPoint(_path,NULL, point.x, point.y);

}


- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    CGPoint point = [[touches anyObject]locationInView:self];
    

     // 追加路径
    
    CGPathAddLineToPoint(_path, NULL, point.x, point.y);
    


    // 不能直接调用drawRect方法，，使用setNeedsDisplay方法来触发drawRect执行
    [self setNeedsDisplay];

    
    


}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    if (_pathArray == nil) {
        
        
        _pathArray = [[NSMutableArray alloc]init];
        
    }
    
    
    // 使用贝塞尔曲线，将CGpath包装成对象
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithCGPath:_path];
    
    
    PathModel *model = [[PathModel alloc]init];
    
    
    model.bezierPath = bezierPath;
    model.color = self.drawColor;
    model.lineWidth = self.drawlinewidth;
    
    
    
    
    [_pathArray addObject:model];
    

    // 6.释放路径
    
    CGPathRelease(_path);

    
    // 记录路径被释放
    self.isReleasePath = YES;

}




- (void)drawView:(CGContextRef)context{
    
    for (PathModel*path in _pathArray) {
        
        [path.color setStroke];
        
        CGContextAddPath(context,path.bezierPath.CGPath);
        
        CGContextSetLineWidth(context, path.lineWidth);
        
        CGContextDrawPath(context, kCGPathStroke);
        
        
    }
    
    if (self.isReleasePath == NO) {
        
        
        // 3.把路径添加到上下文
        
        CGContextAddPath(context, self.path);
        
        // 4.给上下文设置状态
        
        [self.drawColor setStroke];
        
        CGContextSetLineWidth(context, self.drawlinewidth);
        
        // 5.绘制路径
        
        CGContextDrawPath(context, kCGPathStroke);
        
    }

}

- (void)undo{

    [self.pathArray removeLastObject];

    [self setNeedsDisplay];

}

- (void)clear{
    
    [self.pathArray removeAllObjects];

    [self setNeedsDisplay];

}

- (void)save{

    UIGraphicsBeginImageContext(CGSizeMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)));
    
    //获取到当前指定试图上的内容，并把它放到画板上面
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    
    UIGraphicsEndImageContext();
    
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, NULL);
    

}

   



@end
