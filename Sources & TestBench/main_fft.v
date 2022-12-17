/*
This Main Module takes 8 Real Inputs and 8 Imaginary Inputs each of 16 bits and 
Calculate 8-point Fast Forier Transform and store Output in 16 Different registers each of 16 bits
8 for Real Part and 8 for Imaginary Output, clock we will Take From FPGA Board itself 

We have Created 12 Instances of Butterfly Module as per DIT FFT algorithm,
and 5 Instances for Multiplication of Butterfly Results with Twiddle FACTOR.

For angle of Each Twiddle factor there is a Lookup Table Already Declared as (angle_lut)
*/
`timescale 1ns / 1ps
module main_cordic_fft(xin1,xin2,xin3,xin4,xin5,xin6,xin7,xin8,yin1,yin2,yin3,yin4,yin5,yin6,yin7,yin8,xout,yout,clock);
	input signed [15:0] xin1,xin2,xin3,xin4,xin5,xin6,xin7,xin8;
	input signed [15:0] yin1,yin2,yin3,yin4,yin5,yin6,yin7,yin8;
    output signed [128:0] xout;
    output signed [128:0] yout;
    input clock;
    wire signed [31:0] angle_lut [0:7];
    wire signed[15:0] xtemp_in[0:7],ytemp_in[0:7];
    wire signed[15:0] xtemp1[0:7],ytemp1[0:7],xtemp2[0:7],ytemp2[0:7],xtemp3[0:7],ytemp3[0:7],xtemp_1[0:7],ytemp_1[0:7],xtemp_2[0:7],ytemp_2[0:7];

    assign angle_lut[0] = 'b00000000000000000000000000000000;
    assign angle_lut[1] = 'b11100000000000000000000000000000;
    assign angle_lut[2] = 'b11000000000000000000000000000000;
    assign angle_lut[3] = 'b10100000000000000000000000000000;

assign {xtemp_in[0],xtemp_in[1],xtemp_in[2],xtemp_in[3],xtemp_in[4],xtemp_in[5],xtemp_in[6],xtemp_in[7]} = {xin1,xin2,xin3,xin4,xin5,xin6,xin7,xin8};
assign {ytemp_in[0],ytemp_in[1],ytemp_in[2],ytemp_in[3],ytemp_in[4],ytemp_in[5],ytemp_in[6],ytemp_in[7]} = {yin1,yin2,yin3,yin4,yin5,yin6,yin7,yin8};

	butterfly b4(.clock(clock),.x1(xtemp_in[0]),.y1(ytemp_in[0]),.x2(xtemp_in[4]),.y2(ytemp_in[4]),.xout1(xtemp1[0]),.yout1(ytemp1[0]),.xout2(xtemp1[1]),.yout2(ytemp1[1]));
	butterfly b5(.clock(clock),.x1(xtemp_in[2]),.y1(ytemp_in[2]),.x2(xtemp_in[6]),.y2(ytemp_in[6]),.xout1(xtemp1[2]),.yout1(ytemp1[2]),.xout2(xtemp1[3]),.yout2(ytemp1[3]));
    butterfly b6(.clock(clock),.x1(xtemp_in[1]),.y1(ytemp_in[1]),.x2(xtemp_in[5]),.y2(ytemp_in[5]),.xout1(xtemp1[4]),.yout1(ytemp1[4]),.xout2(xtemp1[5]),.yout2(ytemp1[5]));
	butterfly b7(.clock(clock),.x1(xtemp_in[3]),.y1(ytemp_in[3]),.x2(xtemp_in[7]),.y2(ytemp_in[7]),.xout1(xtemp1[6]),.yout1(ytemp1[6]),.xout2(xtemp1[7]),.yout2(ytemp1[7]));
	
    cordic c7(clock,angle_lut[2],xtemp1[3],ytemp1[3],xtemp_1[3],ytemp_1[3]);
    cordic c8(clock,angle_lut[2],xtemp1[7],ytemp1[7],xtemp_1[7],ytemp_1[7]);

	butterfly b8(.clock(clock),.x1(xtemp1[0]),.y1(ytemp1[0]),.x2(xtemp1[2]),.y2(ytemp1[2]),.xout1(xtemp2[0]),.yout1(ytemp2[0]),.xout2(xtemp2[2]),.yout2(ytemp2[2]));
	butterfly b9(.clock(clock),.x1(xtemp1[1]),.y1(ytemp1[1]),.x2(xtemp_1[3]),.y2(ytemp_1[3]),.xout1(xtemp2[1]),.yout1(ytemp2[1]),.xout2(xtemp2[3]),.yout2(ytemp2[3]));
    butterfly b10(.clock(clock),.x1(xtemp1[4]),.y1(ytemp1[4]),.x2(xtemp1[6]),.y2(ytemp1[6]),.xout1(xtemp2[4]),.yout1(ytemp2[4]),.xout2(xtemp2[6]), .yout2(ytemp2[6]));
	butterfly b11(.clock(clock),.x1(xtemp1[5]),.y1(ytemp1[5]),.x2(xtemp_1[7]),.y2(ytemp_1[7]),.xout1(xtemp2[5]),.yout1(ytemp2[5]),.xout2(xtemp2[7]),.yout2(ytemp2[7]));

    cordic c9(clock,angle_lut[1],xtemp2[5],ytemp2[5],xtemp_2[5],ytemp_2[5]);
    cordic c10(clock,angle_lut[2],xtemp2[6],ytemp2[6],xtemp_2[6],ytemp_2[6]);
    cordic c11(clock,angle_lut[3],xtemp2[7],ytemp2[7],xtemp_2[7],ytemp_2[7]);

	butterfly b12(.clock(clock),.x1(xtemp2[0]),.y1(ytemp2[0]),.x2(xtemp2[4]),.y2(ytemp2[4]),.xout1(xtemp3[0]),.yout1(ytemp3[0]),.xout2(xtemp3[4]),.yout2(ytemp3[4]));
	butterfly b13(.clock(clock),.x1(xtemp2[1]),.y1(ytemp2[1]),.x2(xtemp_2[5]),.y2(ytemp_2[5]),.xout1(xtemp3[1]),.yout1(ytemp3[1]),.xout2(xtemp3[5]),.yout2(ytemp3[5]));
    butterfly b14(.clock(clock),.x1(xtemp2[2]),.y1(ytemp2[2]),.x2(xtemp_2[6]),.y2(ytemp_2[6]),.xout1(xtemp3[2]),.yout1(ytemp3[2]),.xout2(xtemp3[6]),.yout2(ytemp3[6]));
	butterfly b15(.clock(clock),.x1(xtemp2[3]),.y1(ytemp2[3]),.x2(xtemp_2[7]),.y2(ytemp_2[7]),.xout1(xtemp3[3]),.yout1(ytemp3[3]),.xout2(xtemp3[7]),.yout2(ytemp3[7]));

assign xout = {xtemp3[15],xtemp3[14],xtemp3[13],xtemp3[12],xtemp3[11],xtemp3[10],xtemp3[9],xtemp3[8],xtemp3[7],xtemp3[6],xtemp3[5],xtemp3[4],xtemp3[3],xtemp3[2],xtemp3[1],xtemp3[0]};
assign yout = {ytemp3[15],ytemp3[14],ytemp3[13],ytemp3[12],ytemp3[11],ytemp3[10],ytemp3[9],ytemp3[8],ytemp3[7],ytemp3[6],ytemp3[5],ytemp3[4],ytemp3[3],ytemp3[2],ytemp3[1],ytemp3[0]};

endmodule