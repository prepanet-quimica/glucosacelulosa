import UIKit


class RepasoViewController: UIViewController {
	
	@IBOutlet weak internal var leftBarButton: UIBarButtonItem!
	
	override var preferredStatusBarStyle: UIStatusBarStyle  {
		return .default
	}
	
	override var prefersStatusBarHidden: Bool  {
		return false
	}
	
	var pageController1: PageController1!
	
	override func viewDidLoad() {
		super.viewDidLoad();
		self.navigationController?.navigationBar.barStyle = .default
		self.setNeedsStatusBarAppearanceUpdate()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		self.setNeedsStatusBarAppearanceUpdate()
		
		
		self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.847, green: 0.847, blue: 0.847, alpha: 1)
		self.navigationController?.navigationBar.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
		var titleTextAttributes = [String : AnyObject]();
		titleTextAttributes[NSFontAttributeName] = UIFont.systemFont(ofSize: 17, weight: UIFontWeightSemibold)
		titleTextAttributes[NSForegroundColorAttributeName] = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
		self.navigationController?.navigationBar.titleTextAttributes = titleTextAttributes
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let destination = segue.destination as? PageController1 {
			self.pageController1 = destination
			self.pageController1._parent = self
		}
	}
	
	@IBAction internal func leftBarButtonTapped(leftBarButton: UIBarButtonItem) {
		if let controller = self.presentingViewController {
			controller.dismiss(animated: true, completion: nil);
		}
	}
	
}
    


class PageControllerView2: UIViewController {
	
	@IBOutlet var imageView3: UIImageView!
	
	var pageController1: PageController1?
	
	override func viewDidLoad() {
		super.viewDidLoad();
	}
	
}
    


