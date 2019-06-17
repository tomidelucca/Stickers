//
// STMainStickersCollectionViewController.m
// Stickers
//
// Created by Tomi De Lucca on 3/24/18.
// Copyright © 2018 Tomi De Lucca. All rights reserved.
//

#import "STMainStickersCollectionViewController.h"

#import "STStickerCollectionViewCell.h"
#import "STStickerStatisticViewModel.h"
#import "STStickerStatisticsBoxView.h"
#import "STUserDefaultsStickerDAO.h"
#import "STStickerSectionScrubber.h"
#import "STStickerProgressView.h"
#import "STStickersViewModel.h"
#import "STStickersLayout.h"

#import <PureLayout/PureLayout.h>

@interface STMainStickersCollectionViewController () <UICollectionViewDelegate, UICollectionViewDataSource, STStickerSectionScrubberDelegate>
@property (strong, nonatomic) STStickersViewModel *viewModel;
@property (strong, nonatomic) STStickerStatisticViewModel *statisticViewModel;
@property (strong, nonatomic) STStickerStatisticsBoxView *statisticsBoxView;
@property (strong, nonatomic) STStickerProgressView *stickerProgressView;
@property (strong, nonatomic) STStickerSectionScrubber *sectionScrubber;
@property (strong, nonatomic) UIView *separator;
@property (strong, nonatomic) UICollectionView *collectionView;
@end

@implementation STMainStickersCollectionViewController

static NSString *const cellReuseIdentifier = @"StickerCell";

- (void)viewDidLoad
{
	[super viewDidLoad];

	self.title = NSLocalizedString(@"RUSSIA_2018", @"Navigation Bar Title");

	id <STStickerDAO> userDefaultsDAO = [STUserDefaultsStickerDAO new];

	self.viewModel = [[STStickersViewModel alloc] initWithStickerDAO:userDefaultsDAO];
	self.statisticViewModel = [[STStickerStatisticViewModel alloc] initWithStickerDAO:userDefaultsDAO];

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
	[self.view setBackgroundColor:[UIColor colorNamed:@"background"]];

	[self.navigationController.navigationBar setBarTintColor:[UIColor colorNamed:@"navbar-background-tint"]];
	[self.navigationController.navigationBar setTintColor:[UIColor colorNamed:@"navbar-text-tint"]];
	[self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
}

- (void)configureStatisticsView
{
	self.statisticsBoxView = [[STStickerStatisticsBoxView alloc] initWithStatistics:[self.statisticViewModel currentStatistics]];

	[self.view addSubview:self.statisticsBoxView];
	[self.statisticsBoxView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
}

- (void)configureStickerProgressView
{
	self.stickerProgressView = [STStickerProgressView newAutoLayoutView];
	[self.stickerProgressView updateWithProgress:[self.statisticViewModel totalProgress]];

	[self.view addSubview:self.stickerProgressView];

	[self.stickerProgressView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.statisticsBoxView];
	[self.stickerProgressView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
	[self.stickerProgressView autoPinEdgeToSuperviewEdge:ALEdgeRight];
}

- (void)configureSeparatorView
{
	self.separator = [UIView newAutoLayoutView];
	[self.separator setBackgroundColor:[UIColor colorNamed:@"separator-color"]];
	[self.separator setHidden:YES];
	[self.view addSubview:self.separator];

	[self.separator autoSetDimension:ALDimensionHeight toSize:1.0f];
	[self.separator autoPinEdgeToSuperviewEdge:ALEdgeLeft];
	[self.separator autoPinEdgeToSuperviewEdge:ALEdgeRight];
	[self.stickerProgressView autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.separator];
}

- (void)configureCollectionView
{
	self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:[STStickersLayout new]];
	self.collectionView.delegate = self;
	self.collectionView.dataSource = self;
	[self.view addSubview:self.collectionView];

	[self.collectionView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
	[self.collectionView autoPinEdgeToSuperviewEdge:ALEdgeRight];
	[self.collectionView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.separator];

	[self.collectionView setBackgroundColor:[UIColor colorNamed:@"background"]];
	[self.collectionView registerClass:[STStickerCollectionViewCell class] forCellWithReuseIdentifier:cellReuseIdentifier];

	UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressed:)];
	[longPressGesture setDelaysTouchesBegan:YES];
	[self.collectionView addGestureRecognizer:longPressGesture];
}

- (void)configureScrubberView
{
	self.sectionScrubber = [[STStickerSectionScrubber alloc] initWithNumberOfSections:self.viewModel.numberOfSections];
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
	STStickerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellReuseIdentifier forIndexPath:indexPath];

	STSticker *sticker = [self.viewModel stickerForSection:indexPath.section andRow:indexPath.row];

	[cell updateWithTitle:[@(sticker.number)stringValue] andSubtitle:[@(sticker.amount)stringValue]];
	[cell setStatus:[self.viewModel cellStatusForSticker:sticker]];

	return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	[collectionView deselectItemAtIndexPath:indexPath animated:YES];

	STSticker *sticker = [self.viewModel stickerForSection:indexPath.section andRow:indexPath.row];
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

#pragma mark - STStickerScrubberDelegate

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

	STSticker *sticker = [self.viewModel stickerForSection:indexPath.section andRow:indexPath.row];
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

	UIAlertAction *duplicated = [UIAlertAction actionWithTitle:NSLocalizedString(@"DUPLICATED", @"Duplicated Stickers")
	                                                     style:UIAlertActionStyleDefault handler: ^(UIAlertAction *action) {
	    [[UIPasteboard generalPasteboard] setString:[weakSelf.viewModel duplicatedStickers]];
	}];

	UIAlertAction *missing = [UIAlertAction actionWithTitle:NSLocalizedString(@"MISSING", @"Missing Stickers")
	                                                  style:UIAlertActionStyleDefault handler: ^(UIAlertAction *action) {
	    [[UIPasteboard generalPasteboard] setString:[weakSelf.viewModel missingStickers]];
	}];

	UIAlertAction *cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"CANCEL", @"Share Stickers cancel action")
	                                                 style:UIAlertActionStyleCancel handler:nil];

	[alert addAction:missing];
	[alert addAction:duplicated];
	[alert addAction:cancel];

	[self presentViewController:alert animated:YES completion:nil];
}

@end
