//
//  SNCustomerImageVC.m
//  MactuniAirCondition
//
//  Created by 朱正晶 on 15/7/30.
//  Copyright (c) 2015年 scinan. All rights reserved.
//

#import "SNCustomerImageVC.h"

@interface SNCustomerImageVC () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end

@implementation SNCustomerImageVC
{
    UIImagePickerControllerSourceType _sourceType;
}

- (instancetype)initWithSourceType:(UIImagePickerControllerSourceType)sourceType
{
    self = [super init];
    if (self) {
        _sourceType = sourceType;
        [self initProgram];
    }

    return self;
}

- (void)initProgram
{
    self.sourceType = _sourceType;
    self.delegate = self;
    self.allowsEditing = YES;
}

#pragma mark- UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    [self dismissViewControllerAnimated:YES completion:nil];

    if ([_customerDelegate respondsToSelector:@selector(SNCustomerImageVCDidFinishedPickingImage:)]) {
        [_customerDelegate SNCustomerImageVCDidFinishedPickingImage:image];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];

    if ([_customerDelegate respondsToSelector:@selector(SNCustomerImageVCDidCancelPickerImage)]) {
        [_customerDelegate SNCustomerImageVCDidCancelPickerImage];
    }
}

@end
