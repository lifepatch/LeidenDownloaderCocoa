//
//  TileDownloadOperation.h
//  LeidenDownloader
//
//  Created by xcorex on 8/12/15.
//  Copyright (c) 2015 xcorex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TileImageDownloadOperation.h"

@interface ImageMapConfig : NSObject

@property (strong) NSString * map_url;
@property (strong) NSString * map_uid;

@property (strong) NSString * map_tile_url;
@property (strong) NSString * map_file_path;

@property (strong) NSString * map_image_url;

@property (assign) int img_width;
@property (assign) int img_height;
@property (assign) int tile_width;
@property (assign) int tile_height;

@property (assign) int cols;
@property (assign) int rows;

@property (assign) int starttile;

@end



@interface ImageMapDownloadOperation : NSOperation
{
    @private
    
    NSOperationQueue * queue;
    NSString * raw_html;
    
    ImageMapConfig * map_config;
}

- (void) main;

- (id) initWithUrl:(NSString *) url;

@end
