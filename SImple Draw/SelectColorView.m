//
//  SelectColorView.m
//  简易画板
//
//  Created by 赵子龙 on 16/5/11.
//  Copyright © 2016年 赵子龙. All rights reserved.
//

#import "SelectColorView.h"

@interface SelectColorView ()

{
    SelectColorBlock _selectColorBlock;

}


@end


@implementation SelectColorView


- (void)afterSelected:(SelectColorBlock)selectBlock{
    
    _selectColorBlock = selectBlock;
    
    
}


- (void)selectChangeItem:(UIButton *)sender{
    
    
    _selectColorBlock(self.contentArray[sender.tag-100]);
    
    
}



@end
