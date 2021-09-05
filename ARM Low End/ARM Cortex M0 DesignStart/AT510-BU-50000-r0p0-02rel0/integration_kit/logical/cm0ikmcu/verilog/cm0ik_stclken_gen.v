//-----------------------------------------------------------------------------
// The confidential and proprietary information contained in this file may
// only be used by a person authorised under and to the extent permitted
// by a subsisting licensing agreement from ARM Limited.
//
//            (C) COPYRIGHT 2008-2009 ARM Limited.
//                ALL RIGHTS RESERVED
//
// This entire notice must be reproduced on all copies of this file
// and copies of this file may only be made by a person if such person is
// permitted to do so under the terms of a subsisting license agreement
// from ARM Limited.
//
//      SVN Information
//
//      Checked In          : $Date: 2008-12-08 12:21:19 +0000 (Mon, 08 Dec 2008) $
//
//      Revision            : $Revision: 96209 $
//
//      Release Information : Cortex-M0-AT510-r0p0-01rel0
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
//      SysTick Clock Enable (STCLKEN) Generator
//-----------------------------------------------------------------------------
//
// This block generates STCLKEN. For this
//   o  A half-frequency signal is generated from STCLK
//   o  This signal is double synchronised to FCLK
//   o  STCLKEN is generated by detecting both edges on the synchronised signal
// Note that this circuit only generates STCLKEN when SCLK is running
//-----------------------------------------------------------------------------

module cm0ik_stclken_gen
  (input  wire  SCLK,
   input  wire  HRESETn,
   input  wire  STCLK,
   output wire  STCLKEN);
  
  // Generate a half-frequency even mark-space ratio
  // signal to ensure the rest of the circuit is
  // agnostic to the mark-space ratio of the raw STCLK
  // Each edge corresponds to a rising edge of raw STCLK
  reg 	stclk_div2;
  always @ (posedge STCLK or negedge HRESETn)
    if (!HRESETn)
      stclk_div2 <= 1'b0;
    else
      stclk_div2 <= ~stclk_div2;

  // Double-synchronise generated clock onto SCLK
  // and assert STCLKEN when an edge (of either polarity)
  // is observed
  reg   stclk_sync0, stclk_sync1, stclk_sync2;
  always @ (posedge SCLK or negedge HRESETn)
    if (!HRESETn)
      begin
        stclk_sync0 <= 1'b0;
        stclk_sync1 <= 1'b0;
        stclk_sync2 <= 1'b0;
      end  
    else
      begin
        stclk_sync0 <= stclk_div2;
        stclk_sync1 <= stclk_sync0;
        stclk_sync2 <= stclk_sync1;
      end

  assign STCLKEN = stclk_sync2 ^ stclk_sync1;
  
endmodule
