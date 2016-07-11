//
//  ViewController.m
//  SImple Draw
//
//  Created by 赵子龙 on 16/7/11.
//  Copyright © 2016年 赵子龙. All rights reserved.
//

#import "ViewController.h"
#import "drawView.h"
#import "ToolView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    drawView *draw = [[drawView alloc]initWithFrame:self.view.frame];
    
    draw.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:draw];
    
    
    NSArray *contentArray = @[@"颜色",@"线宽",@"橡皮",@"撤销",@"清屏",@"相机",@"保存"];
    
    ToolView *toolView = [[ToolView alloc]initWithFrame:CGRectMake(0, 20, 414, 50) WithArray:contentArray];
    
    [toolView afterSelectColor:^(UIColor *color) {
        
        
        
        draw.drawColor = color;
        
        NSLog(@"%@",color);
        
        
    } afterSelectLineWidth:^(CGFloat lineWidth) {
        
        
        
        draw.drawlinewidth = lineWidth;
        
        NSLog(@"%f",lineWidth);
    }];
    
    
    
    
    toolView.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:toolView];
    
    [toolView clickEraserBlock:^{
        
        draw.drawColor = [UIColor whiteColor];
        
        
    } WithUndoBlock:^{
        
        [draw undo];
        
    } WithClearBlock:^{
        
        [draw clear];
        
    } WithSaveBlock:^{
        
        [draw save];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
