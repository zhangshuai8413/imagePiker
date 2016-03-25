//
//  ViewController.m
//  ImagePicker
//
//  Created by kakao on 16/3/25.
//  Copyright © 2016年 shuai zhang. All rights reserved.
//

#import "ViewController.h"
#import "ImagePickerManage.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [[[ImagePickerManage alloc] init] showImagePickerControllerWithViewControll:self finishBlock:^(UIImage *image) {
        self.imageView.image=image;
        
    }];
}
@end
