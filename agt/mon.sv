class monitor extends uvm_monitor;
  `uvm_component_utils(monitor)
   
   uvm_analysis_port#(xtn) ap;
  
   config1 cfg;
   virtual inf inf_h;

//-------------------cover group-----------------------------
covergroup cg_fa;
  option.per_instance = 1;

                input_comb: coverpoint {inf_h.a, inf_h.b, inf_h.c} {
                                                                      bins all_inputs[] = {[0:7]};
                                                                   }

                    sum_cp: coverpoint inf_h.sum;

                  carry_cp: coverpoint inf_h.carry;

     endgroup

//-----------------------------------------------------------
  function new(string name="monitor", uvm_component parent = null);
    super.new(name, parent);
    ap=new("ap",this);
    cg_fa=new();
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
     if(!uvm_config_db#(config1)::get(this, "", "config1", cfg))
   begin
    `uvm_fatal("CONFIG", "Configuration not received in Monitor")
   end
  endfunction

function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    inf_h=cfg.inf_h;
    
endfunction

task run_phase(uvm_phase phase);
    xtn tx;
    forever begin
      #1;
      tx = xtn::type_id::create("tx", this);
      tx.a     = inf_h.a;
      tx.b     = inf_h.b;
      tx.c     = inf_h.c;
      tx.sum   = inf_h.sum;
      tx.carry = inf_h.carry;
      `uvm_info("MONITOR", $sformatf("Printing from Monitor:\n%s", tx.sprint()), UVM_LOW)
    cg_fa.sample();
    $display("------------------------------------------------------------------------------------------");
    $display("Updated Coverage for Each transaction       : %0.2f%%", $get_coverage(cg_fa));
    $display("------------------------------------------------------------------------------------------");

 ap.write(tx);
end

  endtask

function void extract_phase(uvm_phase phase);
super.extract_phase(phase);
    $display("------------------------------------------------------------------------------------------");
    $display("Final Coverage       : %0.2f%%", $get_coverage(cg_fa));
    $display("------------------------------------------------------------------------------------------");
endfunction

endclass
