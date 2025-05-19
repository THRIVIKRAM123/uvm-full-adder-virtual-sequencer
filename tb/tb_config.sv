class config1 extends uvm_object;
  `uvm_object_utils(config1)
  uvm_active_passive_enum is_active = UVM_ACTIVE;
  int no_of_agents=1;
  virtual inf inf_h;
  function new(string name="config1");
    super.new(name);
  endfunction
endclass