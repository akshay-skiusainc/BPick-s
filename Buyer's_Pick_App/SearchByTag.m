//
//  SearchByTag.m
//  Buyer's_Pick_App
//
//  Created by Ashwini Pawar on 29/01/14.
//  Copyright (c) 2014 Ashwini Pawar. All rights reserved.
//

#import "SearchByTag.h"
#import "OpenVendor.h"
#import "CameraAudioVideoNote.h"
#import "AddNote.h"

@interface SearchByTag ()

@end

@implementation SearchByTag
@synthesize placeHolderTitle,totalVendors,INDEX,listAndGridIndex,sortedArray,pView,lView,listView,gridView,sortByDate,syncButton,vendorScroller,tableViewBgImage,sortingTable,listViewLand,gridViewLand,sortByDateLand,sortingTableLand,syncButtonLand,vendorScrollerLand,tableViewBgImageLand,TAG,tagSearch;

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
    NSLog(@"tagSearch = %@",tagSearch);
   
    UIImage *cameraImage = [UIImage imageNamed:@"camera_icon.png"];
    UIButton *cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cameraButton setImage:cameraImage forState:UIControlStateNormal];
    cameraButton.frame = CGRectMake(0, 5, cameraImage.size.width, cameraImage.size.height);
    cameraButton.tag = 0;
    [cameraButton addTarget:self action:@selector(cameraClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customBarItemCamera = [[UIBarButtonItem alloc] initWithCustomView:cameraButton];
    
    UIImage *audioImage = [UIImage imageNamed:@"recording_icon.png"];
    UIButton *audioButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [audioButton setImage:audioImage forState:UIControlStateNormal];
    audioButton.frame = CGRectMake(0, 5, audioImage.size.width, audioImage.size.height);
    audioButton.tag = 1;
    [audioButton addTarget:self action:@selector(cameraClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customBarItemAudio = [[UIBarButtonItem alloc] initWithCustomView:audioButton];
    
    
    UIImage *noteImage = [UIImage imageNamed:@"note_icon.png"];
    UIButton *noteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [noteButton setImage:noteImage forState:UIControlStateNormal];
    noteButton.frame = CGRectMake(0, 5, noteImage.size.width, noteImage.size.height);
    noteButton.tag = 2;
    [noteButton addTarget:self action:@selector(cameraClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customBarItemNote = [[UIBarButtonItem alloc] initWithCustomView:noteButton];
    
    
    UIImage *searchBarImage = [UIImage imageNamed:@"searchbox.png"];
    searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 5, 150, 30)];
    searchTextField.borderStyle = UITextBorderStyleRoundedRect;
    searchTextField.font = [UIFont systemFontOfSize:12];
    [searchTextField setBackground:searchBarImage];
    searchTextField.textColor = [UIColor whiteColor];
    searchTextField.backgroundColor = [UIColor clearColor];
    searchTextField.placeholder = @"SEARCH BY TAG";
    [searchTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    searchTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    searchTextField.keyboardType = UIKeyboardTypeDefault;
    searchTextField.returnKeyType = UIReturnKeySearch;
    searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    searchTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    searchTextField.delegate = self;
    
     searchTextField.text = tagSearch;
    UIBarButtonItem *customBarItemSearch = [[UIBarButtonItem alloc] initWithCustomView:searchTextField];
    
    
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:customBarItemNote, customBarItemAudio,customBarItemCamera,customBarItemSearch,nil]];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 90, 40)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"SEARCH";
    titleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size: 30.0];
    titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
    titleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;
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
    
    NSString   *fetchdata = [NSString stringWithFormat:@"select id , vendor_name, Description, Description from ba_tbl_vendor"];
    [self displayContentData:fetchdata];
    
    totalVendors=TotalData;
    
    listAndGridIndex = 2;

    sortedArray = [[NSArray alloc]initWithObjects:@"Default View",@"Vendor Created",@"Vendor Modified",@"A to Z",@"Z to A", nil];
    sortingTable.hidden = YES;
    tableViewBgImage.alpha = 0.0;
    sortingTableLand.hidden = YES;
    tableViewBgImageLand.alpha = 0.0;
    INDEX=0;
    tableViewBgImageLand.layer.cornerRadius = 10.0;
    tableViewBgImageLand.clipsToBounds = YES;
    tableViewBgImage.layer.cornerRadius = 10.0;
    tableViewBgImage.clipsToBounds = YES;
    
    [tableViewBgImage.layer setBorderColor:[UIColor darkGrayColor].CGColor];
    [tableViewBgImage.layer setBorderWidth:0.5];
    [tableViewBgImageLand.layer setBorderColor:[UIColor darkGrayColor].CGColor];
    [tableViewBgImageLand.layer setBorderWidth:0.5];

}

