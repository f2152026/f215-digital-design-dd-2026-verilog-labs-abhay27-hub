// cla4.v
// Gate-level 4-bit carry-lookahead adder, matching the lecture circuit.
// Every gate needs an explicit delay (constant is fine here, e.g. #(2)) --
// this is the default from Task 2 onward, not a special step.
//
// TODO -- Step 1: generate/propagate signals (one xor + one and per bit)
//   p[i] = a[i] ^ b[i]
//   g[i] = a[i] & b[i]
//
// TODO -- Step 2: direct (non-recursive) carry equations. Verilog's and/or
// primitives accept more than 2 inputs directly, e.g.:
//   and #(2) (t2, p1, p0, g0);
// so you do not need to manually chain 2-input gates.
//   c1 = g0 + p0.cin
//   c2 = g1 + p1.g0 + p1.p0.cin
//   c3 = g2 + p2.g1 + p2.p1.g0 + p2.p1.p0.cin
//   c4 = g3 + p3.g2 + p3.p2.g1 + p3.p2.p1.g0 + p3.p2.p1.p0.cin
//
// TODO -- Step 3: sum bits
//   sum[i] = p[i] ^ c[i]     (c0 = cin)

module cla4(
  input  [3:0] a,
  input  [3:0] b,
  input        cin,
  output [3:0] sum,
  output       cout
);

  wire p0, p1, p2, p3;
  wire g0, g1, g2, g3;
  wire c1, c2, c3, c0, c4;

  // TODO: your gate-level P/G, carry, and sum logic goes here.

  assign p0 = a[0] ^ b[0] ;
  assign g0 = a[0] & b[0] ;
  assign p1 = a[1] ^ b[1] ;
  assign g1 = a[1] & b[1] ;
  assign p2 = a[2] ^ b[2] ;
  assign g2 = a[2] & b[2] ;
  assign p3 = a[3] ^ b[3] ;
  assign g3 = a[3] & b[3] ;
  
  // (cout should be connected to c4.) Remember the delay on every gate.
  // --- Carry c1 ---
wire t1_0;
and #(2) (t1_0, p[0], cin);
or  #(2) (c[1], g[0], t1_0);

// --- Carry c2 ---
wire t2_0, t2_1;
and #(2) (t2_0, p[1], g[0]);
and #(2) (t2_1, p[1], p[0], cin);
or  #(2) (c[2], g[1], t2_0, t2_1);

// --- Carry c3 ---
wire t3_0, t3_1, t3_2;
and #(2) (t3_0, p[2], g[1]);
and #(2) (t3_1, p[2], p[1], g[0]);
and #(2) (t3_2, p[2], p[1], p[0], cin);
or  #(2) (c[3], g[2], t3_0, t3_1, t3_2);

// --- Carry c4 ---
wire t4_0, t4_1, t4_2, t4_3;
and #(2) (t4_0, p[3], g[2]);
and #(2) (t4_1, p[3], p[2], g[1]);
and #(2) (t4_2, p[3], p[2], p[1], g[0]);
and #(2) (t4_3, p[3], p[2], p[1], p[0], cin);
or  #(2) (c[4], g[3], t4_0, t4_1, t4_2, t4_3);

assign sum[1] = p1 ^ c1 ;
assign sum[2] = p2 ^ c2 ;
assign sum[3] = p3 ^ c3 ;
assign c0 = cin; 
assign c4 = cout; 

endmodule
