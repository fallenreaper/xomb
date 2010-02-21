/*
 * pci.d
 *
 * This module implements the architecture specific parts of the PCI spec.
 *
 */

module architecture.pci;

import architecture.cpu;

class PCIImplementation {
static:

	T read(T)(uint address) {
		synchronized {
			_setAddress(address);

			// get offset
			ushort offset = cast(ushort)(address & 0x3);

			return Cpu.ioIn!(T)(0xcfc + offset);
		}
	}

	void write(T)(uint address, T value) {
		synchronized {
			_setAddress(address);

			// get offset
			ushort offset = cast(ushort)(address & 0x3);

			Cpu.ioOut!(T)(0xcfc + offset, value);
		}
	}

private:

	void _setAddress(uint address) {
		// write out address
		Cpu.ioOut!(uint, "0xcf8")(address);
	}
}
