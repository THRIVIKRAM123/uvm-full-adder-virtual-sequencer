class env extends uvm_env;
  `uvm_component_utils(env)
  config1 cfg;
  agent agh[];
  
  sb sb_h;
  
  v_seqr v_seqr_h;

  //int no_of_agents=3;
  function new(string name="env", uvm_component parent );
    super.new(name, parent);
  endfunction
  
   function void build_phase(uvm_phase phase);
    super.build_phase(phase);
   if (!uvm_config_db#(config1)::get(this, "", "config1", cfg)) 
    begin
      `uvm_fatal("CONFIG", "Configuration getting failed in the environment")
    end

    agh=new[cfg.no_of_agents];
   // agh = agent::type_id::create("agh", this);
foreach(agh[i])
	begin
		agh[i] = agent::type_id::create($sformatf("agh[%0d]",i),this);
	end
      
      v_seqr_h=v_seqr::type_id::create("v_seqr_h",this);

      sb_h=sb::type_id::create("sb_h",this);
      
      
  endfunction

function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    foreach(agh[i])
    begin
      v_seqr_h.seqr_h=agh[i].seqh;
    agh[i].monh.ap.connect(sb_h.a_fifo.analysis_export);
    
   // agh[0].monh.ap.connect(sb_h.a_fifo.analysis_export);
    
   
    end 
endfunction

endclass