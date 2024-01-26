import os
from datetime import datetime
from PIL import Image, ImageFont, ImageDraw

# Font setup
font_path = '/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf'
font = ImageFont.truetype(font_path, 72)
fontsmall = ImageFont.truetype(font_path, 32)
fontcolor = (238,161,6)

# Create 'resized' directory if it does not exist
output_dir = 'resized'
if not os.path.exists(output_dir):
    os.makedirs(output_dir)

# Image processing
counter = 0
padding = 20  # Amount of padding from the right edge

for i in os.listdir(os.getcwd()):
    if i.endswith(".jpg"):
        counter += 1
        print("Image {0}: {1}".format(counter, i))

        # Get the modified date of the file
        mod_time = os.path.getmtime(i)
        date_obj = datetime.fromtimestamp(mod_time)
        get_mod_date = date_obj.strftime('%Y:%m:%d')
        get_mod_time = date_obj.strftime('%H:%M')

        # Open the image
        img = Image.open(i)

        # Draw the date and time with padding
        draw = ImageDraw.Draw(img)
        text_position_date = (img.width - 220 - padding, img.height - 150)
        text_position_time = (img.width - 220 - padding, img.height - 120)
        draw.text(text_position_date, get_mod_date, fontcolor, font=fontsmall)
        draw.text(text_position_time, get_mod_time, fontcolor, font=font)

        # Save the image in the 'resized' directory
        filename = os.path.join(output_dir, i[:-4] + "-resized.jpg")
        img.save(filename)