-(void)done
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:YES];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"topnavigation.jpg"] forBarMetrics:UIBarMetricsDefault];
    sortingTableLand.frame = CGRectMake(861, 43, 137, 170);
    sortingTable.frame = CGRectMake(616, 43, 137, 170);
    
    NSString   *fetchdata = [NSString stringWithFormat:@"select id , vendor_name, Description, Description from ba_tbl_vendor"];
    [self displayContentData:fetchdata];
    
    totalVendors=TotalData;
    [self DisplayVendors];
    
    INDEX = [[NSUserDefaults standardUserDefaults] integerForKey:@"selected option"];
    NSLog(@"INDEX = %d",INDEX);
    
       UIInterfaceOrientation ori = [[UIApplication sharedApplication]statusBarOrientation];
    if(ori == UIInterfaceOrientationLandscapeRight || ori ==UIInterfaceOrientationLandscapeLeft)
    {
        self.view = self.lView;
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main-bg-1024-704.jpg"]];
        
        
    }
    
    else if(ori == UIInterfaceOrientationPortrait || ori==UIInterfaceOrientationPortraitUpsideDown)
    {
        self.view = self.pView;
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main-bg-768-960.jpg"]];
        
    }
    dispatch_async(dispatch_get_main_queue()	, ^{
        [self DisplayVendors];
    });
    
    
    [self tablereloaddata];
    
    
}

-(void)tablereloaddata
{
    
    INDEX = [[NSUserDefaults standardUserDefaults] integerForKey:@"selected option"];
    NSLog(@"INDEX = %d",INDEX);
    [sortingTable reloadData];
    [sortingTableLand reloadData];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
   
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
   
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self performSelector:@selector(DisplayVendors) withObject:nil afterDelay:0.0];
    [textField resignFirstResponder];
    return YES;
    
}

