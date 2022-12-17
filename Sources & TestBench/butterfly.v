/* Simple Butterfly Module to Calculate 2 Radix Which were used in DIT/DIF FFT algorithms */

`timescale 1ns / 1ps
module butterfly(
	input clock,
	input signed [15:0] x1,
	input signed [15:0] y1,
	input signed [15:0] x2,
	input signed [15:0] y2,
	output signed [15:0] xout1,
	output signed [15:0] yout1,
	output signed [15:0] xout2,
	output signed [15:0] yout2 );


assign xout1 = x1+x2;
assign yout1 = y1+y2;

assign xout2 = x1-x2;
assign yout2 = y1-y2;

endmodule