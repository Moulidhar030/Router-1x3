
class test extends uvm_test;
  `uvm_component_utils(test)
   env1 envh;
   env_cnfg e_cnfgh;
   source_cnfg s_cnfgh;
    dest_cnfg   d_cnfgh[];
	bit has_dagent=1;
	bit has_sagent=1;
	int no_of_destinations=3;
	bit [1:0] addr;
   s_seqs s_seqsh;
   d_seqs d_seqsh;
    extern function new(string name="test",uvm_component parent =null);
     extern function void build_phase(uvm_phase phase);
    // extern function void connect_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	
endclass 
  
   function test::new(string name="test",uvm_component parent =null);
        	super.new(name,parent);
   endfunction
   function void test::build_phase(uvm_phase phase);
        e_cnfgh=env_cnfg::type_id::create("e_cnfgh");
        if(has_sagent)
		  begin
		    s_cnfgh=source_cnfg::type_id::create("s_cnfgh");
            s_cnfgh.is_active=UVM_ACTIVE;
			 assert(uvm_config_db #(virtual srce_if)::get(this,"","sif",s_cnfgh.vif));
		     e_cnfgh.s_cnfgh=s_cnfgh;
          end
        if(has_dagent)
		   begin
		       e_cnfgh.d_cnfgh=new[no_of_destinations];
			   d_cnfgh=new[no_of_destinations];
			   foreach(d_cnfgh[i])
			     begin 
				   d_cnfgh[i]=dest_cnfg::type_id::create($sformatf("d_cnfgh[%0d]",i));
				   d_cnfgh[i].is_active=UVM_ACTIVE;
				   assert(uvm_config_db #(virtual dest_if)::get(this,"",$sformatf("dif_%0d",i),d_cnfgh[i].vif));
				   e_cnfgh.d_cnfgh[i]=d_cnfgh[i];
				 end 
		    end    
                e_cnfgh.addr=addr;  
		e_cnfgh.has_dagent=has_dagent;
		e_cnfgh.has_sagent=has_sagent;
		e_cnfgh.no_of_destinations=no_of_destinations;
	uvm_config_db #(env_cnfg)::set(this,"*","env_cnfg",e_cnfgh);
	  super.build_phase(phase);
	   envh=env1::type_id::create("envh",this);
   endfunction 
   task test::run_phase(uvm_phase phase);
    phase.raise_objection(this);
	s_seqsh=s_seqs::type_id::create("s_seqsh");
	d_seqsh=d_seqs::type_id::create("d_seqsh");
	phase.drop_objection(this);
	
   endtask

class small_test extends test;
      //small_pkt_vseq spv;
      bit [1:0] addr;
	  
	// Factory Registration
	`uvm_component_utils(small_test)

	// Declare the handle for  ram_odd_vseq virtual sequence
        small_seqs small_seqh;
		d1_seqs d1_h;
	//------------------------------------------
	// METHODS
	//------------------------------------------

	// Standard UVM Methods:
 	extern function new(string name = "small_test" , uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass

//-----------------  constructor new method  -------------------//

 // Define Constructor new() function
function small_test::new(string name = "small_test" , uvm_component parent);
	super.new(name,parent);
endfunction


//-----------------  build() phase method  -------------------//
            
function void small_test::build_phase(uvm_phase phase);
    super.build_phase(phase);
	 small_seqh=small_seqs::type_id::create("small_seqh");
	 d1_h=d1_seqs::type_id::create("d1_h");
	  //spv=small_pkt_vseq::type_id::create("spv");
	  
endfunction


//-----------------  run() phase method  -------------------//
task small_test::run_phase(uvm_phase phase);
	//raise objection
    phase.raise_objection(this);
	//create instance for sequence
    
	 
	  addr={$random}%3;
		uvm_config_db#(bit[1:0])::set(this,"*","bit[1:0]",addr);
	//start the sequence wrt virtual sequencer
	 fork
       small_seqh.start(envh.stoph.agth.s_sh);
	   d1_h.start(envh.dtoph.d_agth[e_cnfgh.addr].sh);
	  join 
	    //spv.start(envh.seqrh);
      #100;
	//drop objection
    phase.drop_objection(this);
endtask  

class medium_test extends test;

  
	// Factory Registration
	`uvm_component_utils(medium_test)
    
	// Declare the handle for  ram_odd_vseq virtual sequence
        medium_seqs medium_seqh;
		d2_seqs d2_h;
	//------------------------------------------
	// METHODS
	//------------------------------------------

	// Standard UVM Methods:
 	extern function new(string name = "medium_test" , uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass

//-----------------  constructor new method  -------------------//

 // Define Constructor new() function
function medium_test::new(string name = "medium_test" , uvm_component parent);
	super.new(name,parent);
endfunction


//-----------------  build() phase method  -------------------//
            
function void medium_test::build_phase(uvm_phase phase);
    super.build_phase(phase);
	  medium_seqh=medium_seqs::type_id::create("medium_seqh");
	  d2_h=d2_seqs::type_id::create("d2_h");
endfunction


//-----------------  run() phase method  -------------------//
task medium_test::run_phase(uvm_phase phase);
	//raise objection
    phase.raise_objection(this);
	//create instance for sequence
   
	 addr={$random}%3;
		uvm_config_db#(bit[1:0])::set(this,"*","bit[1:0]",addr);
	//start the sequence wrt virtual sequencer
	 fork
        medium_seqh.start(envh.stoph.agth.s_sh);
		 d2_h.start(envh.dtoph.d_agth[e_cnfgh.addr].sh);
	 join
	//drop objection
    phase.drop_objection(this);
endtask   

class big_test extends test;

  
	// Factory Registration
	`uvm_component_utils(big_test)
 bit [1:0] addr;
	// Declare the handle for  ram_odd_vseq virtual sequence
        big_seqs big_seqh;
	//------------------------------------------
	// METHODS
	//------------------------------------------

	// Standard UVM Methods:
 	extern function new(string name = "big_test" , uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass

//-----------------  constructor new method  -------------------//

 // Define Constructor new() function
function big_test::new(string name = "big_test" , uvm_component parent);
	super.new(name,parent);
endfunction


//-----------------  build() phase method  -------------------//
            
function void big_test::build_phase(uvm_phase phase);
    super.build_phase(phase);
endfunction


//-----------------  run() phase method  -------------------//
task big_test::run_phase(uvm_phase phase);
	//raise objection
    phase.raise_objection(this);
	//create instance for sequence
     big_seqh=big_seqs::type_id::create("big_seqh");
	 addr={$random}%3;
	uvm_config_db#(bit[1:0])::set(this,"*","bit[1:0]",addr);
	//start the sequence wrt virtual sequencer
        big_seqh.start(envh.stoph.agth.s_sh);
         // #100;
	//drop objection
    phase.drop_objection(this);
endtask   


 




   
