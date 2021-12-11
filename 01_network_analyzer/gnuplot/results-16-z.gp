load "../plotsettings.gp"
set log
set border 15
set xtics in mirror
set ytics in mirror
set xtics ('$10^4$' 1e4+1, '$10^5$' 1e5, '$10^6$' 1e6, '$10^7$' 1e7, '$10^8$' 1e8, '$10^9$' 1e9, '$10^{10}$' 1e10)
#set ytics ('$1$' 1, '$10^{1}$' 1e1, '$10^{2}$' 1e2, '$10^{3}$' 1e3, '$10^{4}$' 1e4)
set xlabel '$\freq\,[\si{\hertz}]$'
set ylabel '$\impedance\,[\si{\ohm}]$'
set key off
