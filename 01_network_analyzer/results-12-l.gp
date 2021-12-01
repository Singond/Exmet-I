load "../plotsettings.gp"
set log
set border 15
set xtics in mirror
set ytics in mirror
set xtics ('$10^4$' 1e4+1, '$10^5$' 1e5, '$10^6$' 1e6, '$10^7$' 1e7, '$10^8$' 1e8, '$10^9$' 1e9, '$10^{10}$' 1e10)
set ytics ('$10^{-10}$' 1e-10, '$10^{-9}$' 1e-9, '$10^{-8}$' 1e-8, '$10^{-7}$' 1e-7, '$10^{-6}$' 1e-6, '$10^{-5}$' 1e-5, '$10^{-4}$' 1e-4, '$10^{-3}$' 1e-3-0.000001)
set xlabel '$\freq\,[\si{\hertz}]$'
set ylabel '$\inductance\,[\si{\henry}]$'
set key off