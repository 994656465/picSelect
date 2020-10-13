//
//  ViewController.m
//  picSelect
//
//  Created by mac on 2020/10/10.
//  Copyright © 2020 SmartPig. All rights reserved.
//

#import "ViewController.h"

#import <TZImagePickerController.h>
@interface ViewController ()<TZImagePickerControllerDelegate>
@property (nonatomic, strong)     UIImageView * imageView ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 300, 60, 60);
    [button addTarget:self action:@selector(buttouClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    button.backgroundColor = [UIColor redColor];
    
    
    UIImageView * imageView = [[UIImageView alloc]init];
    imageView.backgroundColor = [UIColor orangeColor];
    imageView.frame = CGRectMake(200, 300, 150, 150);
    self.imageView = imageView;
    [self.view addSubview:imageView];
    
}
-(void)buttouClick{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:2000 delegate:self];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

-(void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos{
    UIImage * photo = photos.lastObject;
    self.imageView.image =photo;
    NSLog(@"photos = %@ \n assets = %@ \n infos = %@",photos,assets,infos);
    PHAsset * asset = assets[0];
    // 经纬度
    NSLog(@"latitude = %lf   longitude = %lf   ", asset.location.coordinate.latitude,asset.location.coordinate.longitude);
    
    // 海拔
    NSLog(@"altitude = %lf ", asset.location.altitude);
    
    // 类型:照片,视频,
    NSLog(@"mediaType = %ld", asset.mediaType);
    
    //  HRD,LIVE,
    NSLog(@"mediaSubtypes = %ld", asset.mediaSubtypes);
    
    //  创建时间
    NSLog(@"creationDate = %@", asset.creationDate);
    
    //  时间
    NSLog(@"duration = %f", asset.duration);
    
    //像素尺寸
    CGFloat width = photo.size.width;
    CGFloat height = photo.size.height;
    NSLog(@"像素尺寸 imagewidth = %f  imageheight =  %f",width,height);
    

    
    //  图片名称
    NSString *fileName = [asset valueForKey:@"filename"];
    NSLog(@"图片名字:%@",fileName);
    
    // 照片大小
    TZAssetModel * model = [[TZAssetModel alloc]init];
    model.asset = asset;
    [[TZImageManager manager] getPhotosBytesWithArray:@[model] completion:^(NSString *totalBytes) {
        NSLog(@"totalBytes =  %@",totalBytes);
    }];
}
@end
