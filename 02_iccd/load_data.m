addpath octave

[img hdr] = readSPE("data/hydrogen-ccp.spe");

## In subsequent frames, the pixel columns are shifted
## by an increasing amount. The following corrects this offset.
for fn = 1:size(img, 3)
	offset = 2 * (fn - 1);  # Amount of offset
	frame = img(:,:,fn);
	img(:,:,fn) = frame(:,[offset+1:end 1:offset]);
endfor
clear fn frame offset
