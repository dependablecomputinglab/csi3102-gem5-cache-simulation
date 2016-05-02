if [ $# -lt 1 ]; then
    echo "Usage: program <path to benchmark> [benchmark input]"
    exit
fi

# Your gem5 project root here.
gem5_root=~/jongho/gem5/

# configuration number
config_num=0

# gem5 Parameters
gem5_binary=$gem5_root"build/ARM/gem5.opt"
gem5_option=
gem5_script=$gem5_root"configs/example/se.py"
gem5_script_option=

# Simulation Configurations
baseline_config="--caches --cacheline_size=16 --l1d_size=1kB --l1i_size=2kB --l1i_assoc=1 --l2cache --num-l2caches=1 --l2_size=16kB --l2_assoc=16"
benchmark="-c $1"
benchmark_input=

if [ $# -gt 1 ]; then
    benchmark_input="-o \"$2\""
fi

for l1dassoc in 1 2 4 8
do
    config_num=$(($config_num+1))
    gem5_option="-re -d $gem5_root""_config$config_num"
    gem5_script_option="$baseline_config --l1d_assoc=$l1dassoc $benchmark $benchmark_input"
    gem5_command="$gem5_binary $gem5_option $gem5_script $gem5_script_option"
    echo $gem5_command
    #eval $gem5_command
done
