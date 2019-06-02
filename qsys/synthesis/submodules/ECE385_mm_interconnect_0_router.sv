// (C) 2001-2018 Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files from any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License Subscription 
// Agreement, Intel FPGA IP License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Intel and sold by 
// Intel or its authorized distributors.  Please refer to the applicable 
// agreement for further details.



// Your use of Altera Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License Subscription 
// Agreement, Altera MegaCore Function License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


// $Id: //acds/rel/18.1std/ip/merlin/altera_merlin_router/altera_merlin_router.sv.terp#1 $
// $Revision: #1 $
// $Date: 2018/07/18 $
// $Author: psgswbuild $

// -------------------------------------------------------
// Merlin Router
//
// Asserts the appropriate one-hot encoded channel based on 
// either (a) the address or (b) the dest id. The DECODER_TYPE
// parameter controls this behaviour. 0 means address decoder,
// 1 means dest id decoder.
//
// In the case of (a), it also sets the destination id.
// -------------------------------------------------------

`timescale 1 ns / 1 ns

module ECE385_mm_interconnect_0_router_default_decode
  #(
     parameter DEFAULT_CHANNEL = 14,
               DEFAULT_WR_CHANNEL = -1,
               DEFAULT_RD_CHANNEL = -1,
               DEFAULT_DESTID = 22 
   )
  (output [100 - 95 : 0] default_destination_id,
   output [35-1 : 0] default_wr_channel,
   output [35-1 : 0] default_rd_channel,
   output [35-1 : 0] default_src_channel
  );

  assign default_destination_id = 
    DEFAULT_DESTID[100 - 95 : 0];

  generate
    if (DEFAULT_CHANNEL == -1) begin : no_default_channel_assignment
      assign default_src_channel = '0;
    end
    else begin : default_channel_assignment
      assign default_src_channel = 35'b1 << DEFAULT_CHANNEL;
    end
  endgenerate

  generate
    if (DEFAULT_RD_CHANNEL == -1) begin : no_default_rw_channel_assignment
      assign default_wr_channel = '0;
      assign default_rd_channel = '0;
    end
    else begin : default_rw_channel_assignment
      assign default_wr_channel = 35'b1 << DEFAULT_WR_CHANNEL;
      assign default_rd_channel = 35'b1 << DEFAULT_RD_CHANNEL;
    end
  endgenerate

endmodule


module ECE385_mm_interconnect_0_router
(
    // -------------------
    // Clock & Reset
    // -------------------
    input clk,
    input reset,

    // -------------------
    // Command Sink (Input)
    // -------------------
    input                       sink_valid,
    input  [114-1 : 0]    sink_data,
    input                       sink_startofpacket,
    input                       sink_endofpacket,
    output                      sink_ready,

    // -------------------
    // Command Source (Output)
    // -------------------
    output                          src_valid,
    output reg [114-1    : 0] src_data,
    output reg [35-1 : 0] src_channel,
    output                          src_startofpacket,
    output                          src_endofpacket,
    input                           src_ready
);

    // -------------------------------------------------------
    // Local parameters and variables
    // -------------------------------------------------------
    localparam PKT_ADDR_H = 67;
    localparam PKT_ADDR_L = 36;
    localparam PKT_DEST_ID_H = 100;
    localparam PKT_DEST_ID_L = 95;
    localparam PKT_PROTECTION_H = 104;
    localparam PKT_PROTECTION_L = 102;
    localparam ST_DATA_W = 114;
    localparam ST_CHANNEL_W = 35;
    localparam DECODER_TYPE = 0;

    localparam PKT_TRANS_WRITE = 70;
    localparam PKT_TRANS_READ  = 71;

    localparam PKT_ADDR_W = PKT_ADDR_H-PKT_ADDR_L + 1;
    localparam PKT_DEST_ID_W = PKT_DEST_ID_H-PKT_DEST_ID_L + 1;



    // -------------------------------------------------------
    // Figure out the number of bits to mask off for each slave span
    // during address decoding
    // -------------------------------------------------------
    localparam PAD0 = log2ceil(64'h1000 - 64'h0); 
    localparam PAD1 = log2ceil(64'h2000 - 64'h1000); 
    localparam PAD2 = log2ceil(64'h3000 - 64'h2000); 
    localparam PAD3 = log2ceil(64'h4000 - 64'h3000); 
    localparam PAD4 = log2ceil(64'h8000 - 64'h4000); 
    localparam PAD5 = log2ceil(64'h9000 - 64'h8000); 
    localparam PAD6 = log2ceil(64'ha000 - 64'h9000); 
    localparam PAD7 = log2ceil(64'hb000 - 64'ha000); 
    localparam PAD8 = log2ceil(64'hc000 - 64'hb000); 
    localparam PAD9 = log2ceil(64'hd000 - 64'hc800); 
    localparam PAD10 = log2ceil(64'hd400 - 64'hd000); 
    localparam PAD11 = log2ceil(64'hd800 - 64'hd400); 
    localparam PAD12 = log2ceil(64'hd880 - 64'hd800); 
    localparam PAD13 = log2ceil(64'hd900 - 64'hd880); 
    localparam PAD14 = log2ceil(64'hd940 - 64'hd900); 
    localparam PAD15 = log2ceil(64'hd980 - 64'hd940); 
    localparam PAD16 = log2ceil(64'hd9c0 - 64'hd980); 
    localparam PAD17 = log2ceil(64'hda00 - 64'hd9c0); 
    localparam PAD18 = log2ceil(64'hda40 - 64'hda00); 
    localparam PAD19 = log2ceil(64'hda60 - 64'hda40); 
    localparam PAD20 = log2ceil(64'hda80 - 64'hda60); 
    localparam PAD21 = log2ceil(64'hdaa0 - 64'hda80); 
    localparam PAD22 = log2ceil(64'hdac0 - 64'hdaa0); 
    localparam PAD23 = log2ceil(64'hdae0 - 64'hdad0); 
    localparam PAD24 = log2ceil(64'hdaf0 - 64'hdae0); 
    localparam PAD25 = log2ceil(64'hdb00 - 64'hdaf0); 
    localparam PAD26 = log2ceil(64'hdb10 - 64'hdb00); 
    localparam PAD27 = log2ceil(64'hdb20 - 64'hdb10); 
    localparam PAD28 = log2ceil(64'hdb30 - 64'hdb20); 
    localparam PAD29 = log2ceil(64'hdb40 - 64'hdb30); 
    localparam PAD30 = log2ceil(64'hdb50 - 64'hdb48); 
    localparam PAD31 = log2ceil(64'hdb58 - 64'hdb50); 
    localparam PAD32 = log2ceil(64'h80000 - 64'h40000); 
    localparam PAD33 = log2ceil(64'h800000 - 64'h400000); 
    localparam PAD34 = log2ceil(64'h10000000 - 64'h8000000); 
    // -------------------------------------------------------
    // Work out which address bits are significant based on the
    // address range of the slaves. If the required width is too
    // large or too small, we use the address field width instead.
    // -------------------------------------------------------
    localparam ADDR_RANGE = 64'h10000000;
    localparam RANGE_ADDR_WIDTH = log2ceil(ADDR_RANGE);
    localparam OPTIMIZED_ADDR_H = (RANGE_ADDR_WIDTH > PKT_ADDR_W) ||
                                  (RANGE_ADDR_WIDTH == 0) ?
                                        PKT_ADDR_H :
                                        PKT_ADDR_L + RANGE_ADDR_WIDTH - 1;

    localparam RG = RANGE_ADDR_WIDTH-1;
    localparam REAL_ADDRESS_RANGE = OPTIMIZED_ADDR_H - PKT_ADDR_L;

      reg [PKT_ADDR_W-1 : 0] address;
      always @* begin
        address = {PKT_ADDR_W{1'b0}};
        address [REAL_ADDRESS_RANGE:0] = sink_data[OPTIMIZED_ADDR_H : PKT_ADDR_L];
      end   

    // -------------------------------------------------------
    // Pass almost everything through, untouched
    // -------------------------------------------------------
    assign sink_ready        = src_ready;
    assign src_valid         = sink_valid;
    assign src_startofpacket = sink_startofpacket;
    assign src_endofpacket   = sink_endofpacket;
    wire [PKT_DEST_ID_W-1:0] default_destid;
    wire [35-1 : 0] default_src_channel;




    // -------------------------------------------------------
    // Write and read transaction signals
    // -------------------------------------------------------
    wire read_transaction;
    assign read_transaction  = sink_data[PKT_TRANS_READ];


    ECE385_mm_interconnect_0_router_default_decode the_default_decode(
      .default_destination_id (default_destid),
      .default_wr_channel   (),
      .default_rd_channel   (),
      .default_src_channel  (default_src_channel)
    );

    always @* begin
        src_data    = sink_data;
        src_channel = default_src_channel;
        src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = default_destid;

        // --------------------------------------------------
        // Address Decoder
        // Sets the channel and destination ID based on the address
        // --------------------------------------------------

    // ( 0x0 .. 0x1000 )
    if ( {address[RG:PAD0],{PAD0{1'b0}}} == 28'h0   ) begin
            src_channel = 35'b00000100000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 33;
    end

    // ( 0x1000 .. 0x2000 )
    if ( {address[RG:PAD1],{PAD1{1'b0}}} == 28'h1000   ) begin
            src_channel = 35'b00000010000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 32;
    end

    // ( 0x2000 .. 0x3000 )
    if ( {address[RG:PAD2],{PAD2{1'b0}}} == 28'h2000   ) begin
            src_channel = 35'b00000001000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 31;
    end

    // ( 0x3000 .. 0x4000 )
    if ( {address[RG:PAD3],{PAD3{1'b0}}} == 28'h3000   ) begin
            src_channel = 35'b00000000100000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 30;
    end

    // ( 0x4000 .. 0x8000 )
    if ( {address[RG:PAD4],{PAD4{1'b0}}} == 28'h4000   ) begin
            src_channel = 35'b00001000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 0;
    end

    // ( 0x8000 .. 0x9000 )
    if ( {address[RG:PAD5],{PAD5{1'b0}}} == 28'h8000   ) begin
            src_channel = 35'b00000000001000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 29;
    end

    // ( 0x9000 .. 0xa000 )
    if ( {address[RG:PAD6],{PAD6{1'b0}}} == 28'h9000   ) begin
            src_channel = 35'b00000000000100000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 28;
    end

    // ( 0xa000 .. 0xb000 )
    if ( {address[RG:PAD7],{PAD7{1'b0}}} == 28'ha000   ) begin
            src_channel = 35'b00000000000010000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 27;
    end

    // ( 0xb000 .. 0xc000 )
    if ( {address[RG:PAD8],{PAD8{1'b0}}} == 28'hb000   ) begin
            src_channel = 35'b00000000000001000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 26;
    end

    // ( 0xc800 .. 0xd000 )
    if ( {address[RG:PAD9],{PAD9{1'b0}}} == 28'hc800   ) begin
            src_channel = 35'b00000000000000000000000100000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 15;
    end

    // ( 0xd000 .. 0xd400 )
    if ( {address[RG:PAD10],{PAD10{1'b0}}} == 28'hd000   ) begin
            src_channel = 35'b10000000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 24;
    end

    // ( 0xd400 .. 0xd800 )
    if ( {address[RG:PAD11],{PAD11{1'b0}}} == 28'hd400   ) begin
            src_channel = 35'b00000000000000000000000000000010000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 34;
    end

    // ( 0xd800 .. 0xd880 )
    if ( {address[RG:PAD12],{PAD12{1'b0}}} == 28'hd800   ) begin
            src_channel = 35'b00000000000000000000000000000000100;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 3;
    end

    // ( 0xd880 .. 0xd900 )
    if ( {address[RG:PAD13],{PAD13{1'b0}}} == 28'hd880   ) begin
            src_channel = 35'b00000000000000000000000000000000010;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 6;
    end

    // ( 0xd900 .. 0xd940 )
    if ( {address[RG:PAD14],{PAD14{1'b0}}} == 28'hd900   ) begin
            src_channel = 35'b00000000000000000000000010000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 16;
    end

    // ( 0xd940 .. 0xd980 )
    if ( {address[RG:PAD15],{PAD15{1'b0}}} == 28'hd940   ) begin
            src_channel = 35'b00000000000000000000000001000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 8;
    end

    // ( 0xd980 .. 0xd9c0 )
    if ( {address[RG:PAD16],{PAD16{1'b0}}} == 28'hd980   ) begin
            src_channel = 35'b00000000000000000000000000100000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 7;
    end

    // ( 0xd9c0 .. 0xda00 )
    if ( {address[RG:PAD17],{PAD17{1'b0}}} == 28'hd9c0   ) begin
            src_channel = 35'b00000000000000000000000000010000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 5;
    end

    // ( 0xda00 .. 0xda40 )
    if ( {address[RG:PAD18],{PAD18{1'b0}}} == 28'hda00   ) begin
            src_channel = 35'b00000000000000000000000000001000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 4;
    end

    // ( 0xda40 .. 0xda60 )
    if ( {address[RG:PAD19],{PAD19{1'b0}}} == 28'hda40   ) begin
            src_channel = 35'b00000000000000100000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 9;
    end

    // ( 0xda60 .. 0xda80 )
    if ( {address[RG:PAD20],{PAD20{1'b0}}} == 28'hda60   ) begin
            src_channel = 35'b00000000000000010000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 11;
    end

    // ( 0xda80 .. 0xdaa0 )
    if ( {address[RG:PAD21],{PAD21{1'b0}}} == 28'hda80   ) begin
            src_channel = 35'b00000000000000000010000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 21;
    end

    // ( 0xdaa0 .. 0xdac0 )
    if ( {address[RG:PAD22],{PAD22{1'b0}}} == 28'hdaa0   ) begin
            src_channel = 35'b00000000000000000001000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 12;
    end

    // ( 0xdad0 .. 0xdae0 )
    if ( {address[RG:PAD23],{PAD23{1'b0}}} == 28'hdad0   ) begin
            src_channel = 35'b01000000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 25;
    end

    // ( 0xdae0 .. 0xdaf0 )
    if ( {address[RG:PAD24],{PAD24{1'b0}}} == 28'hdae0  && read_transaction  ) begin
            src_channel = 35'b00100000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 2;
    end

    // ( 0xdaf0 .. 0xdb00 )
    if ( {address[RG:PAD25],{PAD25{1'b0}}} == 28'hdaf0   ) begin
            src_channel = 35'b00010000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 1;
    end

    // ( 0xdb00 .. 0xdb10 )
    if ( {address[RG:PAD26],{PAD26{1'b0}}} == 28'hdb00  && read_transaction  ) begin
            src_channel = 35'b00000000010000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 14;
    end

    // ( 0xdb10 .. 0xdb20 )
    if ( {address[RG:PAD27],{PAD27{1'b0}}} == 28'hdb10  && read_transaction  ) begin
            src_channel = 35'b00000000000000001000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 13;
    end

    // ( 0xdb20 .. 0xdb30 )
    if ( {address[RG:PAD28],{PAD28{1'b0}}} == 28'hdb20  && read_transaction  ) begin
            src_channel = 35'b00000000000000000100000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 10;
    end

    // ( 0xdb30 .. 0xdb40 )
    if ( {address[RG:PAD29],{PAD29{1'b0}}} == 28'hdb30   ) begin
            src_channel = 35'b00000000000000000000001000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 19;
    end

    // ( 0xdb48 .. 0xdb50 )
    if ( {address[RG:PAD30],{PAD30{1'b0}}} == 28'hdb48  && read_transaction  ) begin
            src_channel = 35'b00000000000000000000000000000100000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 20;
    end

    // ( 0xdb50 .. 0xdb58 )
    if ( {address[RG:PAD31],{PAD31{1'b0}}} == 28'hdb50   ) begin
            src_channel = 35'b00000000000000000000000000000000001;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 17;
    end

    // ( 0x40000 .. 0x80000 )
    if ( {address[RG:PAD32],{PAD32{1'b0}}} == 28'h40000   ) begin
            src_channel = 35'b00000000000000000000010000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 18;
    end

    // ( 0x400000 .. 0x800000 )
    if ( {address[RG:PAD33],{PAD33{1'b0}}} == 28'h400000   ) begin
            src_channel = 35'b00000000000000000000000000000001000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 23;
    end

    // ( 0x8000000 .. 0x10000000 )
    if ( {address[RG:PAD34],{PAD34{1'b0}}} == 28'h8000000   ) begin
            src_channel = 35'b00000000000000000000100000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 22;
    end

end


    // --------------------------------------------------
    // Ceil(log2()) function
    // --------------------------------------------------
    function integer log2ceil;
        input reg[65:0] val;
        reg [65:0] i;

        begin
            i = 1;
            log2ceil = 0;

            while (i < val) begin
                log2ceil = log2ceil + 1;
                i = i << 1;
            end
        end
    endfunction

endmodule


