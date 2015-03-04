//
//  UserDataViewController.h
//  Flavour v0.6
//
//  Created by Demian Schkolnik on 2/2/15.
//  Copyright (c) 2015 Schkolnik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderingViewController.h"

@interface UserDataViewController : UIViewController

@property (strong, nonatomic) NSString *chefId;
@property (strong, nonatomic) NSString *dateId;
@property (strong, nonatomic) NSString *menuId;
@property (strong, nonatomic) NSString *peopleCount;

@property (strong, nonatomic) IBOutlet UITextField *nameField;
@property (strong, nonatomic) IBOutlet UITextField *directionField;
@property (strong, nonatomic) IBOutlet UITextField *cellphoneField;
@property (strong, nonatomic) IBOutlet UITextField *emailField;

@end
