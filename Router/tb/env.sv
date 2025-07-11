class env1 extends uvm_env;
   `uvm_component_utils(env1)
     env_cnfg e_cnfgh;
      s_agt_top stoph;
      d_agt_top dtoph;
	  //v_seqr seqrh;
     extern function new(string name="env1",uvm_component parent);
     extern function void build_phase(uvm_phase phase);
     //extern function void connect_phase(uvm_phase phase);
endclass 
  
   function env1::new(string name="env1",uvm_component parent);
        	super.new(name,parent);
   endfunction
   function void env1::build_phase(uvm_phase phase);
    assert(uvm_config_db #(env_cnfg)::get(this,"","env_cnfg",e_cnfgh));
	 if(e_cnfgh.has_sagent)
	    stoph=s_agt_top::type_id::create("stoph",this);
     if(e_cnfgh.has_dagent)
	    dtoph=d_agt_top::type_id::create("dtoph",this);
	//seqrh=v_seqr::type_id::create("seqrh",this);	
   endfunction 
   
   
