//
//  SelectLineWidthView.m
//  简易画板
//
//  Created by 赵子龙 on 16/5/11.
//  Copyright © 2016年 赵子龙. All rights reserved.
//

#import "SelectLineWidthView.h"

@interface SelectLineWidthView ()


{
    SelectLineWidthBlock _selectLineWidthBlock;
    
}

@end


@implementation SelectLineWidthView

- (void)afterSelected:(SelectLineWidthBlock)selectLineBlock{
   
    _selectLineWidthBlock = selectLineBlock;

}

- (void)selectChangeItem:(UIButton *)sender{


    float lineWidth = [self.contentArray[sender.tag-100] floatValue];
    
    
    _selectLineWidthBlock(lineWidth);


}







@end
