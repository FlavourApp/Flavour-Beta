//
//  MenuTableViewController.h
//  Flavour v0.6
//
//  Created by Demian Schkolnik on 11/10/14.
//  Copyright (c) 2014 Schkolnik. All rights reserved.
//

#import "TableViewController.h"
#import "chefObject.h"

@interface MenuTableViewController : TableViewController

@property (nonatomic,strong) NSArray *Menus;
@property (strong, nonatomic) chefObject *chef;
@property (strong, nonatomic) NSDictionary *date;

@end
