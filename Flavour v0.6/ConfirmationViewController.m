//
//  ConfirmationViewController.m
//  Flavour v0.6
//
//  Created by Demian Schkolnik on 11/11/14.
//  Copyright (c) 2014 Schkolnik. All rights reserved.
//

#import "ConfirmationViewController.h"
#import "UserDataViewController.h"

@interface ConfirmationViewController ()

@end

@implementation ConfirmationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _chefLabel.text = _chef;
    _dateLabel.text = _date;
    _menuLabel.text = _menu;
    _descriptionLabel.text = _descriptionString;
    int price = [_price intValue];
    price = price * 2;
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    formatter.currencySymbol = @"$";
    formatter.currencyGroupingSeparator = @".";
    formatter.allowsFloats = NO;
    formatter.maximumFractionDigits = 0;
    
    NSString *priceString = [formatter stringFromNumber:[NSNumber numberWithInt:price]];
    _priceLabel.text = priceString;
    
    NSURL *url = [NSURL URLWithString:_chefImageUrl];
    NSData *data = [NSData dataWithContentsOfURL:url];
    _chefImage.image = [UIImage imageWithData:data];
    
    NSURL *url2 = [NSURL URLWithString:_foodImageUrl];
    NSData *data2 = [NSData dataWithContentsOfURL:url2];
    _foodImage.image = [UIImage imageWithData:data2];
    
    _peopleCountSlider.minimumValue = 2;
    _peopleCountSlider.maximumValue = 10;
    _peopleCountSlider.continuous = false;
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"goToUserData"]) {
        
        UserDataViewController *userDataViewController = [segue destinationViewController];
        
        userDataViewController.chefId = _chefPk;
        userDataViewController.menuId = _menuPk;
        userDataViewController.dateId = _dateId;
        userDataViewController.peopleCount = _peopleCountLabel.text;
        
    }
}

- (IBAction) sliderValueChanged:(UISlider *)sender {
    _peopleCountLabel.text = [NSString stringWithFormat:@" %i", (int)([sender value])];
    int price = [_price intValue];
    int people = _peopleCountSlider.value;
    price = price * people;
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    formatter.currencySymbol = @"$";
    formatter.currencyGroupingSeparator = @".";
    formatter.allowsFloats = NO;
    formatter.maximumFractionDigits = 0;
    
    NSString *priceString = [formatter stringFromNumber:[NSNumber numberWithInt:price]];
    _priceLabel.text = priceString;
    
}

@end
