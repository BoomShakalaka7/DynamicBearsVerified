import UIKit

class StartScreenViewController: UIViewController {
    

    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var heightLogo: NSLayoutConstraint!
    @IBOutlet weak var widthLogo: NSLayoutConstraint!
    
    
//
//    @IBAction func profileShow(_ sender: Any) {
//        performSegue(withIdentifier: "profile", sender: self)
//    }
    
    
    @IBAction func showInfo(_ sender: Any) {
        performSegue(withIdentifier: "info", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //FOR TESTING...
//        let cards = CardData.getAllCards()
//
//        for card in cards {
//            print(card.name + " WORKS")
//        }
    
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        
        switch UIScreen.main.bounds.width {
        case 834, 1024:
            self.topConstraint.constant = 200
            self.heightLogo.constant = 354
            self.widthLogo.constant = 200
        default:
            break
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    
    @IBAction func startButton(_ sender: Any) {
        SessionController.newGame()
        let storyboard = UIStoryboard(name: "CardViewer", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "CardViewerController") as UIViewController
        self.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func searchButton(_ sender: Any) {
        performSegue(withIdentifier: "searchView", sender: self)
    }
    
    @IBAction func creditsButton(_ sender: Any) {
        performSegue(withIdentifier: "showCredits", sender: self)
    }
    
    @IBAction func InfoButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "InfoScreen", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "InfoScreenViewController") as UIViewController
//        let navi = UINavigationController(rootViewController: controller)
//        navigationController?.pushViewController(navi, animated: true)
       
        self.present(controller, animated: true, completion: nil)    }
    
    //    @IBAction func categoryButton(_ sender: Any) {
    //            self.performSegue(withIdentifier: "categoryVC", sender: self)
    //    }
    override var prefersStatusBarHidden: Bool
    {
        return true
    }
}

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    
    let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
    if statusBar.responds(to:#selector(setter: UIView.backgroundColor)) {
        statusBar.backgroundColor = UIColor.blue
    }
    UIApplication.shared.statusBarStyle = .lightContent
    
    return true
}



