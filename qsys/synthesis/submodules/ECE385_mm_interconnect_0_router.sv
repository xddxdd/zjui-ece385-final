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
     parameter DEFAULT_CHANNEL = 7,
               DEFAULT_WR_CHANNEL = -1,
               DEFAULT_RD_CHANNEL = -1,
               DEFAULT_DESTID = 12 
   )
  (output [94 - 90 : 0] default_destination_id,
   output [25-1 : 0] default_wr_channel,
   output [25-1 : 0] default_rd_channel,
   output [25-1 : 0] default_src_channel
  );

  assign default_destination_id = 
    DEFAULT_DESTID[94 - 90 : 0];

  generate
    if (DEFAULT_CHANNEL == -1) begin : no_default_channel_assignment
      assign default_src_channel = '0;
    end
    else begin : default_channel_assignment
      assign default_src_channel = 25'b1 << DEFAULT_CHANNEL;
    end
  endgenerate

  generate
    if (DEFAULT_RD_CHANNEL == -1) begin : no_default_rw_channel_assignment
      assign default_wr_channel = '0;
      assign default_rd_channel = '0;
    end
    else begin : default_rw_channel_assignment
      assign default_wr_channel = 25'b1 << DEFAULT_WR_CHANNEL;
      assign default_rd_channel = 25'b1 << DEFAULT_RD_CHANNEL;
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
    input  [108-1 : 0]    sink_data,
    input                       sink_startofpacket,
    input                       sink_endofpacket,
    output                      sink_ready,

    // -------------------
    // Command Source (Output)
    // -------------------
    output                          src_valid,
    output reg [108-1    : 0] src_data,
    output reg [25-1 : 0] src_channel,
    output                          src_startofpacket,
    output                          src_endofpacket,
    input                           src_ready
);

    // -------------------------------------------------------
    // Local parameters and variables
    // -------------------------------------------------------
    localparam PKT_ADDR_H = 63;
    localparam PKT_ADDR_L = 36;
    localparam PKT_DEST_ID_H = 94;
    localparam PKT_DEST_ID_L = 90;
    localparam PKT_PROTECTION_H = 98;
    localparam PKT_PROTECTION_L = 96;
    localparam ST_DATA_W = 108;
    localparam ST_CHANNEL_W = 25;
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
    localparam PAD1 = log2ceil(64'h440000 - 64'h420000); 
    localparam PAD2 = log2ceil(64'h442000 - 64'h440000); 
    localparam PAD3 = log2ceil(64'h444000 - 64'h442000); 
    localparam PAD4 = log2ceil(64'h446000 - 64'h444000); 
    localparam PAD5 = log2ceil(64'h448000 - 64'h446000); 
    localparam PAD6 = log2ceil(64'h44a000 - 64'h448000); 
    localparam PAD7 = log2ceil(64'h44c000 - 64'h44a000); 
    localparam PAD8 = log2ceil(64'h44e000 - 64'h44c000); 
    localparam PAD9 = log2ceil(64'h450000 - 64'h44e000); 
    localparam PAD10 = log2ceil(64'h452000 - 64'h450000); 
    localparam PAD11 = log2ceil(64'h453000 - 64'h452800); 
    localparam PAD12 = log2ceil(64'h453400 - 64'h453000); 
    localparam PAD13 = log2ceil(64'h453800 - 64'h453400); 
    localparam PAD14 = log2ceil(64'h453820 - 64'h453800); 
    localparam PAD15 = log2ceil(64'h453840 - 64'h453820); 
    localparam PAD16 = log2ceil(64'h453860 - 64'h453840); 
    localparam PAD17 = log2ceil(64'h453880 - 64'h453860); 
    localparam PAD18 = log2ceil(64'h4538a0 - 64'h453890); 
    localparam PAD19 = log2ceil(64'h4538b0 - 64'h4538a0); 
    localparam PAD20 = log2ceil(64'h4538c0 - 64'h4538b0); 
    localparam PAD21 = log2ceil(64'h4538d0 - 64'h4538c0); 
    localparam PAD22 = log2ceil(64'h4538e0 - 64'h4538d8); 
    localparam PAD23 = log2ceil(64'h4538e8 - 64'h4538e0); 
    localparam PAD24 = log2ceil(64'h10000000 - 64'h8000000); 
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
    wire [25-1 : 0] default_src_channel;




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
            src_channel = 25'b0000000000000000000000010;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 13;
    end

    // ( 0x420000 .. 0x440000 )
    if ( {address[RG:PAD1],{PAD1{1'b0}}} == 28'h420000   ) begin
            src_channel = 25'b0000000000000000001000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 8;
    end

    // ( 0x440000 .. 0x442000 )
    if ( {address[RG:PAD2],{PAD2{1'b0}}} == 28'h440000   ) begin
            src_channel = 25'b0100000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 23;
    end

    // ( 0x442000 .. 0x444000 )
    if ( {address[RG:PAD3],{PAD3{1'b0}}} == 28'h442000   ) begin
            src_channel = 25'b0010000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 22;
    end

    // ( 0x444000 .. 0x446000 )
    if ( {address[RG:PAD4],{PAD4{1'b0}}} == 28'h444000   ) begin
            src_channel = 25'b0001000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 21;
    end

    // ( 0x446000 .. 0x448000 )
    if ( {address[RG:PAD5],{PAD5{1'b0}}} == 28'h446000   ) begin
            src_channel = 25'b0000100000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 20;
    end

    // ( 0x448000 .. 0x44a000 )
    if ( {address[RG:PAD6],{PAD6{1'b0}}} == 28'h448000   ) begin
            src_channel = 25'b0000010000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 19;
    end

    // ( 0x44a000 .. 0x44c000 )
    if ( {address[RG:PAD7],{PAD7{1'b0}}} == 28'h44a000   ) begin
            src_channel = 25'b0000000100000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 18;
    end

    // ( 0x44c000 .. 0x44e000 )
    if ( {address[RG:PAD8],{PAD8{1'b0}}} == 28'h44c000   ) begin
            src_channel = 25'b0000000010000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 17;
    end

    // ( 0x44e000 .. 0x450000 )
    if ( {address[RG:PAD9],{PAD9{1'b0}}} == 28'h44e000   ) begin
            src_channel = 25'b0000000001000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 16;
    end

    // ( 0x450000 .. 0x452000 )
    if ( {address[RG:PAD10],{PAD10{1'b0}}} == 28'h450000   ) begin
            src_channel = 25'b0000000000100000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 15;
    end

    // ( 0x452800 .. 0x453000 )
    if ( {address[RG:PAD11],{PAD11{1'b0}}} == 28'h452800   ) begin
            src_channel = 25'b0000000000000000000010000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 6;
    end

    // ( 0x453000 .. 0x453400 )
    if ( {address[RG:PAD12],{PAD12{1'b0}}} == 28'h453000   ) begin
            src_channel = 25'b0000000000000000000000100;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 24;
    end

    // ( 0x453400 .. 0x453800 )
    if ( {address[RG:PAD13],{PAD13{1'b0}}} == 28'h453400   ) begin
            src_channel = 25'b1000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 14;
    end

    // ( 0x453800 .. 0x453820 )
    if ( {address[RG:PAD14],{PAD14{1'b0}}} == 28'h453800   ) begin
            src_channel = 25'b0000000000010000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 0;
    end

    // ( 0x453820 .. 0x453840 )
    if ( {address[RG:PAD15],{PAD15{1'b0}}} == 28'h453820   ) begin
            src_channel = 25'b0000000000001000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 2;
    end

    // ( 0x453840 .. 0x453860 )
    if ( {address[RG:PAD16],{PAD16{1'b0}}} == 28'h453840   ) begin
            src_channel = 25'b0000000000000001000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 11;
    end

    // ( 0x453860 .. 0x453880 )
    if ( {address[RG:PAD17],{PAD17{1'b0}}} == 28'h453860   ) begin
            src_channel = 25'b0000000000000000100000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 3;
    end

    // ( 0x453890 .. 0x4538a0 )
    if ( {address[RG:PAD18],{PAD18{1'b0}}} == 28'h453890  && read_transaction  ) begin
            src_channel = 25'b0000001000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 5;
    end

    // ( 0x4538a0 .. 0x4538b0 )
    if ( {address[RG:PAD19],{PAD19{1'b0}}} == 28'h4538a0  && read_transaction  ) begin
            src_channel = 25'b0000000000000100000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 4;
    end

    // ( 0x4538b0 .. 0x4538c0 )
    if ( {address[RG:PAD20],{PAD20{1'b0}}} == 28'h4538b0  && read_transaction  ) begin
            src_channel = 25'b0000000000000010000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 1;
    end

    // ( 0x4538c0 .. 0x4538d0 )
    if ( {address[RG:PAD21],{PAD21{1'b0}}} == 28'h4538c0   ) begin
            src_channel = 25'b0000000000000000000100000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 9;
    end

    // ( 0x4538d8 .. 0x4538e0 )
    if ( {address[RG:PAD22],{PAD22{1'b0}}} == 28'h4538d8  && read_transaction  ) begin
            src_channel = 25'b0000000000000000000001000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 10;
    end

    // ( 0x4538e0 .. 0x4538e8 )
    if ( {address[RG:PAD23],{PAD23{1'b0}}} == 28'h4538e0   ) begin
            src_channel = 25'b0000000000000000000000001;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 7;
    end

    // ( 0x8000000 .. 0x10000000 )
    if ( {address[RG:PAD24],{PAD24{1'b0}}} == 28'h8000000   ) begin
            src_channel = 25'b0000000000000000010000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 12;
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


