//
//  ViewController.swift
//  WordGuessingGameApp
//
//  Created by Eren Elçi on 12.10.2024.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    
    var allWords = [String]()
    var tahminEdilenKelime = ""
    var tahminEdilenGizliKelimeArray = [Character]()
    var dogrumu = false
    var tutulankelime = [String]()
    var hata: Int?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(tahminYapClicked))
        
        startGame()
        
    }
    func startGame(){
        hata = 0
        tahminEdilenKelime = allWords.randomElement() ?? "Eren"
        print(tahminEdilenKelime)
        
        tahminEdilenGizliKelimeArray = Array(repeating: "?", count: tahminEdilenKelime.count)
        title = String(tahminEdilenGizliKelimeArray)
        
        tutulankelime.removeAll()
        tableView.reloadData()
    }
    
    @objc func tahminYapClicked() {
        let alert = UIAlertController(title: "Hadi Bakalim", message: "tahmin icin bir adet harf giriniz", preferredStyle: .alert)
        alert.addTextField()
        
        let submit = UIAlertAction(title: "Tahmini Gonder", style: UIAlertAction.Style.cancel) { [weak self , weak alert ] _ in
            guard let answer = alert?.textFields?[0].text else { return }
            self?.submit(answer)
        }
        alert.addAction(submit)
        present(alert, animated: true)
    }
    
    func submit(_ answer: String) {
        if answer.count == 1 {
            
            for (index , harf) in tahminEdilenKelime.enumerated() {
                if harf.lowercased() == answer.lowercased() {
                    dogrumu = true
                    tahminEdilenGizliKelimeArray[index] = harf
                    title = String(tahminEdilenGizliKelimeArray)
                }
            }
            
            if dogrumu {
                tutulankelime.append("Dogru cevap: \(answer)")
                dogrumu = false
            } else {
                tutulankelime.append("Yanlis Cevap: \(answer)")
                hata! += 1
            }
            
        } else {
            makeAlert(title: "Uyari", message: "Bir adet harf giriniz lutfen")
        }
        
        if !tahminEdilenGizliKelimeArray.contains("?") {
            let alert = UIAlertController(title: "Tebrikler", message: "\(tahminEdilenKelime) Kelimesini dogru tahmin ettiniz ", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Yeniden Oyna", style: .cancel, handler: { [weak self] _ in
                self?.startGame()
            }))
            present(alert, animated: true)
        } else if hata == 6 {
            makeAlert(title: "Uzgunuz", message: " 6 Tahmin hakkin doldurdun sansini tekrar dene yeni bir kelime ile  ")
            self.startGame()
        }
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tutulankelime.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var context = cell.defaultContentConfiguration()
        context.text = tutulankelime[indexPath.row]
        cell.contentConfiguration = context
        return cell
    }
    
    func makeAlert(title: String , message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        ac.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.cancel, handler: nil))
        present(ac, animated: true)
    }
    


}

