all: zephyr.bin

PATCHES = ../../mirage_firmware.patch

zephyrproject:
	west init zephyrproject
	pip install -r zephyrproject/zephyr/scripts/requirements.txt
	cd zephyrproject/zephyr && git apply $(PATCHES)

zephyr.bin: zephyrproject
	cd zephyrproject/zephyr && west build -b qemu_riscv64 samples/synchronization
	cp ./zephyrproject/zephyr/build/zephyr/zephyr.elf zephyr.elf
	riscv64-linux-gnu-objcopy -O binary zephyr.elf zephyr.bin

.PHONY: clean
clean:
	rm -rf zephyrproject zephyr.bin zephyr.elf
