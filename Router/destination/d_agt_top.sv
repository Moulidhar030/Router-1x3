class d_agt_top extends uvm_agent;
   `uvm_component_utils(d_agt_top)
     d_agent d_agth[];
     env_cnfg e_cnfgh;	 
     extern function new(string name="d_agt_top",uvm_component parent);
     extern function void build_phase(uvm_phase phase);

endclass 
  
   function d_agt_top::new(string name="d_agt_top",uvm_component parent);
        	super.new(name,parent);
   endfunction
   function void d_agt_top::build_phase(uvm_phase phase);
		assert(uvm_config_db #(env_cnfg)::get(this,"","env_cnfg",e_cnfgh));
		if(e_cnfgh.has_dagent)
		  begin
		    d_agth=new[e_cnfgh.no_of_destinations];
			foreach(d_agth[i])
			    begin
			     d_agth[i]=d_agent::type_id::create($sformatf("d_agth[%0d]",i),this); 
		         uvm_config_db #(dest_cnfg)::set(this,$sformatf("d_agth[%0d]*",i),"dest_cnfg",e_cnfgh.d_cnfgh[i]);
		        end
	      end
        
        super.build_phase(phase);
		
    endfunction
