class s_mon extends uvm_monitor();
   `uvm_component_utils(s_mon)
     source_cnfg s_cnfgh;
     virtual srce_if.DUV_M vif;
      source_xtn data_sent;

     extern function new(string name="s_mon",uvm_component parent);
     extern function void build_phase(uvm_phase phase);
     extern function void connect_phase(uvm_phase phase);
     extern task run_phase(uvm_phase phase);
     extern task collect_data();
endclass 
  
   function s_mon::new(string name="s_mon",uvm_component parent);
        	super.new(name,parent);
   endfunction
   function void s_mon::build_phase(uvm_phase phase);
      assert(uvm_config_db #(source_cnfg)::get(this,"","source_cnfg",s_cnfgh));
		super.build_phase(phase);
   endfunction 
   function void s_mon::connect_phase(uvm_phase phase);
            vif=s_cnfgh.vif;
                super.connect_phase(phase);
   endfunction
 task s_mon::run_phase(uvm_phase phase);
    //phase.raise_objection(this);
    
    forever begin
        // Call collect data task
        collect_data();
    end
    //phase.drop_objection(this);
endtask


task s_mon::collect_data();
//source_xtn data_sent;
    data_sent = source_xtn::type_id::create("data_sent");
   	        wait(vif.mon_cb.busy == 0);
	while(vif.mon_cb.pkt_valid !== 1)
	@(vif.mon_cb);
    	data_sent.header = vif.mon_cb.data_in;
      	@(vif.mon_cb);
    	data_sent.payload = new[data_sent.header[7:2]];

    foreach(data_sent.payload[i]) begin
        while(vif.mon_cb.busy !== 0)
        @(vif.mon_cb);
        data_sent.payload[i] = vif.mon_cb.data_in;
        //`uvm_info(get_type_name(), $sformatf("Collected payload[%	0d]: %0h", i, data_sent.payload[i]), UVM_LOW);
        @(vif.mon_cb);
    end

    while(vif.mon_cb.busy !== 0)
    @(vif.mon_cb);
	while(vif.mon_cb.pkt_valid !== 0)
	@(vif.mon_cb);
    data_sent.parity = vif.mon_cb.data_in;
    repeat(2) @(vif.mon_cb);
    data_sent.error = vif.mon_cb.error;
    //`uvm_info(get_type_name(), $sformatf("Collected parity: %0h", data_sent.parity), UVM_LOW);
   // `uvm_info(get_type_name(), $sformatf("Collected error: %0d", data_sent.error), UVM_LOW);
	//`uvm_info(get_type_name(), $sformatf("Error signal in monitor: %0d", vif.mon_cb.error), UVM_LOW);
    //s_cnfgh.mon_cnt++;
	 `uvm_info(get_type_name(),$sformatf("source_monitor %s",data_sent.sprint()),UVM_LOW)
endtask
