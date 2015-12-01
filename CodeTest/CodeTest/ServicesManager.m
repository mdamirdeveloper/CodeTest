//
//  ServicesManager.m
//  CodeTest
//
//  Created by TAE on 12/1/15.
//  Copyright © 2015 TAE. All rights reserved.
//

#import "ServicesManager.h"
#import "DownloadImageOperation.h"
#import "SearchOperation.h"

@interface ServicesManager()

@property (nonatomic,strong) NSOperationQueue * queueImageDownload;
@property (nonatomic,strong) NSOperationQueue * queueSearch;

@end

@implementation ServicesManager


+ (instancetype)sharedServicesManager {
    static ServicesManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    //Initialize static variable only once
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}


- (id)init {
    if (self = [super init]) {
        //Image download queue
        _queueImageDownload = [[NSOperationQueue alloc] init];
        _queueImageDownload.maxConcurrentOperationCount = 10;
        _queueImageDownload.name = @"image_queue";
        //We want image download to be responsive
        _queueImageDownload.qualityOfService = NSQualityOfServiceUserInteractive;
        
        //Search queue
        _queueSearch = [[NSOperationQueue alloc] init];
        //Have maximum one search operation at any given time
        _queueSearch.maxConcurrentOperationCount = 1;
        _queueSearch.name = @"search_queue";
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
    [_queueImageDownload cancelAllOperations];
    _queueImageDownload = nil;
    [_queueSearch cancelAllOperations];
    _queueSearch = nil;
}

-(void)downloadImage:(NSString *)url completion:(ImageDownloadCompletion)completionHandler{
    DownloadImageOperation * downloadOp = [[DownloadImageOperation alloc] initWithUrl:[NSURL URLWithString:url] completion:completionHandler];
    [_queueImageDownload addOperation:downloadOp];
}

-(void)searchArtist:(NSString *)searchTerm completion:(SongSearchCompletion)completionHandler{
    NSString * url = [NSString stringWithFormat:@"http://itunes.apple.com/search?term=%@",[self urlencode:searchTerm]];
    SearchOperation * searchOp = [[SearchOperation alloc] initWithUrl:[NSURL URLWithString:url] completion:completionHandler];
    //Cancel any in progress search operations
    [_queueSearch cancelAllOperations];
    //Add new search op
    [_queueSearch addOperation:searchOp];
    
}
-(void)cancelArtistSearch{
    //Cancel any in-progress searches
    // @LIMITATION: Operations are not immediately cancelled and removed
    [_queueSearch cancelAllOperations];
}


/*
 * URL Encode provided string
 */
- (NSString *)urlencode:(NSString *)string {
    NSMutableString *output = [NSMutableString string];
    const unsigned char *source = (const unsigned char *)[string UTF8String];
    int sourceLen = (int)strlen((const char *)source);
    for (int i = 0; i < sourceLen; ++i) {
        const unsigned char thisChar = source[i];
        if (thisChar == ' '){
            [output appendString:@"+"];
        } else if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' ||
                   (thisChar >= 'a' && thisChar <= 'z') ||
                   (thisChar >= 'A' && thisChar <= 'Z') ||
                   (thisChar >= '0' && thisChar <= '9')) {
            [output appendFormat:@"%c", thisChar];
        } else {
            [output appendFormat:@"%%%02X", thisChar];
        }
    }
    return output;
}
@end
