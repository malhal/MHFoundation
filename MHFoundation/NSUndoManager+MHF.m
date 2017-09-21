//
//  NSUndoManager+MHF.m
//  MHFoundation
//
//  Created by Malcolm Hall on 19/09/2017.
//  Copyright © 2017 Malcolm Hall. All rights reserved.
//

#import "NSUndoManager+MHF.h"

@implementation NSUndoManager (MHF)

- (BOOL)mhf_isUndoingOrRedoing{
    return self.isUndoing || self.isRedoing;
}

@end
