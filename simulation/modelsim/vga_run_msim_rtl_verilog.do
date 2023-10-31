transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Data/GIT/VGA {C:/Data/GIT/VGA/tbird_fsm.v}
vlog -vlog01compat -work work +incdir+C:/Data/GIT/VGA {C:/Data/GIT/VGA/vga_control.v}
vlog -vlog01compat -work work +incdir+C:/Data/GIT/VGA {C:/Data/GIT/VGA/bit_gen2.v}
vlog -vlog01compat -work work +incdir+C:/Data/GIT/VGA {C:/Data/GIT/VGA/vga_2.v}

vlog -vlog01compat -work work +incdir+C:/Data/GIT/VGA {C:/Data/GIT/VGA/vga_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  vga_tb

add wave *
view structure
view signals
run -all
