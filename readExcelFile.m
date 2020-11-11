function [numJoints,coOrdinates,t]=readExcelFile(filename)
[numbers, strings, raw] = xlsread(filename);

strings=strings(4,:);
strings(:,[1,2])= '';
strings=strings(~cellfun('isempty',strings));
numbers([1,2,3,4,5],:) = []; %removes first 5 unwanted rows
numbers(:,1)=[]; %removes frames columns
t=numbers(:,1);
coOrdinates=numbers;
coOrdinates(:,1)=[];%removes time columns

[m,n] = size(coOrdinates);
numJoints=n/3;
end


