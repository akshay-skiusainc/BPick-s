//
//  PhotoEditor.m
//  Buyer's_Pick_App
//
//  Created by Ashwini Pawar on 07/01/14.
//  Copyright (c) 2014 Ashwini Pawar. All rights reserved.
//

#import "PhotoEditor.h"
#define kAFSDKDemoImageViewInset 10.0f
#define kAFSDKDemoBorderAspectRatioPortrait 3.0f/4.0f
#define kAFSDKDemoBorderAspectRatioLandscape 4.0f/3.0f

@interface PhotoEditor ()

@end

@implementation PhotoEditor

@synthesize TAG,DATAPATH,DATATYPE,imageToEdit,editOptionsArray,scrollBgImage,optionsScroller,addCustmFldsInScrll,addCustmFldsInTbl,detailTableView;

@synthesize brandTextFld,beltTxtFld,availabilityTextFld,briefDescTxtFld,productTextFld,priceTextFld,QuantityTextFld,modelTextFld,CertifctnTextFld,minOrderTextFld,paymentTextFld,manufacturerTextFld,DATAID;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    if ([DATATYPE isEqualToString:@"image"]) {
        
        
        imageToEdit.image = [UIImage imageWithContentsOfFile:DATAPATH];
        [self displayEditorForImage:imageToEdit.image];
        
    }
    
    addCustmFldsInTbl.layer.cornerRadius = 10.0;
    addCustmFldsInTbl.clipsToBounds = YES;
    scrollBgImage.alpha = 0.0;
    optionsScroller.alpha = 0.0;
    addCustmFldsInTbl.alpha = 0.0;
    detailTableView.hidden = YES;
    
    editOptionsArray = [[NSMutableArray alloc]init];
    [editOptionsArray addObject:@"Steel Belt"];
    [editOptionsArray addObject:@"Rubber Belt"];
    [editOptionsArray addObject:@"Leather Belt"];
    
    
    UIImage *undoImage = [UIImage imageNamed:@"reset.png"];
    UIButton *undoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [undoButton setImage:undoImage forState:UIControlStateNormal];
    undoButton.frame = CGRectMake(0, 5, undoImage.size.width, undoImage.size.height);
    undoButton.tag = 1;
    [undoButton addTarget:self action:@selector(navRightButtonClked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customBarItemAudio = [[UIBarButtonItem alloc] initWithCustomView:undoButton];
    
    
    UIImage *deleteImage = [UIImage imageNamed:@"delete.png"];
    UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteButton setImage:deleteImage forState:UIControlStateNormal];
    deleteButton.frame = CGRectMake(0, 5, deleteImage.size.width, deleteImage.size.height);
    deleteButton.tag = 2;
    [deleteButton addTarget:self action:@selector(navRightButtonClked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customBarItemNote = [[UIBarButtonItem alloc] initWithCustomView:deleteButton];
    
    
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:customBarItemNote, customBarItemAudio,nil]];
    
        
    if([TAG isEqualToString:@"fromSplitView"])
    {
        
    }
    else
    {
        UIImage *doneImage = [UIImage imageNamed:@"done.png"];
        UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [doneButton setImage:doneImage forState:UIControlStateNormal];
        doneButton.frame = CGRectMake(0, 3, 64, 37);
        [doneButton addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *customBarItemDone = [[UIBarButtonItem alloc] initWithCustomView:doneButton];
        self.navigationItem.leftBarButtonItem = customBarItemDone;
    }
    
   
    UILabel *navTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 90, 40)];
    navTitleLabel.backgroundColor = [UIColor clearColor];
    navTitleLabel.text = @"TITLE TAG";
    navTitleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size: 30.0];
    navTitleLabel.font = [UIFont boldSystemFontOfSize:15.0];
    navTitleLabel.textColor = [UIColor darkGrayColor];
    self.navigationItem.titleView = navTitleLabel;
    
    UITapGestureRecognizer *brandTextFldTapped = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openTable:)];
    brandTextFldTapped.numberOfTapsRequired = 1;
    brandTextFldTapped.delegate = self;
    [brandTextFld addGestureRecognizer:brandTextFldTapped];
    
    UITapGestureRecognizer *beltTxtFldTapped = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openTable:)];
    beltTxtFldTapped.numberOfTapsRequired = 1;
    beltTxtFldTapped.delegate = self;
    [beltTxtFld addGestureRecognizer:beltTxtFldTapped];
    
    UITapGestureRecognizer *availabilityTextFldTapped = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openTable:)];
    availabilityTextFldTapped.numberOfTapsRequired = 1;
    availabilityTextFldTapped.delegate = self;
    [availabilityTextFld addGestureRecognizer:availabilityTextFldTapped];
    
    UITapGestureRecognizer *briefDescTxtFldTapped = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openTable:)];
    briefDescTxtFldTapped.numberOfTapsRequired = 1;
    briefDescTxtFldTapped.delegate = self;
    [briefDescTxtFld addGestureRecognizer:briefDescTxtFldTapped];
}

