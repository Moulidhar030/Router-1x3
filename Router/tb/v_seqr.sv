class v_seqr extends uvm_sequencer#(source_xtn);
   `uvm_component_utils(v_seqr)
    s_seqr s_sh;
    d_seqr d_h[];
    env_cnfg e_cnfgh;	
     extern function new(string name="v_seqr",uvm_component parent);
     extern function void build_phase(uvm_phase phase);
     extern function void connect_phase(uvm_phase phase);
endclass 
  
   function v_seqr::new(string name="v_seqr",uvm_component parent);
        	super.new(name,parent);
   endfunction
   function void v_seqr::build_phase(uvm_phase phase);
		super.build_phase(phase);
		  	assert(uvm_config_db #(env_cnfg)::get(this,"","env_cnfg",e_cnfgh));
			//s_sh=s_seqr::type_id::create("s_h",this);
			d_h=new[e_cnfgh.no_of_destinations];
			
   endfunction 
   function void v_seqr::connect_phase(uvm_phase phase);
                super.connect_phase(phase);
   endfunction
