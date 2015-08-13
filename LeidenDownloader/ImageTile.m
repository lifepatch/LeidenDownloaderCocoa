//
//  ImageTile.m
//  LeidenDownloader
//
//  Created by xcorex on 8/10/15.
//  Copyright (c) 2015 xcorex. All rights reserved.
//

#import "ImageTile.h"

@implementation ImageTile

@synthesize url;
@synthesize filename;


//- (instancetype)initWithUrl:(*NSString)url filename:(*NSString)file
//{
//    self = [super init];
//    if (self) {
//        
//    }
//    return self;
//}

- (instancetype)init:(NSString*)p_url filename:(NSString*)p_file
{
    self = [super init];
    if (self) {
        self.url = p_url;
        self.filename  = p_file;
    }
    return self;
}

@end
