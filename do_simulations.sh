if [ $# -lt 2 ]; then
    echo "Usage: program <output path prefixt> <path to benchmark> [benchmark input]"
    exit
fi

# Your gem5 project root here.
gem5_root=~/jongho/gem5/

# gem5 Parameters
gem5_binary=$gem5_root"build/ARM/gem5.opt"
gem5_option=
gem5_script=$gem5_root"configs/example/se.py"
gem5_script_option=

# Simulation Configurations
baseline_config="--caches --cacheline_size=16 --l1d_size=1kB --l1i_size=2kB --l1i_assoc=1 --l2cache --num-l2caches=1 --l2_size=16kB --l2_assoc=16"
benchmark="-c $2"
benchmark_input=

if [ $# -gt 2 ]; then
    benchmark_input="-o \"$3\""
fi

for l1dassoc in 1 2 4 8
do
    gem5_option="-re -d $gem5_root$1"_l1dassoc_"$l1dassoc"
    gem5_script_option="$baseline_config --l1d_assoc=$l1dassoc $benchmark $benchmark_input"
    gem5_command="$gem5_binary $gem5_option $gem5_script $gem5_script_option"
    #echo $gem5_command
    eval $gem5_command
done
