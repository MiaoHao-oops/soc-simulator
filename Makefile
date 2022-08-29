TOP_NAME := mycpu_top
INC_FILE := $(shell find /home/haooops/Documents/mycpu/vsrc/cache -name "*.v")
INC_FILE += $(shell find /home/haooops/Documents/mycpu/vsrc/core -name "*.v")
INC_FILE += $(shell find /home/haooops/Documents/mycpu/vsrc/tools/modules -name "*.v")
INC_FILE += $(shell find /home/haooops/Documents/mycpu/sim/verilator/vsrc -name "*.v")
INC_DIR	 := /home/haooops/Documents/mycpu/vsrc/core
INC_PATH := /home/haooops/Documents/cemu/src/core/mips
INCFLAGS = $(addprefix -I, $(INC_PATH))
CFLAGS = $(INCFLAGS) -O3 -g

.PHONY: obj_dir/V$(TOP_NAME), run_func, clean
obj_dir/V$(TOP_NAME): src/* $(INC_FILE)
	verilator --cc -Wno-fatal --exe -LDFLAGS "-lpthread" --build \
	$(addprefix -CFLAGS , $(CFLAGS)) \
	src/sim_mycpu.cpp $(INC_FILE) -I$(INC_DIR) --top $(TOP_NAME) --trace -j 12

run_func: obj_dir/V$(TOP_NAME)
	./obj_dir/Vmycpu_top -func -trace 10000000 10000000 -setdelay 34

clean:
	rm -rf obj_dir *.vcd