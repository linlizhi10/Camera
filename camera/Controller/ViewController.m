//
//  ViewController.m
//  camera
//
//  Created by skunk  on 15/3/4.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "ViewController.h"
#import "PhotoShow.h"
#import <AVFoundation/AVFoundation.h>
@interface ViewController ()
{
    //执行输入设备和输出设备之间的数据传递
    AVCaptureSession *_session;
    //输入流
    AVCaptureDeviceInput *_videoInput;
    //照片输出流对象，只有拍照功能，所以这个对象就够了
    AVCaptureStillImageOutput *_stillImageOutput;
    //预览图层，用来显示照相机拍摄到得画面
    AVCaptureVideoPreviewLayer *_previewLayer;
    //
    NSMutableData *_imageData;
    
    BOOL _isTakePhoto;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _isTakePhoto = YES;
    _imageData = [[NSMutableData alloc]init];
    _savePhoto.hidden = YES;
    _arrPhotoName = [[NSMutableArray alloc]init];
    [self initialSession];
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //_checkPhoto.enabled = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initialSession
{
    _session = [[AVCaptureSession alloc]init];
    _videoInput = [[AVCaptureDeviceInput alloc]initWithDevice:[self backCamera] error:nil];
    
    _stillImageOutput = [[AVCaptureStillImageOutput alloc]init];
    //这是输出流的设置参数AVVideoCodecJPEG参数表示以JPEG的图片格式输出图片
    NSDictionary *outPutSettings = [[NSDictionary alloc]initWithObjectsAndKeys:
                                    AVVideoCodecJPEG,
                                    AVVideoCodecKey, nil];
    [_stillImageOutput setOutputSettings:outPutSettings];
    
    if ([_session canAddInput:_videoInput]) {
        [_session addInput:_videoInput];
    }
    if ([_session canAddOutput:_stillImageOutput]) {
        [_session addOutput:_stillImageOutput];
    }
    
}

#pragma mark --获取前后摄像头
- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position
{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if ([device position] == position ) {
            return device;
        }
    }
    return nil;
}

- (AVCaptureDevice *)frontCamera
{
    return [self cameraWithPosition:AVCaptureDevicePositionFront];
}

- (AVCaptureDevice *)backCamera
{
    return  [self cameraWithPosition:AVCaptureDevicePositionBack];
}

#pragma mark --加载预览图层的方法
- (void)setUpCameraLayer
{
    if (_previewLayer == nil) {
        _previewLayer = [[AVCaptureVideoPreviewLayer alloc]initWithSession:_session];
        UIView *view = self.cameraView;
        CALayer *viewLayer = [view layer];
        [viewLayer setMasksToBounds:YES];
        
        CGRect bounds = [view bounds];
        [_previewLayer setFrame:bounds];
        [_previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
        [viewLayer insertSublayer:_previewLayer below:[[viewLayer sublayers] objectAtIndex:0]];
    }
}
//storyboard 页面间的传值 http://www.tuicool.com/articles/uuAv2ia
- (IBAction)checkPhoto:(id)sender {
    //根据指定线的id跳转到目标VC
    

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"SendValue"]) {
        //segue.destinationViewContriller:获取连线时所指向的界面
        PhotoShow *photo = segue.destinationViewController;
        //photo.arrPhotoName = _arrPhotoName;
        photo.testInfo = @"test";
    }
}
- (IBAction)takePhoto:(id)sender {
    
    if (!_isTakePhoto) {
        [self shutterCamera];

        _isTakePhoto = YES;
        _savePhoto.hidden = NO;
        [_session stopRunning];
        [_takePhoto setTitle:@"拍照" forState:UIControlStateNormal];
        
    }else{
        
    [_takePhoto setTitle:@"确认" forState:UIControlStateNormal];
    _isTakePhoto = NO;
    [self setUpCameraLayer];
    [_session startRunning];
   
    }
    
}

- (IBAction)changeCamera:(id)sender {
    
    NSUInteger cameraCount = [[AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo] count];
    if (cameraCount > 1) {
        NSError *error;
        AVCaptureDeviceInput *newVideoInput;
        AVCaptureDevicePosition position = [[_videoInput device] position];
        
        if (position == AVCaptureDevicePositionBack) {
            newVideoInput = [[AVCaptureDeviceInput alloc]initWithDevice:[self frontCamera] error:nil];
            
        }
        else if (position == AVCaptureDevicePositionFront)
        {
            newVideoInput = [[AVCaptureDeviceInput alloc]initWithDevice:[self backCamera] error:nil];
            
        }
        else return;
        
        if (newVideoInput !=nil) {
            [_session beginConfiguration];
            [_session removeInput:_videoInput];
            if ([_session canAddInput:newVideoInput]) {
                [_session addInput:newVideoInput];
                _videoInput = newVideoInput;
            }else{
                [_session addInput:_videoInput];
                
            }
            [_session commitConfiguration];
        }else if (error){
            NSLog(@"toggle camera failed,error = %@",error);
        }
    }
}

- (IBAction)saveThePhoto:(id)sender {
    
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"warning"
                                                       message:@""
                                                      delegate:self
                                             cancelButtonTitle:nil
                                             otherButtonTitles:@"yes", nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        alert.tag = 101;
        UITextField *tf = [alert textFieldAtIndex:0];
        tf.placeholder = @"输入照片名称";
        tf.tag = 1001;
        tf.keyboardType = UIKeyboardTypeAlphabet;
       
        [alert show];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        UITextField *tf = [alertView textFieldAtIndex:0];
        NSString *name = tf.text;
        NSString *path = [NSString stringWithFormat:@"%@/%@",[self restorePath],name];
        BOOL rec = [_imageData writeToFile:path atomically:YES];
        if (!rec) {
            NSLog(@"failed to save");
        }else{
            [_arrPhotoName addObject:name];
        }
    }
}
- (void)saveImageToPhotos:(UIImage *)savedImage
{
    /**
     *  UIKIT_EXTERN void UIImageWriteToSavedPhotosAlbum(UIImage *image, id completionTarget, SEL completionSelector, void *contextInfo);

     */
    UIImageWriteToSavedPhotosAlbum(savedImage, self, nil, nil);
    
}
- (void)imageSavedToPhotoAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error
{
    NSString *message = @"呵呵";
    if (!error) {
        message = @"成功保存到相册";
    }else
    {
        message = [error description];
    }
    NSLog(@"message is %@",message);
}
- (void )shutterCamera
{
    
    AVCaptureConnection *videoConnection = [_stillImageOutput connectionWithMediaType:AVMediaTypeVideo];
    if (!videoConnection)
    {
        NSLog(@"take photo failed");
    }
    
    [_stillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        if (imageDataSampleBuffer == NULL) {
            return ;
        }
        NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
        
        _imageData = (NSMutableData *)imageData;
        
       
        UIImage *image = [UIImage imageWithData:imageData];
        UIImageView *iView = [[UIImageView alloc]initWithImage:image];
        iView.frame = _cameraView.frame;
        [self.view addSubview:iView];
        [self saveImageToPhotos:image];
        
    }];
    
}
- (NSString *)restorePath
{
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject ];
    
    return rootPath;
}
@end
