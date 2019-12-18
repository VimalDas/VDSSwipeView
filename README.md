# VDSSwipeView


1. Drag UIView onto storyboard change its class to 

                  VDSSwipeView

2. create an outlet .
                           
                  @IBOutlet weak var swipeView: VDSSwipeView!


3. give view controllers with titles

                  let vc1 = self.storyboard?
                      .instantiateViewController(withIdentifier: "2") as! ViewController2
                  let vc2 = self.storyboard?
                      .instantiateViewController(withIdentifier: "3") as! ViewControlle3
                  
                  swipeView.setup(in: self, withTitles: ["Swipe", ":D"], ofViewControllers: [vc1, vc2])
                                              
        
        
THATS IT ENJOYY!!!
        

<a href="https://imgflip.com/gif/3jszyd"><img src="https://i.imgflip.com/3jszyd.gif" title="made at imgflip.com"/></a>
