class agent extends uvm_agent;
  config1 cfg;
  driver drvh;
  monitor monh;
  seqr seqh;
  
  `uvm_component_utils(agent)
  
  function new(string name="agent", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    // Retrieve the configuration for the agent
    if (!uvm_config_db#(config1)::get(this, "", "config1", cfg)) begin
      `uvm_fatal("CONFIG", "Configuration getting failed in the agent")
    end
    
    if (cfg.is_active == UVM_ACTIVE) begin
      drvh = driver::type_id::create("drvh", this);
      seqh = seqr::type_id::create("seqh", this);
    end
    
    monh = monitor::type_id::create("monh", this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
  super.connect_phase(phase);

   if (!uvm_config_db#(config1)::get(this, "", "config1", cfg)) begin
      `uvm_fatal("CONFIG", "Configuration getting failed in the agent")
    end
    
    if (cfg.is_active == UVM_ACTIVE) 
    begin

    drvh.seq_item_port.connect(seqh.seq_item_export);
    end
    endfunction

endclass
