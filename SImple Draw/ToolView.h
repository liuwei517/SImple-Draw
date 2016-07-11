//
//  ToolView.h
//  简易画板
//
//  Created by 赵子龙 on 16/5/11.
//  Copyright © 2016年 赵子龙. All rights reserved.
//

#import "BaseView.h"
#import "SelectColorView.h"
#import "SelectLineWidthView.h"

typedef void(^ToolActionBlock)(void);

@interface ToolView : BaseView

- (void)afterSelectColor:(SelectColorBlock)selectColorBlock afterSelectLineWidth:(SelectLineWidthBlock)selectLineWidth;

- (void)clickEraserBlock:(ToolActionBlock)araserBlock WithUndoBlock:(ToolActionBlock)undoBlock WithClearBlock:(ToolActionBlock)clearBlock WithSaveBlock:(ToolActionBlock)saveBlock;





@end
