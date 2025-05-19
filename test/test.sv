class test extends uvm_test;
  `uvm_component_utils(test)
  env env_h;
  config1 cfg_h; 

  //seq seq_h;
    v_seq v_seq_h;
  
  function new(string name="test", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
     cfg_h=config1::type_id::create("cfg_h");
   
    if(!uvm_config_db#(virtual inf)::get(this,"","inf",cfg_h.inf_h))
     begin
      `uvm_fatal("CONFIG", "Configuration not received in Test - Interface related")
    end
    
    env_h = env::type_id::create("env_h", this);
  

    uvm_config_db#(config1)::set(this, "*", "config1", cfg_h);
  endfunction

  task run_phase(uvm_phase phase);
		super.run_phase(phase);
		
                phase.raise_objection(this);
		v_seq_h=v_seq::type_id::create("v_seq_h");
		v_seq_h.start(env_h.v_seqr_h);
		phase.drop_objection(this);
  endtask


endclass

