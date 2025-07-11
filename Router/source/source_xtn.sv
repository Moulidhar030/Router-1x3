class source_xtn extends uvm_sequence_item;
   rand bit [7:0] header;
   rand bit [7:0] payload[];
   bit [7:0]parity;
   bit pkt_valid;
   bit error;
   bit busy;
   bit resetn;
 `uvm_object_utils(source_xtn)
  

  
 

   function new(string name = "source_xtn");
      super.new(name);
   endfunction
    
extern function void do_copy(uvm_object rhs);
extern function bit do_compare(uvm_object rhs,uvm_comparer comparer);
extern function void do_print(uvm_printer printer);
 constraint c1 { header[1:0] != 2'b1; }
   constraint c2 { payload.size() == header[7:2]; }
   constraint c3 { header[7:2] != 1'd0; }


    function void post_randomize();
      parity = header^0; // Start with the first bit of header for parity calculation
      foreach(payload[i]) begin
         parity = parity ^ payload[i];
      end
   endfunction
endclass
   
function void source_xtn::do_copy (uvm_object rhs);
    source_xtn rhs_;
	    if(!$cast(rhs_,rhs))
		`uvm_fatal("do_copy","cast of the rhs object failed");	

super.do_copy(rhs);
this.pkt_valid  = rhs_.pkt_valid;
this.resetn=rhs_.resetn;
this.header= rhs_.header;
foreach(payload[i])
this.payload[i] = rhs_.payload[i];
this.parity = rhs_.parity;
this.error=rhs_.error;
this.busy = rhs_.busy;
    

endfunction:do_copy


function bit  source_xtn::do_compare (uvm_object rhs,uvm_comparer comparer);
    source_xtn rhs_;
	   if(!$cast(rhs_,rhs))
		`uvm_fatal("do_compare","cast of the object is failed");
 

return 
this.parity == rhs_.parity;
endfunction:do_compare 

 
   function void source_xtn::do_print(uvm_printer printer);
   
   super.do_print(printer);

   
    //              	srting name   		bitstream value     size    radix for printing	
    printer.print_field( "pkt_valid",		this.pkt_valid,     1,           UVM_DEC		);
    printer.print_field( "resetn",          	this.resetn,	    1,   	 UVM_DEC		);
    printer.print_field( "header", 		this.header, 	    8,		 UVM_DEC		);
foreach(this.payload[i])
printer.print_field( $sformatf("payload[%0d]",i), this.payload[i], 8,		 UVM_DEC		);
    printer.print_field( "parity", 		this.parity, 	    8,  	 UVM_DEC		);
    printer.print_field( "error", 		this.error,         1,		 UVM_DEC		);
    printer.print_field ( "busy", 		this.busy,          1, 		 UVM_DEC                );
/*
   super.do_print(printer);
   printer.print_field("header", this.header, 8, UVM_DEC);
   
   for (int i = 0; i < payload.size(); i++) begin
      string field_name = $sformatf("payload[%0d]", i);
      printer.print_field(field_name, payload[i], 8, UVM_DEC);
   end
   
   printer.print_field("parity", this.parity, 1, UVM_DEC); */
endfunction


 
