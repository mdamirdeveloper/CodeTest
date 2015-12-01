//
//  SearchOperation.m
//  CodeTest
//
//  Created by TAE on 12/1/15.
//  Copyright © 2015 TAE. All rights reserved.
//

#import "SearchOperation.h"
#import "Item.h"
@interface SearchOperation()
@property (nonatomic, strong) NSURL * searchUrl;
@property (nonatomic, strong) SongSearchCompletion completion;

@end

@implementation SearchOperation
-(instancetype)initWithUrl:(NSURL *)searchUrl completion:(SongSearchCompletion)completionHandler{
    self = [super init];
    if(self){
        _searchUrl = searchUrl;
        _completion = completionHandler;
    }
    return self;
}
- (void)main {
    
    @autoreleasepool {
        //TODO: NSURLSession based cancellable downloads for better control
        NSError *error = nil;
        NSData *data = [NSData dataWithContentsOfURL:_searchUrl options:0 error:&error];
        NSDictionary * results = nil;
        NSArray * items = nil;
        if (data){ //If data returned parse json
            results = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            if(error){ //If json parse error
                if(_completion)
                    _completion(NO, nil, error);
            }else{ // Populate strong typed Item objects
                items = [results valueForKey:@"results"];
                if(items){
                    NSMutableArray * songs = [[NSMutableArray alloc] init];
                    for(NSDictionary * item in items){
                        [songs addObject:[[Item alloc] initWithDictionary:item]];
                    }
                    if(_completion)
                        _completion(YES, songs, nil);
                }else{ // Send an error for no results found
                    if(_completion)
                        _completion(NO, nil, [NSError errorWithDomain:@"com.TAE.CodeTest" code:-1 userInfo:@{NSLocalizedDescriptionKey:@"No results found."}]);
                }
            }
        }else{
            if(_completion)
                _completion(NO, nil, error);
        }
        
    }
}
@end
