
module DE2_115_Basic_Computer (
// Clock Inputs
  input         CLOCK_50,    // 50MHz Input 1
  input         CLOCK2_50,   // 50MHz Input 2
  input         CLOCK3_50,   // 50MHz Input 3
  output        SMA_CLKOUT,  // External Clock Output
  input         SMA_CLKIN,   // External Clock Input

  // Push Button
  input  [3:0]  KEY,         // Pushbutton[3:0]

  // DPDT Switch
  input  [17:0] SW,          // Toggle Switch[17:0]

  // 7-SEG Display
  output [6:0]  HEX0,        // Seven Segment Digit 0
  output [6:0]  HEX1,        // Seven Segment Digit 1
  output [6:0]  HEX2,        // Seven Segment Digit 2
  output [6:0]  HEX3,        // Seven S egment Digit 3
  output [6:0]  HEX4,        // Seven Segment Digit 4
  output [6:0]  HEX5,        // Seven Segment Digit 5
  output [6:0]  HEX6,        // Seven Segment Digit 6
  output [6:0]  HEX7,        // Seven Segment Digit 7

  // LED
  output [8:0]  LEDG,        // LED Green[8:0]
  output [17:0] LEDR,        // LED Red[17:0]

  // UART
  output        UART_TXD,    // UART Transmitter
  input         UART_RXD,    // UART Receiver
  output        UART_CTS,    // UART Clear to Send
  input         UART_RTS,    // UART Request to Send

  // IRDA
  input         IRDA_RXD,    // IRDA Receiver

  // SDRAM Interface
  inout  [31:0] DRAM_DQ,     // SDRAM Data bus 32 Bits
  output [12:0] DRAM_ADDR,   // SDRAM Address bus 13 Bits
  output [1:0]  DRAM_BA,     // SDRAM Bank Address
  output [3:0]  DRAM_DQM,    // SDRAM Byte Data Mask 
  output        DRAM_RAS_N,  // SDRAM Row Address Strobe
  output        DRAM_CAS_N,  // SDRAM Column Address Strobe
  output        DRAM_CKE,    // SDRAM Clock Enable
  output        DRAM_CLK,    // SDRAM Clock
  output        DRAM_WE_N,   // SDRAM Write Enable
  output        DRAM_CS_N,   // SDRAM Chip Select

  // Flash Interface
  inout  [7:0]  FL_DQ,       // FLASH Data bus 8 Bits
  output [22:0] FL_ADDR,     // FLASH Address bus 23 Bits
  output        FL_WE_N,     // FLASH Write Enable
  output        FL_WP_N,     // FLASH Write Protect / Programming Acceleration
  output        FL_RST_N,    // FLASH Reset
  output        FL_OE_N,     // FLASH Output Enable
  output        FL_CE_N,     // FLASH Chip Enable
  input         FL_RY,       // FLASH Ready/Busy output

  // SRAM Interface
  inout  [15:0] SRAM_DQ,     // SRAM Data bus 16 Bits
  output [19:0] SRAM_ADDR,   // SRAM Address bus 20 Bits
  output        SRAM_OE_N,   // SRAM Output Enable
  output        SRAM_WE_N,   // SRAM Write Enable
  output        SRAM_CE_N,   // SRAM Chip Enable
  output        SRAM_UB_N,   // SRAM High-byte Data Mask 
  output        SRAM_LB_N,   // SRAM Low-byte Data Mask 

  // ISP1362 Interface
  inout  [15:0] OTG_DATA,    // ISP1362 Data bus 16 Bits
  output [1:0]  OTG_ADDR,    // ISP1362 Address 2 Bits
  output        OTG_CS_N,    // ISP1362 Chip Select
  output        OTG_RD_N,    // ISP1362 Write
  output        OTG_WR_N,    // ISP1362 Read
  output        OTG_RST_N,   // ISP1362 Reset
  input  [1:0]  OTG_INT,     // ISP1362 Interrupts
  inout         OTG_FSPEED,  // USB Full Speed, 0 = Enable, Z = Disable
  inout         OTG_LSPEED,  // USB Low Speed,  0 = Enable, Z = Disable
  input  [1:0]  OTG_DREQ,    // ISP1362 DMA Request
  output [1:0]  OTG_DACK_N,  // ISP1362 DMA Acknowledge

  // LCD Module 16X2
  inout  [7:0]  LCD_DATA,    // LCD Data bus 8 bits
  output        LCD_ON,      // LCD Power ON/OFF
  output        LCD_BLON,    // LCD Back Light ON/OFF
  output        LCD_RW,      // LCD Read/Write Select, 0 = Write, 1 = Read
  output        LCD_EN,      // LCD Enable
  output        LCD_RS,      // LCD Command/Data Select, 0 = Command, 1 = Data

  // SD Card Interface
  inout  [3:0]  SD_DAT,      // SD Card Data
  inout         SD_CMD,      // SD Card Command Line
  output        SD_CLK,      // SD Card Clock
  input         SD_WP_N,     // SD Write Protect

  // EEPROM Interface
  output        EEP_I2C_SCLK, // EEPROM Clock
  inout         EEP_I2C_SDAT, // EEPROM Data

  // PS2
  inout         PS2_DAT,     // PS2 Data
  inout         PS2_CLK,     // PS2 Clock
  inout         PS2_DAT2,    // PS2 Data 2 (use for 2 devices and y-cable)
  inout         PS2_CLK2,    // PS2 Clock 2 (use for 2 devices and y-cable)

  // I2C  
  inout         I2C_SDAT,    // I2C Data
  output        I2C_SCLK,    // I2C Clock

  // Audio CODEC
  inout         AUD_ADCLRCK, // Audio CODEC ADC LR Clock
  input         AUD_ADCDAT,  // Audio CODEC ADC Data
  inout         AUD_DACLRCK, // Audio CODEC DAC LR Clock
  output        AUD_DACDAT,  // Audio CODEC DAC Data
  inout         AUD_BCLK,    // Audio CODEC Bit-Stream Clock
  output        AUD_XCK,     // Audio CODEC Chip Clock

  // Ethernet Interface (88E1111)
  input         ENETCLK_25,    // Ethernet clock source

  output        ENET0_GTX_CLK, // GMII Transmit Clock 1
  input         ENET0_INT_N,   // Interrupt open drain output 1
  input         ENET0_LINK100, // Parallel LED output of 100BASE-TX link 1
  output        ENET0_MDC,     // Management data clock ref 1
  inout         ENET0_MDIO,    // Management data 1
  output        ENET0_RST_N,   // Hardware Reset Signal 1
  input         ENET0_RX_CLK,  // GMII and MII receive clock 1
  input         ENET0_RX_COL,  // GMII and MII collision 1
  input         ENET0_RX_CRS,  // GMII and MII carrier sense 1
  input   [3:0] ENET0_RX_DATA, // GMII and MII receive data 1
  input         ENET0_RX_DV,   // GMII and MII receive data valid 1
  input         ENET0_RX_ER,   // GMII and MII receive error 1
  input         ENET0_TX_CLK,  // MII Transmit clock 1
  output  [3:0] ENET0_TX_DATA, // MII Transmit data 1
  output        ENET0_TX_EN,   // GMII and MII transmit enable 1
  output        ENET0_TX_ER,   // GMII and MII transmit error 1

  output        ENET1_GTX_CLK, // GMII Transmit Clock 1
  input         ENET1_INT_N,   // Interrupt open drain output 1
  input         ENET1_LINK100, // Parallel LED output of 100BASE-TX link 1
  output        ENET1_MDC,     // Management data clock ref 1
  inout         ENET1_MDIO,    // Management data 1
  output        ENET1_RST_N,   // Hardware Reset Signal 1
  input         ENET1_RX_CLK,  // GMII and MII receive clock 1
  input         ENET1_RX_COL,  // GMII and MII collision 1
  input         ENET1_RX_CRS,  // GMII and MII carrier sense 1
  input   [3:0] ENET1_RX_DATA, // GMII and MII receive data 1
  input         ENET1_RX_DV,   // GMII and MII receive data valid 1
  input         ENET1_RX_ER,   // GMII and MII receive error 1
  input         ENET1_TX_CLK,  // MII Transmit clock 1
  output  [3:0] ENET1_TX_DATA, // MII Transmit data 1
  output        ENET1_TX_EN,   // GMII and MII transmit enable 1
  output        ENET1_TX_ER,   // GMII and MII transmit error 1

  // Expansion Header
  inout   [6:0] EX_IO,       // 14-pin GPIO Header
  inout  [35:0] GPIO,        // 40-pin Expansion header

  // TV Decoder
  input  [8:0]  TD_DATA,     // TV Decoder Data
  input         TD_CLK27,    // TV Decoder Clock Input
  input         TD_HS,       // TV Decoder H_SYNC
  input         TD_VS,       // TV Decoder V_SYNC
  output        TD_RESET_N,  // TV Decoder Reset

  // VGA
  output        VGA_CLK,     // VGA Clock
  output        VGA_HS,      // VGA H_SYNC
  output        VGA_VS,      // VGA V_SYNC
  output        VGA_BLANK_N, // VGA BLANK
  output        VGA_SYNC_N,  // VGA SYNC
  output [7:0]  VGA_R,       // VGA Red[9:0]
  output [7:0]  VGA_G,       // VGA Green[9:0]
  output [7:0]  VGA_B       // VGA Blue[9:0]
);

