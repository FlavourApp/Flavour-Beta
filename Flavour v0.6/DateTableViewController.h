//
//  DateTableViewController.h
//  Flavour v0.6
//
//  Created by Demian Schkolnik on 11/5/14.
//  Copyright (c) 2014 Schkolnik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "chefObject.h"

@interface DateTableViewController : UITableViewController

@property (nonatomic,strong) NSMutableArray *dates;
@property (nonatomic, strong) chefObject *chef;

@end
