//
//  KKVTagButton.h
//  Tag Games
//
//  Created by Konstantin Kimlaev on 30.10.12.
//  Copyright (c) 2012 JTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define COUNT_OF_BUTTONS 16

@interface KKVTagButton : NSObject{
    UIImageView *image;
    int buttonID;
    int posCol;
    int posRow;
    int init_posCol;
    int init_posRow;    
    int type;
}

- (id)initN: (int)i_buttonID posCol:(int)i_posCol posRow:(int) i_posRow  image:(UIImageView *) i_image;

- (void)addToView: (UIView *) view;

- (void)showTagButtons:(CGRect) tagBox;

- (bool)isClickX: (CGFloat)x Y:(CGFloat)y;

- (void)setType: (int)_type;

- (bool)move: (KKVTagButton *)space box:(CGRect)tagBox;

- (int)posCol;

- (int)posRow;

- (void)setPosCol: (int) _posCol;

- (void)setPosRow: (int) _posRow;

- (bool)isIn;


@end
