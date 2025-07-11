class source_cnfg extends uvm_object;
   `uvm_object_utils(source_cnfg)
       virtual srce_if vif;
       uvm_active_passive_enum is_active=UVM_ACTIVE;
       // Declare the mon_rcvd_xtn_cnt as static int and initialize it to zero  
	static int mon_cnt=0;

	// Declare the drv_data_sent_cnt as static int and initialize it to zero 
	static int drv_cnt=0;
    
     extern function new(string name="source_cnfg");
endclass 
  
   function source_cnfg::new(string name="source_cnfg");
        	super.new(name);
   endfunction

