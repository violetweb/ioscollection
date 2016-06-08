import UIKit


/// Get the Pod Bundle
public class BundleUtil:NSObject{
    
    
    /// Gets the bundle property for the pod
    public static var bundle:NSBundle{
        
        get{
            
            //Get the bundle
            var bundle = NSBundle(forClass: self.classForCoder())
            
            //Trys to load the path to resource(In case we are calling this from the pod)
            if let bundlePath:String = bundle.pathForResource("PasswordTextField", ofType: "bundle")
            {
                //If we get the path to resource, set the bundle path
                bundle =  NSBundle(path: bundlePath)!
                
            }
            
            return bundle
        }
    }
    
    
}

/// The Segure text button toggle shown in the right side of the textfield
public class SecureTextToggleButton: UIButton {
    
    
    private let RightMargin:CGFloat = 10.0
    private let Width:CGFloat = 20.0
    private let Height:CGFloat = 20.0
    
    /// Sets the value for the secure or note secure toggle and
    dynamic public var isSecure:Bool = true{
        
        didSet{
            
            if isSecure{
                setVisibilityOn()
            }
            else
            {
                setVisibilityOff()
            }
        }
    }
    
    /// Image to shown when the visibility is on
    public var showSecureTextImage:UIImage = UIImage(named: "visibility_on", inBundle: BundleUtil.bundle, compatibleWithTraitCollection: nil)!{
        
        didSet{
            self.setImage(showSecureTextImage.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate),forState: .Normal)
        }
        
    }
    
    /// Image to shown when the visibility is off
    public var hideSecureTextImage:UIImage = UIImage(named: "visibility_off", inBundle: BundleUtil.bundle, compatibleWithTraitCollection: nil)!
    
    
    /// Tint of the image
    public var imageTint:UIColor = UIColor.grayColor(){
        didSet{
            self.tintColor = imageTint
        }
    }
    
    
    /**
     Convenience init that can be set to initialize the object with visible on image visible off image and image tint
     
     - parameter visibilityOnImage:  Visible on Image
     - parameter visibilityOffImage: Visible off Image
     - parameter imageTint:          The tint of the image
     
     - returns:
     */
    public convenience init(showSecureTextImage:UIImage = UIImage(named: "visibility_on", inBundle:BundleUtil.bundle, compatibleWithTraitCollection: nil)! , hideSecureTextImage:UIImage = UIImage(named: "visibility_off", inBundle: BundleUtil.bundle, compatibleWithTraitCollection: nil)! , imageTint:UIColor = UIColor.grayColor())
    {
        self.init(frame:CGRectZero)
        
        self.showSecureTextImage = showSecureTextImage
        
        self.hideSecureTextImage = hideSecureTextImage
        
        self.imageTint = imageTint
    }
    
    
    public override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        setup()
        
    }
    
    public required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        
        setup()
        
    }
    
    
    /**
     Initialize properties and values
     */
    func setup()
    {
        
        //Initialize the frame and adds a right margin
        self.frame = CGRect(x: 0, y: -0, width: showSecureTextImage.size.width+RightMargin, height: showSecureTextImage.size.height)
        
        //Sets the tint color
        self.tintColor = imageTint
        
        //Sets the aspect fit of the image
        self.contentMode = UIViewContentMode.ScaleAspectFit
        self.backgroundColor = UIColor.clearColor()
        
        //Initialize the component with the secure state
        isSecure = true
        
        //Sets the button target
        self.addTarget(self, action: "buttonTouch", forControlEvents: .TouchUpInside)
        
    }
    
    /**
     Updates the image and the set the visibility on icon
     */
    func setVisibilityOn()
    {
        self.setImage(showSecureTextImage.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate),forState: .Normal)
    }
    
    
    /**
     Update teh image and sets the visibility off icon
     */
    func setVisibilityOff()
    {
        self.setImage(hideSecureTextImage.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate),forState: .Normal)
    }
    
    /**
     Toggle the icon
     */
    public func buttonTouch()
    {
        self.isSecure = !self.isSecure
    }
    
}


public protocol Ruleable {
    func validate(value: String) -> Bool
    func errorMessage() -> String
}


// Basic structure that represent a Regex Rule
public class RegexRule : Ruleable {
    
    /// Default regex
    private var REGEX: String = "^(?=.*?[A-Z]).{8,}$"
    /// Error message
    private var message : String
    
    
    /**
     Default constructor
     
     - parameter regex:   regex of the rule
     - parameter message: errorMessage
     
     - returns: <#return value description#>
     */
    public init(regex: String, errorMessage: String = "Invalid Regular Expression"){
        self.REGEX = regex
        self.message = errorMessage
    }
    
    /**
     Validates if the rule works matches
     
     - parameter value: String value to validate againts a rule
     
     - returns: if the rule is valid or not
     */
    public func validate(value: String) -> Bool {
        let test = NSPredicate(format: "SELF MATCHES %@", self.REGEX)
        return test.evaluateWithObject(value)
    }
    
    /**
     Returns the error message
     
     - returns: <#return value description#>
     */
    public func errorMessage() -> String {
        return message
    }
    
    
    
}

public class PasswordRule : RegexRule {
    
    // Other Regexes that you can se
    
    // 8 characters. One uppercase. One Lowercase. One number.
    // static let regex = "^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[a-z]).{8,}$"
    //
    // no length. One uppercase. One lowercae. One number.
    // static let regex = "^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[a-z]).*?$"
    
