module display_ctrl
(
    input  logic            clk
  , input  logic            rst
  , input  logic [7:0][3:0] value
  , output logic      [7:0] seg
  , output logic      [7:0] dsp
);

logic [15:0] delay;
logic  [2:0] index;
logic  update;
logic  [7:0] value_to_seg;

bcd_to_7seg bcd_to_7seg(.bcd(value[index]), .seg(value_to_seg));

always_ff @(posedge clk) begin
  if (rst) begin
    delay <= 'd0;
    index <= 'd0;
    seg   <= '1;
    dsp   <= 8'b1000_0000;
    update <= 1'b1;
  end else begin
    {update,delay} <= delay + 16'd01;
    if (update) begin
      dsp <= {dsp[6:0], dsp[7]};
      seg <= ~value_to_seg;
      index <= index + 1;
    end
  end
end

endmodule : display_ctrl