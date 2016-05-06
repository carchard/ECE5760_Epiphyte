module autoGen_BPF #(
  parameter filterID = 0 // lower num = lower BP
                         // 0 -> [10Hz 100Hz]
                         // 1 -> [100Hz 500Hz]
                         // 2 -> [500Hz 1000Hz]
                         // 3 -> [1000Hz 5000Hz]
                         // 4 -> [5000Hz 10000Hz]
                         // 5 -> [10000Hz 20000Hz]
)(
  input clk,
  input aud_clk,
  input reset,
  input enable,

  input signed [15:0] iAud_L,
  input signed [15:0] iAud_R,

  output reg signed [15:0] oAud_L,
  output reg signed [15:0] oAud_R,
  output reg [10:0]  power
);

reg  signed [26:0] y;
reg  signed [26:0] x;
reg  signed [26:0] z1;
reg  signed [26:0] a1;
reg  signed [26:0] b1;
wire signed [26:0] mul_a1_y;
wire signed [26:0] mul_b1_x;
fixed_comb_mult5760 mula1 (y,a1,mul_a1_y);
fixed_comb_mult5760 mulb1 (x,b1,mul_b1_x);

reg  signed [26:0] z2;
reg  signed [26:0] a2;
reg  signed [26:0] b2;
wire signed [26:0] mul_a2_y;
wire signed [26:0] mul_b2_x;
fixed_comb_mult5760 mula2 (y,a2,mul_a2_y);
fixed_comb_mult5760 mulb2 (x,b2,mul_b2_x);

reg  signed [26:0] z3;
reg  signed [26:0] a3;
reg  signed [26:0] b3;
wire signed [26:0] mul_a3_y;
wire signed [26:0] mul_b3_x;
fixed_comb_mult5760 mula3 (y,a3,mul_a3_y);
fixed_comb_mult5760 mulb3 (x,b3,mul_b3_x);

reg  signed [26:0] z4;
reg  signed [26:0] a4;
reg  signed [26:0] b4;
wire signed [26:0] mul_a4_y;
wire signed [26:0] mul_b4_x;
fixed_comb_mult5760 mula4 (y,a4,mul_a4_y);
fixed_comb_mult5760 mulb4 (x,b4,mul_b4_x);

reg  signed [26:0] a5;
reg  signed [26:0] b5;
wire signed [26:0] mul_a5_y;
wire signed [26:0] mul_b5_x;
fixed_comb_mult5760 mula5 (y,a5,mul_a5_y);
fixed_comb_mult5760 mulb5 (x,b5,mul_b5_x);

always @ (posedge clk) begin
case(filterID)
0: begin
b1 <= 27'b000_0000_0000_0000_0000_0000_0011;
b2 <= 27'b000_0000_0000_0000_0000_0000_0000;
b3 <= 27'b111_1111_1111_1111_1111_1111_1001;
b4 <= 27'b000_0000_0000_0000_0000_0000_0000;
b5 <= 27'b000_0000_0000_0000_0000_0000_0011;
a1 <= 27'b000_1000_0000_0000_0000_0000_0000;
a2 <= 27'b110_0000_0000_0011_1100_1011_1111;
a3 <= 27'b011_1111_1111_0100_1001_1110_1000;
a4 <= 27'b110_0000_0000_1011_0101_1111_0100;
a5 <= 27'b000_0111_1111_1100_0011_0110_0101;
end

1: begin
b1 <= 27'b000_0000_0000_0000_0000_0010_0000;
b2 <= 27'b000_0000_0000_0000_0000_0000_0000;
b3 <= 27'b111_1111_1111_1111_1111_1100_0000;
b4 <= 27'b000_0000_0000_0000_0000_0000_0000;
b5 <= 27'b000_0000_0000_0000_0000_0010_0000;
a1 <= 27'b000_1000_0000_0000_0000_0000_0000;
a2 <= 27'b110_0000_0000_1011_0110_1011_1101;
a3 <= 27'b011_1111_1101_1101_1101_0000_1101;
a4 <= 27'b110_0000_0010_0010_0001_1011_0000;
a5 <= 27'b000_0111_1111_0100_1010_1000_0110;
end

2: begin
b1 <= 27'b000_0000_0000_0000_0001_0010_0000;
b2 <= 27'b000_0000_0000_0000_0000_0000_0000;
b3 <= 27'b111_1111_1111_1111_1101_1011_1111;
b4 <= 27'b000_0000_0000_0000_0000_0000_0000;
b5 <= 27'b000_0000_0000_0000_0001_0010_0000;
a1 <= 27'b000_1000_0000_0000_0000_0000_0000;
a2 <= 27'b110_0000_0010_0010_1000_1011_1001;
a3 <= 27'b011_1111_1001_1001_0001_0011_0001;
a4 <= 27'b110_0000_0110_0110_0011_1000_0001;
a5 <= 27'b000_0111_1101_1110_0010_1001_0100;
end

