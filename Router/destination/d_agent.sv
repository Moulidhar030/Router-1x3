class d_agent extends uvm_agent;
   `uvm_component_utils(d_agent)
      d_drv dh;
      d_mon mh;
      d_seqr sh;
     dest_cnfg d_cnfgh;
     //extern function new(string name="d_agent",uvm_component parent);
   //  extern function void build_phase(uvm_phase phase);
     //extern function void connect_phase(uvm_phase phase);
  function new(string name="d_agent",uvm_component parent);
        	super.new(name,parent);
   endfunction
      

function void build_phase(uvm_phase phase);
		super.build_phase(phase);
   `uvm_info(get_type_name(),"this is build phase",UVM_LOW)
     if(!uvm_config_db #(dest_cnfg)::get(this,"","dest_cnfg",d_cnfgh))
    `uvm_fatal(get_type_name(),"not getting")
     mh=d_mon::type_id::create("mh",this);
if(d_cnfgh.is_active==UVM_ACTIVE)
begin
              dh=d_drv::type_id::create("dh",this);
              sh=d_seqr::type_id::create("sh",this);
end
   endfunction 
   function void connect_phase(uvm_phase phase);
       if(d_cnfgh.is_active==UVM_ACTIVE)
	       dh.seq_item_port.connect(sh.seq_item_export);
	super.connect_phase(phase);
   endfunction

endclass 
  
 