/*
  // Turn off all displays.
  assign HEX0 = 7'h7F;
  assign HEX1 = 7'h7F;
  assign HEX2 = 7'h7F;
  assign HEX3 = 7'h7F;
  assign HEX4 = 7'h7F;
  assign HEX5 = 7'h7F;
  assign HEX6 = 7'h7F;
  assign HEX7 = 7'h7F;
*/
  // Set all GPIO to tri-state.
  assign GPIO = 36'hzzzzzzzzz;
  assign EX_IO = 7'hzzzzzzzzz;

  // Disable audio codec.
  // assign AUD_DACDAT = 1'b0;
  // assign AUD_XCK    = 1'b0;


  // Disable flash.
  assign FL_ADDR  = 23'h0;
  assign FL_CE_N  = 1'b1;
  assign FL_DQ    = 8'hzz;
  assign FL_OE_N  = 1'b1;
  assign FL_RST_N = 1'b1;
  assign FL_WE_N  = 1'b1;
  assign FL_WP_N  = 1'b0;

  // Disable LCD.
  assign LCD_BLON = 1'b0;
  assign LCD_DATA = 8'hzz;
  assign LCD_EN   = 1'b0;
  assign LCD_ON   = 1'b0;
  assign LCD_RS   = 1'b0;
  assign LCD_RW   = 1'b0;

  // Disable OTG.
  assign OTG_ADDR    = 2'h0;
  assign OTG_CS_N    = 1'b1;
  assign OTG_DACK_N  = 2'b11;
  assign OTG_FSPEED  = 1'b1;
  assign OTG_DATA    = 16'hzzzz;
  assign OTG_LSPEED  = 1'b1;
  assign OTG_RD_N    = 1'b1;
  assign OTG_RST_N   = 1'b1;
  assign OTG_WR_N    = 1'b1;

  // Disable SD
  assign SD_DAT = 4'bzzzz;
  assign SD_CLK = 1'b0;
  assign SD_CMD = 1'b0;




