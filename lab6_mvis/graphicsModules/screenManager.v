module screenManager (
	input clk,
	input aud_clk,
	input reset,

	input [9:0]  iVGA_X,
	input [8:0]  iVGA_Y,
	input [15:0] iAudL,
	input [15:0] iAudR,
	input [9:0]  SW,

	output reg [7:0] oR,
	output reg [7:0] oG,
	output reg [7:0] oB
);

// TEST SECTION FOR STROBING THROUGH BRIGHTNESS ---------------------------------------------------
//reg [15:0] count;
//reg [15:0] count2;
//reg [1:0] brightness;
//
//always @(posedge clk) begin
//	if (count < 16'd27000) begin
//		count = count + 1;
//	end
//	else begin
//		count <= 16'd0;
//		if (count2 < 16'd1000) begin
//			count2 <= count2 + 16'd1;
//		end
//		else begin
//			count2 <= 16'd0;
//			brightness <= brightness + 1;
//		end
//	end
//end
// END TEST SECTION -------------------------------------------------------------------------------

wire [63:0] layer;
wire [63:0] layerOH;

wire [7:0] R [0:63];
wire [7:0] G [0:63];
wire [7:0] B [0:63];
wire [7:0] power [0:5];

generate
	genvar i;
	genvar j;
	for (i=0; i < 6; i = i + 1) begin:xsweep
		bandpassFilter #(i) bp (
			.clk(aud_clk),
			.reset(reset),
			.enable(SW[i]),

			.iAud_L(iAudL),
			.iAud_R(iAudR),

			.oAud_L(),
			.oAud_R(),
			.power(power[i])
		);
		
		for (j=0; j < 6; j = j + 1) begin:ysweep
			colorBlock #(95,69,0,11-2*i,j) cb (
				.clk(clk),
				.reset(reset),
				
				.pow(power[i]),
				.iVGA_X(iVGA_X),
				.iVGA_Y(iVGA_Y),
				.topLeftX(10+i*105),
				.topLeftY(10+j*79),
				
				.oLayer(),
				.oVal(layer[6*i+j]),
				.R(R[6*i+j]),
				.G(G[6*i+j]),
				.B(B[6*i+j])
			);
		end
	end	
endgenerate

msbOneHot msb0 (layer,layerOH);

always @(posedge clk) begin
	case(layerOH)
	(1<<37): begin
		oR <= R[37];
		oB <= B[37];
		oG <= G[37];
	end
	(1<<36): begin
		oR <= R[36];
		oB <= B[36];
		oG <= G[36];
	end
	(1<<35): begin
		oR <= R[35];
		oB <= B[35];
		oG <= G[35];
	end
	(1<<34): begin
		oR <= R[34];
		oB <= B[34];
		oG <= G[34];
	end
	(1<<33): begin
		oR <= R[33];
		oB <= B[33];
		oG <= G[33];
	end
	(1<<32): begin
		oR <= R[32];
		oB <= B[32];
		oG <= G[32];
	end
	(1<<31): begin
		oR <= R[31];
		oB <= B[31];
		oG <= G[31];
	end
	(1<<30): begin
		oR <= R[30];
		oB <= B[30];
		oG <= G[30];
	end
	(1<<29): begin
		oR <= R[29];
		oB <= B[29];
		oG <= G[29];
	end
	(1<<28): begin
		oR <= R[28];
		oB <= B[28];
		oG <= G[28];
	end
	(1<<27): begin
		oR <= R[27];
		oB <= B[27];
		oG <= G[27];
	end
	(1<<26): begin
		oR <= R[26];
		oB <= B[26];
		oG <= G[26];
	end
	(1<<25): begin
		oR <= R[25];
		oB <= B[25];
		oG <= G[25];
	end
	(1<<24): begin
		oR <= R[24];
		oB <= B[24];
		oG <= G[24];
	end
	(1<<23): begin
		oR <= R[23];
		oB <= B[23];
		oG <= G[23];
	end
	(1<<22): begin
		oR <= R[22];
		oB <= B[22];
		oG <= G[22];
	end
	(1<<21): begin
		oR <= R[21];
		oB <= B[21];
		oG <= G[21];
	end
	(1<<20): begin
		oR <= R[20];
		oB <= B[20];
		oG <= G[20];
	end
	(1<<19): begin
		oR <= R[19];
		oB <= B[19];
		oG <= G[19];
	end
	(1<<18): begin
		oR <= R[18];
		oB <= B[18];
		oG <= G[18];
	end
	(1<<17): begin
		oR <= R[17];
		oB <= B[17];
		oG <= G[17];
	end
	(1<<16): begin
		oR <= R[16];
		oB <= B[16];
		oG <= G[16];
	end
	(1<<15): begin
		oR <= R[15];
		oB <= B[15];
		oG <= G[15];
	end
	(1<<14): begin
		oR <= R[14];
		oB <= B[14];
		oG <= G[14];
	end
	(1<<13): begin
		oR <= R[13];
		oB <= B[13];
		oG <= G[13];
	end
	(1<<12): begin
		oR <= R[12];
		oB <= B[12];
		oG <= G[12];
	end
	(1<<11): begin
		oR <= R[11];
		oB <= B[11];
		oG <= G[11];
	end
	(1<<10): begin
		oR <= R[10];
		oB <= B[10];
		oG <= G[10];
	end
	(1<<9): begin
		oR <= R[9];
		oB <= B[9];
		oG <= G[9];
	end
	(1<<8): begin
		oR <= R[8];
		oB <= B[8];
		oG <= G[8];
	end
	(1<<7): begin
		oR <= R[7];
		oB <= B[7];
		oG <= G[7];
	end
	(1<<6): begin
		oR <= R[6];
		oB <= B[6];
		oG <= G[6];
	end
	(1<<5): begin
		oR <= R[5];
		oB <= B[5];
		oG <= G[5];
	end
	(1<<4): begin
		oR <= R[4];
		oB <= B[4];
		oG <= G[4];
	end
	(1<<3): begin
		oR <= R[3];
		oB <= B[3];
		oG <= G[3];
	end
	(1<<2): begin
		oR <= R[2];
		oB <= B[2];
		oG <= G[2];
	end
	(1<<1): begin
		oR <= R[1];
		oB <= B[1];
		oG <= G[1];
	end
	(1<<0): begin
		oR <= R[0];
		oG <= G[0];
		oB <= B[0];
	end
	default: begin
		oR <= 8'd0;
		oG <= 8'd0;
		oB <= 8'd0;
	end
	endcase
end

endmodule