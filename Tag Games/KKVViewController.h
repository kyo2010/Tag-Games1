//
//  KKVViewController.h
//  Tag Games
//
//  Created by Konstantin Kimlaev on 30.10.12.
//  Copyright (c) 2012 JTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "MyOpenAL.h"
#import "KKVTagButton.h"
#import "KKVOptions.h"


@interface KKVViewController : UIViewController {
    IBOutlet UILabel *status; //присвоим нашей строке имя Label
    IBOutlet UIImageView *tagBox;
    
   // IBOutlet UIButton *buttonShakeP;
   // IBOutlet UIButton *buttonShakeL;
     
    IBOutlet UIBarButtonItem *buttonSoundControl;
    IBOutlet UIToolbar *ipadBar;
    
    KKVTagButton *bSpace;
    KKVOptions *optionsForm;
    
    NSArray *buttons;
    int stepCount;  
    
    // Sounds part
    MyOpenAL* myOpenAL;  
    BOOL enabledSound;
    float soundEventsVolume;
    NSUInteger soundWin;
    NSUInteger soundClick;
    
    
    BOOL isOriginalSize;
}    

- (IBAction) onShake:(id)sender;
- (IBAction) onSoundControl:(id)sender;
- (IBAction) onOptions:(id)sender;
- (void) showTagButtons; 
- (void) dealloc;
- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
- (void) win;
- (void) showSteps;

@end
