//
//  Item.m
//  CodeTest
//
//  Created by TAE on 12/1/15.
//  Copyright © 2015 TAE. All rights reserved.
//

#import "Item.h"

@implementation Item
- (instancetype)initWithDictionary:(NSDictionary *)item{
    self = [super init];
    if(self){
        _artistName = [item valueForKey:@"artistName"];
        _trackName = [item valueForKey:@"trackName"];
        _albumName = [item valueForKey:@"collectionName"];
        _artworkUrl30 = [item valueForKey:@"artworkUrl30"];
        _artworkUrl60 = [item valueForKey:@"artworkUrl60"];
        _artworkUrl100 = [item valueForKey:@"artworkUrl100"];
        _trackPrice = [NSNumber numberWithDouble:[[item valueForKey:@"trackPrice"] doubleValue]];
        NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
        NSString * dateFormat = @"yyyy-MM-dd'T'hh:mm:ss'Z'";
        [dateFormatter setDateFormat:dateFormat];
        _releaseDate = [dateFormatter dateFromString:[item valueForKey:@"releaseDate"]];
    }
    return self;
}

@end
