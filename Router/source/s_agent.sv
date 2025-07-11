class agent extends uvm_agent;
   `uvm_component_utils(agent)
      s_drv s_dh;
      s_mon s_mh;
      s_seqr s_sh;
     source_cnfg s_cnfgh;
     extern function new(string name="agent",uvm_component parent =null);
     extern function void build_phase(uvm_phase phase);
     extern function void connect_phase(uvm_phase phase);
endclass 
  
   function agent::new(string name="agent",uvm_component parent =null);
        	super.new(name,parent);
   endfunction
   function void agent::build_phase(uvm_phase phase);
		super.build_phase(phase);
    assert(uvm_config_db #(source_cnfg)::get(this,"","source_cnfg",s_cnfgh));

     s_mh=s_mon::type_id::create("s_mh",this);
      if(s_cnfgh.is_active==UVM_ACTIVE)
        begin
              s_dh=s_drv::type_id::create("s_dh",this);
              s_sh=s_seqr::type_id::create("s_sh",this);
        end
   endfunction 
   function void agent::connect_phase(uvm_phase phase);
                //super.connect_phase(phase);
   		 if(s_cnfgh.is_active==UVM_ACTIVE)
                    begin
                       s_dh.seq_item_port.connect(s_sh.seq_item_export);
 		    end

   endfunction
   


