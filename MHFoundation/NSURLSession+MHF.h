//
//  NSURLSession+MHF.h
//  MHFoundation
//
//  Created by Malcolm Hall on 04/09/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MHFoundation/MHFDefines.h>

@interface NSURLSession (MHF)

// convenience for cancelling tasks but not invalidating session like invalidateAndCancel does.
- (void)mhf_cancelAllTasks;

@end
