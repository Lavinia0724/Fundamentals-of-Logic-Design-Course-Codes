module exercise(
// Clock Input (50 MHz)
	input  CLOCK_50,
	//  Push Buttons
	input  [3:0]  KEY,
	//  DPDT Switches 
	input  [17:0]  SW,
	//  7-SEG Displays
	output  [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7,
	//  LEDs
	output  [8:0]  LEDG, 
	 //  LED Green[8:0]
	output  [17:0]  LEDR, 
	//  LED Red[17:0]
	output [3:0] result1,result2,result3,result4,
	output f1,f2,f3,f4,
	//  GPIO Connections
	inout[35:0]  GPIO_0, GPIO_1);
	//  set all inoutports to tri-state
	assign  GPIO_0    =  36'hzzzzzzzzz;
	assign  GPIO_1    =  36'hzzzzzzzzz;
	// Connect dip switches to red LEDs
	assign LEDR[17:0] = SW[17:0];
	assign LEDR[17]= SW[17];
	assign LEDR[16] = SW[16]
	// turn off green LEDs
	assign LEDG[8:0] = 0;
	wire [15:0] A;
	// map to 7-segment displays
    mycircuit(A[3],A[2],A[1],A[0],f1,f2,f3,f4,f5,f6,f7,f8);
    assign result1[7] = f1;
    assign result1[6] = f2;
    assign result1[5] = f3;
    assign result1[4] = f4;
    assign result1[3] = f5;
    assign result1[2] = f6;
    assign result1[1] = f7;
    assign result1[0] = f8;
	hex_7seg(result1,HEX0);   
	// We are calling a module called hex_7seg
	assign HEX1 = blank;
	assign HEX2 = blank;
	assign HEX3 = blank;
	wire [6:0] blank = ~7'h00; 
	// blank remaining digits
	assign HEX4 = blank;
	assign HEX5 = blank;
	assign HEX6 = blank;
	assign HEX7 = blank;
	// control (set) value of A, signal with KEY3
	//always @(negedgeKEY[3])
	//    A <= SW[15:0];
	assign A = SW[15:0];
	endmodule

module hex_7seg(hex_digit,seg);
    input [3:0] hex_digit;
    output [6:0] seg;
    reg[6:0] seg;
    // seg= {g,f,e,d,c,b,a};
    // // 0 is on and 1 is off
    always @ (hex_digit)
    case (hex_digit)
        4'h0: seg= ~7'h3F;
        4'h1: seg= ~7'h06;     //   ---a----
        4'h2: seg= ~7'h5B;     // |           |
        4'h3: seg= ~7'h4F;     // f          b
        4'h4: seg= ~7'h66;     // |           |
        4'h5: seg= ~7'h6D;     //  ---g----
        4'h6: seg= ~7'h7D;     // |           |
        4'h7: seg= ~7'h07;     // e          c
        4'h8: seg= ~7'h7F;     // |           |
        4'h9: seg= ~7'h67;     //   ---d----
        4'hA: seg= ~7'h77;
        4'hC: seg= ~7'h39;
        4'hE: seg= ~7'h79;
        4'hF: seg= ~7'h71;
        endcase
endmodule

module mycircuit(A,B,C,D,S,T,U,V,X,Y,W,Z);
    input   A,B,C,D;
    output S,T,U,V,X,Y,W,Z;
    
    assign S = 0;
    assign T = A;
    assign U = B;
    assign V = C;
    assign W = 0;
    assign X = D;
    assign Y = 0;
    assign Z = D;
endmodule