all:
	verilator -Wall --cc ../rtl/*.v --exe main.cpp
	make -C obj_dir -f Vstopwatch_top.mk
	./obj_dir/Vstopwatch_top

clean:
	rm -rf obj_dir
