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
               DEFAULT_DESTID = 23 
   )
  (output [96 - 91 : 0] default_destination_id,
   output [36-1 : 0] default_wr_channel,
   output [36-1 : 0] default_rd_channel,
   output [36-1 : 0] default_src_channel
  );

  assign default_destination_id = 
    DEFAULT_DESTID[96 - 91 : 0];

  generate
    if (DEFAULT_CHANNEL == -1) begin : no_default_channel_assignment
      assign default_src_channel = '0;
    end
    else begin : default_channel_assignment
      assign default_src_channel = 36'b1 << DEFAULT_CHANNEL;
    end
  endgenerate

  generate
    if (DEFAULT_RD_CHANNEL == -1) begin : no_default_rw_channel_assignment
      assign default_wr_channel = '0;
      assign default_rd_channel = '0;
    end
    else begin : default_rw_channel_assignment
      assign default_wr_channel = 36'b1 << DEFAULT_WR_CHANNEL;
      assign default_rd_channel = 36'b1 << DEFAULT_RD_CHANNEL;
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
    output reg [36-1 : 0] src_channel,
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
    localparam ST_CHANNEL_W = 36;
    localparam DECODER_TYPE = 0;

    localparam PKT_TRANS_WRITE = 66;
    localparam PKT_TRANS_READ  = 67;

    localparam PKT_ADDR_W = PKT_ADDR_H-PKT_ADDR_L + 1;
    localparam PKT_DEST_ID_W = PKT_DEST_ID_H-PKT_DEST_ID_L + 1;



    // -------------------------------------------------------
    // Figure out the number of bits to mask off for each slave span
    // during address decoding
    // -------------------------------------------------------
    localparam PAD0 = log2ceil(64'h400000 - 64'h0); 
    localparam PAD1 = log2ceil(64'h420000 - 64'h410000); 
    localparam PAD2 = log2ceil(64'h430000 - 64'h420000); 
    localparam PAD3 = log2ceil(64'h432000 - 64'h430000); 
    localparam PAD4 = log2ceil(64'h434000 - 64'h432000); 
    localparam PAD5 = log2ceil(64'h436000 - 64'h434000); 
    localparam PAD6 = log2ceil(64'h438000 - 64'h436000); 
    localparam PAD7 = log2ceil(64'h43a000 - 64'h438000); 
    localparam PAD8 = log2ceil(64'h43c000 - 64'h43a000); 
    localparam PAD9 = log2ceil(64'h43e000 - 64'h43c000); 
    localparam PAD10 = log2ceil(64'h440000 - 64'h43e000); 
    localparam PAD11 = log2ceil(64'h441000 - 64'h440800); 
    localparam PAD12 = log2ceil(64'h441400 - 64'h441000); 
    localparam PAD13 = log2ceil(64'h441800 - 64'h441400); 
    localparam PAD14 = log2ceil(64'h441880 - 64'h441800); 
    localparam PAD15 = log2ceil(64'h441900 - 64'h441880); 
    localparam PAD16 = log2ceil(64'h441940 - 64'h441900); 
    localparam PAD17 = log2ceil(64'h441980 - 64'h441940); 
    localparam PAD18 = log2ceil(64'h4419c0 - 64'h441980); 
    localparam PAD19 = log2ceil(64'h441a00 - 64'h4419c0); 
    localparam PAD20 = log2ceil(64'h441a20 - 64'h441a00); 
    localparam PAD21 = log2ceil(64'h441a40 - 64'h441a20); 
    localparam PAD22 = log2ceil(64'h441a60 - 64'h441a40); 
    localparam PAD23 = log2ceil(64'h441a80 - 64'h441a60); 
    localparam PAD24 = log2ceil(64'h441aa0 - 64'h441a90); 
    localparam PAD25 = log2ceil(64'h441ab0 - 64'h441aa0); 
    localparam PAD26 = log2ceil(64'h441ac0 - 64'h441ab0); 
    localparam PAD27 = log2ceil(64'h441ad0 - 64'h441ac0); 
    localparam PAD28 = log2ceil(64'h441ae0 - 64'h441ad0); 
    localparam PAD29 = log2ceil(64'h441af0 - 64'h441ae0); 
    localparam PAD30 = log2ceil(64'h441b00 - 64'h441af0); 
    localparam PAD31 = log2ceil(64'h441b10 - 64'h441b00); 
    localparam PAD32 = log2ceil(64'h441b20 - 64'h441b10); 
    localparam PAD33 = log2ceil(64'h441b30 - 64'h441b28); 
    localparam PAD34 = log2ceil(64'h441b38 - 64'h441b30); 
    localparam PAD35 = log2ceil(64'h10000000 - 64'h8000000); 
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
    wire [36-1 : 0] default_src_channel;




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

    // ( 0x0 .. 0x400000 )
    if ( {address[RG:PAD0],{PAD0{1'b0}}} == 28'h0   ) begin
            src_channel = 36'b000000000000000000000000000000001000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 24;
    end

    // ( 0x410000 .. 0x420000 )
    if ( {address[RG:PAD1],{PAD1{1'b0}}} == 28'h410000   ) begin
            src_channel = 36'b000010000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 0;
    end

    // ( 0x420000 .. 0x430000 )
    if ( {address[RG:PAD2],{PAD2{1'b0}}} == 28'h420000   ) begin
            src_channel = 36'b000000000000000000000010000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 19;
    end

    // ( 0x430000 .. 0x432000 )
    if ( {address[RG:PAD3],{PAD3{1'b0}}} == 28'h430000   ) begin
            src_channel = 36'b000000100000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 34;
    end

    // ( 0x432000 .. 0x434000 )
    if ( {address[RG:PAD4],{PAD4{1'b0}}} == 28'h432000   ) begin
            src_channel = 36'b000000010000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 33;
    end

    // ( 0x434000 .. 0x436000 )
    if ( {address[RG:PAD5],{PAD5{1'b0}}} == 28'h434000   ) begin
            src_channel = 36'b000000001000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 32;
    end

    // ( 0x436000 .. 0x438000 )
    if ( {address[RG:PAD6],{PAD6{1'b0}}} == 28'h436000   ) begin
            src_channel = 36'b000000000100000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 31;
    end

    // ( 0x438000 .. 0x43a000 )
    if ( {address[RG:PAD7],{PAD7{1'b0}}} == 28'h438000   ) begin
            src_channel = 36'b000000000001000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 30;
    end

    // ( 0x43a000 .. 0x43c000 )
    if ( {address[RG:PAD8],{PAD8{1'b0}}} == 28'h43a000   ) begin
            src_channel = 36'b000000000000100000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 29;
    end

    // ( 0x43c000 .. 0x43e000 )
    if ( {address[RG:PAD9],{PAD9{1'b0}}} == 28'h43c000   ) begin
            src_channel = 36'b000000000000010000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 28;
    end

    // ( 0x43e000 .. 0x440000 )
    if ( {address[RG:PAD10],{PAD10{1'b0}}} == 28'h43e000   ) begin
            src_channel = 36'b000000000000001000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 27;
    end

    // ( 0x440800 .. 0x441000 )
    if ( {address[RG:PAD11],{PAD11{1'b0}}} == 28'h440800   ) begin
            src_channel = 36'b000000000000000000000000010000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 17;
    end

    // ( 0x441000 .. 0x441400 )
    if ( {address[RG:PAD12],{PAD12{1'b0}}} == 28'h441000   ) begin
            src_channel = 36'b100000000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 25;
    end

    // ( 0x441400 .. 0x441800 )
    if ( {address[RG:PAD13],{PAD13{1'b0}}} == 28'h441400   ) begin
            src_channel = 36'b000000000000000000000000000000010000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 35;
    end

    // ( 0x441800 .. 0x441880 )
    if ( {address[RG:PAD14],{PAD14{1'b0}}} == 28'h441800   ) begin
            src_channel = 36'b000000000000000000000000000000000100;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 3;
    end

    // ( 0x441880 .. 0x441900 )
    if ( {address[RG:PAD15],{PAD15{1'b0}}} == 28'h441880   ) begin
            src_channel = 36'b000000000000000000000000000000000010;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 6;
    end

    // ( 0x441900 .. 0x441940 )
    if ( {address[RG:PAD16],{PAD16{1'b0}}} == 28'h441900   ) begin
            src_channel = 36'b000000000000000000000000001000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 8;
    end

    // ( 0x441940 .. 0x441980 )
    if ( {address[RG:PAD17],{PAD17{1'b0}}} == 28'h441940   ) begin
            src_channel = 36'b000000000000000000000000000100000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 7;
    end

    // ( 0x441980 .. 0x4419c0 )
    if ( {address[RG:PAD18],{PAD18{1'b0}}} == 28'h441980   ) begin
            src_channel = 36'b000000000000000000000000000010000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 5;
    end

    // ( 0x4419c0 .. 0x441a00 )
    if ( {address[RG:PAD19],{PAD19{1'b0}}} == 28'h4419c0   ) begin
            src_channel = 36'b000000000000000000000000000001000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 4;
    end

    // ( 0x441a00 .. 0x441a20 )
    if ( {address[RG:PAD20],{PAD20{1'b0}}} == 28'h441a00   ) begin
            src_channel = 36'b000000000000000100000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 10;
    end

    // ( 0x441a20 .. 0x441a40 )
    if ( {address[RG:PAD21],{PAD21{1'b0}}} == 28'h441a20   ) begin
            src_channel = 36'b000000000000000010000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 13;
    end

    // ( 0x441a40 .. 0x441a60 )
    if ( {address[RG:PAD22],{PAD22{1'b0}}} == 28'h441a40   ) begin
            src_channel = 36'b000000000000000000010000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 22;
    end

    // ( 0x441a60 .. 0x441a80 )
    if ( {address[RG:PAD23],{PAD23{1'b0}}} == 28'h441a60   ) begin
            src_channel = 36'b000000000000000000001000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 14;
    end

    // ( 0x441a90 .. 0x441aa0 )
    if ( {address[RG:PAD24],{PAD24{1'b0}}} == 28'h441a90   ) begin
            src_channel = 36'b000000000000000000000001000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 9;
    end

    // ( 0x441aa0 .. 0x441ab0 )
    if ( {address[RG:PAD25],{PAD25{1'b0}}} == 28'h441aa0   ) begin
            src_channel = 36'b010000000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 26;
    end

    // ( 0x441ab0 .. 0x441ac0 )
    if ( {address[RG:PAD26],{PAD26{1'b0}}} == 28'h441ab0  && read_transaction  ) begin
            src_channel = 36'b001000000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 2;
    end

    // ( 0x441ac0 .. 0x441ad0 )
    if ( {address[RG:PAD27],{PAD27{1'b0}}} == 28'h441ac0   ) begin
            src_channel = 36'b000100000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 1;
    end

    // ( 0x441ad0 .. 0x441ae0 )
    if ( {address[RG:PAD28],{PAD28{1'b0}}} == 28'h441ad0  && read_transaction  ) begin
            src_channel = 36'b000001000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 11;
    end

    // ( 0x441ae0 .. 0x441af0 )
    if ( {address[RG:PAD29],{PAD29{1'b0}}} == 28'h441ae0  && read_transaction  ) begin
            src_channel = 36'b000000000010000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 16;
    end

    // ( 0x441af0 .. 0x441b00 )
    if ( {address[RG:PAD30],{PAD30{1'b0}}} == 28'h441af0  && read_transaction  ) begin
            src_channel = 36'b000000000000000001000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 15;
    end

    // ( 0x441b00 .. 0x441b10 )
    if ( {address[RG:PAD31],{PAD31{1'b0}}} == 28'h441b00  && read_transaction  ) begin
            src_channel = 36'b000000000000000000100000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 12;
    end

    // ( 0x441b10 .. 0x441b20 )
    if ( {address[RG:PAD32],{PAD32{1'b0}}} == 28'h441b10   ) begin
            src_channel = 36'b000000000000000000000000100000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 20;
    end

    // ( 0x441b28 .. 0x441b30 )
    if ( {address[RG:PAD33],{PAD33{1'b0}}} == 28'h441b28  && read_transaction  ) begin
            src_channel = 36'b000000000000000000000000000000100000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 21;
    end

    // ( 0x441b30 .. 0x441b38 )
    if ( {address[RG:PAD34],{PAD34{1'b0}}} == 28'h441b30   ) begin
            src_channel = 36'b000000000000000000000000000000000001;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 18;
    end

    // ( 0x8000000 .. 0x10000000 )
    if ( {address[RG:PAD35],{PAD35{1'b0}}} == 28'h8000000   ) begin
            src_channel = 36'b000000000000000000000100000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 23;
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


