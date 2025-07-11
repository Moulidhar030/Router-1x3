class d_seqs extends uvm_sequence#(dest_xtn);
   `uvm_object_utils(d_seqs)
    env_cnfg e_cnfgh;
     extern function new(string name="d_seqs");
     extern task body();
endclass 
  
   function d_seqs::new(string name="d_seqs");
        	super.new(name);
   endfunction
   
  task d_seqs::body();
    
  if(!uvm_config_db #(env_cnfg)::get(null,get_full_name(),"env_cnfg",e_cnfgh))
    `uvm_fatal(get_type_name(),"getting is failed")
	
  endtask
  
 class d1_seqs extends d_seqs;
   `uvm_object_utils(d1_seqs)
    
     extern function new(string name="d1_seqs");
     extern task body();
endclass 
  
   function d1_seqs::new(string name="d1_seqs");
        	super.new(name);
   endfunction
   
  task d1_seqs::body();
   super.body();
    begin
    req=dest_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize () with {no_of_cycles <30;}); 
	`uvm_info("DST_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_HIGH)
	finish_item(req);
	end
  endtask
  
 class d2_seqs extends d_seqs;
   `uvm_object_utils(d2_seqs)
    
     extern function new(string name="d2_seqs");
     extern task body();
endclass 
  
   function d2_seqs::new(string name="d2_seqs");
        	super.new(name);
   endfunction
   
  task d2_seqs::body();
   super.body();
    begin
    req=dest_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize () with {no_of_cycles>30;}); 
	`uvm_info("DST_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_HIGH)
	finish_item(req);
	end
  endtask
  
