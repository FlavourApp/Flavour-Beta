//
//  DetailViewController.h
//  chefTestV2
//
//  Created by Demian Schkolnik on 8/31/14.
//  Copyright (c) 2014 Schkolnik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "chefObject.h"

@interface DetailViewController : UIViewController

@property (strong,nonatomic) IBOutlet UILabel *TitleLabel;
@property (strong,nonatomic) IBOutlet UILabel *DescriptionLabel;
@property (strong,nonatomic) IBOutlet UIImageView *CookImage;
@property (strong,nonatomic) IBOutlet UIImageView *FoodImage;
@property (strong, nonatomic) IBOutlet UILabel *bioLabel;

@property (strong,nonatomic) chefObject *chef;

@end
