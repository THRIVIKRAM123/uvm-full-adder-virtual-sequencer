class seq extends uvm_sequence#(xtn);
	`uvm_object_utils(seq)
	
        function new(string name="seq");
		super.new(name);	
	endfunction

	task body;
                repeat(20)
	begin
                
		req = xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize());
		finish_item(req);
	end
	endtask

endclass



