# Image Montage
This is a Matlab program that yields an image montage from a collection of images as resouce and a reference image.

## Instruction
The function contains 4 steps
- Read file
- Rescale them so we can stitch the resource image to the output properly
- Match the histogram of resource images to that of the corresponding image block of the reference image
- Merge the output image with the reference image

## Files
- README.md: readme
- demo.m: demo code
- imMontage.m: main function

## imMontage
- input
    - imRef: reference image | 2-3D array
    - folder: path to the image collection | string ends with '/'
    - dup: number of duplication of the image collection, in case your collection isn't big enough | integer, default:4
    - wc: weight of the output image when merging with the reference image 
    - wh: weight of matched resource images and orginal resource images when matching local histogram
- output
    - out: output image montage | 2-3D array, 'dup' times bigger than the input
