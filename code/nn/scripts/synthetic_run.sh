#!/bin/bash

task=mixture-HMM
prefix_event=event-temporal-3
prefix_time=time-temporal-3

DATA_ROOT=$HOME/Research/NeuralPointProcess/data/synthetic/$task
RESULT_ROOT=$HOME/scratch/results/NeuralPointProcess

hist=1
gru=1
n_embed=64
H=128
h2=0
bsize=64
bptt=5
learning_rate=0.0001
max_iter=10000000
cur_iter=0
T=24
w_scale=0.01
mode=CPU
net=joint
time_scale=1
lambda=1
loss=intensity
save_dir="$RESULT_ROOT/$net-$task-hidden-$H-embed-$n_embed-bptt-$bptt-bsize-$bsize"

if [ ! -e $save_dir ];
then
    mkdir -p $save_dir
fi

dev_id=0

./build/main \
    -h2 $h2 \
    -t_scale $time_scale \
    -history $hist \
    -gru $gru \
    -event $DATA_ROOT/$prefix_event \
    -time $DATA_ROOT/$prefix_time \
    -loss $loss \
    -lambda $lambda \
    -lr $learning_rate \
    -device $dev_id \
    -maxe $max_iter \
    -svdir $save_dir \
    -hidden $H \
    -embed $n_embed \
    -save_eval 1 \
    -eval 1 \
    -T $T \
    -b $bsize \
    -w_scale $w_scale \
    -int_report 500 \
    -int_test 2500 \
    -int_save 2500 \
    -bptt $bptt \
    -cur_iter $cur_iter \
    -mode $mode \
    -net $net \
    2>&1 | tee $save_dir/log.txt