//	For Delay Timer
wire			DLY0;
wire			DLY1;
wire			DLY2;


//	Reset Delay Timer
Reset_Delay			u3	(	.iCLK(CLOCK_50),
							.iRST(KEY[0]),
							.oRST_0(DLY0),  // Delay by 0.0026 sec
							.oRST_1(DLY1),  // Delay by 0.0039 sec
							.oRST_2(DLY2)); // Delay by 0.0838 sec

  ///////////////////////////////////////
  // Main program
  ///////////////////////////////////////

  assign TD_RESET_N = 1'b1;  // Enable 27MHz Clock

  /*****************************************************************************
 *                 Internal Wires and Registers Declarations                 *
 *****************************************************************************/
// Internal Wires
//  Used to connect the Nios II system clock to the non-shifted output of the PLL
wire				system_clock;

// Internal Registers

// State Machine Registers

/*****************************************************************************
 *                         Finite State Machine(s)                           *
 *****************************************************************************/


/*****************************************************************************
 *                             Sequential Logic                              *
 *****************************************************************************/


/*****************************************************************************
 *                            Combinational Logic                            *
 *****************************************************************************/


/*****************************************************************************
 *                              Internal Modules                             *
 *****************************************************************************/
 
 wire [21:0] dda_opts;
nios_system NiosII (
	// 1) global signals:
	.clk									(system_clock),
	.reset_n								(KEY[0]),

	.dda_options_external_interface_export(dda_opts),
	// the_Green_LEDs
	.LEDG_from_the_Green_LEDs				(LEDG),

	// the_HEX3_HEX0
	.HEX0_from_the_HEX3_HEX0				(HEX0),
	.HEX1_from_the_HEX3_HEX0				(HEX1),
	.HEX2_from_the_HEX3_HEX0				(HEX2),
	.HEX3_from_the_HEX3_HEX0				(HEX3),
	



	// the_SDRAM
	.zs_addr_from_the_SDRAM					(DRAM_ADDR),
	.zs_ba_from_the_SDRAM					(DRAM_BA),
	.zs_cas_n_from_the_SDRAM				(DRAM_CAS_N),
	.zs_cke_from_the_SDRAM					(DRAM_CKE),
	.zs_cs_n_from_the_SDRAM					(DRAM_CS_N),
	.zs_dq_to_and_from_the_SDRAM			(DRAM_DQ),
	.zs_dqm_from_the_SDRAM					(DRAM_DQM),
	.zs_ras_n_from_the_SDRAM				(DRAM_RAS_N),
	.zs_we_n_from_the_SDRAM					(DRAM_WE_N)
	

	);

