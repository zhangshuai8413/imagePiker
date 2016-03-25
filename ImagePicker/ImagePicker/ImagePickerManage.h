//
//  ImagePickerManage.h
//  ImagePicker
//
//  Created by kakao on 16/3/25.
//  Copyright © 2016年 shuai zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^FinishPickerImageBlock)(UIImage * image);

@interface ImagePickerManage : NSObject<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic,copy) FinishPickerImageBlock  finishBlock ;

/**
 *  选择照片完成回调
 *
 *  @param viewController 调用的VC
 *  @param finishBlock    回调block
 
 */

-(void)showImagePickerControllerWithViewControll:(UIViewController *)viewController finishBlock:(FinishPickerImageBlock )finishBlock;

@end
