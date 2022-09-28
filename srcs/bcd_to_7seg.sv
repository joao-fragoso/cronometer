module bcd_to_7seg
#(
  parameter DP=1'b0
) 
(
    input  logic [3:0] bcd
  , output logic [7:0] seg
);

assign seg[7] = DP;

always_comb begin
  case (bcd)
    //                   gfe_dcba
    4'h0 : seg[6:0] = 7'b011_1111;
    4'h1 : seg[6:0] = 7'b000_0110;
    4'h2 : seg[6:0] = 7'b101_1011;
    4'h3 : seg[6:0] = 7'b100_1111;
    4'h4 : seg[6:0] = 7'b110_0110;
    4'h5 : seg[6:0] = 7'b110_1101;
    4'h6 : seg[6:0] = 7'b111_1101;
    4'h7 : seg[6:0] = 7'b000_0111;
    4'h8 : seg[6:0] = 7'b111_1111;
    4'h9 : seg[6:0] = 7'b110_1111;
    4'ha : seg[6:0] = 7'b111_0111;
    4'hb : seg[6:0] = 7'b111_1100;
    4'hc : seg[6:0] = 7'b011_1001;
    4'hd : seg[6:0] = 7'b101_1110;
    4'he : seg[6:0] = 7'b111_1001;
    4'hf : seg[6:0] = 7'b111_0001;
  endcase  
end

endmodule
