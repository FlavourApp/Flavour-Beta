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
    _descriptionText.text = _descriptionString;
    _descriptionText.editable = NO;
    
    int price = [_price intValue];
    price = price * 2;
    
    [_peopleTable addTarget:self
                         action:@selector(onPeopleTableChange)
               forControlEvents:UIControlEventValueChanged];
    
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
    
    NSURL *urlFood1 = [NSURL URLWithString:_foodImageUrl];
    NSData *dataFood1 = [NSData dataWithContentsOfURL:urlFood1];
    _foodImage.image = [UIImage imageWithData:dataFood1];
    
    NSURL *urlFood2 = [NSURL URLWithString:_foodImageUrl2];
    NSData *dataFood2 = [NSData dataWithContentsOfURL:urlFood2];
    _foodImage.image = [UIImage imageWithData:dataFood2];
   
}

- (void)onPeopleTableChange
{
    int price = [_price intValue];
    price = price * (_peopleTable.selectedSegmentIndex + 2);

    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    formatter.currencySymbol = @"$";
    formatter.currencyGroupingSeparator = @".";
    formatter.allowsFloats = NO;
    formatter.maximumFractionDigits = 0;
    NSString *priceString = [formatter stringFromNumber:[NSNumber numberWithInt:price]];
    _priceLabel.text = priceString;
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
        userDataViewController.peopleCount = [_peopleTable titleForSegmentAtIndex:_peopleTable.selectedSegmentIndex];
    }
}



@end
