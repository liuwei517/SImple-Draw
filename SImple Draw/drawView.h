//
//  drawView.h
//  简易画板
//
//  Created by 赵子龙 on 16/5/11.
//  Copyright © 2016年 赵子龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface drawView : UIView

@property (nonatomic,strong) UIColor *drawColor;

@property (nonatomic,assign) CGFloat drawlinewidth;

- (void)undo;

- (void)clear;

- (void)save;




@end
