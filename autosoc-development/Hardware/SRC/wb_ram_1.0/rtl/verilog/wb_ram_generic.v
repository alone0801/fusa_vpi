//TODO: Add function to convert between 32 bit words and bytes
module wb_ram_generic
  #(parameter depth=256,
    parameter memfile = "")
  (input clk,
   input [3:0]	 we,
   input [31:0]  din,
   input [$clog2(depth)-1:0] 	 waddr,
   input [$clog2(depth)-1:0] 	 raddr,
   output reg [31:0] dout);

   reg [31:0] 	 mem [0:depth-1] /* verilator public */;
   
   always @(posedge clk) begin
      if (we[0]) mem[waddr][7:0]   <= din[7:0];
      if (we[1]) mem[waddr][15:8]  <= din[15:8];
      if (we[2]) mem[waddr][23:16] <= din[23:16];
      if (we[3]) mem[waddr][31:24] <= din[31:24];
      dout <= mem[raddr];
   end
/*
    //load elf//
    localparam MEM_SIZE = 32'h02000000;
    integer mem_words;
    integer i;
    reg [1023:0] elf_file;

    initial begin
      if ($test$plusargs("clear_ram")) begin
    $display("%m Clearing RAM");
        for(i=0; i < MEM_SIZE; i = i+1) begin
            // Zeroize Memory
        mem[i] = 32'h00000000;
        end
      end
        
      if($value$plusargs("elf_load=%s", elf_file)) begin
     $display("%m elf_load=%s", elf_file);
     $elf_load_file(elf_file);
     $display("%m elf_load_file done");
     mem_words = $elf_get_size/4;
     $display("%m Loading %d words", mem_words);

        for(i=0; i < mem_words; i = i+1) begin
        mem[i] = $elf_read_32(i*4);
        end
        $display("%m loading is done");
      end else
    $display("No ELF file specified");

    end
*/
   generate
      initial
	if(memfile != "") begin
	   $display("Preloading %m from %s", memfile);
	   $readmemb(memfile, mem);
	end
   endgenerate

endmodule
