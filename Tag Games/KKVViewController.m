//
//  KKVViewController.m
//  Tag Games
//
//  Created by Konstantin Kimlaev on 30.10.12.
//  Copyright (c) 2012 JTeam. All rights reserved.
//


#import "KKVViewController.h"
#import "KKVTagButton.h"
#import "KKVOptions.h"
#import "WToast.h"


@interface KKVViewController ()

@end

@implementation KKVViewController

/* Лучше вызвать один метод в обоих случаях */
- (void) showTagButtons {
    //[self setBackgroundColor:[UIColor pinkColor]];
        
    for (int i=0; i<COUNT_OF_BUTTONS; i++){
        KKVTagButton *tag;
        tag = [buttons objectAtIndex:i];
        CGRect rec = tagBox.frame;
        [tag showTagButtons: rec];
     }
   //  label.text = @"Start is Ok...";
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation) interfaceOrientation duration:(NSTimeInterval)duration {
    
    int hb = ipadBar.frame.size.height;    
    int spacer = tagBox.frame.origin.y - hb;
    
    int dx = tagBox.frame.origin.y + 2*spacer;
    
    if (interfaceOrientation == UIInterfaceOrientationPortrait
        || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
      if (!isOriginalSize){  
        tagBox.frame = CGRectMake(tagBox.frame.origin.x, tagBox.frame.origin.y,
                                tagBox.frame.size.width+dx,tagBox.frame.size.height+dx);
          isOriginalSize = true;  
      }    
    }else{
        if (isOriginalSize){  
          tagBox.frame = CGRectMake(tagBox.frame.origin.x, tagBox.frame.origin.y,
                                    tagBox.frame.size.width-dx,tagBox.frame.size.height-dx);  
          isOriginalSize = false;  
        }    
    }
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation) orient {
  [self showTagButtons];
  return true;   
}

-(void)viewDidAppear:(BOOL)animated{
   [self showTagButtons];
   [self onShake:NULL]; 
   [self setSoundSwitcher];
   [self showSteps];
}

//- (void)viewWillUnload NS_DEPRECATED_IOS(5_0,6_0){
  //[[NSUserDefaults standardUserDefaults] setBool:enabledSound forKey:@"SoundSwitcher"]; 
//}

- (void)viewWillDisappear:(BOOL)animated{
 // [[NSUserDefaults standardUserDefaults] setBool:enabledSound forKey:@"SoundSwitcher"]; 
}

- (void)viewDidDisappear:(BOOL)animated{
  // [[NSUserDefaults standardUserDefaults] setBool:enabledSound forKey:@"SoundSwitcher"]; 
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    isOriginalSize = true;
    
    enabledSound = true;
    enabledSound = [[NSUserDefaults standardUserDefaults] boolForKey:@"SoundSwitcher" ]; 
    
    //return retVal;

    //[winnerForm setHidden:true];
        
    // Initializing OpenAL.
    myOpenAL = [[MyOpenAL alloc] init];
    soundEventsVolume = 1.0f;
    
    // Loading sounds
    soundWin = [myOpenAL loadSoundFromFile:@"win" ext:@"wav" withLoop:false];
    soundClick = [myOpenAL loadSoundFromFile:@"step" ext:@"wav" withLoop:false];
    
    optionsForm = [[KKVOptions alloc]  //инициализируем первый вид
                     initWithNibName:@"KKVOptions" bundle:nil];
    
    stepCount = 0;
    
    bSpace = [[KKVTagButton alloc] initN: 15 posCol:4 posRow:4
                                                 image:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default.png"]]
                            ]; 
    [bSpace setType:1];
    
    buttons = [[NSArray alloc] initWithObjects:
                [[KKVTagButton alloc] initN: 1 posCol:1 posRow:1 
                                      image:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"b1.png"]]],
               [[KKVTagButton alloc] initN: 2 posCol:2 posRow:1
                                     image:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"b2.png"]]],
               [[KKVTagButton alloc] initN: 3 posCol:3 posRow:1 
                                     image:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"b3.png"]]],
               [[KKVTagButton alloc] initN: 4 posCol:4 posRow:1 
                                     image:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"b4.png"]]],
               [[KKVTagButton alloc] initN: 5 posCol:1 posRow:2 
                                     image:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"b5.png"]]],
               [[KKVTagButton alloc] initN: 6 posCol:2 posRow:2 
                                     image:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"b6.png"]]],
               [[KKVTagButton alloc] initN: 7 posCol:3 posRow:2 
                                     image:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"b7.png"]]],
               [[KKVTagButton alloc] initN: 8 posCol:4 posRow:2 
                                     image:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"b8.png"]]],
               [[KKVTagButton alloc] initN: 9 posCol:1 posRow:3 
                                     image:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"b9.png"]]],
               [[KKVTagButton alloc] initN: 10 posCol:2 posRow:3 
                                     image:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"b10.png"]]],
               [[KKVTagButton alloc] initN: 11 posCol:3 posRow:3 
                                     image:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"b11.png"]]],
               [[KKVTagButton alloc] initN: 12 posCol:4 posRow:3 
                                     image:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"b12.png"]]],
               [[KKVTagButton alloc] initN: 13 posCol:1 posRow:4 
                                     image:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"b13.png"]]],
               [[KKVTagButton alloc] initN: 14 posCol:2 posRow:4 
                                     image:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"b14.png"]]],
               [[KKVTagButton alloc] initN: 15 posCol:3 posRow:4 
                                     image:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"b15.png"]]],
               bSpace,
               nil
               ];
    UIView *ui;
    ui = self.view;
    for (int i=0; i<COUNT_OF_BUTTONS; i++){
        KKVTagButton *tag;
        tag = [buttons objectAtIndex:i];
        [tag addToView: ui];
    }
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1){
        [self onShake:0];
    }
}

