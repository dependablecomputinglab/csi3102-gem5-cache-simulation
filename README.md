#Cache Simulation with _gem5_
```shell
$ ./build/ARM/gem5.opt -re -d dijkstra configs/example/se.py --caches --cacheline_size=16 --l1d_size=1kB --l1d_assoc=1 --l1i_size=2kB --l1i_assoc=1 --l2cache --num-l2caches=1 --l2_size=16kB --l2_assoc=16 -c <path to dijkstra binary> -o <path to dijkstra input>
```

In directory `dijkstra`, you can see:
- [stats.txt](http://dclab.yonsei.ac.kr/csi3102/dijkstra/stats.txt)
- [simout](http://dclab.yonsei.ac.kr/csi3102/dijkstra/simout)
- [simerr](http://dclab.yonsei.ac.kr/csi3102/dijkstra/simerr)
- [config.ini](http://dclab.yonsei.ac.kr/csi3102/dijkstra/config.ini)
- [config.json](http://dclab.yonsei.ac.kr/csi3102/dijkstra/config.json)

Modify `src/mem/cache/Cache.py`:
```Python
#tags = Param.BaseTags(LRU(), "Tag store (replacement policy)")
tags = Param.BaseTags(RandomRepl(), "Tag store (replacement policy)")
```

Rebuild:
```shell
$ scons build/ARM/gem5.opt
```

Do simulation:
```shell
$ ./build/ARM/gem5.opt -re configs/example/se.py --caches --cacheline_size=16 --l1d_size=1kB --l1d_assoc=1 --l1i_size=2kB --l1i_assoc=1 --l2cache --num-l2caches=1 --l2_size=16kB --l2_assoc=16 -c <benchmark binary> [-o benchmark input]
```
