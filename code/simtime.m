function [A] = simtime(n,index)
A = zeros(1,n);
for i=1:length(A)-1
    A(i+1)=A(i)+index;
end
end

