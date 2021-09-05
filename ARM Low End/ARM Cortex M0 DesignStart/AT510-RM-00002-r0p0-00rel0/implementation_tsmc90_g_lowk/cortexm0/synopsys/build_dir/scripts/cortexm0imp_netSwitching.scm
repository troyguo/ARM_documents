;#############################################################################
;# Copyright Notice and Proprietary Information
;#
;# Copyright (c) 2001-2009 ARM Limited and Synopsys, Inc. All rights reserved.
;#
;# The  accompanying  software  and   documentation  contain  confidential and
;# proprietary   information   that  is   the  property  of  ARM  Limited  and
;# Synopsys,  Inc.   No   part  of  the  software   or  documentation  may  be
;# reproduced, transmitted,  or  translated  in  any form  or  by  any  means,
;# electronic,  mechanical, optical  or  otherwise  without the  prior written
;# permission of Synopsys, Inc. and  ARM Limited.  If  you have  entered  into
;# a  license  with  Synopsys,  Inc.  or  ARM  Limited   with  regard  to  the
;# accompanying software and documentation, please  refer  to  that  agreement
;# for  details  on   your  applicable   license   rights,  restrictions   and
;# conditions.
;#############################################################################

;#############################################################################
;# Right to Copy Documentation
;# Except with the  prior written  permission of  ARM  Limited  and  Synopsys,
;# Inc. copies of  the  documentation  shall only  be  made for  internal use.
;#############################################################################

;#############################################################################
;# Disclaimer
;# THE  ACCOMPANYING SOFTWARE AND  DOCUMENTATION  IS  PROVIDED "AS IS" WITHOUT
;# WARRANTY  OF  ANY  KIND.  ARM  LIMITED, SYNOPSYS, INC. AND  THEIR LICENSORS
;# HEREBY  DISCLAIM ALL  EXPRESS  OR  IMPLIED  WARRANTIES, INCLUDING, BUT  NOT
;# LIMITED  TO, THE  IMPLIED  WARRANTIES  OF  MERCHANTABILITY, FITNESS  FOR  A
;# PARTICULAR PURPOSE, TITLE, AND NON INFRINGEMENT.
;#
;# IN  NO EVENT  SHALL  ARM  LIMITED, SYNOPSYS,  INC. OR  THEIR  LICENSORS  BE
;# LIABLE TO YOU OR  ANY OTHER PARTY  FOR ANY  INDIRECT, INCIDENTAL,  SPECIAL,
;# EXEMPLARY,  OR  CONSEQUENTIAL  DAMAGES  (INCLUDING,  BUT  NOT  LIMITED  TO,
;# PROCUREMENT  OF  SUBSTITUTE  GOODS  OR  SERVICES;  LOSS  OF  USE,  DATA, OR
;# PROFITS; OR BUSINESS  INTERRUPTION) HOWEVER  CAUSED AND  ON  ANY THEORY  OF
;# LIABILITY, WHETHER  IN  CONTRACT,  STRICT  LIABILITY,  OR  TORT  (INCLUDING
;# NEGLIGENCE  OR  OTHERWISE)  ARISING  IN  ANY  WAY  OUT  OF  THE USE  OF THE
;# ACCOMPANYING   SOFTWARE  OR   DOCUMENTATION,  EVEN  IF   ADVISED   OF   THE
;# POSSIBILITY OF SUCH DAMAGE.
;#############################################################################
;####################################################################################
;
; File Name     : cortexm0imp_netSwitching.scm   
; RM Release    : RM 2008.09 ICC,  v1.0
;
; Purpose       : Net Switching Activity file for the CORTEXM0IMP. 
;
;
; Date          : Mar. 17 2009
;
;####################################################################################
;
;    2 toggles
;  ------------- * (net probability %)
;   (1 / Freq )
;        ^
;        |
;        |
;  (converted to units of time in techfile)
;
;  Calculation is as follows:
;   to solve for 15% switching on 500MHz

;  2 / ( (1/500) * 10^3 ) * 0.15 = 0.15

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;@50% of clock freq.
;defineNetSwitchingActivity (geGetEditCell) ".*" 0.50

;@25% of clock freq.
;defineNetSwitchingActivity (geGetEditCell) ".*" 0.25

;@15% of clock freq.
defineNetSwitchingActivity (geGetEditCell) ".*" 0.15
