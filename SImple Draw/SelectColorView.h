//
//  SelectColorView.h
//  简易画板
//
//  Created by 赵子龙 on 16/5/11.
//  Copyright © 2016年 赵子龙. All rights reserved.
//

#import "BaseView.h"

typedef void(^SelectColorBlock)(UIColor *color);

@interface SelectColorView : BaseView

- (void)afterSelected:(SelectColorBlock)selectBlock;

@end
