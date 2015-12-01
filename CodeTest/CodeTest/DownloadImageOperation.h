//
//  DownloadImageOperation.h
//  CodeTest
//
//  Created by TAE on 12/1/15.
//  Copyright © 2015 TAE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Constants.h"

@interface DownloadImageOperation : NSOperation
/*
 * imageUrl - image url for download
 */
@property (nonatomic, readonly) NSURL * imageUrl;
@property (nonatomic, readonly) ImageDownloadCompletion  completion;

-(instancetype)initWithUrl:(NSURL *)imageUrl completion:(ImageDownloadCompletion)completionHandler;

@end
