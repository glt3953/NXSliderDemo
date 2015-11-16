//
//  LicenseAgreementTableViewCell.h
//  room107
//
//  Created by ningxia on 15/9/8.
//  Copyright (c) 2015年 107room. All rights reserved.
//

#import "Room107TableViewCell.h"

static CGFloat licenseAgreementTableViewCellHeight = 60.0f;

@interface LicenseAgreementTableViewCell : Room107TableViewCell

- (void)setContent:(NSString *)content;
- (void)setStatus:(BOOL)selected;
- (BOOL)status;

@end
