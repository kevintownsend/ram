set outputDir ./vivado
file mkdir $outputDir
read_verilog ./simple_dual_port_ram.v
#read_xdc constraints.xdc
synth_design -top simple_dual_port_ram -part xc7a200t
create_clock -period 2.50 clk
write_checkpoint -force $outputDir/post_synth.dcp
report_timing_summary -file $outputDir/post_synth_timing_summary.rpt
report_utilization -file $outputDir/post_synth_util.rpt
opt_design
place_design
route_design
report_timing_summary -file $outputDir/post_route_timing_summary.rpt
report_utilization -file $outputDir/post_route_util.rpt
