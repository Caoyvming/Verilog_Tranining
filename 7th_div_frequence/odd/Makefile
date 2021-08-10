TSCALE = -timescale="1ns/100ps"
RTL= ./src/3_div.v
TB = ./src/tb_3_div.v
TOP = div3_tb
DIR = ./vcs_work

VLOGAN_OPTS = -full64 -l $(DIR)/vlogan.log -Mdir=$(DIR)

VCS_ELB_OPTS = -Mdir=$(DIR) $(TSCALE) -LDFLAGS -Wl,--no-as-needed -full64 -debug_pp -t ps -licqueue -l $(DIR)/elaborate.log -P /tools/Synopsys/verdi_2018.09/verdi/Verdi_O-2018.09-SP2/share/PLI/VCS/LINUX64/novas.tab /tools/Synopsys/verdi_2018.09/verdi/Verdi_O-2018.09-SP2/share/PLI/VCS/LINUX64/pli.a

VCS_SIM_OPTS = -Mdir=$(DIR) -licqueue -l $(DIR)/simulate.log 

defualt: run

run: ana elb sim

ana:
	vlogan $(VLOGAN_OPTS) $(RTL) $(TB)

elb:
	vcs $(VCS_ELB_OPTS) $(TOP)

sim:
	./simv -l simv.log $(VCS_SIM_OPTS)

verdi:
	verdi $(RTL) $(TB) -ssf $(TOP).fsdb &

clean: 
	rm -rf simv* csrc* *.tmp *.vpd *.key *.log *hdrs.h *.fsdb verdiLog novas.* *.dat AN.DB vcs_work