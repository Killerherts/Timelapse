import cv2
import glob
import os

# Set the directory containing the images
image_folder = 'resized'
video_name = 'timelapse.avi'

# Get all the images in the directory, sorted by filename
images = sorted(glob.glob(os.path.join(image_folder, '*.jpg')), key=os.path.basename)

# Determine the width and height from the first image
frame = cv2.imread(images[0])
height, width, layers = frame.shape
size = (width, height)

# Create the video writer
out = cv2.VideoWriter(video_name, cv2.VideoWriter_fourcc(*'DIVX'), 12, size)

# Add images to video
for filename in images:
    img = cv2.imread(filename)
    out.write(img)

# Release the video writer
out.release()
print("Timelapse video created successfully")
