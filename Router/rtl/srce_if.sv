interface srce_if(input bit clock);
   
 logic resetn;
  logic[7:0]data_in;
  bit pkt_valid;
  bit error;
  bit busy;
  
  clocking drv_cb @(posedge clock);
    default input #1 output #0;
   	 output data_in;
    	output pkt_valid;
    	output resetn;
   	 input error;
   	 input busy;
 endclocking
  
 clocking mon_cb @(posedge clock);
     default input #1 output #0;
       input data_in;
       input pkt_valid;
       input resetn;
       input error;
       input busy;
 endclocking 
  modport DUV_D (clocking drv_cb);
  modport DUV_M (clocking mon_cb);
endinterface
      
    
