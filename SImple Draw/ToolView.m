//
//  ToolView.m
//  简易画板
//
//  Created by 赵子龙 on 16/5/11.
//  Copyright © 2016年 赵子龙. All rights reserved.
//

#import "ToolView.h"
#import "SelectColorView.h"
#import "SelectLineWidthView.h"
typedef enum : NSUInteger {
    kColorSelect = 100,
    kLineWidthSelect,
    KEraserSelect,
    kUndoSelect,
    kClearScreenSelect,
    kcameraSelect,
    kSaveSelect
} kSelectItem;

@interface ToolView ()
{
    SelectLineWidthBlock _selectLineWidthBlock;
    
    SelectColorBlock _selectColorBlock;
    
    ToolActionBlock _araserBlock;
    ToolActionBlock _undoBlock;
    ToolActionBlock _clearBlock;
    ToolActionBlock _saveBlock;
    
    

    
}

@property (nonatomic,strong)SelectColorView *selectColorView;

@property (nonatomic,strong)SelectLineWidthView *selectLineWidthView;


@end

@implementation ToolView

- (void)selectChangeItem:(UIButton *)sender{
    

switch (sender.tag) {
        
    case kColorSelect:{
        
        [self forceHideView:self.selectColorView];
        [self showHideColorSelectView];
        
        
    }break;
        
    case kLineWidthSelect:{
        
        [self forceHideView:self.selectLineWidthView];
        [self showHideLineWidthSelectView];
        
        
        
    }break;
        
    case KEraserSelect:{
        
        _araserBlock();
        
        
    }break;
        
    case kUndoSelect:{
        
        _undoBlock();
        
    }break;
        
    case kClearScreenSelect:{
        
        _clearBlock();
    }break;
        
    case kcameraSelect:{
        
    }break;
      
    case  kSaveSelect:{
        
        _saveBlock();
        
    }break;
        
}
    
}

// 让线宽显示或隐藏

- (void)showHideLineWidthSelectView{


    NSArray *context = @[@"1",@"5",@"8",@"12",@"15",@"18"];
    
    if (self.selectLineWidthView == nil) {
        
    self.selectLineWidthView = [[SelectLineWidthView alloc]initWithFrame:CGRectMake(0, -50, 414, 50) WithArray:context];
      
       [self.selectLineWidthView afterSelected:^(CGFloat lineWidth) {
           
           
           _selectLineWidthBlock(lineWidth);
           
       }];
        
        
        
        self.selectLineWidthView.backgroundColor = [UIColor lightGrayColor];
        
        [self addSubview:self.selectLineWidthView];
    }
    
    
    [self showHideView:self.selectLineWidthView];
        

}

// 让颜色选择色图显示或隐藏

- (void)showHideColorSelectView{
    
    if (self.selectColorView == nil) {
        
        
          NSArray *contentArray = @[[UIColor redColor],[UIColor grayColor],[UIColor orangeColor],[UIColor yellowColor],[UIColor blueColor],[UIColor blackColor],[UIColor cyanColor]];
        
        
        self.selectColorView = [[SelectColorView alloc]initWithFrame:CGRectMake(0, -50, 414, 50)WithArray:contentArray];
        
        [self.selectColorView afterSelected:^(UIColor *color) {
            
            
            _selectColorBlock(color);
            
        }];
        
        
        
        
        self.selectColorView.backgroundColor = [UIColor lightGrayColor];
    
        [self addSubview:self.selectColorView];
        
    }
    
    
    [self showHideView:self.selectColorView];
    
}


// 让视图动画的方式出现及消失

- (void) showHideView:(UIView *)view{

    //保存要消失或出现视图的frame
    CGRect toFrame = view.frame;
    //保存当前工具栏的frame
    CGRect tooFrame = self.frame;
    if (toFrame.origin.y > 0) {
        
        toFrame.origin.y = -70;
        
        tooFrame.size.height = 50;
        
    }else{
    
        toFrame.origin.y = 50;
      
        tooFrame.size.height = 100;
    
    
    }

    
    
    [UIView animateWithDuration:0.5 animations:^{
        
        view.frame = toFrame;
        self.frame = tooFrame;
        
    }];
    
}


// 强制隐藏视图


- (void)forceHideView:(UIView *)view{

    UIView *showView = nil;
    
    if (self.selectColorView.frame.origin.y > 0) {
        
        showView = self.selectColorView;
    }else if (self.selectLineWidthView.frame.origin.y > 0){
    
      
        showView = self.selectLineWidthView;
    
    }else{
    
    
        return;
      
    }
    
    if (view == showView) {
        return;
    }

    CGRect toFrame = showView.frame;
    
    CGRect toolFrame  = self.frame;
    
    toFrame.origin.y = -70;
    toolFrame.size.height = 50;
    
    [UIView animateWithDuration:0.5 animations:^{
        
        showView.frame = toFrame;
        
        self.frame = toolFrame;
    }];

}

- (void)afterSelectColor:(SelectColorBlock)selectColorBlock afterSelectLineWidth:(SelectLineWidthBlock)selectLineWidth{

    _selectColorBlock = selectColorBlock;
    
    _selectLineWidthBlock = selectLineWidth;
    

}

- (void)clickEraserBlock:(ToolActionBlock)araserBlock WithUndoBlock:(ToolActionBlock)undoBlock WithClearBlock:(ToolActionBlock)clearBlock WithSaveBlock:(ToolActionBlock)saveBlock{

    _araserBlock = araserBlock;
    
    _undoBlock = undoBlock;
    
    _clearBlock = clearBlock;
    
    _saveBlock = saveBlock;
    

}




@end
