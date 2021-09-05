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
//      Checked In          : $Date: 2009-03-12 11:51:22 +0000 (Thu, 12 Mar 2009) $
//
//      Revision            : $Revision: 103764 $
//
//      Release Information : Cortex-M0-AT510-r0p0-00rel0
//-----------------------------------------------------------------------------

module cm0_dap_cdc_send_reset
         #(parameter   PRESENT = 1)
          (input  wire REGCLK,     // Register Clock
           input  wire REGRESETn,  // Reset
           input  wire REGEN,      // Register Load Enable
           input  wire REGDI,      // Data Input
           input  wire SE,         // Scan Enable for DFT
           output wire REGDO);     // Data Output

  // --------------------------------------------------------------------------
  // This module is instantiated where a CDC-safe send (launch) register is
  // required, i.e. where the output of the register is used in a different
  // clock domain to the register. In this case, it is necesssary to ensure 
  // that the output of the register does not glitch when the register enable
  // signal, REGEN, is low, or when the output does not logically change on
  // a clock edge.
  //
  // The implementation of this module must ensure that this requirement is
  // met.
  // --------------------------------------------------------------------------

  // --------------------------------------------------------------------------
  // In this example, the above behaviour is ensured by using a clock gating
  // cell (TLATNTSCA) to gate the clock to the launch register(s) (SDFFR) when
  // REGEN is low. The synthesis tool should be configured so that these gates 
  // arent resynthesised into alternative gates, though resizing is allowed.
  // --------------------------------------------------------------------------
   
  // --------------------------------------------------------------------------
  // Signal Declarations
  // --------------------------------------------------------------------------
  // Internal signals
  wire    iREGDI;   // Input to Register
  wire    iREGDO;   // Output of Register
  wire 	  ENREGCLK; // Gated Register clock
  
  //----------------------------------------------------------------------------
  // Register removal
  //----------------------------------------------------------------------------
  assign REGDO    = (PRESENT != 0)  ? iREGDO    : 1'b0;
  assign iREGDI   = (PRESENT != 0)  ? REGDI     : 1'b0;
  
  //----------------------------------------------------------------------------
  // Beginning of main code
  //----------------------------------------------------------------------------

  //Clock gate
   TLATNTSCAX2AD HANDINST_ICG (.ECK(ENREGCLK),
                               .E  (REGEN),
                               .SE (SE),
                               .CK (REGCLK));

  //Register
   SDFFRX2AD   HANDINST_iREGDO (.CK(ENREGCLK),
				.RN(REGRESETn),
				.D(iREGDI),
				.SI(),
				.SE(),
				.Q(iREGDO),
				.QN());

  `ifdef ARM_ASSERT_ON
    `include "std_ovl_defines.h"
   
    assert_never_unknown
      #(`OVL_FATAL, 1, `OVL_ASSUME, "CDC Register Enable must never be X")
      u_x_check_cdc_reg_en
      (
        .clk        (REGCLK),
        .reset_n    (REGRESETn),
        .qualifier  (1'b1),
        .test_expr  (REGEN)
      );

  `endif

endmodule
