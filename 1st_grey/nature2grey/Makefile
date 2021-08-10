TSCALE = -timescale="1ns/100ps"
RTL= nature2grey.v
TB = tb_for_n2g.v
verdi_cmd_file = top_io.cmd

VLOGAN_OPTS = -full64 -l vlogan.log

VCS_ELB_OPTS =-LDFLAGS -Wl,--no-as-needed -full64 -debug_pp -t ps -licqueue -l elaborate.log -P /tools/Synopsys/verdi_2018.09/verdi/Verdi_O-2018.09-SP2/share/PLI/VCS/LINUX64/novas.tab /tools/Synopsys/verdi_2018.09/verdi/Verdi_O-2018.09-SP2/share/PLI/VCS/LINUX64/pli.a

VCS_SIM_OPTS = -licqueue -l simulate.log



defualt: run

run: ana elb sim

ana:
	vlogan $(VLOGAN_OPTS) $(RTL) $(TB)
	
elb:
	vcs $(VCS_ELB_OPTS) tb_for_n2g

sim:
	./simv -l simv.log $(VCS_SIM_OPTS)

verdi:
	verdi $(RTL) $(TB) -ssf nature2grey.fsdb
	
clean: 
	rm -rf simv* csrc* *.tmp *.vpd *.key *.log *hdrs.h *.fsdb verdiLog novas.* *.dat AN.DB
