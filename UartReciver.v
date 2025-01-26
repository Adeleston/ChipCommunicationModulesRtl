module uart_Reciver(//çift parity ile çalışan 8 bit bilgi içeren bir uart modülü için verilog kodu
input wire in_signal,
input wire clk,
input wire reset,
output wire [7:0]out_signal,
output wire out_ready
);
reg [8:0] out_signal_ff;
reg read_ready;reg error;reg out_ready_ff
genvar i;
i = 0;
always_ff @(posedge clk)begin
	if(reset)begin
		out_signal_ff <= 8'h00;
		i = 0;
		read_ready <= 1'b0;
		out_ready_ff <= 1'b0;
		error <= 1'b0;
	end else begin
		if(!read_ready)begin
			if(!in_signal)begin
			ready <= 1'b1;
			out_ready_ff <= 1'b0;
			error <= 1'b0;
			end
		end else begin
			if(i < 9)begin
				out_signal_ff[i] <= in_signal;
				i = i + 1;
			end else begin
				if(in_signal)begin
					read_ready <= 1'b0;
					out_ready_ff <= 1'b1;
					i = 0;
				end else begin
					error <= 1'b1;
					read_ready <= 1'b0;
					i=0;
				end
			end
		end
	end
end
always_ff @(posedge error)begin
	out_signal_ff <= 8'h00;
	i = 0;
	end
assign out_ready = out_ready_ff;
assign out_signal = out_signal_ff;
			
					
			
			