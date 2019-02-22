import UIKit
import SwiftyOnboard

class ViewController: UIViewController {
    
    var swiftyOnboard: SwiftyOnboard!
    var titleArray: [String] = ["تفاصيل اشتراكك", "شحن الرصيد", "الحملات والعروض","الدعم الفني","الاستخدام العادل","سجل الاستخدام","فحص السرعة"]
    var subTitleArray: [String] = ["يمكنك الان رؤية كافة تفاصيل اشتراكك عن طريق تطبيق فيوجن", "أصبح بإمكانك شحن الرصيد المستخدم للأنترنت من خلال تطبيق فيوجن.", "يمكنك الان التحويل من حملة إلي حملة بكل سهولة :)","امكانية التواصل مع  الدعم الفني بكل سهولة","اصبح بإمكانك الخروج من الأستخدام العادل بكل سهولة لمدة ثلاث مرات","رؤية كافة سجلات الاستخدام في حسابك","يمكنك فحص سرعتك بكل سهولة"]
    
    var gradiant: CAGradientLayer = {
        //Gradiant for the background view
        let blue = UIColor(red: 69/255, green: 127/255, blue: 202/255, alpha: 1.0).cgColor
        let purple = UIColor(red: 166/255, green: 172/255, blue: 236/255, alpha: 1.0).cgColor
        let gradiant = CAGradientLayer()
        gradiant.colors = [purple, blue]
        gradiant.startPoint = CGPoint(x: 0.5, y: 0.18)
        return gradiant
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gradient()
        
        swiftyOnboard = SwiftyOnboard(frame: view.frame, style: .light)
        view.addSubview(swiftyOnboard)
        swiftyOnboard.dataSource = self
        swiftyOnboard.delegate = self
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func gradient() {
        //Add the gradiant to the view:
        self.gradiant.frame = view.bounds
        view.layer.addSublayer(gradiant)
    }
    
    @objc func handleSkip() {
        swiftyOnboard?.goToPage(index: 6, animated: true)
    }
    
    @objc func handleContinue(sender: UIButton) {
        let index = sender.tag
        swiftyOnboard?.goToPage(index: index + 1, animated: true)
    }
}

extension ViewController: SwiftyOnboardDelegate, SwiftyOnboardDataSource {
    
    func swiftyOnboardNumberOfPages(_ swiftyOnboard: SwiftyOnboard) -> Int {
        //Number of pages in the onboarding:
        return 6
    }
    
//    func swiftyOnboardBackgroundColorFor(_ swiftyOnboard: SwiftyOnboard, atIndex index: Int) -> UIColor? {
//        //Return the background color for the page at index:
//        return colors[index]
//    }
//    
    func swiftyOnboardPageForIndex(_ swiftyOnboard: SwiftyOnboard, index: Int) -> SwiftyOnboardPage? {
        let view = SwiftyOnboardPage()
        
        //Set the image on the page:
        view.imageView.image = UIImage(named: "onboard\(index)")
        
        //Set the font and color for the labels:
        view.title.font = UIFont(name: "Lato-Heavy", size: 22)
        view.subTitle.font = UIFont(name: "Lato-Regular", size: 16)
        
        //Set the text in the page:
        view.title.text = titleArray[index]
        view.subTitle.text = subTitleArray[index]
        
        //Return the page for the given index:
        return view
    }
    
    func swiftyOnboardViewForOverlay(_ swiftyOnboard: SwiftyOnboard) -> SwiftyOnboardOverlay? {
        let overlay = SwiftyOnboardOverlay()
        
        //Setup targets for the buttons on the overlay view:
        overlay.skipButton.addTarget(self, action: #selector(handleSkip), for: .touchUpInside)
        overlay.continueButton.addTarget(self, action: #selector(handleContinue), for: .touchUpInside)
        
        //Setup for the overlay buttons:
        overlay.continueButton.titleLabel?.font = UIFont(name: "Lato-Bold", size: 16)
        overlay.continueButton.setTitleColor(UIColor.white, for: .normal)
        overlay.skipButton.setTitleColor(UIColor.white, for: .normal)
        overlay.skipButton.titleLabel?.font = UIFont(name: "Lato-Heavy", size: 16)
        
        //Return the overlay view:
        return overlay
    }
    
    func swiftyOnboardOverlayForPosition(_ swiftyOnboard: SwiftyOnboard, overlay: SwiftyOnboardOverlay, for position: Double) {
        let currentPage = round(position)
        overlay.pageControl.currentPage = Int(currentPage)
        print(Int(currentPage))
        overlay.continueButton.tag = Int(position)
        
        if currentPage == 0.0 || currentPage == 1.0 || currentPage == 2.0 || currentPage == 3.0 || currentPage == 4.0 {
            overlay.continueButton.setTitle("التالي", for: .normal)
            overlay.skipButton.setTitle("تخطي", for: .normal)
            overlay.skipButton.isHidden = false
        } else {
            overlay.continueButton.setTitle("الرجوع من البداية !", for: .normal)
            overlay.skipButton.isHidden = true
        }
    }
}

