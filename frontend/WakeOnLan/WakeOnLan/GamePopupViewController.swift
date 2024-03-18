import UIKit

class GamePopupViewController: UIViewController {
    let gameID: Int // Added property to store the game ID
    
    init(gameID: Int) {
        self.gameID = gameID
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        let popupView = UIView()
        popupView.backgroundColor = .white
        popupView.layer.cornerRadius = 8
        popupView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(popupView)
        
        let closeButton = UIButton(type: .system)
        closeButton.setTitle("Close", for: .normal)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        popupView.addSubview(closeButton)
        
        let runButton = UIButton(type: .system)
        runButton.setTitle("Run", for: .normal)
        runButton.addTarget(self, action: #selector(runButtonTapped), for: .touchUpInside)
        runButton.translatesAutoresizingMaskIntoConstraints = false
        popupView.addSubview(runButton)
        
        let killButton = UIButton(type: .system)
        killButton.setTitle("Kill", for: .normal)
        killButton.addTarget(self, action: #selector(killButtonTapped), for: .touchUpInside)
        killButton.translatesAutoresizingMaskIntoConstraints = false
        popupView.addSubview(killButton)
        
        NSLayoutConstraint.activate([
            popupView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            popupView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            popupView.widthAnchor.constraint(equalToConstant: 250),
            
            closeButton.topAnchor.constraint(equalTo: popupView.topAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -16),
            
            runButton.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 16),
            runButton.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 16),
            runButton.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -16),
            
            killButton.topAnchor.constraint(equalTo: runButton.bottomAnchor, constant: 8),
            killButton.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 16),
            killButton.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -16),
            killButton.bottomAnchor.constraint(equalTo: popupView.bottomAnchor, constant: -16)
        ])
    }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func runButtonTapped() {
        let urlString = "http://192.168.1.2:3000/runGame/\(gameID)" // Construct the API URL with the game ID
        if let url = URL(string: urlString) {
            let session = URLSession.shared
            let task = session.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    DispatchQueue.main.async {
                        // Handle the error appropriately
                        print("Error: \(error)")
                    }
                } else if let data = data {
                    if let responseString = String(data: data, encoding: .utf8) {
                        DispatchQueue.main.async {
                            // Print the response string
                            print("Response: \(responseString)")
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

    
    @objc private func killButtonTapped() {
        // Handle "Kill" button action
    }
}
