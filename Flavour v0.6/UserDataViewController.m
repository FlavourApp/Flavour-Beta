//
//  UserDataViewController.m
//  Flavour v0.6
//
//  Created by Demian Schkolnik on 2/2/15.
//  Copyright (c) 2015 Schkolnik. All rights reserved.
//

#import "UserDataViewController.h"

@interface UserDataViewController ()

@end

@implementation UserDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([defaults objectForKey:@"userName"] != nil)
    {
        _nameField.text = [defaults objectForKey:@"userName"];  
    }
    if([defaults objectForKey:@"userDirection"] != nil)
    {
        _directionField.text = [defaults objectForKey:@"userDirection"];
    }
    if([defaults objectForKey:@"userCellphone"] != nil)
    {
        _cellphoneField.text = [defaults objectForKey:@"userCellphone"];
    }
    if ([defaults objectForKey:@"userMail"] != nil)
    {
        _emailField.text = [defaults objectForKey:@"userMail"];
    }

    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES]; // dismiss the keyboard
    
    [super touchesBegan:touches withEvent:event];
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
    if ([[segue identifier] isEqualToString:@"goToOrdering"]) {
        
        OrderingViewController *orderingViewController = [segue destinationViewController];
        
        orderingViewController.chefId = _chefId;
        orderingViewController.menuId = _menuId;
        orderingViewController.dateId = _dateId;
        
        orderingViewController.name = _nameField.text;;
        orderingViewController.adress = _directionField.text;
        orderingViewController.phone = _cellphoneField.text;
        orderingViewController.email = _emailField.text;
        orderingViewController.cantidad = _peopleCount;
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setValue:_nameField.text forKey:@"userName"];
        [defaults setValue:_directionField.text forKey:@"userDirection"];
        [defaults setValue:_cellphoneField.text forKey:@"userCellphone"];
        [defaults setValue:_emailField.text forKey:@"userMail"];
    }
}

@end
