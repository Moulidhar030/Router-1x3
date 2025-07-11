class v_seqs extends uvm_sequence #(uvm_sequence_item);
  `uvm_object_utils(v_seqs)
        s_seqr s_sh;
    d_seqr d_h[];
    //env_cnfg e_cnfgh;	
    v_seqr v_h;
bit [1:0] addr;
small_seqs small_seqh;
medium_seqs medium_seqh;
big_seqs big_seqh;
 d1_seqs d1_h;
 d2_seqs d2_h;
 env_cnfg cnfgh;	


    extern function new(string name ="v_seqs");
  extern task body();
endclass
 
function  v_seqs::new(string name ="v_seqs");
   super.new(name);
endfunction

task v_seqs::body();
assert(uvm_config_db #(env_cnfg)::get(null,"","env_cnfg",cnfgh));
assert(uvm_config_db #(bit[1:0])::get(null,"","bit[1:0]",addr));
  //`uvm_fatal("ADDR","getting failed in Vseq")
   assert($cast(v_h, m_sequencer)) else begin
      `uvm_error("BODY", "Error in $cast of virtual sequencer")
  end
	//s_sh=s_seqr::type_id::create("s_sh",this);
 d_h=new[cnfgh.no_of_destinations];

assert($cast(v_h,m_sequencer))
else 
    begin
         `uvm_error("BODY","error in $cast of virtual sequencer")
    end
 //foreach(s_sh[i])
   s_sh=v_h.s_sh;
 foreach(d_h[i])
   d_h[i]=v_h.d_h[i];
endtask

//small packet

class small_pkt_vseq extends v_seqs;
  `uvm_object_utils(small_pkt_vseq)
  bit [1:0] addr;
 extern function new(string name ="small_pkt_vseq");
 extern task body();
endclass
  
function small_pkt_vseq::new(string name="small_pkt_vseq");
   super.new(name);
endfunction

task small_pkt_vseq::body();
  super.body();
 assert(uvm_config_db #(bit[1:0])::get(null,"","bit[1:0]",addr));

      small_seqh=small_seqs::type_id::create("small_seqh");
	 d1_h=d1_seqs::type_id::create("d1_h");
  fork 
     begin 
         small_seqh.start(s_sh);
     end
	begin
     		if(addr==2'b00) 
 			d1_h.start(d_h[0]);
		if(addr==2'b01) 
 			d1_h.start(d_h[1]);
		if(addr==2'b10) 
 			d1_h.start(d_h[2]);


	end
  join
endtask

//medium packet

 
class medium_pkt_vseq extends v_seqs;
  `uvm_object_utils(medium_pkt_vseq)
  bit [1:0] addr;
 extern function new(string name ="medium_pkt_vseq");
 extern task body();
endclass
  
function medium_pkt_vseq::new(string name="medium_pkt_vseq");
   super.new(name);
endfunction

task medium_pkt_vseq::body();
  super.body();
assert(uvm_config_db #(bit[1:0])::get(null,"","bit[1:0]",addr));
  begin
      medium_seqh=medium_seqs::type_id::create("medium_seqh");
	 d2_h=d2_seqs::type_id::create("d2_h");
 end
  fork 
     begin 
         medium_seqh.start(s_sh);
     end
	begin
     		if(addr==2'b00) 
 			d2_h.start(d_h[0]);
		if(addr==2'b01) 
 			d2_h.start(d_h[1]);
		if(addr==2'b10) 
 			d2_h.start(d_h[2]);


	end
  join
endtask


//big packet
class big_pkt_vseq extends v_seqs;
  `uvm_object_utils(big_pkt_vseq)
  bit [1:0] addr;
 extern function new(string name ="big_pkt_vseq");
 extern task body();
endclass
  
function big_pkt_vseq::new(string name="big_pkt_vseq");
   super.new(name);
endfunction

task big_pkt_vseq::body();
  super.body();
assert(uvm_config_db #(bit[1:0])::get(null,"","bit[1:0]",addr));

      big_seqh=big_seqs::type_id::create("big_seqh");
	// d2_h=d1_seqs::type_id::create("d2_h");
 
     begin 
         big_seqh.start(s_sh);
     end
endtask








