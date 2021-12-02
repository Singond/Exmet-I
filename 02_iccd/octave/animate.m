function animate(img, framelength, varargin)
	if (nargin < 2)
		framelength = 1;
	endif
	for f = 1:size(img, 3)
		printf("Frame %d\n", f);
		printf("Maximum value: %g\n", max(img(:,:,f)(:)));
		printf("Minimum value: %g\n", min(img(:,:,f)(:)));
		imshow(img(:,:,f), [], varargin{:});
		pause(framelength);
	endfor
endfunction
