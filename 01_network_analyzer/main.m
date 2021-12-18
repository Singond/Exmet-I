pkg load singon-ext
addpath octave

load_data
disp("");

eps0 = 8.854E-12;           # Permittivity of free space [SI]
mu0 = 1.257E-6;             # Permeability of free space [SI]
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
printf("  Length of T-piece: d = %g [mm]\n", d*1000);
disp("");

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
printf("  Length of cable: d = %g +- %g [mm]\n", dcab*1000, dcab_ster*1000);

dcab2 = (2*k + 1) ./ (4 .* fpks .* sqrt(eps0 * eps_polyethylene * mu0));
dcab2_mean = mean(dcab2);
dcab2_ster = std(dcab2) / sqrt(numel(dcab2));
disp("");

## Experiment 12
s = experiment(12).s11;
z12 = z0 .* (1 + s) ./ (1 - s);
L12 = z12 ./ (2i .* pi .* experiment(12).freq);  # L is complex inductance

## Experiment 13
s = experiment(13).s11;
z13 = z0 .* (1 + s) ./ (1 - s);
C13 = 1 ./ (z13 .* 2i .* pi .* experiment(13).freq);  # C is complex capacitance

## Experiment 15
s = experiment(15).s11;
z15 = z0 .* (1 + s) ./ (1 - s);

## Experiment 16
s = experiment(16).s11;
z16 = z0 .* (1 + s) ./ (1 - s);
