# Retrieving Structural Information from Image Using Corner Information

This demo program takes as input an image consisting of (perfectly) closed polygons. It locates all (chordless) polygons in the image and their adjacencies. In the output, a polygon is represented as a red asterisk on its centroid and adjacencies are shown as yellow straight lines.

prog_CornerWallDetectionBetter.m is the main program.

I provided two images as sample inputs. If you want to use your own images, you may want to modify the program. Please read comments in the program for more information. Please be informed that DFS was used to find chordless cycles in a graph and I DID NOT RESTRICT THE DEPTH OF SEARCH. Therefore, image with too many corners connected to each other could cause matlab to consume huge amount of memory and breaks down your OS.

I offered more details and screenshots in my personal site. Please read more [here](http://ziweixu.github.io/projects/Retrieving-Structural-Information-from-Image-Using-Corners/) if you'd like to.