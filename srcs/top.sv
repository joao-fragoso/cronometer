module top
(
    input  logic rst
  , input  logic clk
  , input  logic button
  , output logic [7:0] dsp
  , output logic [7:0] seg
  , output logic       running
  , output logic       power_on
  , output logic       ready
  );

(* ASYNC_REG="true" *)logic button_s;
logic [5:0] button_reg;
assign power_on = 1'b1;
always_ff @(posedge clk) begin
  if (rst) begin
    button_s <= 'b0;
    button_reg <= 'd0;
  end else begin
    button_reg <= {button_reg[4:0], button_s};
    button_s <= button;
  end
end

logic button_released;
assign button_released = button_reg[5] && !button_reg[4];

always_ff @(posedge clk) begin
  if (rst) begin
  running <= 'b0;
  ready <= 1'b0;
  end else begin
    ready <= 1'b1;
    if (button_released)
    running <= ~running;
  end
end
  
  logic _10_ms;
  logic _100_ms;
  logic _1s;
  logic _10s;
  logic _1m;
  logic _10m;
  logic _1h;
  logic _10h;  
  logic [7:0][3:0] crono;
  counter #(.LIMIT(999999)) ten_ms (.clk(clk), .rst(rst), .enable(running), .count(),    .tc(_10_ms));
  counter #(.LIMIT(9)) cent_s (.clk(clk), .rst(rst), .enable(_10_ms),  .count(crono[0]), .tc(_100_ms));
  counter #(.LIMIT(9)) dec_s  (.clk(clk), .rst(rst), .enable(_100_ms), .count(crono[1]), .tc(_1s));
  counter #(.LIMIT(9)) sec    (.clk(clk), .rst(rst), .enable(_1s),     .count(crono[2]), .tc(_10s));
  counter #(.LIMIT(5)) d_sec  (.clk(clk), .rst(rst), .enable(_10s),    .count(crono[3]), .tc(_1m));
  counter #(.LIMIT(9)) min    (.clk(clk), .rst(rst), .enable(_1m),     .count(crono[4]), .tc(_10m));
  counter #(.LIMIT(5)) d_min  (.clk(clk), .rst(rst), .enable(_10m),    .count(crono[5]), .tc(_1h));
  counter #(.LIMIT(9)) hour   (.clk(clk), .rst(rst), .enable(_1h),     .count(crono[6]), .tc(_10h));
  counter #(.LIMIT(9)) d_hour (.clk(clk), .rst(rst), .enable(_10h),    .count(crono[7]), .tc());


  display_ctrl display_ctrl (
    .clk(clk)
  , .rst(rst)
  , .value(crono)
  , .seg(seg)
  , .dsp(dsp)
);

endmodule : top

