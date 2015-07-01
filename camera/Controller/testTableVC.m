//
//  testTableVC.m
//  camera
//
//  Created by skunk  on 15/6/2.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "testTableVC.h"
#import "TestCell.h"
#define iPhoneHeight [UIScreen mainScreen].bounds.size.height

@interface testTableVC ()
- (IBAction)testAction:(id)sender;

@end

@implementation testTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    
    [self loadCellContent:nil indexPath:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIdentifier";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier" forIndexPath:indexPath];
//   
//    UILabel *name = (UILabel *)[cell viewWithTag:102];
//    name.text =  @"Storyboard是一项令人兴奋的功能，在iOS5中首次推出，在开发app的界面时可以极大地节省时间。 ";
//    [name sizeToFit];
//    UIImageView *iView = (UIImageView *)[cell viewWithTag:104];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
        return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
/**
 *  如何测量使用Autolayout的UIView的尺寸？可以使用UIView的systemLayoutSizeFittingSize方法，对于UITableViewCell，那就是测量其contentView的大小。那么，本例中需要返回Autolayout的Cell的高度，则可以写一个辅助方法，这样：
 */
- (CGFloat)getCellHeight:(UITableViewCell *)cell
{
    [cell layoutIfNeeded];
    [cell updateConstraintsIfNeeded];
    
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    return height;
    
}
/*
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static UITableViewCell *cell = nil;
    if (!cell) {
        cell = [self.tableView dequeueReusableCellWithIdentifier:@"cellIdentifier"];
    }
    [self loadCellContent:cell indexPath:indexPath];
    
    NSLog(@"cell height is %f",[self getCellHeight:cell]);
    
    return [self getCellHeight:cell];
}
 */

/**
 *  等比例返回cell高度 保证在所有屏幕上cell显示的个数相同
 *
 */
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//    return (120 * ((iPhoneHeight)/(480)));
//}
/**
 *  然后把Cell加载数据的逻辑写在一个方法里，这个方法是被heightForRowAtIndexPath和cellForRowAtIndexPath方法所共用的，因为不管是测量Cell的高度还是展示Cell，我们都需要Cell加载相应的数据：
 */
- (void)loadCellContent:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath
{

  //这里把数据设置给cell
    UILabel *label = (UILabel *)[cell.contentView viewWithTag:102];
    label.text = @"test";
    NSString *str = @"12    423k";
    /**
     *  修改除set中的所有字符并添加%号
     */
//    str =[str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//    NSLog(@"str is %@",str);
    /**
     *  将非正常字符串添加%号修改为合法字符
     */
    str = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"str is %@",str);
    
    
}

- (IBAction)testAction:(id)sender {
    NSLog(@"button");
    UIButton *button = (UIButton *)sender;
    CGRect rect = CGRectMake(0,0, 200, 200);
    button.backgroundColor = [UIColor blueColor];
    [button setFrame:CGRectMake(10, 10, 200, 200)];
    [self.view layoutSubviews];
}
@end
