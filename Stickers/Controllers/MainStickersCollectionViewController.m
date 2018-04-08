//
// MainStickersCollectionViewController.m
// Stickers
//
// Created by Tomi De Lucca on 3/24/18.
// Copyright © 2018 Tomi De Lucca. All rights reserved.
//

#import "MainStickersCollectionViewController.h"

#import "StickerCollectionViewCell.h"
#import "StickerStatisticViewModel.h"
#import "StickerStatisticsBoxView.h"
#import "UserDefaultsStickerDAO.h"
#import "StickerSectionScrubber.h"
#import "StickerProgressView.h"
#import "StickersViewModel.h"
#import "StickersLayout.h"

#import <PureLayout/PureLayout.h>
#import <DKNightVersion/DKNightVersion.h>

@interface MainStickersCollectionViewController () <UICollectionViewDelegate, UICollectionViewDataSource, StickerSectionScrubberDelegate>
@property (strong, nonatomic) StickersViewModel *viewModel;
@property (strong, nonatomic) StickerStatisticViewModel *statisticViewModel;
@property (strong, nonatomic) StickerStatisticsBoxView *statisticsBoxView;
@property (strong, nonatomic) StickerProgressView *stickerProgressView;
@property (strong, nonatomic) StickerSectionScrubber *sectionScrubber;
@property (strong, nonatomic) UIView *separator;
@property (strong, nonatomic) UICollectionView *collectionView;
@end

@implementation MainStickersCollectionViewController

static NSString *const cellReuseIdentifier = @"StickerCell";

- (void)viewDidLoad
{
	[super viewDidLoad];

	self.title = @"Russia 2018";

	id <StickerDAO> userDefaultsDAO = [UserDefaultsStickerDAO new];

	self.viewModel = [[StickersViewModel alloc] initWithStickerDAO:userDefaultsDAO];
	self.statisticViewModel = [[StickerStatisticViewModel alloc] initWithStickerDAO:userDefaultsDAO];

	[self configureNavigationBar];
	[self configureStatisticsView];
	[self configureStickerProgressView];
	[self configureSeparatorView];
	[self configureCollectionView];
	[self configureScrubberView];
}

- (void)configureNavigationBar
{
	UIBarButtonItem *share = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(openShareSheet)];
	self.navigationItem.rightBarButtonItem = share;
	self.edgesForExtendedLayout = UIRectEdgeNone;
	[self.view dk_setBackgroundColorPicker:DKColorPickerWithKey(BG)];

	[self.navigationController.navigationBar dk_setBarTintColorPicker:DKColorPickerWithKey(NAVBAR_BG_TINT)];
	[self.navigationController.navigationBar dk_setTintColorPicker:DKColorPickerWithKey(NAVBAR_TEXT_TINT)];
	[self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
}

- (void)configureStatisticsView
{
	self.statisticsBoxView = [[StickerStatisticsBoxView alloc] initWithStatistics:[self.statisticViewModel currentStatistics]];

	[self.view addSubview:self.statisticsBoxView];
	[self.statisticsBoxView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
}

- (void)configureStickerProgressView
{
	self.stickerProgressView = [StickerProgressView newAutoLayoutView];
	[self.stickerProgressView updateWithProgress:[self.statisticViewModel totalProgress]];

	[self.view addSubview:self.stickerProgressView];

	[self.stickerProgressView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.statisticsBoxView];
	[self.stickerProgressView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
	[self.stickerProgressView autoPinEdgeToSuperviewEdge:ALEdgeRight];
}

- (void)configureSeparatorView
{
	self.separator = [UIView newAutoLayoutView];
	[self.separator dk_setBackgroundColorPicker:DKColorPickerWithKey(SEPARATOR_COLOR)];
	[self.separator setHidden:YES];
	[self.view addSubview:self.separator];

	[self.separator autoSetDimension:ALDimensionHeight toSize:1.0f];
	[self.separator autoPinEdgeToSuperviewEdge:ALEdgeLeft];
	[self.separator autoPinEdgeToSuperviewEdge:ALEdgeRight];
	[self.stickerProgressView autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.separator];
}

- (void)configureCollectionView
{
	self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:[StickersLayout new]];
	self.collectionView.delegate = self;
	self.collectionView.dataSource = self;
	[self.view addSubview:self.collectionView];

	[self.collectionView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
	[self.collectionView autoPinEdgeToSuperviewEdge:ALEdgeRight];
	[self.collectionView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.separator];

	[self.collectionView dk_setBackgroundColorPicker:DKColorPickerWithKey(BG)];
	[self.collectionView registerClass:[StickerCollectionViewCell class] forCellWithReuseIdentifier:cellReuseIdentifier];

	UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressed:)];
	[longPressGesture setDelaysTouchesBegan:YES];
	[self.collectionView addGestureRecognizer:longPressGesture];
}

