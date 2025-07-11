class env_cnfg extends uvm_object;
    `uvm_object_utils(env_cnfg)
    
   function new(string name="env_cnfg");
        	super.new(name);
   endfunction
   
	  
	  bit [1:0] addr;
	 source_cnfg s_cnfgh;
    dest_cnfg   d_cnfgh[];
	 bit has_sagent;
	 bit has_dagent;
	 int no_of_destinations;
	// int no_of_source;
	 bit has_virtual_seqr;
endclass 
  
   
