
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


   //assign LEDR = 18'h0;
   //assign LEDG = 9'h0;
   
   //Set all GPIO to tri-state.
   assign GPIO_0 = 36'hzzzzzzzzz;
   assign GPIO_1 = 36'hzzzzzzzzz;

   //Disable audio codec.
   //assign AUD_DACDAT = 1'b0;
   //assign AUD_XCK    = 1'b0;

   //Disable DRAM.
   assign DRAM_ADDR  = 12'h0;
   assign DRAM_BA_0  = 1'b0;
   assign DRAM_BA_1  = 1'b0;
   assign DRAM_CAS_N = 1'b1;
   assign DRAM_CKE   = 1'b0;
   assign DRAM_CLK   = 1'b0;
   assign DRAM_CS_N  = 1'b1;
   assign DRAM_DQ    = 16'hzzzz;
   assign DRAM_LDQM  = 1'b0;
   assign DRAM_RAS_N = 1'b1;
   assign DRAM_UDQM  = 1'b0;
   assign DRAM_WE_N  = 1'b1;

   //Disable Ethernet.
   assign ENET_CLK   = 1'b0;
   assign ENET_CS_N  = 1'b1;
   assign ENET_CMD   = 1'b0;
   assign ENET_DATA  = 16'hzzzz;
   assign ENET_RD_N  = 1'b1;
   assign ENET_RST_N = 1'b1;
   assign ENET_WR_N  = 1'b1;

   //Disable flash.
   assign FL_ADDR  = 22'h0;
   assign FL_CE_N  = 1'b1;
   assign FL_DQ    = 8'hzz;
   assign FL_OE_N  = 1'b1;
   assign FL_RST_N = 1'b1;
   assign FL_WE_N  = 1'b1;

   //Disable LCD.
   assign LCD_BLON = 1'b0;
   assign LCD_DATA = 8'hzz;
   assign LCD_EN   = 1'b0;
   assign LCD_ON   = 1'b0;
   assign LCD_RS   = 1'b0;
   assign LCD_RW   = 1'b0;

   //Disable OTG.
   assign OTG_ADDR    = 2'h0;
   assign OTG_CS_N    = 1'b1;
   assign OTG_DACK0_N = 1'b1;
   assign OTG_DACK1_N = 1'b1;
   assign OTG_FSPEED  = 1'b1;
   assign OTG_DATA    = 16'hzzzz;
   assign OTG_LSPEED  = 1'b1;
   assign OTG_RD_N    = 1'b1;
   assign OTG_RST_N   = 1'b1;
   assign OTG_WR_N    = 1'b1;

   //Disable SDRAM.
   assign SD_DAT = 1'bz;
   assign SD_CLK = 1'b0;

   //Disable SRAM.
   assign SRAM_ADDR = 18'h0;
   assign SRAM_CE_N = 1'b1;
   assign SRAM_DQ   = 16'hzzzz;
   assign SRAM_LB_N = 1'b1;
   assign SRAM_OE_N = 1'b1;
   assign SRAM_UB_N = 1'b1;
   assign SRAM_WE_N = 1'b1;

   //Disable VGA.
   //assign VGA_CLK   = 1'b0;
   assign VGA_BLANK = 1'b0;
   assign VGA_SYNC  = 1'b0;
   assign VGA_HS    = 1'b0;
   assign VGA_VS    = 1'b0;
   assign VGA_R     = 10'h0;
   assign VGA_G     = 10'h0;
   assign VGA_B     = 10'h0;

   //Disable all other peripherals.
   //assign I2C_SCLK = 1'b0;
   assign IRDA_TXD   = 1'b0;
   assign TD_RESET_N = 1'b1;
   assign TDO        = 1'b0;
   assign UART_TXD   = 1'b0;
   

wire	VGA_CTRL_CLK;
wire	AUD_CTRL_CLK;
wire	DLY_RST;

assign	TD_RESET	=	1'b1;	//	Allow 27 MHz
assign	AUD_ADCLRCK	=	AUD_DACLRCK;
assign	AUD_XCK		=	AUD_CTRL_CLK;

Reset_Delay			r0	(	.iCLK(CLOCK_50),.oRESET(DLY_RST)	);

VGA_Audio_PLL 		p1	(	.areset(~DLY_RST),.inclk0(TD_CLK27),.c0(VGA_CTRL_CLK),.c1(AUD_CTRL_CLK),.c2(VGA_CLK)	);

I2C_AV_Config 		u3	(	//	Host Side
							.iCLK(CLOCK_50),
							.iRST_N(KEY[0]),
							//	I2C Side
							.I2C_SCLK(I2C_SCLK),
							.I2C_SDAT(I2C_SDAT)	);

