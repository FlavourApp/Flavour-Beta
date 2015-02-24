//
//  LoadingViewController.h
//  chefTestV2
//
//  Created by Demian Schkolnik on 9/22/14.
//  Copyright (c) 2014 Schkolnik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingViewController : UIViewController <UIAlertViewDelegate> 
 
@property (nonatomic,strong) NSMutableArray *fullChefList;
/*------- Chef API ----------
 chefId - int
 name - String
 lastname - String
 comunas - Array of Strings
 phone - String
 pictureUrl - String
 email - String
 description - String
 -------------------------*/

@property (strong, nonatomic) NSString *comuna;

@end
