module top;
 import uvm_pkg::*;
 import router_pkg::*;
 
 `include "uvm_macros.svh"
   bit clock;
    
     always #10 clock=~clock;
  
  srce_if sif(clock);
  dest_if dif0(clock);
  dest_if dif1(clock);
  dest_if dif2(clock);
router_top DUV(.clock(clock),
                .resetn(sif.resetn),
				.data_in(sif.data_in),
				.pkt_valid(sif.pkt_valid),
				.err(sif.error),
				.busy(sif.busy),
				.data_out_0(dif0.data_out),
		         .vldout_0(dif0.valid_out),
		         .read_enb_0(dif0.read_enb),
		
		        .data_out_1(dif1.data_out),
				.vldout_1(dif1.valid_out),
		       .read_enb_1(dif1.read_enb),
			   
			   .data_out_2(dif2.data_out),
			   .vldout_2(dif2.valid_out),
			   .read_enb_2(dif2.read_enb));
      	

   initial 
   begin
      `ifdef VCS
         $fsdbDumpvars(0, top);
       `endif

      uvm_config_db #(virtual srce_if)::set(null,"*","sif",sif);
      uvm_config_db #(virtual dest_if)::set(null,"*","dif_0",dif0);
      uvm_config_db #(virtual dest_if)::set(null,"*","dif_1",dif1);
      uvm_config_db #(virtual dest_if)::set(null,"*","dif_2",dif2);
       
      uvm_top.enable_print_topology = 1;
      run_test();
	  
   end

endmodule
