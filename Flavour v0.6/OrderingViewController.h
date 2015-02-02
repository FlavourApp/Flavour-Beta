//
//  OrderingViewController.h
//  Flavour v0.6
//
//  Created by Demian Schkolnik on 11/11/14.
//  Copyright (c) 2014 Schkolnik. All rights reserved.
//

#import "ViewController.h"

@interface OrderingViewController : ViewController

@property (strong, nonatomic) NSString *chefId;
@property (strong, nonatomic) NSString *dateId;
@property (strong, nonatomic) NSString *menuId;


@property (weak, nonatomic)  NSString *name;
@property (weak, nonatomic)  NSString *direction;
@property (weak, nonatomic)  NSString *cellphone;
@property (weak, nonatomic)  NSString *email;

-(void)goToNextScene;

@end