-(void) win{
    [WToast showWithText:[NSString stringWithFormat:@"You are winner, steps:%i",stepCount]];
    
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"You are winner!" message:[NSString stringWithFormat:@"You are winner, steps:%i",stepCount] delegate:self cancelButtonTitle:@"Close" otherButtonTitles:@"Shake", nil];
    //  message.alertViewStyle = UIAlertViewStylePlainTextInput;
    [message show];
    
    /** Super method - waiting....
     UIAlertView *msg = [[UIAlertView alloc] initWithTitle:@"Por favor, aguarde" message:@"Carregando imagens" 
     delegate:nil 
     cancelButtonTitle:nil 
     otherButtonTitles:nil];
     [msg show];
     
     if(msg != nil) {
     UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
     
     indicator.center = CGPointMake(msg.bounds.size.width/2, msg.bounds.size.height-45);
     [indicator startAnimating];
     [msg addSubview:indicator];
     [msg dismissWithClickedButtonIndex:0 animated:YES];
     //[indicator release];
     }*/
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    
   // [winnerForm setHidden:false];
   // MyViewController *ctrl = [[MyViewController alloc] initWithNibName:@"MyViewController" bundle:nil]; 
   // [self.view addSubview:ctrl.view];
    
    
    NSSet *allTouches = [event allTouches];
    UITouch *touch = [[allTouches allObjects] objectAtIndex:0];
    CGPoint touchLocation = [touch locationInView:self.view];
    
    NSLog(@"x=%f y=%f", touchLocation.x, touchLocation.y);
    
    int tx = touchLocation.x;
    int ty = touchLocation.y;
    for (int i=0; i<COUNT_OF_BUTTONS; i++){
        KKVTagButton *tag;
        tag = [buttons objectAtIndex:i];
        if ( [tag isClickX:tx Y:ty]==true )
        {
            /*  NSRunAlertPanel (@"GUI App", @"GUI App using GNUStep in Windows",
             @"Okay", nil, nil);*/
            /*     //NSRunAlertPanel(@"My Application", @"My Application's string contents", @"OK", nil, nil);
             NSTextView *accessory = [[NSTextView alloc] initWithFrame:NSMakeRect(0,0,200,15)];
             NSFont *font = [NSFont systemFontOfSize:[NSFont systemFontSize]];
             NSDictionary *textAttributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
             [accessory insertText:[[NSAttributedString alloc] initWithString:@"Text in accessory view"
             attributes:textAttributes]];
             [accessory setEditable:NO];
             [accessory setDrawsBackground:NO];
             
             NSAlert *alert = [[NSAlert alloc] init];
             [alert setMessageText:@"Message text"];
             [alert setInformativeText:@"Informative text"];
             [alert setAccessoryView:accessory];
             [alert runModal];
             [alert release];*/
            
            if ([tag move:bSpace box:tagBox.frame] && enabledSound){
              [myOpenAL playSoundWithId:soundClick atVolume:soundEventsVolume];  
            }
            
            NSLog(@"button number=%i", i);
            
            stepCount++;
            [self showSteps];
       //     label.text = [NSString stringWithFormat:@"Steps:%i",stepCount];
            
            bool isIn = true;
            for (int v=0; v<COUNT_OF_BUTTONS; v++){
              KKVTagButton *tag1 = [buttons objectAtIndex:v];
                if ([tag1 isIn]==false){
                    isIn = false;
                    break;
                }
            }
            if (isIn){
              if (enabledSound){  
                [myOpenAL playSoundWithId:soundWin atVolume:soundEventsVolume];  
              }    
             [self win];
           //   label.text = [NSString stringWithFormat:@"You are winner! steps:%i", stepCount];
            }
        }
        
    }
}
   
   -(void) setSoundSwitcher{
       if (enabledSound){
           [buttonSoundControl setTitle:@"sound off" ];  
       }else{
           [buttonSoundControl setTitle:@"sound on" ];  
       }
   }  

- (IBAction) onSoundControl:(id)sender{
    enabledSound = !enabledSound;
    [[NSUserDefaults standardUserDefaults] setBool:enabledSound forKey:@"SoundSwitcher"];
    [self setSoundSwitcher];
}

-(void) showSteps{ 
  status.text = [NSString stringWithFormat:@"Steps :%i",stepCount];
}
 
- (IBAction) onShake:(id)sender{
    for (int countShake=0; countShake<200+random()%100; countShake++){
     //   sleep(1);
    int dx = random()%7;
    //int dy = random()%3;
    int d_col = 0;
    int d_row = 0;
    if (bSpace.posRow!=1 && dx==0){
        d_row = -1;   
    }else if (bSpace.posRow!=4 && dx==2){
        d_row = 1;
    }else if (bSpace.posCol!=1 && dx==4){
        d_col = -1;   
    }else if (bSpace.posCol!=4 && dx==5){
        d_col = 1;
    }
    for (int i=0; i<COUNT_OF_BUTTONS; i++){
        KKVTagButton *tag;
        tag = [buttons objectAtIndex:i];
        if (tag.posCol==bSpace.posCol+d_col && tag.posRow==bSpace.posRow+d_row){
          [tag move:bSpace box:tagBox.frame];
        }
    } 
    }  
    stepCount = 0;
    [self showSteps];
};

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) onOptions:(id)sender
{
  [self.view insertSubview:optionsForm.view atIndex:0]; //делаем его активным
  [tagBox setHidden:true]; 
//  label.text = [NSString stringWithFormat:@"OptionsForm"];
}


//- (void) dealloc {
  //  [optionsForm release]; 
  //  [super dealloc];
//}

@end
