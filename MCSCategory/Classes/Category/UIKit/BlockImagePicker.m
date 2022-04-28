

#import "BlockImagePicker.h"

@interface BlockImagePicker ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>


@end

@implementation BlockImagePicker

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (BlockImagePicker *)imagePickerDidFinishPickImage:(finishBlock)finishBlock didCancelPickImage:(cancelBlock)cancelBlock
{
    BlockImagePicker *imagePicker= [[BlockImagePicker alloc]init];
    imagePicker.delegate = imagePicker;
    imagePicker.finish = finishBlock;
    imagePicker.cancel = cancelBlock;
    return imagePicker;
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    self.finish(info,image);
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    self.cancel(picker);
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
