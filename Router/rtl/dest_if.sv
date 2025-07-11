interface dest_if(input bit clock);
 logic[7:0]data_out;
  bit valid_out;
  bit read_enb;
   clocking drv_cb @(posedge clock);
        default input #1 output #1;
         //output data_out;
         input valid_out;
         output read_enb;
   endclocking
   clocking mon_cb @(posedge clock);
        default input #1 output #1;
          input data_out;
          input valid_out;
          input read_enb;
    endclocking 
     modport DUV_D(clocking drv_cb);
     modport DUV_M(clocking mon_cb);

endinterface 
