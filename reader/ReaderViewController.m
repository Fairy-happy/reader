//
//  ReaderViewController.m
//  reader
//
//  Created by fairy on 16/12/15.
//  Copyright © 2016年 fairy. All rights reserved.
//

#import "ReaderViewController.h"
#import "ModelViewController.h"
#import "DataViewController.h"
#import "CollectViewModel.h"
#import "GlobalModel.h"
#import "PageCell.h"
@interface ReaderViewController ()<UICollectionViewDelegate, FontAdjustViewDelegate>

@property (strong, nonatomic) ModelViewController *modelController;
@property (strong, nonatomic) CollectViewModel *collectionViewModel;
@property (strong, nonatomic) GlobalModel *globalModel;
@property (strong, nonatomic) FontAdjustView *fontAdjustView;
@property (strong, nonatomic) UIButton *menuButton;
@property (strong, nonatomic) UIButton *backgroundView;
@property (strong, nonatomic) UIToolbar *toolbar;
@property (strong, nonatomic) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic) BOOL isShowMenu;

@property (strong, nonatomic) NSArray *toolbarConstraintArray;


@end

@implementation ReaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageController.delegate = self;
    
    DataViewController *startingViewController = [self.modelController viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    self.pageController.dataSource = self.modelController;
    self.modelController.readerController = self;
    
    [self addChildViewController:self.pageController];
    [self.view addSubview:self.pageController.view];
    
    // Set the page view controller's bounds using an inset rect so that self's view is visible around the edges of the pages.
    CGRect pageViewRect = self.view.bounds;
    self.pageController.view.frame = pageViewRect;
    
    [self.pageController didMoveToParentViewController:self];
    
    [self setupCollectionView];
    
    [self.view addSubview:self.menuButton];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_menuButton]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_menuButton)]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.menuButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.menuButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0.2 constant:0]];
    
    [self setupBackgroundView];
    [self setupToolbar];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)setupCollectionView
{
    [self.view addSubview:self.collectionView];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[_collectionView]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_collectionView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-40-[_collectionView]-40-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_collectionView)]];
    [self.view layoutIfNeeded];
    
    self.flowLayout.itemSize = self.collectionView.bounds.size;
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.flowLayout.minimumLineSpacing = 0;
    [self.collectionView setCollectionViewLayout:self.flowLayout];
    self.collectionView.hidden = YES;
}

- (void)setupBackgroundView
{
    self.backgroundView = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.backgroundView addTarget:self action:@selector(backgroundAction) forControlEvents:UIControlEventTouchUpInside];
    self.backgroundView.hidden = YES;
    
    [self.view addSubview:self.backgroundView];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_backgroundView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_backgroundView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_backgroundView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_backgroundView)]];
}

- (void)setupToolbar
{
    self.toolbar = [[UIToolbar alloc] init];
    self.toolbar.translatesAutoresizingMaskIntoConstraints = NO;
    self.toolbar.barStyle = UIBarStyleDefault;
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"夜间" style:UIBarButtonItemStylePlain target:self action:@selector(switchNightAction)];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithTitle:@"翻页" style:UIBarButtonItemStylePlain target:self action:@selector(changeReadAction)];
    UIBarButtonItem *item3 = [[UIBarButtonItem alloc] initWithTitle:@"字体" style:UIBarButtonItemStylePlain target:self action:@selector(adjustFontAction)];
    UIBarButtonItem *item4 = [[UIBarButtonItem alloc] initWithTitle:@"缓存" style:UIBarButtonItemStylePlain target:self action:@selector(downloadAction)];
    UIBarButtonItem *item5 = [[UIBarButtonItem alloc] initWithTitle:@"目录" style:UIBarButtonItemStylePlain target:self action:@selector(catalogAction)];
    UIBarButtonItem *fixibleItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    [self.toolbar setItems:@[item1,fixibleItem,item2,fixibleItem,item3,fixibleItem,item4,fixibleItem,item5]];
    
    [self.view addSubview:self.fontAdjustView];
    [self.view addSubview:self.toolbar];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_toolbar]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_toolbar)]];
    self.toolbarConstraintArray = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_toolbar(48)]-(-48)-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_toolbar)];
    [self.view addConstraints:self.toolbarConstraintArray];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_fontAdjustView(44)]-48-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_fontAdjustView)]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.fontAdjustView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.fontAdjustView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0 constant:98]];
}

