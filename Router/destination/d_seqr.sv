class d_seqr extends uvm_sequencer#(dest_xtn);
   `uvm_component_utils(d_seqr)
    
     extern function new(string name="d_seqr",uvm_component parent);
     extern function void build_phase(uvm_phase phase);
     extern function void connect_phase(uvm_phase phase);
endclass 
  
   function d_seqr::new(string name="d_seqr",uvm_component parent);
        	super.new(name,parent);
   endfunction
   function void d_seqr::build_phase(uvm_phase phase);
		super.build_phase(phase);
   endfunction 
   function void d_seqr::connect_phase(uvm_phase phase);
                super.connect_phase(phase);
   endfunction
   
