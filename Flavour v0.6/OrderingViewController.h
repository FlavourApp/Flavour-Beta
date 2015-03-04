//
//  OrderingViewController.h
//  Flavour v0.6
//
//  Created by Demian Schkolnik on 11/11/14.
//  Copyright (c) 2014 Schkolnik. All rights reserved.
//

#import "ViewController.h"

@interface OrderingViewController : ViewController
{
    bool timerBool;
}


@property (strong, nonatomic) NSString *chefId;
@property (strong, nonatomic) NSString *dateId;
@property (strong, nonatomic) NSString *menuId;


@property (strong, nonatomic)  NSString *name;
@property (strong, nonatomic)  NSString *adress;
@property (strong, nonatomic)  NSString *phone;
@property (strong, nonatomic)  NSString *email;
@property (strong, nonatomic)  NSString *cantidad;

- (void)goToNextScene;

@end
