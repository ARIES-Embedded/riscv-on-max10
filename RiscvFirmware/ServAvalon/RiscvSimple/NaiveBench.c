#include "NaiveBench.h"

#define ARRAYLEN 512
#define ITERATIONS 10
typedef uint16_t bench_t;
static bench_t buffer[ARRAYLEN];
static bench_t randomValue = 0;

bench_t Random() {
	randomValue = 1103515245 * randomValue + 12345;
	return randomValue;
}

void FillArray() {
	for (uint16_t i = 0; i < ARRAYLEN; ++i) {
		buffer[i] = Random();
	}
}

void Sort() {
	bool hasSwapped = true;
	while (hasSwapped) {
		hasSwapped = false;
		for (uint16_t i = 0; i < ARRAYLEN - 1; ++i) {
			if (buffer[i] > buffer[i + 1]) {
				uint16_t temp = buffer[i];
				buffer[i] = buffer[i + 1];
				buffer[i + 1] = temp;
				hasSwapped = true;
			}
		}
	}
}

void Bench(void) {
	for (uint16_t i = 0; i < ITERATIONS; ++i) {
		randomValue = 0;
		FillArray();
		Sort();
	}
}
