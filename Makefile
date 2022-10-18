TOP_NAME := mycpu_top
INC_FILE := $(shell find /home/haooops/Documents/mycpu/vsrc/cache -name "*.v")
INC_FILE += $(shell find /home/haooops/Documents/mycpu/vsrc/core -name "*.v")
INC_FILE += $(shell find /home/haooops/Documents/mycpu/vsrc/tools/modules -name "*.v")
INC_FILE += $(shell find /home/haooops/Documents/mycpu/sim/verilator/vsrc -name "*.v")
INC_DIR	 := /home/haooops/Documents/mycpu/vsrc/core
INC_PATH := /home/haooops/Documents/cemu/src/core/mips
INCFLAGS = $(addprefix -I, $(INC_PATH))
CFLAGS = $(INCFLAGS) -O2 -g
T ?= n

ifeq ($(T), y)
	TRACE := -trace 10000000 10000000
endif

.PHONY: obj_dir/V$(TOP_NAME), run_func, clean
obj_dir/V$(TOP_NAME): src/* $(INC_FILE)
	verilator --cc -Wno-fatal --exe -LDFLAGS "-lpthread" --build \
	$(addprefix -CFLAGS , $(CFLAGS)) \
	src/sim_mycpu.cpp $(INC_FILE) -I$(INC_DIR) --top $(TOP_NAME) --trace -j 12

run_func: obj_dir/V$(TOP_NAME)
	./obj_dir/V$(TOP_NAME) -func $(TRACE) -setdelay 34

run_perf: obj_dir/V$(TOP_NAME)
	./obj_dir/V$(TOP_NAME) -perf $(TRACE) -uart

diff_perf: obj_dir/V$(TOP_NAME)
	./obj_dir/V$(TOP_NAME) -perfdiff $(TRACE) -uart

diff_bitcount: obj_dir/V$(TOP_NAME)
	./obj_dir/V$(TOP_NAME) -perfdiff $(TRACE) -uart -prog 1

diff_bubblesort: obj_dir/V$(TOP_NAME)
	./obj_dir/V$(TOP_NAME) -perfdiff $(TRACE) -uart -prog 2

diff_coremark: obj_dir/V$(TOP_NAME)
	./obj_dir/V$(TOP_NAME) -perfdiff $(TRACE) -uart -prog 3

diff_crc32: obj_dir/V$(TOP_NAME)
	./obj_dir/V$(TOP_NAME) -perfdiff $(TRACE) -uart -prog 4

diff_dhrystone: obj_dir/V$(TOP_NAME)
	./obj_dir/V$(TOP_NAME) -perfdiff $(TRACE) -uart -prog 5

diff_quicksort: obj_dir/V$(TOP_NAME)
	./obj_dir/V$(TOP_NAME) -perfdiff $(TRACE) -uart -prog 6

diff_selectsort: obj_dir/V$(TOP_NAME)
	./obj_dir/V$(TOP_NAME) -perfdiff $(TRACE) -uart -prog 7

diff_sha: obj_dir/V$(TOP_NAME)
	./obj_dir/V$(TOP_NAME) -perfdiff $(TRACE) -uart -prog 8

diff_streamcopy: obj_dir/V$(TOP_NAME)
	./obj_dir/V$(TOP_NAME) -perfdiff $(TRACE) -uart -prog 9

diff_stringsearch: obj_dir/V$(TOP_NAME)
	./obj_dir/V$(TOP_NAME) -perfdiff $(TRACE) -uart -prog 10

open_wave: ./trace-perf-1.vcd ./test/perf/waveform.gtkw
	gtkwave -f ./trace-perf-1.vcd -a ./test/perf/waveform.gtkw

clean:
	rm -rf obj_dir *.vcd