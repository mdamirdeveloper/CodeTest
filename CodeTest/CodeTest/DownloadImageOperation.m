//
//  DownloadImageOperation.m
//  CodeTest
//
//  Created by TAE on 12/1/15.
//  Copyright © 2015 TAE. All rights reserved.
//

#import "DownloadImageOperation.h"
@interface DownloadImageOperation()
@property (nonatomic, strong) NSURL * imageUrl;
@property (nonatomic, strong) ImageDownloadCompletion completion;
@end
@implementation DownloadImageOperation
-(instancetype)initWithUrl:(NSURL *)imageUrl completion:(ImageDownloadCompletion)completionHandler{
    self = [super init];
    if(self){
        _imageUrl = imageUrl;
        _completion = completionHandler;
    }
    return self;
}

- (void)main {
    
    @autoreleasepool {
        //TODO: NSURLConnection based cancellable downloads for better control
        NSError *error = nil;
        NSData *data = [NSData dataWithContentsOfURL:_imageUrl options:0 error:&error];
        UIImage *image = nil;
        if (data)
            image = [UIImage imageWithData:data];
        if(_completion){
            if(image && !error)
                _completion(YES, image, error);
            else
                _completion(NO, image, error);
        }
    }
}
@end
