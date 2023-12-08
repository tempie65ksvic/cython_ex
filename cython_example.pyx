# cython: language_level=3

# Import static data types from libc.stdlib library
from libc.stdlib cimport malloc, free

# Declare a static data type for the argument and return value
def calculate_square(int x) -> int:
     return x * x

# Use C built-in functions to allocate and free memory
def allocate_and_fill_array(int size) -> int[:]:
     cdef int[:] array = <int[:]>malloc(size * sizeof(int))
     if not array:
         raise MemoryError("Failed to allocate memory")
    
     for i in range(size):
         array[i] = i

     return array

def free_allocated_memory(int[:] array) -> None:
     free(&array[0])

if __name__ == "__main__":
     # Use a statically typed function
     result = calculate_square(5)
     print("Square:", result)

     # Use built-in C functions to work with memory
     allocated_array = allocate_and_fill_array(5)
     print("Allocated Array:", allocated_array.tolist())

     # Free the allocated memory
     free_allocated_memory(allocated_array)
