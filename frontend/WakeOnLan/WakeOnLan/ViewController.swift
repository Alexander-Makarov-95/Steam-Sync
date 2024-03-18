import UIKit
import Kingfisher

struct Game: Codable {
    let game_id: Int
    let name: String
    let image_url: String
}

class GameCell: UICollectionViewCell {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .black
        label.numberOfLines = 0 // Allow multiple lines for the text
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var gameID: Int?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupTapGestureRecognizer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
        setupTapGestureRecognizer()
    }
    
    private func setupViews() {
        addSubview(imageView)
        addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupTapGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func imageViewTapped() {
        guard let gameID = gameID else {
            return
        }
        let popupViewController = GamePopupViewController(gameID: gameID)
        popupViewController.modalPresentationStyle = .overCurrentContext
        popupViewController.modalTransitionStyle = .crossDissolve
        viewController()?.present(popupViewController, animated: true, completion: nil)
    }
    
    private func viewController() -> UIViewController? {
        var responder: UIResponder? = self
        while responder != nil {
            if let viewController = responder as? UIViewController {
                return viewController
            }
            responder = responder?.next
        }
        return nil
    }
}

class ViewController: UIViewController, UICollectionViewDataSource {
    var collectionView: UICollectionView!
    var games: [Game] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        fetchGames()
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let itemSpacing: CGFloat = 10
        let itemsInRow: CGFloat = 2
        let totalSpacing: CGFloat = itemSpacing * (itemsInRow - 1)
        let itemWidth = (view.bounds.width - totalSpacing) / itemsInRow
        let itemHeight = itemWidth + 40 // Adjust the value as needed to accommodate the text
        
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.minimumInteritemSpacing = itemSpacing
        layout.minimumLineSpacing = itemSpacing
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.register(GameCell.self, forCellWithReuseIdentifier: "GameCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func fetchGames() {
        if let url = URL(string: "http://192.168.1.2:3000/games") {
            let session = URLSession.shared
            let task = session.dataTask(with: url) { [weak self] (data, response, error) in
                if let error = error {
                    DispatchQueue.main.async {
                        // Handle the error appropriately
                        print("Error: \(error)")
                    }
                } else if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let games = try decoder.decode([Game].self, from: data)
                        self?.games = games
                        DispatchQueue.main.async {
                            self?.collectionView.reloadData()
                        }
                    } catch {
                        DispatchQueue.main.async {
                            // Handle the error appropriately
                            print("Error: \(error)")
                        }
                    }
                }
            }
            task.resume()
        } else {
            let error = NSError(domain: "Invalid URL", code: 0, userInfo: nil)
            // Handle the error appropriately
            print("Error: \(error)")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameCell", for: indexPath) as! GameCell
        let game = games[indexPath.item]
        
        if let url = URL(string: game.image_url) {
            cell.imageView.kf.setImage(with: url)
        }
        
        cell.nameLabel.text = game.name
        cell.gameID = game.game_id // Set the game ID for the cell
        
        return cell
    }
}

//test
