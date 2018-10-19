module updown(
  input clk,
  input nrst,
  input dir,
  output reg [3:0] count
  );
  
  always @ (posedge clk or negedge nrst) begin
    if (!nrst) begin
        count <= 0;
    end
    else begin
      case (dir)
        1'b1:       count <= count + 1;
        default:    count <= count - 1;
      endcase
    end
  end
endmodule