-(void)DisplayVendors
{
     NSLog(@"ashwini");
    NSLog(@"listAndGridIndex = %d",listAndGridIndex);
    
    [[vendorScroller subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [[vendorScrollerLand subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSString   *fetchdata = [NSString stringWithFormat:@"select id , vendor_name, Description, vendor_title, created_date from ba_tbl_vendor"];
    [self displayAllVendorsInDB:fetchdata];
    
    NSString   *searchData = [NSString stringWithFormat:@"select * from ba_tbl_vendor where tags = %@",searchTextField.text];
    NSLog(@"searchData = %@",searchData);
    [self displayAllVendorsInDB:searchData];
    
    //    for (int j = 0; j<totalVendors; j++)
    //    {
    //        [sortedVendorsByDate addObject:datadate[j]];
    //        [sortedVendorsByTitle addObject:datatitle[j]];
    //    }
    //    NSLog(@"sortedVendorsByTitle=%@",sortedVendorsByTitle);
    //
    //    NSLog(@"sortedVendorsByDate=%@",sortedVendorsByDate);
    //    todayDate = [NSDate date];
    //    [sortedVendorsByTitle sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    //
    //    NSSortDescriptor *descriptor=[[NSSortDescriptor alloc] initWithKey:@"self" ascending:NO];
    //    NSArray *descriptors=[NSArray arrayWithObject: descriptor];
    //    sortedVendorsByDate=[sortedVendorsByDate sortedArrayUsingComparator:descriptors];
    //
    //    NSLog(@"sortedVendorsByTitle=%@",sortedVendorsByTitle);
    //
    //
    //    NSLog(@"sortedVendorsByDate=%@",sortedVendorsByDate);
    
    int m = 0;
    int nXX = 0;
    int nYY = 0;
    if (listAndGridIndex==1)
    {
        int mX = 7;
        int mY = 0;
        
        int nX = 7;
        int nY = 0;
        
        NSLog(@"totalvendore = %d",totalVendors);
        for (int i =0; i<totalVendors; i++)
        {
            mX=248*(i%3);
            mY=237 * (i/3);
            
            nX=248*(i%4);
            nY=237 * (i/4);
            
            
            vendorImage[i]	= [UIButton buttonWithType:UIButtonTypeCustom];
            vendorImage[i].frame = CGRectMake(mX+7, mY, 238, 227);
            vendorImage[i].userInteractionEnabled = YES;
            [vendorImage[i] setBackgroundImage:[UIImage imageNamed:@"pic-folder.png"] forState:UIControlStateNormal];
            [ vendorImage[i] addTarget:self action:@selector(openAddNote:) forControlEvents:UIControlEventTouchUpInside];
            vendorImage[i].tag = i;
            [vendorScroller addSubview:vendorImage[i]];
            
            imageOnVendorGrid[i] = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 238, 217)];
            imageOnVendorGrid[i].image = [UIImage imageWithContentsOfFile:datapath[i]];
            [vendorImage[i] addSubview:imageOnVendorGrid[i]];
            
            UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
            longPress.delegate = self;
            [vendorImage[i] addGestureRecognizer:longPress];
            
            
            mX=mX+248;
            mY=mY+237;
            
            
            
            vendorImageLand[i]	= [UIButton buttonWithType:UIButtonTypeCustom];
            vendorImageLand[i].frame = CGRectMake(nX+7, nY, 238, 227);
            vendorImageLand[i].userInteractionEnabled = YES;
            [vendorImageLand[i] setBackgroundImage:[UIImage imageNamed:@"pic-folder.png"] forState:UIControlStateNormal];
            [ vendorImageLand[i] addTarget:self action:@selector(openAddNote:) forControlEvents:UIControlEventTouchUpInside];
            vendorImageLand[i].tag = i;
            [vendorScrollerLand addSubview:vendorImageLand[i]];
            
            imageOnVendorGrid[i] = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 238, 217)];
            imageOnVendorGrid[i].image = [UIImage imageWithContentsOfFile:datapath[i]];
            [vendorImageLand[i] addSubview:imageOnVendorGrid[i]];
            
                   
            nX=nX+248;
            nY=nY+237;
            
            
            
        }
        if(totalVendors%3==0)
        {
            
            vendorScroller.contentSize = CGSizeMake(748,237*(totalVendors/3)+337);
        }
        else
        {
            vendorScroller.contentSize = CGSizeMake(748,237*(totalVendors/3)+337);
            
        }
        
        if(totalVendors%4==0)
        {
            
            vendorScrollerLand.contentSize = CGSizeMake(1006,237*totalVendors/4+150);
        }
        else
        {
            vendorScrollerLand.contentSize = CGSizeMake(1006,(237*totalVendors/4)+150);
            
        }
        
    }
    if (listAndGridIndex==2)
    {
        for (int i =0; i<totalVendors; i++)
        {
            viewForList[i] = [[UIView alloc]initWithFrame:CGRectMake(0, m, 748, 115)];
            viewForList[i].backgroundColor = [UIColor clearColor];
            [vendorScroller addSubview:viewForList[i]];
            
            vendorImage[i]	= [UIButton buttonWithType:UIButtonTypeCustom];
            vendorImage[i].frame = CGRectMake(10, 2, 100, 100);
            vendorImage[i].userInteractionEnabled = YES;
            [vendorImage[i] setBackgroundImage:[UIImage imageNamed:@"pic-folder.png"] forState:UIControlStateNormal];
            [ vendorImage[i] addTarget:self action:@selector(openAddNote:) forControlEvents:UIControlEventTouchUpInside];
            vendorImage[i].tag = i;
            [viewForList[i] addSubview:vendorImage[i]];
            
            imageOnVendorList[i] = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 100, 90)];
            imageOnVendorList[i].image = [UIImage imageWithContentsOfFile:datapath[i]];
            [vendorImage[i] addSubview:imageOnVendorList[i]];
            
            vendorTitle[i] = [[UILabel alloc]initWithFrame:CGRectMake(130, 35, 200, 20)];
            vendorTitle[i].backgroundColor = [UIColor clearColor];
            vendorTitle[i].text = datatitle[i];
            vendorTitle[i].font = [UIFont fontWithName:@"Helvetica Neue" size: 30.0];
            vendorTitle[i].font = [UIFont boldSystemFontOfSize:15.0];
            vendorTitle[i].textColor = [UIColor darkGrayColor];
            [viewForList[i] addSubview:vendorTitle[i]];
            
            vendorName[i] = [[UILabel alloc]initWithFrame:CGRectMake(330, 35, 200, 20)];
            vendorName[i].backgroundColor = [UIColor clearColor];
            vendorName[i].text = datapath[i];
            vendorName[i].font = [UIFont fontWithName:@"Helvetica Neue" size: 30.0];
            vendorName[i].font = [UIFont boldSystemFontOfSize:15.0];
            vendorName[i].textColor = [UIColor grayColor];
            [viewForList[i] addSubview:vendorName[i]];
            
            vendorDate[i] = [[UILabel alloc]initWithFrame:CGRectMake(530, 35, 200, 20)];
            vendorDate[i].backgroundColor = [UIColor clearColor];
            vendorDate[i].text = datadate[i];
            vendorDate[i].font = [UIFont fontWithName:@"Helvetica Neue" size: 30.0];
            vendorDate[i].font = [UIFont boldSystemFontOfSize:13.0];
            vendorDate[i].textColor = [UIColor grayColor];
            [viewForList[i] addSubview:vendorDate[i]];
            
            
            vendorDetails[i] = [[UILabel alloc]initWithFrame:CGRectMake(130, 60, 200, 30)];
            vendorDetails[i].backgroundColor = [UIColor clearColor];
            vendorDetails[i].text =datatype[i];
            vendorDetails[i].font = [UIFont fontWithName:@"Helvetica Neue" size: 30.0];
            vendorDetails[i].font = [UIFont systemFontOfSize:12.0];
            vendorDetails[i].textColor = [UIColor grayColor];
            [viewForList[i] addSubview:vendorDetails[i]];
            
            
            lineImage[i] = [[UIImageView alloc]initWithFrame:CGRectMake(0, 110, 748, 1)];
            lineImage[i].backgroundColor = [UIColor grayColor];
            [viewForList[i] addSubview:lineImage[i]];
            
            
            m=m+115;
            
            nXX=503*(i%2);
            nYY=115 * (i/2);
            
            
            viewForListLand[i] = [[UIView alloc]initWithFrame:CGRectMake(nXX, nYY, 503, 115)];
            viewForListLand[i].backgroundColor = [UIColor clearColor];
            [vendorScrollerLand addSubview:viewForListLand[i]];
            
            vendorImageLand[i]	= [UIButton buttonWithType:UIButtonTypeCustom];
            vendorImageLand[i].frame = CGRectMake(10, 2, 100, 100);
            vendorImageLand[i].userInteractionEnabled = YES;
            [vendorImageLand[i] setBackgroundImage:[UIImage imageNamed:@"pic-folder.png"] forState:UIControlStateNormal];
            [ vendorImageLand[i] addTarget:self action:@selector(openAddNote:) forControlEvents:UIControlEventTouchUpInside];
            vendorImageLand[i].tag = i;
            [viewForListLand[i] addSubview:vendorImageLand[i]];
            
            imageOnVendorList[i] = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 100, 90)];
            imageOnVendorList[i].image = [UIImage imageWithContentsOfFile:datapath[i]];
            [vendorImageLand[i] addSubview:imageOnVendorList[i]];
            
            vendorTitleLand[i] = [[UILabel alloc]initWithFrame:CGRectMake(130, 35, 200, 20)];
            vendorTitleLand[i].backgroundColor = [UIColor clearColor];
            vendorTitleLand[i].text = datatitle[i];
            vendorTitleLand[i].font = [UIFont fontWithName:@"Helvetica Neue" size: 30.0];
            vendorTitleLand[i].font = [UIFont boldSystemFontOfSize:15.0];
            vendorTitleLand[i].textColor = [UIColor darkGrayColor];
            [viewForListLand[i] addSubview:vendorTitleLand[i]];
            
            vendorNameLand[i] = [[UILabel alloc]initWithFrame:CGRectMake(330, 35, 200, 20)];
            vendorNameLand[i].backgroundColor = [UIColor clearColor];
            vendorNameLand[i].text = datapath[i];
            vendorNameLand[i].font = [UIFont fontWithName:@"Helvetica Neue" size: 30.0];
            vendorNameLand[i].font = [UIFont boldSystemFontOfSize:15.0];
            vendorNameLand[i].textColor = [UIColor grayColor];
            [viewForListLand[i] addSubview:vendorNameLand[i]];
            
            vendorDateLand[i] = [[UILabel alloc]initWithFrame:CGRectMake(330, 60, 200, 20)];
            vendorDateLand[i].backgroundColor = [UIColor clearColor];
            vendorDateLand[i].text = datadate[i];
            vendorDateLand[i].font = [UIFont fontWithName:@"Helvetica Neue" size: 30.0];
            vendorDateLand[i].font = [UIFont boldSystemFontOfSize:13.0];
            vendorDateLand[i].textColor = [UIColor grayColor];
            [viewForListLand[i] addSubview:vendorDateLand[i]];
            
            vendorDetailsLand[i] = [[UILabel alloc]initWithFrame:CGRectMake(130, 60, 200, 30)];
            vendorDetailsLand[i].backgroundColor = [UIColor clearColor];
            vendorDetailsLand[i].text = datatype[i];
            vendorDetailsLand[i].font = [UIFont fontWithName:@"Helvetica Neue" size: 30.0];
            vendorDetailsLand[i].font = [UIFont systemFontOfSize:12.0];
            vendorDetailsLand[i].textColor = [UIColor grayColor];
            [viewForListLand[i] addSubview:vendorDetailsLand[i]];
            
            
            
            lineImageLand[i] = [[UIImageView alloc]initWithFrame:CGRectMake(0, nYY+115, 1006, 1)];
            lineImageLand[i].backgroundColor = [UIColor grayColor];
            [vendorScrollerLand addSubview:lineImageLand[i]];
            
            
                 
            nXX=nXX+503;
            nYY=nYY+115;
            
        }
        vendorScroller.contentSize = CGSizeMake(748, 115*totalVendors+100);
        
        if(totalVendors%2==0)
        {
            vendorScrollerLand.contentSize = CGSizeMake(1006, 115*(totalVendors/2)+100);
        }
        else
        {
            vendorScrollerLand.contentSize = CGSizeMake(1006, 115*(totalVendors/2)+200);
        }
        
    }
    
}

