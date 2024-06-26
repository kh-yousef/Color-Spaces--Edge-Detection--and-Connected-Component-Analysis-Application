function normalized_Image = mynormalize(I)

minimum=min(I(:));
I=I-minimum;
maximum=max(I(:));
I=I/maximum;
I=I*255;
normalized_Image =uint8(I);

end