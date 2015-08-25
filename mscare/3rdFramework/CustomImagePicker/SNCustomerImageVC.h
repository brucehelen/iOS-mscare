//
//  SNCustomerImageVC.h
//  MactuniAirCondition
//
//  Created by 朱正晶 on 15/7/30.
//  Copyright (c) 2015年 scinan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  SNCustomerImageVCDelegate;

@interface SNCustomerImageVC : UIImagePickerController

// UIImagePickerControllerSourceTypePhotoLibrary,
// UIImagePickerControllerSourceTypeCamera,
- (instancetype)initWithSourceType:(UIImagePickerControllerSourceType)sourceType;

@property (nonatomic, weak) id<SNCustomerImageVCDelegate> customerDelegate;

@end

@protocol SNCustomerImageVCDelegate<NSObject>

@optional
- (void)SNCustomerImageVCDidFinishedPickingImage:(UIImage *)image;
- (void)SNCustomerImageVCDidCancelPickerImage;

@end
