//
//  AppDelegate.m
//  LeidenDownloader
//
//  Created by xcorex on 8/10/15.
//  Copyright (c) 2015 xcorex. All rights reserved.
//

#import "AppDelegate.h"
#import "ImageTile.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate


- (void)testFunc:(NSNotification *)notification {
    NSLog(@"received");
}

-(void)awakeFromNib
{
    NSLog(@"awakeFromNib");
    [self.txtUrl setStringValue:@"http://"];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
//    
    [center addObserver:self selector:@selector(testFunc:) name:@"testEvent" object:nil];


}



- (instancetype)init
{
    self = [super init];
    if (self) {
        imageListUrl = [[NSMutableArray alloc] init];
        mapqueue = [[NSOperationQueue alloc] init];
    }
    return self;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    NSLog(@"applicationDidFinishLaunching");
    // Insert code here to initialize your application

}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView {
    return imageListUrl.count;
}

- (id)tableView:(NSTableView *)aTableView
objectValueForTableColumn:(NSTableColumn *)aTableColumn
            row:(NSInteger)rowIndex {
    ImageTile * t_tile = [imageListUrl objectAtIndex:rowIndex];
    NSString * identifier = [aTableColumn identifier];
    return [t_tile valueForKey:identifier];
    
}


- (IBAction)btnGetClicked:(id)sender {
    
    [imageListUrl addObject:[[ImageTile alloc] init:@"http://google.com" filename:@"test.jpg"]];
    [self.tableUrl reloadData];
}

- (IBAction)btnDumpClicked:(id)sender {

        [[NSNotificationCenter defaultCenter] postNotificationName:@"testEvent" object:self];
    
    ImageMapDownloadOperation * tmp_mapdownload = [[ImageMapDownloadOperation alloc] initWithUrl:@"http://media-kitlv.nl/all-media/indeling/detail/form/advanced/start/51?q_searchfield=tigers"];
    
    [mapqueue addOperation:tmp_mapdownload];
}


@end
