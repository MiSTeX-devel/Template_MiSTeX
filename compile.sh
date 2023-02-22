#!/bin/bash
test -d output_files || mkdir output_files
quartus_sh --flow compile *.qpf
SOF=$(echo output_files/*.sof)
RBF=$(echo $SOF | sed s,sof,rbf,g)
quartus_cpf -c $SOF $RBF

