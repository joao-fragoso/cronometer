module counter
#(
    parameter LIMIT=9
  , localparam NBITS=$clog2(LIMIT)
)
(
    input  logic             clk
  , input  logic             rst
  , input  logic             enable
  , output logic [NBITS-1:0] count
  , output logic             tc             
);

always_ff @(posedge clk) begin
  if (rst) begin
    count <= 'd0;
    tc <= 0;
  end else begin
    tc <= 1'b0;
    if (enable) begin
      if (count == LIMIT) begin
        count <= 'd0;
        tc <= 1'b1;
      end else begin
        count <= count + 1;
      end
    end
  end
end

endmodule : counter