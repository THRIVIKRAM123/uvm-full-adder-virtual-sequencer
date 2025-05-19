class v_seq extends uvm_sequence#(xtn);
	`uvm_object_utils(v_seq)
	
        seqr seqr_h;
        v_seqr v_seqr_h;
        seq seq_h;

        function new(string name="v_seq");
		super.new(name);	
	endfunction

	task body;
               if (!$cast(v_seqr_h,m_sequencer))  `uvm_fatal("SEQ", "Cast failed")
               seqr_h=v_seqr_h.seqr_h;
               seq_h= seq::type_id::create("seq_h");
               seq_h.start(seqr_h);
	endtask

endclass