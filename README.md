<details>
    <summary><h2>Uygulma Amacı</h2></summary>
    Proje Amacı
   kullanıcıların harf tahminleri yaparak gizli bir kelimeyi bulmalarını sağlamaktır. Kullanıcı, rastgele seçilen bir kelimenin harflerini tahmin etmeye çalışırken, doğru tahminler yaparak kelimenin tamamını ortaya çıkarmaya çalışır. Kullanıcıya belirli sayıda yanlış tahmin hakkı tanınır (bu örnekte 6 yanlış tahmin), bu nedenle stratejik düşünmek önemlidir.Uygulama, kullanıcıların eğlenceli bir şekilde kelime bilgilerini geliştirmelerine, harf tahminleri yaparak problem çözme becerilerini artırmalarına ve kelime dağarcıklarını genişletmelerine olanak tanır. Ayrıca, kullanıcıların doğru ve yanlış tahminlerini görüntüleyerek oyun sürecinin ilerleyişini takip etmelerini sağlar.
  </details> 
  

  <details>
    <summary><h2>startGame Metodu</h2></summary>
    Hata Sayısını Sıfırlama: Yanlış tahmin sayısı sıfırlanır.
    Kelime Seçimi: allWords dizisinden rastgele bir kelime seçilir. Eğer kelime seçilemezse varsayılan olarak "Eren" kullanılır.
    Gizli Kelime Dizisi Oluşturma: Gizli kelimenin uzunluğu kadar "?" karakteri içeren bir dizi oluşturulur.
    Başlık Güncelleme: Navigasyon barının başlığı gizli kelime dizisi olarak ayarlanır.
    Tahminlerin Temizlenmesi: Daha önceki tahminler temizlenir.
    Tablo Yeniden Yükleme: tableView güncellenir..
    
    ```
    func startGame(){
    hata = 0
    tahminEdilenKelime = allWords.randomElement() ?? "Eren"
    print(tahminEdilenKelime)

    tahminEdilenGizliKelimeArray = Array(repeating: "?", count: tahminEdilenKelime.count)
    title = String(tahminEdilenGizliKelimeArray)

    tutulankelime.removeAll()
    tableView.reloadData()
    }


    ```
  </details> 

  <details>
    <summary><h2>Tahmin İşlemi</h2></summary>
    Harf Sayısı Kontrolü: Kullanıcının sadece bir harf girmesi gerektiği kontrol edilir.
    Doğru Tahmin Kontrolü: Girilen harf, gizli kelimedeki harflerle karşılaştırılır. Doğruysa tahminEdilenGizliKelimeArray güncellenir.
    Tahmin Sonucu Kaydetme: Doğru tahminler tutulankelime dizisine eklenir. Yanlış tahminlerde hata sayısı artırılır.
    Oyun Sonu Kontrolü:
    Kazandıysa: Tüm harfler tahmin edildiyse kullanıcıya tebrik mesajı gösterilir ve oyun yeniden başlatılır.
    Kaybettiyse: 6 yanlış tahmin yapılmışsa kullanıcıya üzgün mesajı gösterilir ve oyun yeniden başlatılır.
    Tablo Yeniden Yükleme: Tahmin sonuçları tabloya yansıtılır.

    
    ```
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


    ```
  </details> 
  
<details>
    <summary><h2>Uygulama Görselleri </h2></summary>
    
    
 <table style="width: 100%;">
    <tr>
        <td style="text-align: center; width: 16.67%;">
            <h4 style="font-size: 14px;">Kelime Oyunu Harf Tahmini</h4>
            <img src="https://github.com/user-attachments/assets/d7ea8f9a-8d38-4b6b-bb17-90d1486ee9af" style="width: 100%; height: auto;">
        </td>
        <td style="text-align: center; width: 16.67%;">
            <h4 style="font-size: 14px;">Dogru tahmin Sonucu Kelime Guncellenmesi</h4>
            <img src="https://github.com/user-attachments/assets/fc53cb90-8d73-4bd9-bc14-3fec1dcecbc1" style="width: 100%; height: auto;">
        </td>
        <td style="text-align: center; width: 16.67%;">
            <h4 style="font-size: 14px;">Kullnici Fazladan Harf Girmek Isterse</h4>
            <img src="https://github.com/user-attachments/assets/4270182b-3813-4554-93f1-94471c8a6094" style="width: 100%; height: auto;">
        </td>
        <td style="text-align: center; width: 16.67%;">
            <h4 style="font-size: 14px;">Tahmin Hakki Doldugunda Oyun biter</h4>
            <img src="https://github.com/user-attachments/assets/08348c5a-d9dd-4bbb-8ddb-a80189b183c8" style="width: 100%; height: auto;">
        </td>
        <td style="text-align: center; width: 16.67%;">
            <h4 style="font-size: 14px;">Tum harfleri bulursa oyun biter</h4>
            <img src="https://github.com/user-attachments/assets/bd515256-f894-4e2f-b311-81a058405aea" style="width: 100%; height: auto;">
        </td>
    </tr>
</table>
  </details> 
