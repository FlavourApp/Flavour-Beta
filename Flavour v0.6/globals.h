//
//  globals.h
//  Flavour v0.6
//
//  Created by Demian Schkolnik on 11/12/14.
//  Copyright (c) 2014 Schkolnik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface globals : NSObject

+(NSString *) getIp;
+(NSString *) getChefsIp;
+(NSString *) getChefsIp:(NSString*)comuna;
+(NSString *) getIPMenusForChef:(NSString*)chefId;
+(NSString *) getIPDatesForChef:(NSString*)chefId;
+(NSString *) getIPImagesForUrl:(NSString*)localUrl;
+(NSString *) getPostOrderIP;
+(NSString *) getComunasIp;

@end
