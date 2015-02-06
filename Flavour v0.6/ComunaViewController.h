//
//  ComunaViewController.h
//  Flavour v0.6
//
//  Created by Demian Schkolnik on 2/5/15.
//  Copyright (c) 2015 Schkolnik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadingViewController.h"

@interface ComunaViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>

@property (strong, nonatomic) IBOutlet UIPickerView *comunaPickerView;
@property (strong, nonatomic) NSArray *pickerData;

@end
