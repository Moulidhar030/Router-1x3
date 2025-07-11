class s_seqs extends uvm_sequence #(source_xtn);
   `uvm_object_utils(s_seqs)
    env_cnfg e_cnfgh;
     //extern function new(string name="s_seqs");
     //extern task body();
  
  bit [1:0] addr;

   function new(string name="s_seqs");
        	super.new(name);
   endfunction
    task body();
  if(!uvm_config_db #(env_cnfg) :: get(null,get_full_name(),"env_cnfg",e_cnfgh))
	`uvm_fatal(get_type_name(),"getting is failed")
    endtask
endclass

class small_seqs extends s_seqs;
  `uvm_object_utils(small_seqs)
  function new(string name="small_seqs"); 
              super.new(name);
  endfunction

task body();
   super.body;
begin
 req=source_xtn::type_id::create("req");
  assert(uvm_config_db#(bit[1:0])::get(null,"","bit[1:0]",addr));
 start_item(req);
assert(req.randomize() with {header[7:2] inside {[1:20]};  header[1:0]==addr;});  
 finish_item(req);
end
endtask  
endclass
 
class medium_seqs extends s_seqs;
  `uvm_object_utils(medium_seqs)
  function new(string name="medium_seqs"); 
              super.new(name);
  endfunction

task body();
 super.body;
  
//repeat(2)
begin
 req=source_xtn::type_id::create("req");
assert(uvm_config_db#(bit[1:0])::get(null,"","bit[1:0]",addr));

 start_item(req);
 assert(req.randomize() with {header[7:2] inside{[21:40]};header[1:0]==addr;});  
 finish_item(req);
  end
endtask  
endclass

 
class big_seqs extends s_seqs;
  `uvm_object_utils(big_seqs)
  function new(string name="big_seqs"); 
              super.new(name);
  endfunction

task body();
 super.body;

begin
req=source_xtn::type_id::create("req");
assert(uvm_config_db#(bit[1:0])::get(null,"","bit[1:0]",addr));

 start_item(req);
assert( req.randomize() with {header[7:2] inside{[41:64]};header[1:0]==addr;});  
 finish_item(req);
end
endtask  

endclass

      