3: begin
b1 <= 27'b000_0000_0000_0000_1001_1111_1011;
b2 <= 27'b000_0000_0000_0000_0000_0000_0000;
b3 <= 27'b111_1111_1111_1110_1100_0000_1010;
b4 <= 27'b000_0000_0000_0000_0000_0000_0000;
b5 <= 27'b000_0000_0000_0000_1001_1111_1011;
a1 <= 27'b000_1000_0000_0000_0000_0000_0000;
a2 <= 27'b110_0000_0110_1010_0010_0010_0001;
a3 <= 27'b011_1110_1100_0111_1111_1011_0100;
a4 <= 27'b110_0001_0011_0001_1011_1100_0100;
a5 <= 27'b000_0111_1001_1100_0010_0110_1110;
end

4: begin
b1 <= 27'b000_0000_0000_0101_0101_1001_1010;
b2 <= 27'b000_0000_0000_0000_0000_0000_0000;
b3 <= 27'b111_1111_1111_0101_0100_1100_1100;
b4 <= 27'b000_0000_0000_0000_0000_0000_0000;
b5 <= 27'b000_0000_0000_0101_0101_1001_1010;
a1 <= 27'b000_1000_0000_0000_0000_0000_0000;
a2 <= 27'b110_0001_0101_0011_1101_0100_0001;
a3 <= 27'b011_1100_0011_1101_1011_0101_0010;
a4 <= 27'b110_0011_1000_1011_1100_0110_1010;
a5 <= 27'b000_0110_1110_0010_1101_0010_1101;
end

5: begin
b1 <= 27'b000_0000_0010_1010_0001_0000_1100;
b2 <= 27'b000_0000_0000_0000_0000_0000_0000;
b3 <= 27'b111_1111_1010_1011_1101_1110_0111;
b4 <= 27'b000_0000_0000_0000_0000_0000_0000;
b5 <= 27'b000_0000_0010_1010_0001_0000_1100;
a1 <= 27'b000_1000_0000_0000_0000_0000_0000;
a2 <= 27'b110_0100_1010_0010_1110_1100_1101;
a3 <= 27'b010_0100_0001_0110_0011_1101_0001;
a4 <= 27'b110_1010_0011_0110_0001_0001_1100;
a5 <= 27'b000_0101_0001_1010_0011_1001_0001;
end

6: begin
b1 <= 27'b000_0001_0001_0001_1110_0100_1111;
b2 <= 27'b000_0000_0000_0000_0000_0000_0000;
b3 <= 27'b111_1101_1101_1100_0011_0110_0001;
b4 <= 27'b000_0000_0000_0000_0000_0000_0000;
b5 <= 27'b000_0001_0001_0001_1110_0100_1111;
a1 <= 27'b000_1000_0000_0000_0000_0000_0000;
a2 <= 27'b111_0001_1100_0100_0100_0111_1000;
a3 <= 27'b000_1100_1010_0110_1011_1001_0111;
a4 <= 27'b111_1001_0110_0011_0001_0111_0110;
a5 <= 27'b000_0010_0010_0101_0111_1000_1011;
end

endcase
end

wire signed [26:0] lpf_y;
reg  signed [26:0] mag_y;
lpf lpf0(
  .clk(clk),
  .aud_clk(aud_clk),
  .reset(reset),

  .in(mag_y),
  .out(lpf_y)
);

always @ (posedge aud_clk) begin
  if (reset) begin
      oAud_R <= 16'd0;
      oAud_L <= 16'd0;
      power  <= 11'd0;
  end
  else if (enable) begin
    // I think these top two need to be blocking
    x  = {{3{iAud_L[15]}},iAud_L,8'd0}; // iAud_L is [-1,1]. Map to 4_16 by extending first bit
    y  = mul_b1_x+z1;
    // the rest are nonblocking
    z1 <= mul_b2_x+z2-mul_a2_y;
    z2 <= mul_b3_x+z3-mul_a3_y;
    z3 <= mul_b4_x+z4-mul_a4_y;
    z4 <= mul_b5_x-mul_a5_y;
    oAud_L <= y[24:9];
    if (y[26]) begin
      mag_y <= (~y)-27'd1;
    end
    else begin
      mag_y <= y;
    end
    power <= lpf_y[23:13];
  end
  else begin
    oAud_R <= iAud_R;
    oAud_L <= oAud_R;
    power  <= 11'd0;
  end
end

endmodule