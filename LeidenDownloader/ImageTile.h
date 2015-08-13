//
//  ImageTile.h
//  LeidenDownloader
//
//  Created by xcorex on 8/10/15.
//  Copyright (c) 2015 xcorex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageTile : NSObject
{

}

@property (nonatomic,copy) NSString * url;
@property (nonatomic,copy) NSString * filename;
//@property  bool * downloaded;
//- (instancetype)initWithUrl:(*NSString)url filename:(*NSString)file;
- (instancetype)init:(NSString*)url filename:(NSString*)file;


@end