-(void)navRightButtonClked:(UIButton *)sender
{
    
}

-(void)openTable:(UITapGestureRecognizer *)sender
{
    addCustmFldsInTbl.alpha = 1.0;
    detailTableView.hidden = NO;
}
-(void)done
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [self performSelector:@selector(changeView) withObject:nil afterDelay:0.0];
}

-(void)viewWillLayoutSubviews
{
    [self performSelector:@selector(changeView) withObject:nil afterDelay:0.0];
}

-(void)changeView
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header.jpg"] forBarMetrics:UIBarMetricsDefault];
    
    UIInterfaceOrientation ori = [[UIApplication sharedApplication]statusBarOrientation];
    if(ori == UIInterfaceOrientationLandscapeRight || ori ==UIInterfaceOrientationLandscapeLeft)
    {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main-bg-1024-704.jpg"]];
        
        
        imageToEdit.frame = CGRectMake(20, 20, 984, 664);
    }
    
    else if(ori == UIInterfaceOrientationPortrait || ori==UIInterfaceOrientationPortraitUpsideDown)
    {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main-bg-768-960.jpg"]];
        imageToEdit.frame = CGRectMake(38, 20, 693, 920);
    }
    

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)shouldAutorotate  // iOS 6 autorotation fix
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations // iOS 6 autorotation fix
{
    return UIInterfaceOrientationMaskAll;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation // iOS 6 autorotation fix
{
    return UIInterfaceOrientationPortrait;
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    if(toInterfaceOrientation == UIInterfaceOrientationLandscapeRight || toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft)
    {
        
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main-bg-1024-704.jpg"]];
        imageToEdit.frame = CGRectMake(20, 20, 984, 664);
    }
    
    else if(toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main-bg-768-960.jpg"]];
        imageToEdit.frame = CGRectMake(38, 20, 693, 920);
        
    }
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return editOptionsArray.count;
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    
    static NSString *CellIdentifier = @"sorting by date1";
    UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell1 == nil) {
        
        cell1=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    cell1.textLabel.textColor = [UIColor whiteColor];
    cell1.textLabel.text = [editOptionsArray objectAtIndex:indexPath.row];

    return cell1;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    scrollBgImage.alpha = 0.0;
    optionsScroller.alpha = 0.0;
    addCustmFldsInTbl.alpha = 0.0;
    detailTableView.hidden = YES;

    
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 34.0;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addDetailsButton:(id)sender
{
    if (optionsScroller.alpha == 1.0)
    {
    scrollBgImage.alpha = 1.0;
    optionsScroller.alpha = 1.0;
    }
    else if (optionsScroller.alpha == 0.0)
    {
        scrollBgImage.alpha = 0.0;
        optionsScroller.alpha = 01.0;
    }
    detailTableView.frame = CGRectMake(260, 111, 211, editOptionsArray.count*34);
}

- (IBAction)changeIndustryClicked:(id)sender {
}

- (IBAction)addColorTagClicked:(id)sender {
}




- (void)displayEditorForImage:(UIImage *)imageToEdit1
{
    AFPhotoEditorController *editorController = [[AFPhotoEditorController alloc] initWithImage:imageToEdit1];
    [editorController setDelegate:self];
    [self presentViewController:editorController animated:YES completion:nil];
}

- (void)photoEditor:(AFPhotoEditorController *)editor finishedWithImage:(UIImage *)image
{
    NSData *imageData= UIImageJPEGRepresentation(image,0.0);
    
    
    
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd-MM-yyyy||HH:mm:SS"];
    NSDate *now = [[NSDate alloc] init];
    NSString*  theDate = [dateFormat stringFromDate:now];
    
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"Photos"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
        [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:nil];
    
    NSString *imagepath= [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@/%@-image.png",documentsDirectory,theDate]];
    
    
    BOOL success = [imageData writeToFile:imagepath atomically:NO];
    
    NSLog(@"Successs:::: %@", success ? @"YES" : @"NO");
    NSLog(@"Image path --> %@",imagepath);
    
    
    
//    [self DATABASECALLED];
    NSString   *insertquery1 = [NSString stringWithFormat:@"SELECT * from  ba_tbl_vendor"];
    [self displayAll:insertquery1];
    NSString   *insertquery = [NSString stringWithFormat:@"update ba_tbl_content set  path = \"%@\" where id=%@ ", imagepath,DATAID];
    
    
    
    
    [self saveData:insertquery];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    imageToEdit.image = [UIImage imageWithContentsOfFile:imagepath];




    // Handle the result image here
}

- (void)photoEditorCanceled:(AFPhotoEditorController *)editor
{
    
    [self dismissViewControllerAnimated:YES completion:nil];

    // Handle cancellation here
}

@end
