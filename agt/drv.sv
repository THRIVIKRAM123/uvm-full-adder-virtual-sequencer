class driver extends uvm_driver#(xtn);
  `uvm_component_utils(driver)
  
   config1 cfg;
   virtual inf inf_h;


  function new(string name="driver", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
    virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
   if(!uvm_config_db#(config1)::get(this, "", "config1", cfg))
   begin
    `uvm_fatal("CONFIG", "Configuration not received in Driver")
   end
  endfunction

function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    inf_h=cfg.inf_h;
    
endfunction

task run_phase(uvm_phase phase);
  super.run_phase(phase);

  forever begin
    seq_item_port.get_next_item(req);

    if (req == null)
      `uvm_fatal("NULL_TXN", "Received null transaction in driver")

    drive(req);

    seq_item_port.item_done();
  end
endtask

task drive(xtn xtn_h);
    inf_h.a = xtn_h.a;
    inf_h.b = xtn_h.b;
    inf_h.c = xtn_h.c;
    
    `uvm_info("DRIVER", $sformatf("Printing from driver:\n%s", xtn_h.sprint()), UVM_LOW)
    #1;
  endtask

endclass


