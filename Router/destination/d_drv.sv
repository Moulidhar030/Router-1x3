class d_drv extends uvm_driver#(dest_xtn);
   `uvm_component_utils(d_drv)
    virtual dest_if.DUV_D vif;
	  dest_cnfg d_cnfgh;
	  
     extern function new(string name="d_drv",uvm_component parent);
     extern function void build_phase(uvm_phase phase);
     extern function void connect_phase(uvm_phase phase);
	  extern task run_phase(uvm_phase phase);
	 extern task drive_item(dest_xtn xtn);
endclass 
  
   function d_drv::new(string name="d_drv",uvm_component parent);
        	super.new(name,parent);
   endfunction
   function void d_drv::build_phase(uvm_phase phase);
           assert(uvm_config_db #(dest_cnfg)::get(this,"","dest_cnfg",d_cnfgh));
		super.build_phase(phase);
   endfunction 
   function void d_drv::connect_phase(uvm_phase phase);
            vif=d_cnfgh.vif;
                super.connect_phase(phase);
   endfunction
   task d_drv::run_phase(uvm_phase phase);
      forever
      begin
    //req=dest_xtn::type_id::create("req");
	seq_item_port.get_next_item(req);
              	drive_item(req);
           `uvm_info(get_type_name(),$sformatf("d_drv %s",req.sprint()),UVM_LOW)

	seq_item_port.item_done();
     end
	endtask
task d_drv::drive_item(dest_xtn xtn);
while(vif.drv_cb.valid_out !==1)
	@(vif.drv_cb);

repeat(xtn.no_of_cycles)
	@(vif.drv_cb);

vif.drv_cb.read_enb <= 1;

while(vif.drv_cb.valid_out !==0)
@(vif.drv_cb);
vif.drv_cb.read_enb <=0;
endtask
	
	 
