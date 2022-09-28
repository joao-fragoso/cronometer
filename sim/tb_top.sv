module tb_top();
logic rst=1'b1;
logic clk=1'b0;
logic button=1'b0;
logic [7:0] dsp;
logic [7:0] seg;
logic       running;
logic       power_on;
logic       ready;

top top (.*);

always #5ns clk = ~clk;

initial begin
  #100ns;
  @(posedge clk) #1ps;
  rst= 1'b0;
  #100ns;
  @(posedge clk) #1ps;
  button = 1'b1;
  #100ns;
  @(posedge clk) #1ps;
  button = 1'b0;
end


endmodule : tb_top