- (void)configureScrubberView
{
	self.sectionScrubber = [[StickerSectionScrubber alloc] initWithNumberOfSections:self.viewModel.numberOfSections];
	self.sectionScrubber.delegate = self;
	[self.view addSubview:self.sectionScrubber];

	[self.sectionScrubber autoPinEdgeToSuperviewEdge:ALEdgeLeft];
	[self.sectionScrubber autoPinEdgeToSuperviewEdge:ALEdgeRight];
	[self.sectionScrubber autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.collectionView];

	UIEdgeInsets insets = UIEdgeInsetsZero;

	if (@available(iOS 11, *)) {
		insets = UIApplication.sharedApplication.keyWindow.safeAreaInsets;
	}

	[self.sectionScrubber autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:insets.bottom];
}

- (void)updateUserInterfaceAtIndexPath:(NSIndexPath *)indexPath
{
	[self.statisticsBoxView updateWithStatistics:[self.statisticViewModel currentStatistics]];
	[self.stickerProgressView updateWithProgress:[self.statisticViewModel totalProgress]];
	[self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
	return self.viewModel.numberOfSections;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return [self.viewModel numberOfStickersInSection:section];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	StickerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellReuseIdentifier forIndexPath:indexPath];

	Sticker *sticker = [self.viewModel stickerForSection:indexPath.section andRow:indexPath.row];

	[cell updateWithTitle:[@(sticker.number)stringValue] andSubtitle:[@(sticker.amount)stringValue]];
	[cell setStatus:[self.viewModel cellStatusForSticker:sticker]];

	return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	[collectionView deselectItemAtIndexPath:indexPath animated:YES];

	Sticker *sticker = [self.viewModel stickerForSection:indexPath.section andRow:indexPath.row];
	[self.viewModel incrementAmountForSticker:sticker];

	[self updateUserInterfaceAtIndexPath:indexPath];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	if (scrollView.contentOffset.y > 10.0f) {
		if ([self.separator isHidden]) {
			[self.separator setHidden:NO];
		}
	} else {
		if (![self.separator isHidden]) {
			[self.separator setHidden:YES];
		}
	}
}

#pragma mark - StickerScrubberDelegate

- (void)didScrubToSection:(NSUInteger)section
{
	[self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section] animated:YES scrollPosition:UICollectionViewScrollPositionTop];
}

#pragma mark UILongPressGestureRecognizer target action

- (void)longPressed:(UILongPressGestureRecognizer *)gestureRecognizer
{
	if (gestureRecognizer.state != UIGestureRecognizerStateBegan) {
		return;
	}

	CGPoint p = [gestureRecognizer locationInView:self.collectionView];

	NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:p];

	if (!indexPath) {
		return;
	}

	Sticker *sticker = [self.viewModel stickerForSection:indexPath.section andRow:indexPath.row];
	[self.viewModel decrementAmountForSticker:sticker];

	[self updateUserInterfaceAtIndexPath:indexPath];
}

#pragma mark UIAlertController target action

- (void)openShareSheet
{
	UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
		                                                           message:nil
		                                                    preferredStyle:UIAlertControllerStyleActionSheet];

	__weak __typeof__(self)weakSelf = self;

	UIAlertAction *duplicated = [UIAlertAction actionWithTitle:@"Repetidas" style:UIAlertActionStyleDefault handler: ^(UIAlertAction *action) {
		[[UIPasteboard generalPasteboard] setString:[weakSelf.viewModel duplicatedStickers]];
	}];

	UIAlertAction *missing = [UIAlertAction actionWithTitle:@"Faltan" style:UIAlertActionStyleDefault handler: ^(UIAlertAction *action) {
		[[UIPasteboard generalPasteboard] setString:[weakSelf.viewModel missingStickers]];
	}];

	UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancelar" style:UIAlertActionStyleCancel handler:nil];

	[alert addAction:missing];
	[alert addAction:duplicated];
	[alert addAction:cancel];

	[self presentViewController:alert animated:YES completion:nil];
}

@end
