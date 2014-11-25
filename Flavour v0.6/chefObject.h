//
//  chefObject.h
//  Flavour v0.6
//
//  Created by Demian Schkolnik on 11/10/14.
//  Copyright (c) 2014 Schkolnik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface chefObject : NSObject

@property (strong, nonatomic) NSString *pictureUrl;
@property (strong, nonatomic) NSString *bio;
@property (strong, nonatomic) NSString *longBio;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *fullName;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *phone;

@property (strong, nonatomic) NSString *pk;

-(id)initWithDictionary:(NSDictionary *)dict;

@end
