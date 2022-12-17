# FFT_Accelerater_CORDIC

Sources & TestBench :--> Contains Verilog Files of Modules and their Respective TestBenches.
Vivado_Project :--> Contain Complete Project as ZIP File.

### Created By :   LUCKY (lucky8882041@gmail.com) 
  --  LinkedIn : https://www.linkedin.com/in/lucky8882041/
    
    
FFT Hardware Accelerater using CORDIC Algorithm and FPGA Board

In This Project a FFT Accelerater using CORDIC Algorithms has been Created using Verilog Language and a FPGA Board (XILINX BASYS3).
a 8-Point FFT can be Performed, it Takes 16 inputs, 8 inputs for Real Part and Another 8 Inputs for Imaginary Part.
Each Input are of 16-bit .

Output is also Having 16 Outputs, Same 8 for real and 8 for Imaginary and Every Input and Output will be Represented with 16 bits.

As we all Know There will be Some Complex Multiplications and additions in FFT DIT/DIF Algorithms and this task utilize a Large amount of Resources from Any FPGA Board
and it will not be possible to multiply real numbers in some FPGA Board like BASYS3 Board and for Simpliflication we have used a efficient Algorithm Known as CORDIC 

## CORDIC Coordinate Rotation Digital Computer

CORDIC will allow us to Calculate Fixed Point Cartision Rotation Very Fast, By using Already Declared Lookup Table. It will Give Twiddle factor for This project
By Calculating Xcos(Theta) and Ysin(Theta) for Real (x) and Imaginary(Y) Inputs.

In this Project I have Used VIO (Virtual Input and Output) IP of XILINX 2022.2 Software to Give Input and ILA (Integrated Logic Analyzer) To Observe Output.
