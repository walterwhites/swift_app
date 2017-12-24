import UIKit
import CoreGraphics
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    
    
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var audioPlayer:AVAudioPlayer!
    
    
    fileprivate var items = [Character]()
    
    fileprivate var currentPage: Int = 0 {
        didSet {
            let character = self.items[self.currentPage]

            if self.infoLabel?.text != nil {
                self.infoLabel.text = character.name.uppercased()
                print("test " + "\(self.infoLabel.text!)")
            }
            if self.detailLabel?.text != nil {
                self.detailLabel.text = character.onomatope.uppercased()
                print("test " + "\(self.detailLabel.text!)")
            }
        }
    }
    
    fileprivate var pageSize: CGSize {
        let layout = self.collectionView.collectionViewLayout as! UPCarouselFlowLayout
        var pageSize = layout.itemSize
        if layout.scrollDirection == .horizontal {
            pageSize.width += layout.minimumLineSpacing
        } else {
            pageSize.height += layout.minimumLineSpacing
        }
        return pageSize
    }
    
    fileprivate var orientation: UIDeviceOrientation {
        return UIDevice.current.orientation
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupLayout()
        self.items = self.createItems()
        self.currentPage = 0
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.rotationDidChange), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    @IBAction func playSound(sender: UIButton) {
        var audioFilePath = NSBundle.mainBundle().pathForResource("lion", ofType: "mp3")
        if audioFilePath != nil {
            var audioFileUrl = NSURL.fileURLWithPath(audioFilePath!)
            audioPlayer = AVAudioPlayer(contentsOfURL: audioFileUrl, error: nil)
            audioPlayer.play()
        } else {
            println("audio file is not found")
        }
    }
    
    fileprivate func setupLayout() {
        let layout = self.collectionView.collectionViewLayout as! UPCarouselFlowLayout
        layout.spacingMode = UPCarouselFlowLayoutSpacingMode.overlap(visibleOffset: 30)
    }
    
    fileprivate func createItems() -> [Character] {
        let characters = [
            Character(imageName: "lion", name: "lion", onomatope: "Rrrrrrhhrhhrhhrh"),
            Character(imageName: "poisson", name: "poisson", onomatope: "Glouglou"),
            Character(imageName: "chat", name: "chat", onomatope: "miaou"),
            Character(imageName: "chien", name: "chien", onomatope: "ouaffff")
        ]
        return characters
    }
    
    @objc fileprivate func rotationDidChange() {
        guard !orientation.isFlat else { return }
        let layout = self.collectionView.collectionViewLayout as! UPCarouselFlowLayout
        let direction: UICollectionViewScrollDirection = UIDeviceOrientationIsPortrait(orientation) ? .horizontal : .vertical
        layout.scrollDirection = direction
        if currentPage > 0 {
            let indexPath = IndexPath(item: currentPage, section: 0)
            let scrollPosition: UICollectionViewScrollPosition = UIDeviceOrientationIsPortrait(orientation) ? .centeredHorizontally : .centeredVertically
            self.collectionView.scrollToItem(at: indexPath, at: scrollPosition, animated: false)
        }
    }
    
    // MARK: - Card Collection Delegate & DataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselCollectionViewCell.identifier, for: indexPath) as! CarouselCollectionViewCell
        let character = items[(indexPath as NSIndexPath).row]
        cell.image.image = UIImage(named: character.imageName)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let character = items[(indexPath as NSIndexPath).row]
        let alert = UIAlertController(title: character.name, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: - UIScrollViewDelegate
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let layout = self.collectionView.collectionViewLayout as! UPCarouselFlowLayout
        let pageSide = (layout.scrollDirection == .horizontal) ? self.pageSize.width : self.pageSize.height
        let offset = (layout.scrollDirection == .horizontal) ? scrollView.contentOffset.x : scrollView.contentOffset.y
        currentPage = Int(floor((offset - pageSide / 2) / pageSide) + 1)
    }
}



