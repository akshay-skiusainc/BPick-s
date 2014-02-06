//
//  PhotoEditor.h
//  Buyer's_Pick_App
//
//  Created by Ashwini Pawar on 07/01/14.
//  Copyright (c) 2014 Ashwini Pawar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <QuartzCore/QuartzCore.h>
#import "AFPhotoEditorController.h"
#import "AFPhotoEditorCustomization.h"
#import "DatabaseClass.h"

@interface PhotoEditor : DatabaseClass <UIGestureRecognizerDelegate,AFPhotoEditorControllerDelegate>


@property (nonatomic,strong)NSString* TAG;
@property(nonatomic,retain) NSString    *DATATYPE;
@property(nonatomic,retain) NSString    *DATAPATH;
@property(nonatomic,retain) NSString    *DATAID;

@property(nonatomic,retain) NSMutableArray    *editOptionsArray;
@property (strong, nonatomic) IBOutlet UIImageView *imageToEdit;
@property (strong, nonatomic) IBOutlet UIImageView *scrollBgImage;
@property (strong, nonatomic) IBOutlet UIScrollView *optionsScroller;
@property (strong, nonatomic) IBOutlet UIButton *addCustmFldsInTbl;
@property (strong, nonatomic) IBOutlet UIButton *addCustmFldsInScrll;
@property (strong, nonatomic) IBOutlet UITableView *detailTableView;
@property (strong, nonatomic) IBOutlet UITextField *brandTextFld;
@property (strong, nonatomic) IBOutlet UITextField *beltTxtFld;
@property (strong, nonatomic) IBOutlet UITextField *availabilityTextFld;
@property (strong, nonatomic) IBOutlet UITextField *briefDescTxtFld;

@property (strong, nonatomic) IBOutlet UITextField *productTextFld;
@property (strong, nonatomic) IBOutlet UITextField *priceTextFld;
@property (strong, nonatomic) IBOutlet UITextField *QuantityTextFld;
@property (strong, nonatomic) IBOutlet UITextField *modelTextFld;
@property (strong, nonatomic) IBOutlet UITextField *CertifctnTextFld;
@property (strong, nonatomic) IBOutlet UITextField *minOrderTextFld;
@property (strong, nonatomic) IBOutlet UITextField *paymentTextFld;
@property (strong, nonatomic) IBOutlet UITextField *manufacturerTextFld;

- (IBAction)addDetailsButton:(id)sender;
- (IBAction)changeIndustryClicked:(id)sender;
- (IBAction)addColorTagClicked:(id)sender;
@end
