module top;
  import pack::*;
  import uvm_pkg::*;
 `include "uvm_macros.svh" 
 
  inf inf_h();
  
  full_adder full (inf_h.a, inf_h.b, inf_h.c, inf_h.sum, inf_h.carry);
  
  //fa_assertions fa_a (inf_h.a, inf_h.b, inf_h.c, inf_h.sum, inf_h.carry);


 initial
  begin
    uvm_config_db#(virtual inf)::set(null,"*","inf",inf_h);
    uvm_top.enable_print_topology = 1;
    run_test("test");
  end

  always_comb begin
  assert (({inf_h.a, inf_h.b, inf_h.c} == 3'b000) -> (inf_h.sum == 0 && inf_h.carry == 0)) else
    $error("000: Expected sum=0, carry=0");

  assert (({inf_h.a, inf_h.b, inf_h.c} == 3'b001) -> (inf_h.sum == 1 && inf_h.carry == 0)) else
    $error("001: Expected sum=1, carry=0");

  assert (({inf_h.a, inf_h.b, inf_h.c} == 3'b010) -> (inf_h.sum == 1 && inf_h.carry == 0)) else
    $error("010: Expected sum=1, carry=0");

  assert (({inf_h.a, inf_h.b, inf_h.c} == 3'b011) -> (inf_h.sum == 0 && inf_h.carry == 1)) else
    $error("011: Expected sum=0, carry=1");

  assert (({inf_h.a, inf_h.b, inf_h.c} == 3'b100) -> (inf_h.sum == 1 && inf_h.carry == 0)) else
    $error("100: Expected sum=1, carry=0");

  assert (({inf_h.a, inf_h.b, inf_h.c} == 3'b101) -> (inf_h.sum == 0 && inf_h.carry == 1)) else
    $error("101: Expected sum=0, carry=1");

  assert (({inf_h.a, inf_h.b, inf_h.c} == 3'b110) -> (inf_h.sum == 0 && inf_h.carry == 1)) else
    $error("110: Expected sum=0, carry=1");

  assert (({inf_h.a, inf_h.b, inf_h.c} == 3'b111) -> (inf_h.sum == 1 && inf_h.carry == 1)) else
    $error("111: Expected sum=1, carry=1");
end



endmodule

//--------------------------Assertion module-------------------

/*module fa_assertions(input logic a, b, c, sum, carry);

  always_comb begin
    assert (({a,b,c} == 3'b000) -> (sum == 0 && carry == 0)) else $error("000: Expected sum=0, carry=0");
    assert (({a,b,c} == 3'b001) -> (sum == 1 && carry == 0)) else $error("001: Expected sum=1, carry=0");
    assert (({a,b,c} == 3'b010) -> (sum == 1 && carry == 0)) else $error("010: Expected sum=1, carry=0");
    assert (({a,b,c} == 3'b011) -> (sum == 0 && carry == 1)) else $error("011: Expected sum=0, carry=1");
    assert (({a,b,c} == 3'b100) -> (sum == 1 && carry == 0)) else $error("100: Expected sum=1, carry=0");
    assert (({a,b,c} == 3'b101) -> (sum == 0 && carry == 1)) else $error("101: Expected sum=0, carry=1");
    assert (({a,b,c} == 3'b110) -> (sum == 0 && carry == 1)) else $error("110: Expected sum=0, carry=1");
    assert (({a,b,c} == 3'b111) -> (sum == 1 && carry == 1)) else $error("111: Expected sum=1, carry=1");
  end

endmodule*/
