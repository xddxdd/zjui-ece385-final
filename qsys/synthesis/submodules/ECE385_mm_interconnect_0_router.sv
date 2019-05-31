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
     parameter DEFAULT_CHANNEL = 13,
               DEFAULT_WR_CHANNEL = -1,
               DEFAULT_RD_CHANNEL = -1,
               DEFAULT_DESTID = 21 
   )
  (output [96 - 91 : 0] default_destination_id,
   output [34-1 : 0] default_wr_channel,
   output [34-1 : 0] default_rd_channel,
   output [34-1 : 0] default_src_channel
  );

  assign default_destination_id = 
    DEFAULT_DESTID[96 - 91 : 0];

  generate
    if (DEFAULT_CHANNEL == -1) begin : no_default_channel_assignment
      assign default_src_channel = '0;
    end
    else begin : default_channel_assignment
      assign default_src_channel = 34'b1 << DEFAULT_CHANNEL;
    end
  endgenerate

  generate
    if (DEFAULT_RD_CHANNEL == -1) begin : no_default_rw_channel_assignment
      assign default_wr_channel = '0;
      assign default_rd_channel = '0;
    end
    else begin : default_rw_channel_assignment
      assign default_wr_channel = 34'b1 << DEFAULT_WR_CHANNEL;
      assign default_rd_channel = 34'b1 << DEFAULT_RD_CHANNEL;
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
    input  [110-1 : 0]    sink_data,
    input                       sink_startofpacket,
    input                       sink_endofpacket,
    output                      sink_ready,

    // -------------------
    // Command Source (Output)
    // -------------------
    output                          src_valid,
    output reg [110-1    : 0] src_data,
    output reg [34-1 : 0] src_channel,
    output                          src_startofpacket,
    output                          src_endofpacket,
    input                           src_ready
);

    // -------------------------------------------------------
    // Local parameters and variables
    // -------------------------------------------------------
    localparam PKT_ADDR_H = 63;
    localparam PKT_ADDR_L = 36;
    localparam PKT_DEST_ID_H = 96;
    localparam PKT_DEST_ID_L = 91;
    localparam PKT_PROTECTION_H = 100;
    localparam PKT_PROTECTION_L = 98;
    localparam ST_DATA_W = 110;
    localparam ST_CHANNEL_W = 34;
    localparam DECODER_TYPE = 0;

    localparam PKT_TRANS_WRITE = 66;
    localparam PKT_TRANS_READ  = 67;

    localparam PKT_ADDR_W = PKT_ADDR_H-PKT_ADDR_L + 1;
    localparam PKT_DEST_ID_W = PKT_DEST_ID_H-PKT_DEST_ID_L + 1;



    // -------------------------------------------------------
    // Figure out the number of bits to mask off for each slave span
    // during address decoding
    // -------------------------------------------------------
    localparam PAD0 = log2ceil(64'h2000 - 64'h0); 
    localparam PAD1 = log2ceil(64'h4000 - 64'h2000); 
    localparam PAD2 = log2ceil(64'h8000 - 64'h4000); 
    localparam PAD3 = log2ceil(64'ha000 - 64'h8000); 
    localparam PAD4 = log2ceil(64'hc000 - 64'ha000); 
    localparam PAD5 = log2ceil(64'he000 - 64'hc000); 
    localparam PAD6 = log2ceil(64'h10000 - 64'he000); 
    localparam PAD7 = log2ceil(64'h12000 - 64'h10000); 
    localparam PAD8 = log2ceil(64'h14000 - 64'h12000); 
    localparam PAD9 = log2ceil(64'h15000 - 64'h14800); 
    localparam PAD10 = log2ceil(64'h15400 - 64'h15000); 
    localparam PAD11 = log2ceil(64'h15800 - 64'h15400); 
    localparam PAD12 = log2ceil(64'h15880 - 64'h15800); 
    localparam PAD13 = log2ceil(64'h15900 - 64'h15880); 
    localparam PAD14 = log2ceil(64'h15940 - 64'h15900); 
    localparam PAD15 = log2ceil(64'h15980 - 64'h15940); 
    localparam PAD16 = log2ceil(64'h159c0 - 64'h15980); 
    localparam PAD17 = log2ceil(64'h15a00 - 64'h159c0); 
    localparam PAD18 = log2ceil(64'h15a20 - 64'h15a00); 
    localparam PAD19 = log2ceil(64'h15a40 - 64'h15a20); 
    localparam PAD20 = log2ceil(64'h15a60 - 64'h15a40); 
    localparam PAD21 = log2ceil(64'h15a80 - 64'h15a60); 
    localparam PAD22 = log2ceil(64'h15aa0 - 64'h15a90); 
    localparam PAD23 = log2ceil(64'h15ab0 - 64'h15aa0); 
    localparam PAD24 = log2ceil(64'h15ac0 - 64'h15ab0); 
    localparam PAD25 = log2ceil(64'h15ae0 - 64'h15ad0); 
    localparam PAD26 = log2ceil(64'h15af0 - 64'h15ae0); 
    localparam PAD27 = log2ceil(64'h15b00 - 64'h15af0); 
    localparam PAD28 = log2ceil(64'h15b10 - 64'h15b00); 
    localparam PAD29 = log2ceil(64'h15b20 - 64'h15b18); 
    localparam PAD30 = log2ceil(64'h15b28 - 64'h15b20); 
    localparam PAD31 = log2ceil(64'h80000 - 64'h40000); 
    localparam PAD32 = log2ceil(64'h800000 - 64'h400000); 
    localparam PAD33 = log2ceil(64'h10000000 - 64'h8000000); 
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
    wire [34-1 : 0] default_src_channel;




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

    // ( 0x0 .. 0x2000 )
    if ( {address[RG:PAD0],{PAD0{1'b0}}} == 28'h0   ) begin
            src_channel = 34'b0000010000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 32;
    end

    // ( 0x2000 .. 0x4000 )
    if ( {address[RG:PAD1],{PAD1{1'b0}}} == 28'h2000   ) begin
            src_channel = 34'b0000001000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 31;
    end

    // ( 0x4000 .. 0x8000 )
    if ( {address[RG:PAD2],{PAD2{1'b0}}} == 28'h4000   ) begin
            src_channel = 34'b0000100000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 0;
    end

    // ( 0x8000 .. 0xa000 )
    if ( {address[RG:PAD3],{PAD3{1'b0}}} == 28'h8000   ) begin
            src_channel = 34'b0000000100000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 30;
    end

    // ( 0xa000 .. 0xc000 )
    if ( {address[RG:PAD4],{PAD4{1'b0}}} == 28'ha000   ) begin
            src_channel = 34'b0000000010000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 29;
    end

    // ( 0xc000 .. 0xe000 )
    if ( {address[RG:PAD5],{PAD5{1'b0}}} == 28'hc000   ) begin
            src_channel = 34'b0000000000100000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 28;
    end

    // ( 0xe000 .. 0x10000 )
    if ( {address[RG:PAD6],{PAD6{1'b0}}} == 28'he000   ) begin
            src_channel = 34'b0000000000010000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 27;
    end

    // ( 0x10000 .. 0x12000 )
    if ( {address[RG:PAD7],{PAD7{1'b0}}} == 28'h10000   ) begin
            src_channel = 34'b0000000000001000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 26;
    end

    // ( 0x12000 .. 0x14000 )
    if ( {address[RG:PAD8],{PAD8{1'b0}}} == 28'h12000   ) begin
            src_channel = 34'b0000000000000100000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 25;
    end

    // ( 0x14800 .. 0x15000 )
    if ( {address[RG:PAD9],{PAD9{1'b0}}} == 28'h14800   ) begin
            src_channel = 34'b0000000000000000000000010000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 15;
    end

    // ( 0x15000 .. 0x15400 )
    if ( {address[RG:PAD10],{PAD10{1'b0}}} == 28'h15000   ) begin
            src_channel = 34'b1000000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 23;
    end

    // ( 0x15400 .. 0x15800 )
    if ( {address[RG:PAD11],{PAD11{1'b0}}} == 28'h15400   ) begin
            src_channel = 34'b0000000000000000000000000000010000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 33;
    end

    // ( 0x15800 .. 0x15880 )
    if ( {address[RG:PAD12],{PAD12{1'b0}}} == 28'h15800   ) begin
            src_channel = 34'b0000000000000000000000000000000100;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 3;
    end

    // ( 0x15880 .. 0x15900 )
    if ( {address[RG:PAD13],{PAD13{1'b0}}} == 28'h15880   ) begin
            src_channel = 34'b0000000000000000000000000000000010;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 6;
    end

    // ( 0x15900 .. 0x15940 )
    if ( {address[RG:PAD14],{PAD14{1'b0}}} == 28'h15900   ) begin
            src_channel = 34'b0000000000000000000000001000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 8;
    end

    // ( 0x15940 .. 0x15980 )
    if ( {address[RG:PAD15],{PAD15{1'b0}}} == 28'h15940   ) begin
            src_channel = 34'b0000000000000000000000000100000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 7;
    end

    // ( 0x15980 .. 0x159c0 )
    if ( {address[RG:PAD16],{PAD16{1'b0}}} == 28'h15980   ) begin
            src_channel = 34'b0000000000000000000000000010000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 5;
    end

    // ( 0x159c0 .. 0x15a00 )
    if ( {address[RG:PAD17],{PAD17{1'b0}}} == 28'h159c0   ) begin
            src_channel = 34'b0000000000000000000000000001000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 4;
    end

    // ( 0x15a00 .. 0x15a20 )
    if ( {address[RG:PAD18],{PAD18{1'b0}}} == 28'h15a00   ) begin
            src_channel = 34'b0000000000000010000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 9;
    end

    // ( 0x15a20 .. 0x15a40 )
    if ( {address[RG:PAD19],{PAD19{1'b0}}} == 28'h15a20   ) begin
            src_channel = 34'b0000000000000001000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 11;
    end

    // ( 0x15a40 .. 0x15a60 )
    if ( {address[RG:PAD20],{PAD20{1'b0}}} == 28'h15a40   ) begin
            src_channel = 34'b0000000000000000001000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 20;
    end

    // ( 0x15a60 .. 0x15a80 )
    if ( {address[RG:PAD21],{PAD21{1'b0}}} == 28'h15a60   ) begin
            src_channel = 34'b0000000000000000000100000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 12;
    end

    // ( 0x15a90 .. 0x15aa0 )
    if ( {address[RG:PAD22],{PAD22{1'b0}}} == 28'h15a90   ) begin
            src_channel = 34'b0100000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 24;
    end

    // ( 0x15aa0 .. 0x15ab0 )
    if ( {address[RG:PAD23],{PAD23{1'b0}}} == 28'h15aa0  && read_transaction  ) begin
            src_channel = 34'b0010000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 2;
    end

    // ( 0x15ab0 .. 0x15ac0 )
    if ( {address[RG:PAD24],{PAD24{1'b0}}} == 28'h15ab0   ) begin
            src_channel = 34'b0001000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 1;
    end

    // ( 0x15ad0 .. 0x15ae0 )
    if ( {address[RG:PAD25],{PAD25{1'b0}}} == 28'h15ad0  && read_transaction  ) begin
            src_channel = 34'b0000000001000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 14;
    end

    // ( 0x15ae0 .. 0x15af0 )
    if ( {address[RG:PAD26],{PAD26{1'b0}}} == 28'h15ae0  && read_transaction  ) begin
            src_channel = 34'b0000000000000000100000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 13;
    end

    // ( 0x15af0 .. 0x15b00 )
    if ( {address[RG:PAD27],{PAD27{1'b0}}} == 28'h15af0  && read_transaction  ) begin
            src_channel = 34'b0000000000000000010000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 10;
    end

    // ( 0x15b00 .. 0x15b10 )
    if ( {address[RG:PAD28],{PAD28{1'b0}}} == 28'h15b00   ) begin
            src_channel = 34'b0000000000000000000000100000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 18;
    end

    // ( 0x15b18 .. 0x15b20 )
    if ( {address[RG:PAD29],{PAD29{1'b0}}} == 28'h15b18  && read_transaction  ) begin
            src_channel = 34'b0000000000000000000000000000100000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 19;
    end

    // ( 0x15b20 .. 0x15b28 )
    if ( {address[RG:PAD30],{PAD30{1'b0}}} == 28'h15b20   ) begin
            src_channel = 34'b0000000000000000000000000000000001;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 16;
    end

    // ( 0x40000 .. 0x80000 )
    if ( {address[RG:PAD31],{PAD31{1'b0}}} == 28'h40000   ) begin
            src_channel = 34'b0000000000000000000001000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 17;
    end

    // ( 0x400000 .. 0x800000 )
    if ( {address[RG:PAD32],{PAD32{1'b0}}} == 28'h400000   ) begin
            src_channel = 34'b0000000000000000000000000000001000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 22;
    end

    // ( 0x8000000 .. 0x10000000 )
    if ( {address[RG:PAD33],{PAD33{1'b0}}} == 28'h8000000   ) begin
            src_channel = 34'b0000000000000000000010000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 21;
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


