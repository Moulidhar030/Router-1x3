class s_agt_top extends uvm_env();
   `uvm_component_utils(s_agt_top)
     env_cnfg e_cnfgh;
     agent agth;
      
     extern function new(string name="s_agt_top",uvm_component parent);
     extern function void build_phase(uvm_phase phase);
     extern function void connect_phase(uvm_phase phase);
endclass 
  
   function s_agt_top::new(string name="s_agt_top",uvm_component parent);
        	super.new(name,parent);
   endfunction
   
   function void s_agt_top::build_phase(uvm_phase phase);
     assert(uvm_config_db #(env_cnfg)::get(this,"","env_cnfg",e_cnfgh));
	  if(e_cnfgh.has_sagent)
	   begin
	     uvm_config_db #(source_cnfg)::set(this,"agth*","source_cnfg",e_cnfgh.s_cnfgh);
        agth=agent::type_id::create("agth",this);
	   end
   endfunction 
   function void s_agt_top::connect_phase(uvm_phase phase);
                super.connect_phase(phase);
   endfunction

