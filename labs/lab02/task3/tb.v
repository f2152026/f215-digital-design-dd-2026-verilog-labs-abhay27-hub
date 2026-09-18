// tb.v
module tb;

  // TODO: declare the three DUT inputs as the appropriate variable type.
  // Use exactly these names: t_i0, t_i1, t_s (needed by $monitor below).
  reg [1:0] t_A, t_B;
  // TODO: declare the DUT output as the appropriate net type.
  // Use exactly this name: t_y (needed by $monitor below).
  wire t_GT, t_LT, t_EQ;

  // TODO: instantiate DUT here, connecting t_i0, t_i1, t_s, t_y to its ports
  comp2 DUT (
    .A (t_A),
    .B (t_B),
    .GT  (t_GT),
    .LT  (t_LT),
    .EQ  (t_EQ)
  );

  // Waveform dump configuration
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  initial begin
    // TODO: apply all 8 combinations of t_i0, t_i1, t_s, 5 time units apart,
    // then $finish. (Same pattern you used in Lab 1's tb.v.)
   // Testing A = 0
    t_A = 0; t_B = 0; 
    #5 t_A = 0; t_B = 1;
    #5 t_A = 0; t_B = 2;
    #5 t_A = 0; t_B = 3;

    // Testing A = 1
    #5 t_A = 1; t_B = 0; 
    #5 t_A = 1; t_B = 1;
    #5 t_A = 1; t_B = 2;
    #5 t_A = 1; t_B = 3;

    // Testing A = 2
    #5 t_A = 2; t_B = 0; 
    #5 t_A = 2; t_B = 1;
    #5 t_A = 2; t_B = 2;
    #5 t_A = 2; t_B = 3;

    // Testing A = 3
    #5 t_A = 3; t_B = 0; 
    #5 t_A = 3; t_B = 1;
    #5 t_A = 3; t_B = 2;
    #5 t_A = 3; t_B = 3;

    #5 $finish;
  end

  initial
    $monitor($time, " A=%b B=%b | GT=%b LT=%b EQ=%b ", t_A, t_B, t_GT, t_LT, t_EQ);

endmodule
