
//
//  ImagePickerManage.m
//  ImagePicker
//
//  Created by kakao on 16/3/25.
//  Copyright © 2016年 shuai zhang. All rights reserved.
//

#import "ImagePickerManage.h"
#import <objc/runtime.h>

static char associationViewControllerkey;

@interface ImagePickerManage ()

@property(nonatomic,strong) UIViewController *viewController;

@end
@implementation ImagePickerManage


-(void)showImagePickerControllerWithViewControll:(UIViewController *)viewController finishBlock:(FinishPickerImageBlock)finishBlock{

    self.viewController=viewController;
    
    objc_setAssociatedObject(viewController, &associationViewControllerkey, self, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.finishBlock=finishBlock;
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *albumAction =[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       
        UIImagePickerController * imagePickerController =[[UIImagePickerController alloc] init];
        
        imagePickerController.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        
        imagePickerController.allowsEditing=YES;
//        CGAffineTransform   transform  =CGAffineTransformMakeRotation(0.2);
//        imagePickerController.cameraViewTransform=transform;
        imagePickerController.delegate=self;
        [viewController presentViewController:imagePickerController animated:YES completion:NULL];
        
    }];
    
    // 拍照
    UIAlertAction *phonAction =[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIImagePickerControllerSourceType soureceType =UIImagePickerControllerSourceTypeCamera;
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController  *imagePickerController =[[UIImagePickerController alloc] init];
            imagePickerController.allowsEditing=YES;
            imagePickerController.delegate=self;
            imagePickerController.sourceType= soureceType;
            [viewController presentViewController:imagePickerController animated:YES completion:NULL];
            }
        }];
    UIAlertAction *calcelAction =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        objc_setAssociatedObject(self.viewController, &associationViewControllerkey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }];
    [actionSheet addAction:albumAction];
    [actionSheet addAction:phonAction];
    [actionSheet addAction:calcelAction];
    [viewController presentViewController:actionSheet animated:YES completion:nil];
    
}


#pragma mark ------- UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [_viewController dismissViewControllerAnimated:YES completion:NULL];
    UIImage *image = info[UIImagePickerControllerEditedImage];
    if (self.finishBlock) {
        self.finishBlock(image);
    }
    objc_setAssociatedObject(self.viewController, &associationViewControllerkey, self, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [_viewController  dismissViewControllerAnimated:YES completion:NULL];
    objc_setAssociatedObject(self.viewController, &associationViewControllerkey, NULL,OBJC_ASSOCIATION_COPY_NONATOMIC);
    
}
-(void)dealloc{
    NSLog(@"释放掉");
}
@end
