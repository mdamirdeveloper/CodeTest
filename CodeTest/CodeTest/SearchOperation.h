//
//  SearchOperation.h
//  CodeTest
//
//  Created by TAE on 12/1/15.
//  Copyright © 2015 TAE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"
@interface SearchOperation : NSOperation
/*
 * searchUrl - Url for search
 */
@property (nonatomic, readonly) NSURL * searchUrl;
@property (nonatomic, readonly) SongSearchCompletion completion;


-(instancetype)initWithUrl:(NSURL *)searchUrl completion:(SongSearchCompletion)completionHandler;

@end
