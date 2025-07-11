package router_pkg;
  import uvm_pkg::*;
   `include "uvm_macros.svh"
    
	
	
	
	
    `include "dest_xtn.sv"
      `include "source_xtn.sv"
    `include "dest_cnfg.sv"
	 `include "source_cnfg.sv"
	`include "env_cnfg.sv"


  
   `include "s_driver.sv"
   `include "s_monitor.sv"
    `include "s_sequencer.sv"
	 `include "s_agent.sv"
	`include "s_agt_top.sv"
	`include "s_seqs.sv"
	
 
	`include "d_drv.sv"
    `include "d_mon.sv"
    `include "d_seqr.sv"
    
    `include "d_agent.sv"
    `include "d_agt_top.sv"
    `include "d_seqs.sv"

   //`include "v_seqr.sv"
  //`include "v_seqs.sv"
	
    `include "env.sv"
   `include "test.sv"
endpackage 
    
