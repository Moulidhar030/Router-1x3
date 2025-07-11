class d_mon extends uvm_monitor;
   `uvm_component_utils(d_mon)
    virtual dest_if.DUV_M vif;
	 dest_cnfg d_cnfgh;
	 dest_xtn xtn;
     extern function new(string name="d_mon",uvm_component parent);
     extern function void build_phase(uvm_phase phase);
     extern function void connect_phase(uvm_phase phase);

	extern task run_phase(uvm_phase phase);
        extern task monitor();
endclass 
  
   function d_mon::new(string name="d_mon",uvm_component parent);
        	super.new(name,parent);
   endfunction
   function void d_mon::build_phase(uvm_phase phase);
      assert(uvm_config_db #(dest_cnfg)::get(this,"","dest_cnfg",d_cnfgh));
		super.build_phase(phase);
		xtn=dest_xtn::type_id::create("xtn");
   endfunction 
   function void d_mon::connect_phase(uvm_phase phase);
           vif=d_cnfgh.vif;
                super.connect_phase(phase);
   endfunction
  
	 task d_mon::run_phase(uvm_phase phase);
	 forever 
	     begin
		    monitor();
		 end
	 endtask

task d_mon::monitor();
wait(vif.mon_cb.valid_out==1);

while(vif.mon_cb.read_enb !==1)
	@(vif.mon_cb);
@(vif.mon_cb);

xtn.header = vif.mon_cb.data_out;
xtn.payload = new[xtn.header[7:2]];

@(vif.mon_cb);

foreach(xtn.payload[i])
	begin
		xtn.payload[i] = vif.mon_cb.data_out;
		@(vif.mon_cb);
	end

xtn.parity = vif.mon_cb.data_out;
  `uvm_info(get_type_name(),$sformatf("d_monitor %s",xtn.sprint()),UVM_LOW)
endtask
   
