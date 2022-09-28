module display_ctrl
(
    input  logic            clk
  , input  logic            rst
  , input  logic      [7:0] dot
  , input  logic [7:0][3:0] value
  , output logic      [7:0] seg
  , output logic      [7:0] dsp
);

function logic [6:0] bcd7seg(input logic [3:0] bcd);
  case (bcd)
    //                 gfe_dcba
    4'h0    : bcd7seg = 7'b011_1111;
    4'h1    : bcd7seg = 7'b000_0110;
    4'h2    : bcd7seg = 7'b101_1011;
    4'h3    : bcd7seg = 7'b100_1111;
    4'h4    : bcd7seg = 7'b110_0110;
    4'h5    : bcd7seg = 7'b110_1101;
    4'h6    : bcd7seg = 7'b111_1101;
    4'h7    : bcd7seg = 7'b000_0111;
    4'h8    : bcd7seg = 7'b111_1111;
    4'h9    : bcd7seg = 7'b110_1111;
    4'ha    : bcd7seg = 7'b111_0111;
    4'hb    : bcd7seg = 7'b111_1100;
    4'hc    : bcd7seg = 7'b011_1001;
    4'hd    : bcd7seg = 7'b101_1110;
    4'he    : bcd7seg = 7'b111_1001;
    4'hf    : bcd7seg = 7'b111_0001;
    default : bcd7seg = 7'b000_0000; // all off
  endcase
endfunction : bcd7seg

logic [16:0] delay;
logic  [2:0] index;
logic  update;

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
      seg <= ~{dot[index],bcd7seg(value[index])};
      index <= index + 1;
    end
  end
end

endmodule : display_ctrl