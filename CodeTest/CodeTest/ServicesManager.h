//
//  ServicesManager.h
//  CodeTest
//
//  Created by TAE on 12/1/15.
//  Copyright © 2015 TAE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Constants.h"

@interface ServicesManager : NSObject

/*
 * Services manager singleton class for performing web service operations
 *
 */
+ (instancetype)sharedServicesManager;


/*
 * Download images
 */
-(void)downloadImage:(NSString *)url completion:(ImageDownloadCompletion)completionHandler;

/*
 * Search artist
 */
-(void)searchArtist:(NSString *)searchTerm completion:(SongSearchCompletion)completionHandler;

/*
 * Cancel artist search
 */
-(void)cancelArtistSearch;

@end
