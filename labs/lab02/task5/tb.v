// tb.v

module tb;

  reg  [3:0] t_a;
  reg  [3:0] t_b;
  reg        t_op;      // 0 = add, 1 = sub
  wire [3:0] t_result;

  alu DUT (
    .a       (t_a),
    .b       (t_b),
    .op      (t_op),
    .result  (t_result)
    );

  // Waveform dump configuration
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, tb);
    end
  end

  // Each gate has a #5 delay somewhere in its own implementation. Toggle
  // the inputs every 2 time units -- faster than that 5-unit delay -- so
  // that any implementation using stale values will show it.
  integer i, j, k;
  
  initial begin
    for (i = 0; i < 16; i = i + 1) begin
        for (j = 0; j < 16; j = j + 1) begin
          for (k = 0; k < 2; k = k + 1) begin
            t_a = i;
            t_b = j;
            t_op = k;
            #2; // Wait 5 time units
      end
    end
  end

  $finish;

  end
  
  initial
    $monitor($time, " a=%b b=%b op=%b | result=%b", t_a, t_b, t_op, t_result);

endmodule
