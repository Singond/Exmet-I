addpath octave

[img hdr] = readSPE("data/hydrogen-ccp.spe");

## In subsequent frames, the pixel columns are shifted
## by an increasing amount. The following corrects this offset.
frames = size(img, 3);
for fn = 1:frames
	offset = 2 * (mod(fn - 1, frames));  # Amount of offset
	frame = img(:,:,fn);
	if (offset != 0)
		img(:,:,fn) = frame(:,[offset+1:end 1:offset]);
	endif
endfor
clear fn frame frames offset
