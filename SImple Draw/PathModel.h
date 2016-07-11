//
//  PathModel.h
//  简易画板
//
//  Created by 赵子龙 on 16/5/11.
//  Copyright © 2016年 赵子龙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface PathModel : NSObject


@property (nonatomic,strong) UIBezierPath *bezierPath;

@property (nonatomic,strong) UIColor *color;

@property (nonatomic,assign) CGFloat lineWidth;


@end
