class xtn extends uvm_sequence_item;
	`uvm_object_utils(xtn)
	
       rand  bit a;
       rand  bit b;
       rand  bit c;
             bit sum;
             bit carry;



	function new(string name="xtn");
		super.new(name);
	endfunction


	function void do_print(uvm_printer printer);
		super.do_print(printer);
				
		printer.print_field("a",	this.a,	           1,	UVM_DEC);
		printer.print_field("b",	this.b,	           1,	UVM_DEC);
		printer.print_field("c",	this.c,	           1,	UVM_DEC);
		printer.print_field("sum",	this.sum,	   1,	UVM_DEC);
		printer.print_field("carry",	this.carry,	   1,	UVM_DEC);
		
	endfunction
	
endclass	