    // 8 characeters. One uppercase.
    //^(?=.*?[A-Z]).{8,}$
    
    static let regex = "^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[a-z]).{8,}$"
    
    public convenience init(message : String = "Your password must be at least 8 characters long and contain one uppercase letter and one number") {
        self.init(regex: PasswordRule.regex, errorMessage : message)
    }
}

//  A custom TextField with a switchable icon which shows or hides the password
public class PasswordTextField: UITextField {
    
    //KVO Context
    private var kvoContext: UInt8 = 0
    
    /// Enums with the values of when to show the secure or insecure text button
    public enum ShowButtonWhile: String {
        case Editing = "editing"
        case Always = "always"
        case Never = "never"
        
        var textViewMode: UITextFieldViewMode {
            switch self{
                
            case .Editing:
                return UITextFieldViewMode.WhileEditing
                
            case .Always:
                return UITextFieldViewMode.Always
                
            case .Never:
                return UITextFieldViewMode.Never
                
            }
        }
    }
    
    
    /**
     Default initializer for the textfield
     
     - parameter frame: fra me of the view
     
     - returns:
     */
    public override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        setup()
        
    }
    
    /**
     Default initializer for the textfield done from storyboard
     
     - parameter coder: coder
     
     - returns:
     */
    public required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        
        setup()
        
    }
    
    /// When to show the button defaults to only when editing
    public var showButtonWhile = ShowButtonWhile.Editing{
        
        didSet{
            self.rightViewMode = self.showButtonWhile.textViewMode
        }
        
    }
    
    /// The rule to apply to the validation password rule
    public var validationRule: RegexRule = PasswordRule()
    
    
    /**
     *  Shows the toggle button while editing, never, or always. The possible values to set are "editing", "never", "always
     */
    @available(*, unavailable, message="This property is reserved for Interface Builder. Use 'showButtonWhile' instead.")
    @IBInspectable var showToggleButtonWhile: String? {
        willSet {
            if let newShow = ShowButtonWhile(rawValue: newValue?.lowercaseString ?? "") {
                self.showButtonWhile = newShow
            }
        }
    }
    
    /// Convenience var to change teh border width
    @IBInspectable  dynamic public var borderWidth: CGFloat = 0 { didSet { self.layer.borderWidth = borderWidth } }
    /// Convenience var to change the corner radius
    @IBInspectable dynamic public var cornerRadius: CGFloat = 0 { didSet { self.layer.cornerRadius = cornerRadius } }
    
    /**
     The color of the image.
     
     This property applies a color to the image. The default value for this property is gray.
     */
    @IBInspectable public var imageTintColor: UIColor = UIColor.grayColor() {
        didSet {
            
            self.secureTextButton.tintColor = imageTintColor
        }
    }
    
    
    /**
     The image to show the secure text
     */
    @IBInspectable public var customShowSecureTextImage: UIImage? {
        
        didSet{
            
            if let image = customShowSecureTextImage
            {
                self.secureTextButton.showSecureTextImage = image
            }
        }
    }
    
    
    /**
     The image to hide the secure text
     */
    @IBInspectable public var customHideSecureTextImage: UIImage? {
        
        didSet{
            
            if let image = customHideSecureTextImage
            {
                self.secureTextButton.hideSecureTextImage = image
            }
            
        }
    }
    
    /**
     Initialize properties and values
     */
    func setup()
    {
        self.secureTextEntry = true
        self.autocapitalizationType = .None
        self.autocorrectionType = .No
        self.keyboardType = .ASCIICapable
        self.rightViewMode = self.showButtonWhile.textViewMode
        self.rightView = self.secureTextButton
        
        self.secureTextButton.addObserver(self, forKeyPath: "isSecure", options: NSKeyValueObservingOptions.New, context: &kvoContext)
    }
    
    
    /// retuns if the textfield is secure or not
    public var isSecure: Bool{
        get{
            return secureTextEntry
        }
    }
    
    public lazy var secureTextButton: SecureTextToggleButton = {
        
        return SecureTextToggleButton(imageTint: self.imageTintColor)
        
    }()
    
    /**
     Toggle the secure text view or not
     */
    public func setSecureMode(secure:Bool)
    {
        
        self.resignFirstResponder()
        self.secureTextEntry = secure
        
        /// Kind of ugly hack to make the text refresh after the toggle. The size of the secure fonts are different than the normal ones and it shows trailing white space
        let tempText = self.text;
        self.text = " ";
        self.text = tempText;
        
        self.becomeFirstResponder()
        
    }
    
    /**
     Checks if the password typed is valid
     
     - returns: valid password of not
     */
    public func isValid() -> Bool{
        
        var returnValue = false
        
        if let text = self.text{
            returnValue = validationRule.validate(text)
        }
        
        return returnValue
    }
    
    /**
     Convenience function to check if the validation is invalid
     
     - returns: true if the validation is invalid
     */
    public func isInvalid() ->Bool {
        
        return !isValid()
    }
    
    /**
     Returns the error message of the validation rule setted
     
     - returns: error message
     */
    public func errorMessage() -> String{
        
        return validationRule.errorMessage()
    }
    
    
    public override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        if context == &kvoContext {
            
            
            if context == &kvoContext {
                
                self.setSecureMode(self.secureTextButton.isSecure)
                
                
            } else {
                super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
            }
        }
    }
    
    deinit {
        self.secureTextButton.removeObserver(self, forKeyPath: "isSecure")
    }
    
    
}