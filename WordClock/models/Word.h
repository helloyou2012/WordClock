//
//  Word.h
//  WordClock
//
//  Created by ZhenzhenXu on 12/26/13.
//  Copyright (c) 2013 ZhenzhenXu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Word : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * word_en;
@property (nonatomic, retain) NSString * word_zh;
@property (nonatomic, retain) NSString * word_pron;
@property (nonatomic, retain) NSNumber * success_num;
@property (nonatomic, retain) NSNumber * fail_num;

@end
