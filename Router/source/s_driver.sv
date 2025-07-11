class s_drv extends uvm_driver #(source_xtn);
   `uvm_component_utils(s_drv)
     source_cnfg s_cnfgh;
     virtual srce_if.DUV_D vif;
     extern function new(string name="s_drv",uvm_component parent);
     extern function void build_phase(uvm_phase phase);
     extern function void connect_phase(uvm_phase phase);
     extern task run_phase(uvm_phase phase);
     extern task send_to_dut(source_xtn xtn);
	  //extern task p1(source_req req);
endclass 
  
   function s_drv::new(string name="s_drv",uvm_component parent);
        	super.new(name,parent);
   endfunction
   function void s_drv::build_phase(uvm_phase phase);
        assert(uvm_config_db #(source_cnfg)::get(this,"","source_cnfg",s_cnfgh));
		super.build_phase(phase);
   endfunction 
   function void s_drv::connect_phase(uvm_phase phase);
            vif=s_cnfgh.vif;
                super.connect_phase(phase);
   endfunction
   task s_drv::run_phase(uvm_phase phase);
        @(vif.drv_cb);
        vif.drv_cb.resetn<=1'b0;
        @(vif.drv_cb);
         vif.drv_cb.resetn<=1'b1;
        
      forever
           begin
               seq_item_port.get_next_item(req);
                `uvm_info(get_type_name(),$sformatf("s_drv %s",req.sprint()),UVM_LOW)

                   		send_to_dut(req);
               seq_item_port.item_done();
           end
         

    endtask

task s_drv::send_to_dut(source_xtn xtn);
	while(vif.drv_cb.busy!==0)
	@(vif.drv_cb);

	@(vif.drv_cb);
	vif.drv_cb.pkt_valid<=1'b1;
	vif.drv_cb.data_in<=xtn.header;
	@(vif.drv_cb);
	foreach(xtn.payload[i])
	begin
		while(vif.drv_cb.busy!==0)
		@(vif.drv_cb);
			vif.drv_cb.data_in<=xtn.payload[i];
		@(vif.drv_cb);
	end
	while(vif.drv_cb.busy!==0)
	@(vif.drv_cb);
	vif.drv_cb.pkt_valid<=1'b0;
	vif.drv_cb.data_in<=xtn.parity;
endtask

    
   
   
