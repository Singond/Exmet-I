function T = tmatrix(s11, s21, z0)
	s22 = s11;
	s12 = s21;

	a = ((1 + s11) .* (1 - s22) + s12 .* s21) ./ (2 * s21);
	b = ((1 + s11) .* (1 + s22) - s12 .* s21) .* z0 ./ (2 * s21);
	c = ((1 - s11) .* (1 - s22) - s12 .* s21) ./ (2 * s21 .* z0);
	d = ((1 - s11) .* (1 + s22) + s12 .* s21) ./ (2 * s21);

	T = reshape([a c b d]', 2, 2, []);
endfunction