#!/bin/sh

cat $in | sed 's/port\s*//' | sed 's/(//g' | sed 's/;/\n/g' | grep -w 'in' | cut -d ':' -f 1 | sed 's/\,/\n/g' | sed 's/ //g' > in_tokens_tempfile;
cat $in | sed 's/;/\n/g' | grep -w 'out' | cut -d ':' -f 1 | sed 's/\,/\n/g' | sed 's/ //g' > out_tokens_tempfile;
let nin=$(cat in_tokens_tempfile | wc -l)-1;
let nout=$(cat out_tokens_tempfile | wc -l)-1;
echo -e "library ieee;\nuse ieee.std_logic_1164.all;\n
entity $(echo $entity)_tb is
end $(echo $entity)_tb; \n
architecture behavior of $(echo $entity)_tb is
component $(echo $entity) is
port (\n$(cat $in | sed 's/port\s*(//' | sed 's/^\s*(//' | grep 'in\|out' -w)
end component;\n
signal input  : std_logic_vector($(echo $nin) downto 0);
signal output  : std_logic_vector($(echo $nout) downto 0);\n
begin test_subject: $entity 
port map (" > $(echo $entity)_tb.vhdl; 

a=0;
cat in_tokens_tempfile | while read line; 
do echo -e $line =\> input\($a\), >> $(echo $entity)_tb.vhdl && let a++; 
done; 

a=0; 
cat out_tokens_tempfile | while read line; 
do echo -n -e $line =\> output\($a\) >> $(echo $entity)_tb.vhdl && let a++;
if [[ $a -le $nout ]];
    then echo "," >> $(echo $entity)_tb.vhdl;
fi
done;

echo -e ");\n" >> $(echo $entity)_tb.vhdl; 

echo -e "stim_proc: process begin" >> $(echo $entity)_tb.vhdl; 
let nin++;
len=$(echo 2^$nin-1 | bc); 
printf "\%0$(echo $nin)d\\n" $(echo -e "obase=2;$(seq 0 $len)" | bc) | while read line; 
                            do echo -e "\tinput <= \"$line\"; wait for 10 ns;" >> $(echo $entity)_tb.vhdl; 
                            done;

echo -e "report \"$entity testbench finished\";\nwait;\nend process;\nend;" >> $(echo $entity)_tb.vhdl

rm in_tokens_tempfile
rm out_tokens_tempfile