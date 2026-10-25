# 8-bit Aritmetik Mantık Birimi (ALU) Tasarımı ve Doğrulaması

Verilog kullanılarak sıfırdan tasarlanan ve **132.072 otomatik test senaryosundan** sıfır hatayla (`0 errors`) başarıyla geçmiş 8-bitlik ALU projesi.

## 📐 Tasarım Mimarisi ve Geliştirme Sırası
Proje, katı bir aşağıdan yukarıya  ve modüler tasarım yaklaşımıyla şu sıra izlenerek inşa edilmiştir:
1. **Full Adder (Tam Toplayıcı):** Temel toplama biriminin ilk taşı.
2. **8-bit Full Adder:** 1-bitlik toplayıcıların zincirleme bağlanmasıyla elde edilen 8-bitlik toplama/çıkarma bloğu.
3. **Lojik Kapılar:** AND, OR, XOR, NOT gibi temel mantıksal işlemler.
4. **MUX ve Birleşim:** Tüm bu birimlerin Multiplexer (MUX) yardımıyla kontrol sinyallerine göre birleştirilmesi.
5. **Bayraklar (Flags):** `zero_flag`, `negative_flag` ve `elde` (carry) denetim mekanizmaları.

## 🚀 Doğrulama ve Testbench Başarısı
Proje, Intel Quartus Prime ve QuestaSim ortamında kapsamlı stres testlerine tabi tutulmuştur:
- **Tam Matris Testleri:** 256x256 tüm olası 8-bit toplama ve çıkarma kombinasyonları.
- **Rastgele Testler:** Donanımın sınırlarını zorlayan dinamik senaryolar.
- **Sonuç:** Toplam **132.072 testin tamamı** hatasız (`0 errors`) tamamlanmıştır.

## 📊 Simülasyon Çıktısı
![Simülasyon Sonucu](simulation.jpg)

## 🛠️ RTL Donanım Şeması
Quartus Prime üzerinden alınan top-level RTL şeması:
![RTL Şeması](rtlsema.jpg)

## 🧰 Kullanılan Araçlar
- **Tasarım & Sentez:** Intel Quartus Prime
- **Simülasyon:** Questa - Intel FPGA Starter Edition
- **Dil:** Verilog
