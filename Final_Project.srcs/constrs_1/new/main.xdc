## squarefsm.xdc - pin constraints for the Basys 3 board (xc7a35tcpg236-1)
## Top module: squarefsm

## 100 MHz board clock
set_property -dict { PACKAGE_PIN W5  IOSTANDARD LVCMOS33 } [get_ports BOARDCLK]
create_clock -period 10.000 -name sys_clk [get_ports BOARDCLK]

## n = switches SW3..SW0 (rightmost four switches)
set_property -dict { PACKAGE_PIN V17 IOSTANDARD LVCMOS33 } [get_ports {N[0]}]
set_property -dict { PACKAGE_PIN V16 IOSTANDARD LVCMOS33 } [get_ports {N[1]}]
set_property -dict { PACKAGE_PIN W16 IOSTANDARD LVCMOS33 } [get_ports {N[2]}]
set_property -dict { PACKAGE_PIN W17 IOSTANDARD LVCMOS33 } [get_ports {N[3]}]

## GO = switch SW15 (leftmost switch)
set_property -dict { PACKAGE_PIN R2  IOSTANDARD LVCMOS33 } [get_ports GO]

## RST_N = switch SW14 (up = run, down = reset)
set_property -dict { PACKAGE_PIN T1  IOSTANDARD LVCMOS33 } [get_ports RST_N]

## DONE = LED LD0 (rightmost LED)
set_property -dict { PACKAGE_PIN U16 IOSTANDARD LVCMOS33 } [get_ports DONE]

## Seven-segment segments A..G (active-low)
set_property -dict { PACKAGE_PIN W7  IOSTANDARD LVCMOS33 } [get_ports A]
set_property -dict { PACKAGE_PIN W6  IOSTANDARD LVCMOS33 } [get_ports B]
set_property -dict { PACKAGE_PIN U8  IOSTANDARD LVCMOS33 } [get_ports C]
set_property -dict { PACKAGE_PIN V8  IOSTANDARD LVCMOS33 } [get_ports D]
set_property -dict { PACKAGE_PIN U5  IOSTANDARD LVCMOS33 } [get_ports E]
set_property -dict { PACKAGE_PIN V5  IOSTANDARD LVCMOS33 } [get_ports F]
set_property -dict { PACKAGE_PIN U7  IOSTANDARD LVCMOS33 } [get_ports G]

## Digit anodes (active-low): ONECOLD[0] = rightmost digit, ONECOLD[3] = leftmost
set_property -dict { PACKAGE_PIN U2  IOSTANDARD LVCMOS33 } [get_ports {ONECOLD[0]}]
set_property -dict { PACKAGE_PIN U4  IOSTANDARD LVCMOS33 } [get_ports {ONECOLD[1]}]
set_property -dict { PACKAGE_PIN V4  IOSTANDARD LVCMOS33 } [get_ports {ONECOLD[2]}]
set_property -dict { PACKAGE_PIN W4  IOSTANDARD LVCMOS33 } [get_ports {ONECOLD[3]}]

## Board configuration settings
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]