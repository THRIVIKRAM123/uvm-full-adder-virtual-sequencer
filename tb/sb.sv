class sb extends uvm_scoreboard;
  `uvm_component_utils(sb)

  uvm_tlm_analysis_fifo#(xtn) a_fifo;
 xtn tx;
  bit expected_sum;
bit expected_carry;
  function new(string name="sb", uvm_component parent);
    super.new(name, parent);
    a_fifo = new("a_fifo", this);
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
   
    
    forever begin
      a_fifo.get(tx); // wait for transaction from monitor

      // Reference model
      expected_sum   = tx.a ^ tx.b ^ tx.c;
      expected_carry = (tx.a & tx.b) | (tx.b & tx.c) | (tx.a & tx.c);

      // Comparing with DUT output

      if (tx.sum !== expected_sum || tx.carry !== expected_carry) 
         begin
         $display("-----------------------------------------------SCORE BOARD--------------------------------------------------------");
        `uvm_error("SCOREBOARD", $sformatf("Mismatch Detected:\nExpected: sum=%0d, carry=%0d\nGot: sum=%0d, carry=%0d",
                                expected_sum, expected_carry, tx.sum, tx.carry))
         $display("------------------------------------------------------------------------------------------------------------------");
      end
      else begin
          $display("-----------------------------------------------SCORE BOARD--------------------------------------------------------");
        `uvm_info("SCOREBOARD", $sformatf("Match Passed: a=%0d, b=%0d, c=%0d => sum=%0d, carry=%0d",
                                tx.a, tx.b, tx.c, tx.sum, tx.carry), UVM_LOW)
          $display("------------------------------------------------------------------------------------------------------------------");

      end
    end
  endtask

endclass
