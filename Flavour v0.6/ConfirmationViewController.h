//
//  ConfirmationViewController.h
//  Flavour v0.6
//
//  Created by Demian Schkolnik on 11/11/14.
//  Copyright (c) 2014 Schkolnik. All rights reserved.
//

#import "ViewController.h"

@interface ConfirmationViewController : ViewController
@property (strong, nonatomic) IBOutlet UILabel *chefLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *menuLabel;
@property (strong, nonatomic) IBOutlet UITextView *descriptionText;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) IBOutlet UIImageView *chefImage;
@property (strong, nonatomic) IBOutlet UIImageView *foodImage;
@property (strong, nonatomic) IBOutlet UIImageView *foodImage2;

@property (strong, nonatomic) IBOutlet UISegmentedControl *peopleTable;

@property (strong, nonatomic) NSString *chef;
@property (strong, nonatomic) NSString *chefPk;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *dateId;
@property (strong, nonatomic) NSString *menu;
@property (strong, nonatomic) NSString *menuPk;
@property (strong, nonatomic) NSString *descriptionString;
@property (strong, nonatomic) NSString *price;
@property (strong, nonatomic) NSString *chefImageUrl;
@property (strong, nonatomic) NSString *foodImageUrl;
@property (strong, nonatomic) NSString *foodImageUrl2;

@end
