pkg load singon-ext
addpath octave

eps0 = 8.854E-12;           # Permittivity of free space [SI]
mu0 = 1.257E-6;             # Permeability of free space [SI]

function mag = db2mag(decibels)
	mag = 10 .^ (decibels ./ 10);
endfunction

function decibels = mag2db(mag)
	decibels = 10 .* log10(mag);
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
ex = struct("name", {}, "freq", {}, "s11", {}, "s21", {});
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

z0 = 50;     # Base impedance [ohm]

## Experiment 3
T_smag = tmatrix(experiment(1).s11, experiment(1).s21, z0);
T_smas = tmatrix(experiment(2).s11, experiment(2).s21, z0);
T_3tot = tmatrix(experiment(3).s11, experiment(3).s21, z0);
T_smamm = zeros(size(T_smag));

for k = 1:size(T_smag)(3)
	T_smamm(:,:,k) = (T_smag(:,:,k) \ T_3tot(:,:,k)) / T_smas(:,:,k);
endfor
[s11_smamm, s21_smamm] = sparams(T_smamm, z0);

## Check
T_check = zeros(size(T_smamm));
for k = 1:size(T_check)(3)
	T_check(:,:,k) = T_smag(:,:,k) * T_smamm(:,:,k) * T_smas(:,:,k);
endfor
assert(T_check, T_3tot, 1e-12);

## Experiment 4
T_bncbnc = tmatrix(experiment(4).s11, experiment(4).s21, z0);
T_bnc = zeros(size(T_bncbnc));
for k = 1:size(T_bncbnc)(3)
	T_bnc(:,:,k) = sqrtm(T_bncbnc(:,:,k));
endfor
[s11_bnc, s21_bnc] = sparams(T_bnc, z0);

## Check
T_check = zeros(size(T_bnc));
for k = 1:size(T_check)(3)
	T_check(:,:,k) = T_bnc(:,:,k) * T_bnc(:,:,k);
endfor
assert(T_check, T_bncbnc, 1e-12);

## Experiment 5
T_5tot = tmatrix(experiment(5).s11, experiment(5).s21, z0);
T_bncff = zeros(size(T_5tot));
assert(size(T_5tot), size(T_bnc));
for k = 1:size(T_5tot)(3)
	T_bncff(:,:,k) = (T_bnc(:,:,k) \ T_5tot(:,:,k)) / T_bnc(:,:,k);
endfor
[s11_bncff, s21_bncff] = sparams(T_bncff, z0);

## Check
T_check = zeros(size(T_bncff));
for k = 1:size(T_check)(3)
	T_check(:,:,k) = T_bnc(:,:,k) * T_bncff(:,:,k) * T_bnc(:,:,k);
endfor
assert(T_check, T_5tot, 1e-12);

## Experiment 6
disp("Experiment 6:");
eps_polyethylene = 2.25;
v_pe = 1 / sqrt(eps0 * eps_polyethylene * mu0);
[~, pks] = findpeaksp(-abs(experiment(6).s21), "MinPeakProminence", 0.1);
fpks = experiment(6).freq(pks);
k = (0:(numel(pks)-1))';

## Fit function b(1) * x + b(2)
x = v_pe .* (2.*k + 1) ./ 4;
[beta, ~, r] = ols(fpks, [x ones(size(x))]);
d = 1/beta(1);
printf("Length of T-piece: d = %g [mm]\n", d*1000);

## Alternative solution
k = [0; 1];
d = (2*k + 1) ./ (4 .* fpks .* sqrt(eps0 * eps_polyethylene * mu0));
d_mean = mean(d);
d_ster = std(d) / sqrt(numel(d));

## Experiment 7
disp("Experiment 7:");
s = experiment(7).s21(experiment(7).freq < 3e8);
[~, pks] = findpeaksp(-abs(s), "MinPeakProminence", 0.1);
fpks = experiment(7).freq(pks);
k = (0:(numel(pks)-1))';

## Fit function b(1) * x + b(2)
x = v_pe .* (2.*k + 1) ./ 4;
[beta, ~, r] = ols(fpks, [x ones(size(x))]);
dcab = 1/beta(1);
##dcab_std = sqrt((v_pe / (2 * mean(fpks)**2))**2 * std(r)**2);
dcab_std = mean(sqrt((v_pe ./ (2 * fpks.**2)).**2 .* r.**2));
dcab_ster = dcab_std / sqrt(numel(fpks));
printf("Length of cable: d = %g +- %g [mm]\n", dcab*1000, dcab_ster*1000);

dcab2 = (2*k + 1) ./ (4 .* fpks .* sqrt(eps0 * eps_polyethylene * mu0));
dcab2_mean = mean(dcab2);
dcab2_ster = std(dcab2) / sqrt(numel(dcab2));

## Experiment 12
s = experiment(12).s11;
z = z0 .* (1 + s) ./ (1 - s);
L = z ./ (2i .* pi .* experiment(12).freq);  # L is complex inductance
