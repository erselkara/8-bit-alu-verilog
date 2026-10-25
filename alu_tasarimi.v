module alu_tasarimi(
	input [7:0] a,
    input [7:0] b,
    input sub,            // Toplama veya çıkarma seçimi için
    input [3:0] sel,      // Hangi işlemin seçileceği (4 bit: 10 farklı işlem için)
    output reg [7:0] alu_out, // atama bu yüzden reg
    output elde,          // Toplayıcıdan gelen elde bayrağı
    output zero_flag,     // Sonuç 0 ise 1 olan bayrak
    output negative_flag  // Sonuç negatif ise 1 olan bayrak
);
	wire [7:0] adder_sonuc ; // adder sonuc kablosu çağırmak için kullanıyoruz.
	wire [7:0] and_sonuc , or_sonuc , xor_sonuc , nand_sonuc , notor_sonuc, xnor_sonuc , nota_sonuc , notb_sonuc;
	
	bit8_fulladder toplayici (
	.giris(a),
	.giris1(b),
	.sub(sub),
	.toplam(adder_sonuc),
   .elde(elde)
);

	lojik_kapilar lojik_birim (
	.a(a),
	.b(b),
	.and_gate(and_sonuc),
	.or_gate(or_sonuc),
	.xor_gate(xor_sonuc),
	.nand_gate(nand_sonuc),
	.notor_gate(notor_sonuc),
	.xnor_gate(xnor_sonuc),
	.nota_gate(nota_sonuc),
	.notb_gate(notb_sonuc)
);

	always @(*) begin
		case(sel) // mux sonuçları tanımlandı
			4'b0000: alu_out = adder_sonuc;
		
			4'b0001: alu_out = and_sonuc;
			4'b0010: alu_out = or_sonuc;
			4'b0011: alu_out = xor_sonuc;
			4'b0100: alu_out = nand_sonuc;
			4'b0101: alu_out = notor_sonuc;
			4'b0110: alu_out = xnor_sonuc;
			4'b0111: alu_out = nota_sonuc;
			4'b1000: alu_out = notb_sonuc;
		  default: alu_out = 8'b00000000;
		endcase
	end
	assign zero_flag  = (alu_out == 8'b00000000);
	assign negative_flag = alu_out[7]; // MSB bitine  bak negatif mi değil mi karar ver
	
endmodule

module fulladder(
	input x,y,cin, // elde girişi x ve y
	output s,c   // sub and cin

);

assign s = x ^ y ^ cin;  // toplam fonksiyonu tanımlanmıştır
assign c = (x & y) | (x & cin) | (y & cin); // elde fonksiyonu tanımlanmıştır


endmodule // fulladder bitişi

module bit8_fulladder( // 8 bitlik fulladder
	input [7:0] giris,
	input [7:0] giris1,
	input sub, // toplama ve cıkarma işlemleri icin
	output [7:0] toplam,
	output  elde
	
);
	wire c0 = sub;
	wire c1,c2,c3,c4,c5,c6,c7;
	wire [7:0] giris1_xored;
	assign giris1_xored = giris1 ^ {8{sub}};
	

fulladder fa0( .x(giris[0]), .y(giris1_xored[0]) , .cin(c0), .s(toplam[0]) , .c(c1)
);
fulladder fa1( .x(giris[1]), .y(giris1_xored[1]) , .cin(c1), .s(toplam[1]) , .c(c2)
);
fulladder fa2( .x(giris[2]), .y(giris1_xored[2]) , .cin(c2), .s(toplam[2]) , .c(c3)
);
fulladder fa3( .x(giris[3]), .y(giris1_xored[3]) , .cin(c3), .s(toplam[3]) , .c(c4)
);
fulladder fa4( .x(giris[4]), .y(giris1_xored[4]) , .cin(c4), .s(toplam[4]) , .c(c5)
);
fulladder fa5( .x(giris[5]), .y(giris1_xored[5]) , .cin(c5), .s(toplam[5]) , .c(c6)
);
fulladder fa6( .x(giris[6]), .y(giris1_xored[6]) , .cin(c6), .s(toplam[6]) , .c(c7)
);
fulladder fa7( .x(giris[7]), .y(giris1_xored[7]) , .cin(c7), .s(toplam[7]) , .c(elde)
);

endmodule	

module lojik_kapilar(
	input [7:0] a ,
	input [7:0] b ,
	output [7:0] and_gate,
	output [7:0] or_gate,
	output [7:0] xor_gate,
	output [7:0] nand_gate,    // lojik devre kodlamaları 
	output [7:0] notor_gate,
	output [7:0] xnor_gate,
	output [7:0] nota_gate,
	output [7:0] notb_gate
);

	assign and_gate = a & b ;
	assign or_gate = a | b ;
	assign xor_gate = a ^ b ;
	assign nand_gate = ~(a & b) ;
	assign notor_gate = ~(a | b) ;
	assign xnor_gate = ~(a ^ b) ;
	assign nota_gate = ~(a) ;
	assign notb_gate = ~(b) ;
	
endmodule












	