vsim_dual_port_xor_ram = work/dual_port_xor_ram

all:

work :
	vlib work

$(vsim_dual_port_xor_ram) : dual_port_xor_ram.v work
	vlog dual_port_xor_ram.v +incdir+../common

vim:
	vim -p makefile ../std_fifo/makefile ../std_fifo/vsim.mk

tcl: common.vh
	vivado -mode tcl < sdp.tcl

common.vh: abs.vh log2.vh
	cp ../common/common.vh .

abs.vh:
	cp ../common/abs.vh .

log2.vh:
	cp ../common/log2.vh .
