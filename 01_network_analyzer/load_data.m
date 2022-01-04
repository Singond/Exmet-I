## Copyright 2021 Radek Hornak, Jan Slany, Lukas Vrana

0;  # Not a function file

function mag = db2mag(decibels)
	mag = 10 .^ (decibels ./ 20);
endfunction

function decibels = mag2db(mag)
	decibels = 20 .* log10(mag);
end

## Create a complex number from modulus and argument in degrees.
function z = complex_polard(modulus, argument)
	z = complex(modulus .* cosd(argument), modulus .* sind(argument));
endfunction

## Import scattering matrix from data files.
function ex = import_smatrix(s11_filename, s21_filename, name)
	if (nargin < 3)
		[~, fname, ~] = fileparts(s11_filename);
		name = strsplit(fname, "-"){1};
	end
	ex = struct("name", name, "freq", [], "s11", [], "s21", []);

	# Read s_11 data
	if (!isempty(s11_filename))
		printf("Reading s_11 data from %s.\n", s11_filename);
		f = fopen(["data/" s11_filename]);
		fskipl(f, 2);
		header = fgetl(f);
		assert(strcmp(strtrim(header), "freq[Hz] db:Trc1_S11 ang:Trc1_S11"),
			"File %s does not contain s_11 data. The header is: %s.",
			s11_filename, header);
		data = dlmread(f, "");
		fclose(f);
		ex.freq = data(:,1);
		ex.s11 = complex_polard(db2mag(data(:,2)), data(:,3));
	end

	# Read s_21 data
	if (!isempty(s21_filename))
		printf("Reading s_21 data from %s.\n", s21_filename);
		f = fopen(["data/" s21_filename]);
		fskipl(f, 2);
		header = fgetl(f);
		assert(strcmp(strtrim(header), "freq[Hz] db:Trc1_S21 ang:Trc1_S21"),
			"File %s does not contain s_21 data.", s21_filename);
		data = dlmread(f, "");
		fclose(f);
		if (!isempty(ex.freq))
			assert(all(data(:,1) == ex.freq),
				"Frequency data differs between %s and %s.",
				s11_filename, s21_filename);
		else
			ex.freq = data(:,1);
		endif
		ex.s21 = complex_polard(db2mag(data(:,2)), data(:,3));
	end
end

## Import the data into an array of structs called 'experiment'.
experiment = struct("name", {}, "freq", {}, "s11", {}, "s21", {});
k = 1;
experiment(k++) = import_smatrix("data01-s11.csv", "data01-s21.csv");
experiment(k++) = import_smatrix("data02-s11.csv", "data02-s21.csv");
experiment(k++) = import_smatrix("data03-s11.csv", "data03-s21.csv");
experiment(k++) = import_smatrix("data04-s11.csv", "data04-s21.csv");
experiment(k++) = import_smatrix("data05-s11.csv", "data05-s21.csv");
experiment(k++) = import_smatrix("data06-s11.csv", "data06-s21.csv");
experiment(k++) = import_smatrix("data07-s11.csv", "data07-s21.csv");
experiment(k++) = import_smatrix("data08-s11.csv", "data08-s21.csv");
experiment(k++) = import_smatrix("data09-s11.csv", "data09-s21.csv");
experiment(k++) = import_smatrix("data10-s11.csv", "data10-s21.csv");
experiment(k++) = import_smatrix("data11-s11.csv", "");
experiment(k++) = import_smatrix("data12-s11.csv", "");
experiment(k++) = import_smatrix("data13-s11.csv", "");
experiment(k++) = import_smatrix("data14-s11.csv", "");
experiment(k++) = import_smatrix("data15-s11.csv", "");
experiment(k++) = import_smatrix("data16-s11.csv", "");
experiment(k++) = import_smatrix("", "data17-s21.csv", "data17");