-(void)openAddNote:(UIButton *)sender
{
     syncButton.alpha = 0.0;
    syncButtonLand.alpha = 0.0;
    
    //    NSString   *fetchdata = [NSString stringWithFormat:@"select id , vendor_name, Description, website  from ba_tbl_vendor WHERE id=%@",dataid[sender.tag]];
    //    [self displaySelctedVendor:fetchdata];
    
    
    NSString   *fetchdata = [NSString stringWithFormat:@"select id , vendor_name, Description, website, tags, email_id, address, contact_no  from ba_tbl_vendor WHERE id=%@",dataid[sender.tag]];
    
    [self displaySelctedVendor:fetchdata];
    
    
    OpenVendor *openVendor = [[OpenVendor alloc]initWithNibName:@"OpenVendor" bundle:nil];
    openVendor.vendorTitle=vendornameDB[0];
    openVendor.vendorDesciption=vendordescDB[0];
    openVendor.vendorWebsite=vendorContactnoDB[0];
    openVendor.vendorid=vendoridDB[0];
    [self.navigationController pushViewController:openVendor animated:YES];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return sortedArray.count;
    
    
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
    
    cell1.textLabel.textColor = [UIColor grayColor];
    cell1.textLabel.font = [UIFont systemFontOfSize:12];
    cell1.textLabel.text=[sortedArray objectAtIndex:indexPath.row];
    NSLog(@"cellForRowAtIndexPath");
    
    [cell1 setSelected:YES];
    
    if ([[sortedArray objectAtIndex:indexPath.row] isEqualToString:[NSString stringWithFormat:@"%@",[sortedArray objectAtIndex:INDEX]]]) {
        [cell1 setAccessoryType:UITableViewCellAccessoryCheckmark];
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else
    {
        
        [cell1 setAccessoryType:UITableViewCellAccessoryNone];
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return cell1;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSUserDefaults *setUserDefaults=[NSUserDefaults standardUserDefaults];
    // [setUserDefaults setObject:[sortedArray objectAtIndex:indexPath.row] forKey:@"selected option"];
    [setUserDefaults setInteger:indexPath.row forKey:@"selected option"];
    
    
    [self tablereloaddata];
    
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
        self.view = self.lView;
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main-bg-1024-704.jpg"]];
        //        adsLand.scrollView.bounces=NO;
        //        adsLand.opaque=NO;
        //        [adsLand loadHTMLString: [NSString stringWithFormat:@"<script type=\"text/javascript\" src=\"http://ad.leadboltads.net/show_app_ad.js?section_id=897295593\"></script>"] baseURL:nil];        //Load the request in the UIWebView.
        
    }
    
    else if(toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        self.view = self.pView;
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main-bg-768-960.jpg"]];
        //        ads.scrollView.bounces=NO;
        //        ads.opaque=NO;
        //        [ads loadHTMLString: [NSString stringWithFormat:@"<script type=\"text/javascript\" src=\"http://ad.leadboltads.net/show_app_ad.js?section_id=897295593\"></script>"] baseURL:nil];        //Load the request in the UIWebView.
        
        
    }
    sortingTableLand.frame = CGRectMake(861, 43, 137, 170);
    sortingTable.frame = CGRectMake(616, 43, 137, 170);
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    sortingTable.hidden = YES;
    tableViewBgImage.alpha = 0.0;
    sortingTableLand.hidden = YES;
    tableViewBgImageLand.alpha = 0.0;
    [[UINavigationBar appearance]setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
}


-(void)cameraClicked:(UIButton *)sender
{
   
    
    [sortByDate setBackgroundImage:[UIImage imageNamed:@"small_thumb.jpg"] forState:UIControlStateNormal];
    [gridView setBackgroundImage:[UIImage imageNamed:@"thumb.jpg"] forState:UIControlStateNormal];
    [listView setBackgroundImage:[UIImage imageNamed:@"list_view.jpg"] forState:UIControlStateNormal];
    sortingTable.hidden = YES;
    tableViewBgImage.alpha = 0.0;
    
    
    [sortByDateLand setBackgroundImage:[UIImage imageNamed:@"small_thumb.jpg"] forState:UIControlStateNormal];
    [gridViewLand setBackgroundImage:[UIImage imageNamed:@"thumb.jpg"] forState:UIControlStateNormal];
    [listViewLand setBackgroundImage:[UIImage imageNamed:@"list_view.jpg"] forState:UIControlStateNormal];
    sortingTableLand.hidden = YES;
    tableViewBgImageLand.alpha = 0.0;
    
    if(sender.tag == 2)
    {
        AddNote *addNote = [[AddNote alloc]initWithNibName:@"AddNote" bundle:nil];
        [self.navigationController pushViewController:addNote animated:YES];
    }
    else
    {
        CameraAudioVideoNote *openCamera = [[CameraAudioVideoNote alloc]initWithNibName:@"CameraAudioVideoNote" bundle:nil];
        openCamera.navTagFromHome = sender.tag;
        [self.navigationController pushViewController:openCamera animated:YES];
        
        
        //        AddNote *addNote = [[AddNote alloc]initWithNibName:@"AddNote" bundle:nil];
        //        addNote.SHORTCUTCLICKED=@"1";
        //        [self.navigationController pushViewController:addNote animated:YES];
        
    }
}
- (IBAction)sortByDate:(id)sender
{
    
    
    [self.pView addSubview:tableViewBgImage];
    [self.pView addSubview:sortingTable];
    [sortByDate setBackgroundImage:[UIImage imageNamed:@"small_thumb_on.jpg"] forState:UIControlStateNormal];
    [gridView setBackgroundImage:[UIImage imageNamed:@"thumb.jpg"] forState:UIControlStateNormal];
    [listView setBackgroundImage:[UIImage imageNamed:@"list_view.jpg"] forState:UIControlStateNormal];
    
    [self.lView addSubview:tableViewBgImageLand];
    [self.lView addSubview:sortingTableLand];
    [sortByDateLand setBackgroundImage:[UIImage imageNamed:@"small_thumb_on.jpg"] forState:UIControlStateNormal];
    [gridViewLand setBackgroundImage:[UIImage imageNamed:@"thumb.jpg"] forState:UIControlStateNormal];
    [listViewLand setBackgroundImage:[UIImage imageNamed:@"list_view.jpg"] forState:UIControlStateNormal];
   
    
    if(sortingTable.hidden == YES || sortingTableLand.hidden==YES)
    {
        [sortByDate setBackgroundImage:[UIImage imageNamed:@"small_thumb_on.jpg"] forState:UIControlStateNormal];
        sortingTable.hidden = NO;
        tableViewBgImage.alpha = 1.0;
        
        [sortByDateLand setBackgroundImage:[UIImage imageNamed:@"small_thumb_on.jpg"] forState:UIControlStateNormal];
        sortingTableLand.hidden = NO;
        tableViewBgImageLand.alpha = 1.0;
    }
    else if ( sortingTable.hidden == NO || sortingTableLand.hidden == NO)
    {
        [sortByDate setBackgroundImage:[UIImage imageNamed:@"small_thumb.jpg"] forState:UIControlStateNormal];
        sortingTable.hidden = YES;
        tableViewBgImage.alpha = 0.0;
        
        [sortByDateLand setBackgroundImage:[UIImage imageNamed:@"small_thumb.jpg"] forState:UIControlStateNormal];
        sortingTableLand.hidden = YES;
        tableViewBgImageLand.alpha = 0.0;
    }
    
}

- (IBAction)displayGridView:(id)sender
{
   
    listAndGridIndex=1;
      syncButton.alpha = 0.0;
    syncButtonLand.alpha = 0.0;
    [sortByDate setBackgroundImage:[UIImage imageNamed:@"small_thumb.jpg"] forState:UIControlStateNormal];
    [gridView setBackgroundImage:[UIImage imageNamed:@"thumb_on.jpg"] forState:UIControlStateNormal];
    [listView setBackgroundImage:[UIImage imageNamed:@"list_view.jpg"] forState:UIControlStateNormal];
  
    sortingTable.hidden = YES;
    tableViewBgImage.alpha = 0.0;
    
    [sortByDateLand setBackgroundImage:[UIImage imageNamed:@"small_thumb.jpg"] forState:UIControlStateNormal];
    [gridViewLand setBackgroundImage:[UIImage imageNamed:@"thumb_on.jpg"] forState:UIControlStateNormal];
    [listViewLand setBackgroundImage:[UIImage imageNamed:@"list_view.jpg"] forState:UIControlStateNormal];
     sortingTableLand.hidden = YES;
    tableViewBgImageLand.alpha = 0.0;
    
    [self DisplayVendors];
}

- (IBAction)displayListView:(id)sender
{
   
    listAndGridIndex=2;
    
     syncButton.alpha = 0.0;
    syncButtonLand.alpha = 0.0;
    [sortByDate setBackgroundImage:[UIImage imageNamed:@"small_thumb.jpg"] forState:UIControlStateNormal];
    [gridView setBackgroundImage:[UIImage imageNamed:@"thumb.jpg"] forState:UIControlStateNormal];
    [listView setBackgroundImage:[UIImage imageNamed:@"list_view_on.jpg"] forState:UIControlStateNormal];
  
    sortingTable.hidden = YES;
    tableViewBgImage.alpha = 0.0;
    
    [sortByDateLand setBackgroundImage:[UIImage imageNamed:@"small_thumb.jpg"] forState:UIControlStateNormal];
    [gridViewLand setBackgroundImage:[UIImage imageNamed:@"thumb.jpg"] forState:UIControlStateNormal];
    [listViewLand setBackgroundImage:[UIImage imageNamed:@"list_view_on.jpg"] forState:UIControlStateNormal];
     sortingTableLand.hidden = YES;
    tableViewBgImageLand.alpha = 0.0;
    
    
    [self DisplayVendors];
}
- (IBAction)syncButton:(id)sender
{
     syncButton.alpha = 0.0;
    syncButtonLand.alpha = 0.0;
    [sortByDate setBackgroundImage:[UIImage imageNamed:@"small_thumb.jpg"] forState:UIControlStateNormal];
    [gridView setBackgroundImage:[UIImage imageNamed:@"thumb.jpg"] forState:UIControlStateNormal];
    [listView setBackgroundImage:[UIImage imageNamed:@"list_view.jpg"] forState:UIControlStateNormal];
      sortingTable.hidden = YES;
    tableViewBgImage.alpha = 0.0;
    
  
    [sortByDateLand setBackgroundImage:[UIImage imageNamed:@"small_thumb.jpg"] forState:UIControlStateNormal];
    [gridViewLand setBackgroundImage:[UIImage imageNamed:@"thumb.jpg"] forState:UIControlStateNormal];
    [listViewLand setBackgroundImage:[UIImage imageNamed:@"list_view.jpg"] forState:UIControlStateNormal];
    sortingTableLand.hidden = YES;
    tableViewBgImageLand.alpha = 0.0;
    
    NSString   *fetchdata = [NSString stringWithFormat:@"select id , vendor_name, Description, Description from ba_tbl_vendor"];
    [self displayContentData:fetchdata];
    
    totalVendors=TotalData;
    [self DisplayVendors];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
