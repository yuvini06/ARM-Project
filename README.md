# CO224: Computer Architecture (Project)

## Description: 
In image processing, images are represented as matrices. The RGB values of each pixel are represented by an element of the matrix (i.e. a single pixel is represented using three values. Each of these values must be between 0-255). However, a gray -scale image is represented using a single value per pixel. 
In this project only gray-scale images are considered and only the matrix representation of images will be used.
Although there are many operations involved in image processing, only the following three will be considered.
1.	Image inversion
2.	Rotation 180
3.	Flip

*The matrix manipulations involved in carrying out the above three operations can be found in the Operations.pdf file*

## Specification:
Program inputs and outputs
The program will take the inputs in the following order:
1. Number of rows in the matrix
2. Number of columns in the matrix
3. Operation code (explained below)
4. Elements of the matrix

The program will give the following output:
1. Type of operation executed
2. Resulting matrix

The operation codes are as follows.
- Display the original without any change: 0 (Original)
- Invert the image: 1 (Inversion)
- Rotate the image by 180 degrees: 2 (Rotation by 180)
- Flip the image: 3 (Flip)

If any other value is given for the operation code, an error message stating 'Invalid operation' will be displayed, thus exiting the program.
