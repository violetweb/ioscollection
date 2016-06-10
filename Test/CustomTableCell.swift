
import UIKit


//CREATE YOUR STUCT TO REPRESENT EACH OF THE ITEMS YOU WANT TO HAVE
// IN THE TABLE.
struct ItemModel {
    let title : String
    let para : String
    let button : String
}

class CustomTableCell: UITableViewCell {
    
    
    private lazy var titleLabel : UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 1
        lbl.font = UIFont.systemFontOfSize(13.0)
        lbl.frame = CGRectMake(0.0, 0.0, 220.0, 85.0)
        lbl.textAlignment = .Right;
        lbl.textColor = UIColor.grayColor()
        return lbl
    } ()
    
    private lazy var paraLabel : UILabel = {
        let lbl = UILabel()
       // lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0 //unlimited
        lbl.textColor = UIColor.darkGrayColor()
        lbl.frame = CGRectMake(0.0, 70.0, 220.0, 85.0)
        lbl.font = UIFont.systemFontOfSize(11.0)
        return lbl
    } ()
    
    private lazy var topSpacerView : UIView = {
        let view = UIView()
      //  view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    
    private lazy var buttonView : UIButton = {
        let btn = UIButton()
        btn.layer.backgroundColor = UIColor.blueColor().CGColor
        btn.frame = CGRectMake(0,0,100,45)
        btn.layer.cornerRadius = 10
        btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        return btn
    } ()
    
    
    private lazy var spacerView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    
    private lazy var bottomSpacerView : UIView = {
        let view = UIView()
       // view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    
      
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    

    
    private func addSubviews() {

        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.topSpacerView)
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.spacerView)
        self.contentView.addSubview(self.paraLabel)
        self.contentView.addSubview(self.bottomSpacerView)
        self.contentView.addSubview(self.buttonView)
        self.setLayoutConstraints()
    }
    
    private func setLayoutConstraints() {
        let views = ["qn":self.titleLabel,"ans":self.paraLabel,"view":self.spacerView,"top":self.topSpacerView,"btm":self.bottomSpacerView,"btn":self.buttonView]
        
    }
    
    //Optional Expandable field... change to something else if required.
    // Expects to receive an array of items in its entirety.
    func setCellContent(item : ItemModel, isExpanded : Bool) {
        self.titleLabel.text = item.title
        self.paraLabel.text = !isExpanded ? item.para : ""
        self.buttonView.setBackgroundImage(UIImage(named: item.button), forState: .Normal)
        self.setNeedsDisplay()
    }
    
    func cellContentHeight()->CGFloat {
        return self.titleLabel.intrinsicContentSize().height + self.paraLabel.intrinsicContentSize().height + 35.0
    }
    
}