; RUN: firrtl -i %s -o %s.v -X verilog -p c 2>&1 | tee %s.out | FileCheck %s
circuit Top : 
  module Top : 
    input clk1 : Clock
    input clk2 : Clock
    input reset1 : UInt<1>
    input reset2 : UInt<1>
    reg src : UInt<10>, clk1 with :
       reset => ( reset1, UInt(0))
    reg sink : UInt<10>, clk2 with :
       reset => ( reset2, UInt(0))

    src <= add(src,UInt(1))

    reg sync_A : UInt<10>, clk2 with :
       reset => ( reset2, UInt(0))
    sync_A <= src
    reg sync_B : UInt<10>, clk2 with :
       reset => ( reset2, UInt(0))
    sync_B <= sync_A

    sink <= sync_B

;CHECK: Done!