- (void)showToolbar
{
    [self.view removeConstraints:self.toolbarConstraintArray];
    self.toolbarConstraintArray = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_toolbar(48)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_toolbar)];
    [self.view addConstraints:self.toolbarConstraintArray];
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)hideToolbar
{
    [self.view removeConstraints:self.toolbarConstraintArray];
    self.toolbarConstraintArray = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_toolbar(48)]-(-48)-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_toolbar)];
    [self.view addConstraints:self.toolbarConstraintArray];
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)loadText:(NSString *)text
{
    [self.globalModel loadText:text completion:^{
        self.collectionViewModel.text = self.globalModel.text;
        self.collectionViewModel.attributes = self.globalModel.attributes;
        self.collectionViewModel.dataArray = self.globalModel.rangeArray;
        [self.collectionView reloadData];
        
        self.modelController.text = self.globalModel.text;
        self.modelController.attributes = self.globalModel.attributes;
        self.modelController.pageData = self.globalModel.rangeArray;
        [self pageControllerSetIndex:[GlobalModel shareModel].currentPage];
    }];
}

- (void)pageControllerSetIndex:(NSInteger)index
{
    [self.pageController setViewControllers:@[[self.modelController viewControllerAtIndex:index]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)memuAction
{
    self.isShowMenu = !self.isShowMenu;
    
    [self.navigationController setNavigationBarHidden:!self.isShowMenu animated:YES];
    [self setNeedsStatusBarAppearanceUpdate];
    self.backgroundView.hidden = !self.isShowMenu;
    if (self.isShowMenu) {
        [self showToolbar];
    } else {
        [self hideToolbar];
    }
}

- (void)backgroundAction
{
    self.isShowMenu = NO;
    
    [self.navigationController setNavigationBarHidden:!self.isShowMenu animated:YES];
    self.backgroundView.hidden = !self.isShowMenu;
    self.fontAdjustView.alpha = 0;
    if (self.isShowMenu) {
        [self showToolbar];
    } else {
        [self hideToolbar];
    }
}

- (ModelViewController *)modelController {
    // Return the model controller object, creating it if necessary.
    // In more complex implementations, the model controller may be passed to the view controller.
    if (!_modelController) {
        _modelController = [[ModelViewController alloc] init];
    }
    return _modelController;
}

- (BOOL)prefersStatusBarHidden
{
    return !self.isShowMenu;
}

#pragma mark - UIPageViewController delegate methods

- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation {
    // Set the spine position to "min" and the page view controller's view controllers array to contain just one view controller. Setting the spine position to 'UIPageViewControllerSpineLocationMid' in landscape orientation sets the doubleSided property to YES, so set it to NO here.
    UIViewController *currentViewController = self.pageController.viewControllers[0];
    NSArray *viewControllers = @[currentViewController];
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    self.pageController.doubleSided = NO;
    return UIPageViewControllerSpineLocationMin;
}

#pragma mark - UICollectionViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger page = scrollView.contentOffset.y / scrollView.frame.size.height;
    [GlobalModel shareModel].currentPage = page;
    [GlobalModel shareModel].currentRange = NSRangeFromString([GlobalModel shareModel].rangeArray[page]);
    [[NSNotificationCenter defaultCenter] postNotificationName:kUpdatePageNotification object:nil];
}

#pragma mark - PCFontAdjustViewDelegate

- (void)adjustRangeArrayForText
{
    [[GlobalModel shareModel] updateFontCompletion:^{
        self.collectionViewModel.text = self.globalModel.text;
        self.collectionViewModel.attributes = self.globalModel.attributes;
        self.collectionViewModel.dataArray = self.globalModel.rangeArray;
        self.collectionView.delegate = nil;
        [self.collectionView reloadData];
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:[GlobalModel shareModel].currentPage inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        [[NSNotificationCenter defaultCenter] postNotificationName:kUpdatePageNotification object:nil];
        self.collectionView.delegate = self;
        
        self.modelController.text = self.globalModel.text;
        self.modelController.attributes = self.globalModel.attributes;
        self.modelController.pageData = self.globalModel.rangeArray;
        [self pageControllerSetIndex:[GlobalModel shareModel].currentPage];
    }];
}

#pragma mark - toolbar Action

- (void)switchNightAction
{
    
}

- (void)changeReadAction
{
    self.collectionView.hidden = !self.collectionView.hidden;
    self.pageController.view.userInteractionEnabled = self.collectionView.hidden;
    
    if (self.collectionView.hidden) {
        [self pageControllerSetIndex:[GlobalModel shareModel].currentPage];
    } else {
        self.collectionView.delegate = nil;
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:[GlobalModel shareModel].currentPage inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        [[NSNotificationCenter defaultCenter] postNotificationName:kUpdatePageNotification object:nil];
        self.collectionView.delegate = self;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self backgroundAction];
    });
}