AUDIO_DAC_ADC 			u4	(	//	Audio Side
							.oAUD_BCK(AUD_BCLK),
							.oAUD_DATA(AUD_DACDAT),
							.oAUD_LRCK(AUD_DACLRCK),
							.oAUD_inL(audio_inL), // audio data from ADC 
							.oAUD_inR(audio_inR), // audio data from ADC 
							.iAUD_ADCDAT(AUD_ADCDAT),
							.iAUD_extL(audio_outL), // audio data to DAC
							.iAUD_extR(audio_outR), // audio data to DAC
							//	Control Signals
				         .iCLK_18_4(AUD_CTRL_CLK),
							.iRST_N(DLY_RST)
							);

wire  MESH_CTRL_CLK = slow_clock;

reg        ledFlag;
reg        ledFlag2;
reg [15:0] count;
reg [15:0] count2;


//hex_7seg(currentEta[17:16],HEX4);


//hex_7seg(aud_out[1:0],HEX3);
hex_7seg(currentRho[3:0],HEX0);
hex_7seg(currentRho[7:4],HEX1);
hex_7seg(currentRho[11:8],HEX2);
hex_7seg(currentRho[15:12],HEX3);

hex_7seg(currentEta[3:0],HEX4);
hex_7seg(currentEta[7:4],HEX5);
hex_7seg(currentEta[11:8],HEX6);
hex_7seg(currentEta[15:12],HEX7);




always @(posedge MESH_CTRL_CLK) begin
	if (count < 12000) begin
		count <= count + 1;
	end
	else begin
		count <= 0;
		ledFlag = ~ledFlag;
	end
end

always @(posedge validOut) begin
	if (count2 < 12000) begin
		count2 <= count2 + 1;
	end
	else begin
		count2 <= 0;
		ledFlag2 = ~ledFlag2;
	end
end


/// tone generation /////////////////////////////////////////////
wire [17:0] etaTone1;
wire [17:0] etaTone2;
wire [17:0] etaTone3;
wire        makeTone;
reg  [17:0] currentEta;
wire [17:0] currentRho;

assign etaTone1 = {8'd0,SW[17:10],2'd0};

assign makeTone = ~KEY[1];

always @(posedge makeTone) begin
  currentEta <= etaTone1;
end

/// comp mesh ///////////////////////////////////////////////////
wire [17:0] u_mid;
wire        validOut;
wire [2:0]  stateLED;
assign LEDR[17] = ((stateLED[2]==0)&&(stateLED[1]==0)&&(stateLED[0]==0));
/*
compNode cn (
	 .clk(MESH_CTRL_CLK),
	 .reset(makeTone),
	 .uInit(18'h3_8000),
	 .uNorth(0),
	 .uSouth(0),
	 .uEast(0),
	 .uWest(0),
	 .rho(18'h0_8000),
	 .eta(currentEta),
	 .tensionSel(3'b0),
	 .u(u_mid), 
	 .validOut(validOut),
	 .state(stateLED)
);
	
*/
compMesh #(15,15) cm1 (
  .clk(MESH_CTRL_CLK),
  .reset(makeTone),

  //Input Params
  .rho(currentRho),
  .eta(currentEta),
  .tensionSel(),
  // Output Values
   .out(u_mid),
   .allValid(validOut)
);

wire [17:0] rhoSwitches;
assign rhoSwitches = {3'd0,SW[9:1],7'd0};
  
rho_effective re1 (
  // clk reset
  .clk(MESH_CTRL_CLK),
  .reset(makeTone),

  // inputs for rho, constants, and middle position
  .tension_effect_enable(SW[0]),
  .rho_0(rhoSwitches),
  .u_mid(u_mid),

  // output the effective rho value for drum
  .rho_eff(currentRho)
);


assign LEDR[2] = ledFlag2;
assign LEDR[1] = ledFlag;
assign LEDR[3] = makeTone;

/// reset ///////////////////////////////////////////////////////						
//state machine start up	
wire reset; 
// reset control
assign reset = ~KEY[0];

/// audio stuff /////////////////////////////////////////////////

wire signed [15:0] audio_outL, audio_outR ;
wire [15:0] aud_out;
cross_clocker #(16) cc(
.dest_clk(AUD_DACLRCK),
.sig_in(u_mid[17:2]),
.sig_out(aud_out));
reg [15:0] acount;

/*
reg slow_clock;
always@(posedge AUD_DACLRCK) begin
	if (reset) begin
	acount <= 16'd0;
	end
	else if(acount >= 16'd1) begin
	acount <= 16'd0;
	slow_clock <= ~slow_clock;
	end
	else begin
	acount <= acount + 1;
	end

end
*/
wire slow_clock = AUD_DACLRCK;

assign LEDG[7] = slow_clock;
assign audio_outR = aud_out;
assign audio_outL = aud_out; 

/*
always@(posedge AUD_DACLRCK) begin
	if (reset) begin
		acount  <= 6'd0;
		aud_out <= 16'd0;
	end
	if (acount > 50 && ~KEY[3]) begin
		acount <= 6'd0;
		aud_out <= sq_out ^ 16'h0FFF;
	end
	else begin
		if (KEY[3]) begin
		aud_out <= u_mid[17:2];
		end
		acount <= acount + 6'd1;
	end
end
	*/

endmodule