sdram_pll neg_3ns (CLOCK_50, DRAM_CLK, system_clock);

wire	VGA_CTRL_CLK;


vga_pll 		p1	(	.areset(),.inclk0(CLOCK_50),.c0(VGA_CTRL_CLK),.c1());

wire		[9:0]	VGA_X;
wire		[8:0]	VGA_Y; 				
JULIE	julies_vga_ctrl	(	
	//	Host Side
	.iRed 		(mVGA_R),
	.iGreen 	(mVGA_G),
	.iBlue 		(mVGA_B),
	.oCurrent_X (VGA_X),
	.oCurrent_Y (VGA_Y),
	//.oAddress 	(VGA_Addr_full_d0), 
	//.oRequest 	(VGA_Read),
	//	VGA Side
	.oVGA_R 	(VGA_R),
	.oVGA_G 	(VGA_G),
	.oVGA_B 	(VGA_B),
	.oVGA_HS 	(VGA_HS),
	.oVGA_VS 	(VGA_VS),
	.oVGA_SYNC 	(VGA_SYNC_N),
	.oVGA_BLANK (VGA_BLANK_N),
	.oVGA_CLOCK (VGA_CLK),
	//	Control Signal
	.iCLK 		(VGA_CTRL_CLK),
	.iRST_N 	(DLY2)	
);

reg [7:0]	mVGA_R;				//memory output to VGA
reg [7:0]	mVGA_G;
reg [7:0]	mVGA_B;


