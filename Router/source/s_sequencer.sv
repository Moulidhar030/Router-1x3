class s_seqr extends uvm_sequencer#(source_xtn);
   `uvm_component_utils(s_seqr)
    
     extern function new(string name="s_seqr",uvm_component parent);
     extern function void build_phase(uvm_phase phase);
     extern function void connect_phase(uvm_phase phase);
endclass 
  
   function s_seqr::new(string name="s_seqr",uvm_component parent);
        	super.new(name,parent);
   endfunction
   function void s_seqr::build_phase(uvm_phase phase);
		super.build_phase(phase);
   endfunction 
   function void s_seqr::connect_phase(uvm_phase phase);
                super.connect_phase(phase);
   endfunction
   
