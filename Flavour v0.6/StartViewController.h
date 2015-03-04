//
//  StartViewController.h
//  Flavour v0.6
//
//  Created by Demian Schkolnik on 11/5/14.
//  Copyright (c) 2014 Schkolnik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ComunaViewController.h"


@interface StartViewController : UIViewController
{
    bool timerBool;
}

@property (strong, nonatomic) NSMutableArray *comunas;
@property (strong, nonatomic) IBOutlet UIButton *startButton;
@property (strong, nonatomic) IBOutlet UIImageView *bgImageView;

@end
