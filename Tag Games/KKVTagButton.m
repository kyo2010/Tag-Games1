//
//  KKVTagButton.m
//  Tag Games
//
//  Created by Konstantin Kimlaev on 30.10.12.
//  Copyright (c) 2012 JTeam. All rights reserved.
//

#import "KKVTagButton.h"

@implementation KKVTagButton


- (id)initN: (int)i_buttonID posCol:(int)i_posCol posRow:(int) i_posRow  image:(UIImageView *) i_image
{
    self = [super init];
    buttonID = i_buttonID;
    posCol = i_posCol;
    posRow = i_posRow;
    image = i_image;
    type = 0;
    init_posCol = posCol;
    init_posRow = posRow;
    //[image autorelease];
    return self;
}

- (void)addToView: (UIView *) view
{
    if (type==1){
    }else{
      [view addSubview:image];   
    }
};

- (void)setType: (int)_type
{
    type = _type;
};

- (bool)isClickX: (CGFloat)x Y:(CGFloat)y
{
    if (type==0 &&
        image.frame.origin.x<=x && image.frame.origin.x+image.frame.size.width>=x &&
        image.frame.origin.y<=y && image.frame.origin.y+image.frame.size.height>=y )
    {
        return true;
    }
    return false;
}

- (bool)move: (KKVTagButton *)space box:(CGRect)tagBox
{
  if (type==0 && 
      ( 
        ( space.posCol==posCol && abs(space.posRow-posRow)==1) ||
        ( space.posRow==posRow && abs(space.posCol-posCol)==1)
       ))
  {
      int c = space.posCol;
      int r = space.posRow;
      [space setPosCol: posCol];
      [space setPosRow: posRow];
      [self setPosCol: c];
      [self setPosRow: r];
      [self showTagButtons: tagBox];
      return true;
  }
  return false;
}

- (void)showTagButtons:  (CGRect) tagBox
{
    int startX = tagBox.origin.x;
    int startY = tagBox.origin.y;
    int x = startX;
    int y = startY;
    int buttonWidth = tagBox.size.width/4;
    int buttonHeight = tagBox.size.height/4;
    int pCol = 1;
    int pRow = 1;
    for (int i=0; i<COUNT_OF_BUTTONS; i++){        
        if (pCol==posCol && pRow==posRow){
          image.frame = CGRectMake(x, y, buttonWidth, buttonHeight);
        }
        if (i==3 || i==7 || i==11){
            x = startX;
            y += buttonHeight;
            pCol=1;
            pRow+=1;
        }else{
            x += buttonWidth;
            pCol+=1;
        }
    }
}

- (bool)isIn
{
    if (init_posCol==posCol && init_posRow==posRow) return true;
    return false;
};

- (int)posCol
{
    return posCol;
};

- (int)posRow
{
    return posRow;
};

- (void)setPosCol: (int) _posCol{
    posCol = _posCol;
};

- (void)setPosRow: (int) _posRow{
    posRow = _posRow;
};


@end
