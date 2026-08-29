// rca.v
// Identical structure to Task 2's ripple_adder -- reuse your wiring
// pattern directly.
//
// Required file: copy your completed FA_Gate.v from Task 2 (the version
// with delays already added, from part (a) or (b)) into this folder.
// No separate "delay" variant is needed -- Task 2's FA_Gate already has
// delays built in, and every gate/module from here on should too.
//
// TODO: instantiate four FA_Gate instances, same chaining pattern as
// Task 2 (FA0..FA3, carry chain c1,c2,c3).

module FA_Gate(
  input  a,
  input  b,
  input  cin,
  output sum,
  output cout
);
  wire ps, pc1, pc2;

  xor #(2,3) (ps,  a,   b);
  and #(3,2) (pc1, a,   b);
  xor #(2,3) (sum, cin, ps);
  and #(3,2) (pc2, cin, ps);
  or  #(1,4) (cout, pc1, pc2);

endmodule 

module rca(
  input  [3:0] a,
  input  [3:0] b,
  input        cin,
  output [3:0] sum,
  output       cout
);

  wire c1, c2, c3;

  // TODO: your four FA_Gate instances go here.
  FA_Gate FA0 (a[0], b[0], cin, sum[0], c1) ;
  FA_Gate FA1 (a[1], b[1], c1, sum[1], c2) ;
  FA_Gate FA2 (a[2], b[2], c2, sum[2], c3) ;
  FA_Gate FA3 (a[3], b[3], c3, sum[3], cout) ;

endmodule
