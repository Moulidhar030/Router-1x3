class dest_cnfg extends uvm_object;
   `uvm_object_utils(dest_cnfg)
       virtual dest_if vif;
       uvm_active_passive_enum is_active=UVM_ACTIVE;
       
    
     extern function new(string name="dest_cnfg");
endclass 
  
   function dest_cnfg::new(string name="dest_cnfg");
        	super.new(name);
   endfunction
  
