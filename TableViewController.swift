import UIKit


class TableViewController: UIViewController {
	
	@IBOutlet var tableView1: TableView1!
	
	override var preferredStatusBarStyle: UIStatusBarStyle  {
		return .default
	}
	
	override var prefersStatusBarHidden: Bool  {
		return false
	}
	
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
		if let destination = segue.destination as? TableView1 {
			self.tableView1 = destination
			self.tableView1._parent = self
		}
	}
	
}
    


class TableView1: UITableViewController {
	
	@IBOutlet var tableViewCell2: UITableViewCell!
	
	@IBOutlet var label3: UILabel!
	
	@IBOutlet var tableViewCell1: UITableViewCell!
	
	@IBOutlet var label2: UILabel!
	
	@IBOutlet var label1: UILabel!
	
	@IBOutlet var tableViewCell3: UITableViewCell!
	
	var _parent: TableViewController?
	
	var tableView1Storage: [UITableViewCell] = []
	
	var label3Attributes = [String : AnyObject]()
	
	var label2Attributes = [String : AnyObject]()
	
	var label1Attributes = [String : AnyObject]()
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if let cell = self.tableView.cellForRow(at: indexPath) {
			if cell === self.tableViewCell1 {
				let destinationNavigationViewController : UINavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "000-000-024") as! UINavigationController
				destinationNavigationViewController.modalTransitionStyle = .crossDissolve;
				self._parent!.present(destinationNavigationViewController, animated: true, completion: nil);
			}
			if cell === self.tableViewCell2 {
			}
			if cell === self.tableViewCell3 {
			}
			self.tableView!.deselectRow(at: indexPath, animated: true)
		}
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.tableView1Storage.count;
	}
	
	override func viewDidLoad() {
		self.tableView.separatorColor = UIColor(red: 0.047, green: 0.22, blue: 0.98, alpha: 1)
		self.tableView.tableFooterView = UIView()
		self.tableView1Storage = [self.tableViewCell1, self.tableViewCell2, self.tableViewCell3]
		
		
		
		var label3Attributes = [String : AnyObject]()
		label3Attributes[NSFontAttributeName] = UIFont.systemFont(ofSize: 22, weight: UIFontWeightRegular);
		label3Attributes[NSForegroundColorAttributeName] = UIColor(red: 0, green: 0, blue: 0, alpha: 1);
		let label3ParagraphStyle = NSMutableParagraphStyle()
		label3ParagraphStyle.lineHeightMultiple = 1;
		label3ParagraphStyle.alignment = .center;
		label3Attributes[NSParagraphStyleAttributeName] = label3ParagraphStyle;
		self.label3Attributes = label3Attributes;
		self.label3.attributedText = NSAttributedString(string : "Quiz", attributes : label3Attributes);
		
		
		var label2Attributes = [String : AnyObject]()
		label2Attributes[NSFontAttributeName] = UIFont.systemFont(ofSize: 22, weight: UIFontWeightRegular);
		label2Attributes[NSForegroundColorAttributeName] = UIColor(red: 0, green: 0, blue: 0, alpha: 1);
		let label2ParagraphStyle = NSMutableParagraphStyle()
		label2ParagraphStyle.lineHeightMultiple = 1;
		label2ParagraphStyle.alignment = .center;
		label2Attributes[NSParagraphStyleAttributeName] = label2ParagraphStyle;
		self.label2Attributes = label2Attributes;
		self.label2.attributedText = NSAttributedString(string : "¡Juega!", attributes : label2Attributes);
		
		
		var label1Attributes = [String : AnyObject]()
		label1Attributes[NSFontAttributeName] = UIFont.systemFont(ofSize: 22, weight: UIFontWeightRegular);
		label1Attributes[NSForegroundColorAttributeName] = UIColor(red: 0, green: 0, blue: 0, alpha: 1);
		let label1ParagraphStyle = NSMutableParagraphStyle()
		label1ParagraphStyle.lineHeightMultiple = 1;
		label1ParagraphStyle.alignment = .center;
		label1Attributes[NSParagraphStyleAttributeName] = label1ParagraphStyle;
		self.label1Attributes = label1Attributes;
		self.label1.attributedText = NSAttributedString(string : "Repaso", attributes : label1Attributes);
	}
	
}