class PageController1: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
	
	var _parent: RepasoViewController?
	
	var viewControllerStorage: [UIViewController] = [] {
		didSet {
			self.pageControl.numberOfPages = viewControllerStorage.count
		}
	}
	
	var pageControlPosition: PageControlPosition = .bottom {
		didSet {
			self.view.setNeedsLayout()
		}
	}
	
	var pageControl: UIPageControl = UIPageControl()
	
	var currentPage: Int = 0
	
	var pageControllerView3: PageControllerView3?
	
	var pageControllerView1: PageControllerView1?
	
	var pageControllerView2: PageControllerView2?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.dataSource = self;
		self.delegate = self;
		self.view.alpha = 1;
		self.view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
		self.view.isHidden = false;
		self.view.isUserInteractionEnabled = true
		self.pageControl.currentPageIndicatorTintColor = UIColor(red: 0.047, green: 0.408, blue: 0.984, alpha: 1)
		self.pageControl.pageIndicatorTintColor = UIColor(red: 0.659, green: 0.659, blue: 0.659, alpha: 1)
		self.pageControl.hidesForSinglePage = false;
		self.pageControl.isHidden = false;
		self.pageControl.addTarget(self, action: #selector(pageControlValueChanged), for: .valueChanged);
		self.view.addSubview(self.pageControl);
		self.pageControllerView1 = storyboard!.instantiateViewController(withIdentifier: "af94803d-5f41-4e5e-82e8-016b42e77d45") as? PageControllerView1
		self.pageControllerView1!.pageController1 = self
		self.pageControllerView2 = storyboard!.instantiateViewController(withIdentifier: "3516ca6e-9c8a-4965-a1a7-189ffc27e202") as? PageControllerView2
		self.pageControllerView2!.pageController1 = self
		self.pageControllerView3 = storyboard!.instantiateViewController(withIdentifier: "6daf4681-13ae-4eb8-b54c-23ef56b51b29") as? PageControllerView3
		self.pageControllerView3!.pageController1 = self
		self.viewControllerStorage = [
		self.pageControllerView1!,
		self.pageControllerView2!,
		self.pageControllerView3!
		];
		self.setViewControllers([self.viewControllerStorage[currentPage]], direction: .forward, animated: false, completion: nil)
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		if self.pageControlPosition == .top {
			self.pageControl.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 30);
		} else {
			self.pageControl.frame = CGRect(x: 0, y: self.view.frame.size.height-30, width: self.view.frame.size.width, height: 30);
		}
		self.view.bringSubview(toFront: self.pageControl);
	}
	
	func pageControlValueChanged(_ pageControl: UIPageControl) {
		let direction = pageControl.currentPage < currentPage ? UIPageViewControllerNavigationDirection.reverse : UIPageViewControllerNavigationDirection.forward
		self.currentPage = pageControl.currentPage
		let nextPage = self.viewControllerStorage[pageControl.currentPage]
		self.setViewControllers([nextPage], direction: direction, animated: false, completion: nil)
	}
	
	func goToPage(_ pageIndex: Int) {
		let direction = currentPage > pageIndex ? UIPageViewControllerNavigationDirection.reverse : UIPageViewControllerNavigationDirection.forward
		if pageIndex < self.viewControllerStorage.count && pageIndex >= 0 {
			let destinationViewController = viewControllerStorage[pageIndex];
			self.currentPage = pageIndex
			self.pageControl.currentPage = pageIndex
			self.setViewControllers([destinationViewController], direction: direction, animated: true, completion: nil);
		}
	}
	
	func goToBeginning() {
		self.goToPage(0);
	}
	
	func goToNextPage() {
		self.goToPage(self.currentPage + 1);
	}
	
	func goToPreviousPage() {
		self.goToPage(self.currentPage - 1);
	}
	
	func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
		if currentPage == viewControllerStorage.count - 1 {
			return nil
		} else {
			let nextViewController = self.viewControllerStorage[currentPage+1];
			return nextViewController;
		}
	}
	
	func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
		if currentPage == 0 {
			return nil
		} else {
			let nextViewController = self.viewControllerStorage[currentPage-1];
			return nextViewController;
		}
	}
	
	func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
		if completed {
			let currentViewController = self.viewControllers![0];
			let index = self.viewControllerStorage.index(of: currentViewController)!;
			currentPage = index;
			self.pageControl.currentPage = index;
		}
	}
	
	enum PageControlPosition {
		
		case top
		
		case bottom
		
	}
	
}
    


class PageControllerView1: UIViewController {
	
	@IBOutlet var imageView2: UIImageView!
	
	@IBOutlet var imageView1: UIImageView!
	
	var pageController1: PageController1?
	
	override func viewDidLoad() {
		super.viewDidLoad();
	}
	
}
    


class PageControllerView3: UIViewController {
	
	@IBOutlet var textView1: UITextView!
	
	var pageController1: PageController1?
	
	var textView1Attributes = [String : AnyObject]()
	
	override func viewDidLoad() {
		super.viewDidLoad();
		
		
		self.textView1.delegate = self;
		self.textView1Attributes[NSFontAttributeName] = UIFont.systemFont(ofSize: 20, weight: UIFontWeightBold);
		self.textView1Attributes[NSForegroundColorAttributeName] = UIColor(red : 0, green : 0, blue : 0, alpha : 1);
		let textView1ParagraphStyle = NSMutableParagraphStyle();
		textView1ParagraphStyle.lineHeightMultiple = 3;
		textView1ParagraphStyle.alignment = .justified;
		self.textView1Attributes[NSParagraphStyleAttributeName] = textView1ParagraphStyle;
		self.textView1.attributedText = NSAttributedString(string : "Recuerda que siempre puedes apoyarte con tus profesores y compañeros de clase!", attributes : self.textView1Attributes);
		self.textView1.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
	}
	
}
    

extension PageControllerView3: UITextViewDelegate {
	
	func textViewDidChange(_ textView: UITextView) {
		if textView === self.textView1 {
			self.textView1.attributedText = NSAttributedString(string: textView.text, attributes: self.textView1Attributes)
		}
	}
	
}