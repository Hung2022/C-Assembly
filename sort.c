#include <stdio.h>

/*
 * Swaps the values of arr at indices i and i-1
 */
// {7, 2, 1, 3, 4, 5, 8, 6, 9, 0};
void swap(int *arr, int i)
{
    int temp = arr[i];
    arr[i] = arr[i - 1];
    arr[i - 1] = temp;
}

/* 
 * Insert the element at i into the sorted region of arr
 *
 * Precondition:
 *   arr from index 0 to i-1 is already sorted
 *
 *  Postcondition:
 *    arr from index 0 to i is now sorted
 */
// {7, 2, 1, 3, 4, 5, 8, 6, 9, 0};
void insert_left(int *arr, int i)
{
    if (i > 0 && arr[i] < arr[i - 1])
    {
        swap(arr, i);
        insert_left(arr, i - 1);
    }
}

/* 
 * loop here
 * Sorts array with the given size in ascending order
 */
void isort(int *arr, int size)
{
    for (int i = 1; i < size; i++)
    {
        insert_left(arr, i);
    }
}

/* 
 * Prints array with the given size
 */
void print(int *arr, int size)
{
    while (size != 0)
    {
        printf("%d", *arr);
        arr = arr + 1;
        size = size - 1;
    }
    printf("\n");
}

int main()
{
    int arr[10] = {7, 2, 1, 3, 4, 5, 8, 6, 9, 0};
    int size = 10;
    isort(arr, size);
    print(arr, size);
    return 0;
}