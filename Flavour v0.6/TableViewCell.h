//
//  TableViewCell.h
//  chefTestV2
//
//  Created by Demian Schkolnik on 8/31/14.
//  Copyright (c) 2014 Schkolnik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell

@property (strong,nonatomic) IBOutlet UILabel *TitleLabel;
@property (strong,nonatomic) IBOutlet UILabel *DescriptionLabel;
@property (strong,nonatomic) IBOutlet UIImageView *ThumbImage;

@end
