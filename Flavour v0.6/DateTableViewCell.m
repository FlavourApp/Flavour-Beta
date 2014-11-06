//
//  DateTableViewCell.m
//  Flavour v0.6
//
//  Created by Demian Schkolnik on 11/5/14.
//  Copyright (c) 2014 Schkolnik. All rights reserved.
//

#import "DateTableViewCell.h"

@implementation DateTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