////////////////////////////////////
//CA state machine variables
wire reset;


localparam SCREEN_WIDTH = 10'd640;
localparam SCREEN_HEIGHT= 10'd480;
reg [SCREEN_WIDTH-1:0] currentGen;
reg [SCREEN_WIDTH-1:0] nextGen;


////////////////////////////////////
/*From megaWizard:
	module vga_buffer (
	address_a, // use a for state machine
	address_b, // use b for VGA refresh
	clock_a,
	clock_b,
	data_a,
	data_b,
	wren_a,
	wren_b,
	q_a,
	q_b);*/
// Show m4k on the VGA
// -- use m4k a for state machine
// -- use m4k b for VGA refresh

wire [9:0] eulers_Xcoord;
wire [8:0] eulers_Ycoord;
hotter_buffer buffbuffbuff(
	.address_a({eulers_Xcoord,eulers_Ycoord}),
	.address_b({VGA_X,VGA_Y}),
	.clock(VGA_CTRL_CLK),
	.data_a(disp_bits),
	//.data_b,
	.wren_a(wren_a),
	.wren_b(1'b0),
	//.q_a,
	.q_b(buff_out)
);
wire wren_a;
wire [1:0] buff_out;
wire [1:0] mem_bits ; //current data from m4k to VGA
reg  [1:0] disp_bits ; // registered data from m4k to VGA

wire state_bit ; // current data from m4k to state machine
reg we ; // write enable for a
reg [18:0] addr_reg ; // for a
reg data_reg ; // for a
localparam bufwhite = 2'b00;
localparam buftrace1 = 2'b01;
localparam buftrace2 = 2'b10;
localparam special = 2'b11;

// make the color white
always @(*) begin
case(buff_out)
	bufwhite: begin
	mVGA_R <= 8'd255;
	mVGA_G <= 8'd255;
	mVGA_B <= 8'd255;
	end
	buftrace1: begin
	mVGA_R <= 8'd0;
	mVGA_G <= 8'd0;
	mVGA_B <= 8'd255;
	end
	buftrace2: begin
	mVGA_R <= 8'd255;
	mVGA_G <= 8'd0;
	mVGA_B <= 8'd0;
	end
	default: begin
	mVGA_R <= 8'd0;
	mVGA_G <= 8'd0;
	mVGA_B <= 8'd0;
	end
endcase
end

reg [3:0] saved_dda_select;
reg [1:0] dda_param_first_byte;
reg [3:0] dda_param_second_byte;
reg [3:0] dda_param_third_byte;
reg [3:0] dda_param_fourth_byte;
always @(posedge VGA_CTRL_CLK)
begin
	if (SW[17]) // show dda_param_driver outputs
	begin
		case(dda_opts[3:0])
		4'b0000 : ; //Do nothing!
		4'd1 :  begin
			dda_param_first_byte <= k1[17:16];
			dda_param_second_byte <= k1[15:12];
			dda_param_third_byte <= k1[11:8];
			dda_param_fourth_byte <= k1[7:4];
		end
		4'd2 :begin
			dda_param_first_byte <= kmid[17:16];
			dda_param_second_byte <= kmid[15:12];
			dda_param_third_byte <= kmid[11:8];
			dda_param_fourth_byte <= kmid[7:4];
		end	
		4'd3 : begin
			dda_param_first_byte <= k2[17:16];
			dda_param_second_byte <= k2[15:12];
			dda_param_third_byte <= k2[11:8];
			dda_param_fourth_byte <= k2[7:4];
		end
		4'd4 : begin 
			dda_param_first_byte <= kcubic[17:16];
			dda_param_second_byte <= kcubic[15:12];
			dda_param_third_byte <= kcubic[11:8];
			dda_param_fourth_byte <= kcubic[7:4];
		end		
		4'd5 :  begin
			dda_param_first_byte <= x1_init[17:16];
			dda_param_second_byte <= x1_init[15:12];
			dda_param_third_byte <= x1_init[11:8];
			dda_param_fourth_byte <= x1_init[7:4];
		end
		4'd6 :  begin 
			dda_param_first_byte <= x2_init[17:16];
			dda_param_second_byte <= x2_init[15:12];
			dda_param_third_byte <= x2_init[11:8];
			dda_param_fourth_byte <= x2_init[7:4];
		end
		4'd7 :  begin 
			dda_param_first_byte <= v1_init[17:16];
			dda_param_second_byte <= v1_init[15:12];
			dda_param_third_byte <= v1_init[11:8];
			dda_param_fourth_byte <= v1_init[7:4];
		end
		4'd8 :  begin 
			dda_param_first_byte <= v2_init[17:16];
			dda_param_second_byte <= v2_init[15:12];
			dda_param_third_byte <= v2_init[11:8];
			dda_param_fourth_byte <= v2_init[7:4];
		end
		endcase
	end
	// if SW[17] is low, then show the output from the NIOS 
	else 
	begin
		dda_param_first_byte <= dda_opts[21:20];
		dda_param_second_byte <= dda_opts[19:16];
		dda_param_third_byte <= dda_opts[15:12];
		dda_param_fourth_byte <= dda_opts[11:8];
	end
	if (dda_opts[3:0] != 4'd0) begin
	saved_dda_select <= dda_opts[3:0];

	end
end

//assign HEX0 = 7'h7F;

// DLA state machine
assign reset = ~KEY[0];

//right-most bit for rand number shift regs
//your basic XOR random # gen
	 //Drive LEDs
hex_7seg hex4_ctrl(dda_param_fourth_byte,HEX4);
hex_7seg hex5_ctrl(dda_param_third_byte,HEX5);
hex_7seg hex6_ctrl(dda_param_second_byte,HEX6);
hex_7seg hex7_ctrl(dda_param_first_byte,HEX7);

assign LEDR[7] = reset;

wire signed [17:0] k1;
wire signed [17:0] kmid;
wire signed [17:0] k2;
wire signed [17:0] kcubic;
wire signed [17:0] x1_init;
wire signed [17:0] x2_init;
wire signed [17:0] v1_init;
wire signed [17:0] v2_init;
wire            start_stop;
assign LEDR[2] = start_stop;
dda_param_driver dpd(
	 .clk(CLOCK_50),
	 .reset(~DLY0),
    .niosDDA_cmd(dda_opts),
	 .k1(k1),
	 .kmid(kmid),
	 .k2(k2),
	 .kcubic(kcubic),
	 .x1_init(x1_init),
	 .x2_init(x2_init),
	 .v1_init(v1_init),
	 .v2_init(v2_init),
	 .start_stop(start_stop)
);
eulersillator snoopDoggWiggleWiggle (
.CLOCK_50(CLOCK_50),
.VGA_CTRL_CLK(VGA_CTRL_CLK),
.reset(reset),
.triggerDraw(),
//NIOS II Inputs
.nios_reset(~KEY[2]),
.cube(SW[3]), // use switch 3 to turn on and off cubic term
.k1(k1),
.kmid(kmid),
.k2(k2),
.kcubic(kcubic),
.start_stop(start_stop),
.x1_init(x1_init),
.x2_init(x2_init),
.v1_init(v1_init),
.v2_init(v2_init),

//VGA interface
.display_xCoord(VGA_X),
.display_yCoord(VGA_Y),
.write_xCoord(eulers_Xcoord),
.write_yCoord(eulers_Ycoord),
.w_en(wren_a),
.disp_bit(mem_bits) 
);

always @ (negedge VGA_CTRL_CLK)
begin
	// register the m9k output for better timing on VGA
	// negedge seems to work better than posedge
	disp_bits <= mem_bits;
end


endmodule //top module

