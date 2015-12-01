//
//  Item.h
//  CodeTest
//
//  Created by TAE on 12/1/15.
//  Copyright © 2015 TAE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Item : NSObject
@property (nonatomic, strong) NSString * artistName;
@property (nonatomic, strong) NSString * trackName;
@property (nonatomic, strong) NSString * albumName;
@property (nonatomic, strong) NSString * artworkUrl30;
@property (nonatomic, strong) NSString * artworkUrl60;
@property (nonatomic, strong) NSString * artworkUrl100;
@property (nonatomic, strong) NSNumber * trackPrice;
@property (nonatomic, strong) NSDate * releaseDate;
@property (nonatomic, strong) UIImage * artwork;

- (instancetype)initWithDictionary:(NSDictionary *)item;

@end
