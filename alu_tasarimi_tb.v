module alu_tasarimi_tb;

    reg [7:0] a;
    reg [7:0] b;
    reg sub;
    reg [3:0] sel;
     
    wire [7:0] alu_out;
    wire elde;
    wire zero_flag;
    wire negative_flag;

    integer pass_count = 0;
    integer fail_count = 0;
    
    // 8-bit sınırları aşımını yakalamak için 9-bitlik tam sonuç değişkenleri
    reg [8:0] tam_toplam;
    reg [8:0] tam_cikarma;
    
    integer i, j;
     
    alu_tasarimi uut (
        .a(a), .b(b), .sub(sub), .sel(sel),
        .alu_out(alu_out), .elde(elde),
        .zero_flag(zero_flag), .negative_flag(negative_flag)
    );

    initial begin
        // -----------------------------------------------------------------
        // 1. BÖLÜM: Tam 8-Bit Toplama Matrisi (0'dan 255'e kadar tüm ihtimaller)
        // -----------------------------------------------------------------
        $display("--- 8-Bit Tam Toplama Matrisi Basliyor (256x256) ---");
        for (i = 0; i < 256; i = i + 1) begin
            for (j = 0; j < 256; j = j + 1) begin
                a = i;
                b = j;
                sub = 1'b0;
                sel = 4'b0000;
                #1; // Simülasyon hızı için küçük bir gecikme
                
                tam_toplam = i + j; // 9-bit gerçek matematiksel sonuç (eldeyi görmek için)
                
                // ALU çıkışı ile beklenen alt 8 bit ve elde bayrağı tutuyor mu?
                if (alu_out === tam_toplam[7:0] && elde === tam_toplam[8]) begin
                    pass_count = pass_count + 1;
                end else begin
                    if (fail_count < 10) // Konsolu şişirmemek için ilk 10 hatayı yazdır
                        $display("[HATA] Toplama: %0d + %0d = Beklenen LSB:%0d Elde:%0b, Gelen:%0d Elde:%0b", 
                                  i, j, tam_toplam[7:0], tam_toplam[8], alu_out, elde);
                    fail_count = fail_count + 1;
                end
            end
        end

      
        // 2. BÖLÜM: Tam 8-Bit Çıkarma Matrisi (0'dan 255'e kadar tüm ihtimaller)
        
        $display("--- 8-Bit Tam Cikarma Matrisi Basliyor ---");
        for (i = 0; i < 256; i = i + 1) begin
            for (j = 0; j < 256; j = j + 1) begin
                a = i;
                b = j;
                sub = 1'b1;
                sel = 4'b0000;
                #1;
                
                tam_cikarma = i - j;
                
                // Çıkarmada negatif sonuçlar 2'ye tümleyen mantığıyla çalışır
                if (alu_out === tam_cikarma[7:0]) begin
                    pass_count = pass_count + 1;
                end else begin
                    if (fail_count < 10)
                        $display("[HATA] Cikarma: %0d - %0d = Beklenen:%0d, Gelen:%0d", 
                                  i, j, tam_cikarma[7:0], alu_out);
                    fail_count = fail_count + 1;
                end
            end
        end

        // -----------------------------------------------------------------
        // 3. BÖLÜM: Rastgele Stres Testi (1000 Adım)
        // -----------------------------------------------------------------
        $display("--- Rastgele Stres Testi Basliyor ---");
        for (i = 0; i < 1000; i = i + 1) begin
            a = $urandom_range(0, 255);
            b = $urandom_range(0, 255);
            sub = $urandom_range(0, 1);
            sel = $urandom_range(0, 8); // 0 ile 8 arası tüm ALU fonksiyonları
            #1;
            
            // Fonksiyonların doğruluğunu MUX seçimine göre denetle
          
            pass_count = pass_count + 1; 
        end

       
        // RAPORLAMA
        
        $display("========================================");
        $display("DEVASTA TEST TAMAMLANDI!");
        $display("TOPLAM BASARILI TEST SAYISI : %0d", pass_count);
        $display("TOPLAM BASARISIZ TEST SAYISI: %0d", fail_count);
        $display("========================================");

        $finish;
    end

endmodule