- (void)adjustFontAction
{
    if (self.fontAdjustView.alpha == 0) {
        [UIView animateWithDuration:0.25 animations:^{
            self.fontAdjustView.alpha = 1;
        }];
    } else {
        [UIView animateWithDuration:0.25 animations:^{
            self.fontAdjustView.alpha = 0;
        }];
    }
}

- (void)downloadAction
{
    
}

- (void)catalogAction
{
    
}

#pragma mark - lazy loading

- (UIButton *)menuButton
{
    if (!_menuButton) {
        _menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _menuButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_menuButton addTarget:self action:@selector(memuAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _menuButton;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[UICollectionViewLayout alloc] init]];
        _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self.collectionViewModel;
        _collectionView.delegate = self;
        self.collectionViewModel.collectionView = _collectionView;
        [_collectionView registerClass:[PageCell class] forCellWithReuseIdentifier:PageCellIdentifier];
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)flowLayout
{
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    }
    return _flowLayout;
}

- (CollectViewModel *)collectionViewModel
{
    if (!_collectionViewModel) {
        _collectionViewModel = [[CollectViewModel alloc] init];
    }
    return _collectionViewModel;
}

- (GlobalModel *)globalModel
{
    if (!_globalModel) {
        _globalModel = [GlobalModel shareModel];
    }
    return _globalModel;
}

- (FontAdjustView *)fontAdjustView
{
    if (!_fontAdjustView) {
        _fontAdjustView = [[FontAdjustView alloc] init];
        _fontAdjustView.translatesAutoresizingMaskIntoConstraints = NO;
        _fontAdjustView.alpha = 0;
        _fontAdjustView.delegate = self;
    }
    return _fontAdjustView;
}

@end

@implementation FontAdjustView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.plusButton];
        [self addSubview:self.minusButton];
        
        NSDictionary *views = NSDictionaryOfVariableBindings(_plusButton, _minusButton);
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_plusButton(44)]-10-[_minusButton(44)]|" options:0 metrics:nil views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_plusButton(44)]" options:0 metrics:nil views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_minusButton(44)]" options:0 metrics:nil views:views]];
    }
    return self;
}

- (void)plusAction
{
    if ([GlobalModel shareModel].fontSize >= 30) {
        //        self.plusButton.enabled = NO;
    } else {
        self.plusButton.enabled = YES;
        [GlobalModel shareModel].fontSize += 2;
        //更新字体
        if ([self.delegate respondsToSelector:@selector(adjustRangeArrayForText)]) {
            [self.delegate adjustRangeArrayForText];
        }
    }
}

- (void)minusAction
{
    if ([GlobalModel shareModel].fontSize <= 14) {
        //        self.minusButton.enabled = NO;
    } else {
        self.minusButton.enabled = YES;
        [GlobalModel shareModel].fontSize -= 2;
        //更新字体
        if ([self.delegate respondsToSelector:@selector(adjustRangeArrayForText)]) {
            [self.delegate adjustRangeArrayForText];
        }
    }
}

- (UIButton *)plusButton
{
    if (!_plusButton) {
        _plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _plusButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_plusButton setTitle:@"+" forState:UIControlStateNormal];
        _plusButton.backgroundColor = [UIColor redColor];
        [_plusButton addTarget:self action:@selector(plusAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _plusButton;
}

- (UIButton *)minusButton
{
    if (!_minusButton) {
        _minusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _minusButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_minusButton setTitle:@"-" forState:UIControlStateNormal];
        _minusButton.backgroundColor = [UIColor redColor];
        [_minusButton addTarget:self action:@selector(minusAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _minusButton;
}

@end
