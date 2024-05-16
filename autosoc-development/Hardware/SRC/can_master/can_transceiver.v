module can_transceiver
(
	// CAN Controller section
	input  tx_can,
	input  selftest_ctrl,
	output rx_can,
	// BUS section
	output tx_bus,
	input rx_bus
);

assign tx_bus = selftest_ctrl ? 1'b1 : tx_can;
assign rx_can = selftest_ctrl ? tx_can : rx_bus;

endmodule
