## Copyright 2021 Radek Hornak, Jan Slany, Lukas Vrana

## Convert the given transmission matrix into a corresponding scattering matrix.
function [s11, s21] = sparams(T, z0)
	a = T(1,1,:)(:);
	b = T(1,2,:)(:);
	c = T(2,1,:)(:);
	d = T(2,2,:)(:);
	s11 = (a + (b./z0) - (c.*z0) - d) ./ (a + (b./z0) + (c.*z0) + d);
	s21 = 2 ./ (a + (b./z0) + (c.*z0) + d);
endfunction
