function R=Koefficienti(v,T,N)
%?????? ?????
syms t
%??????????? ???????????, ???????????? ????? ????????? ?????????? ?????????
p(1,:)=[1 t t^2 t^3 t^4 zeros(1,4*N-3)];
p(2,:)=[zeros(1,5) 1 t t^2 t^3 zeros(1,4*N-7)];
p(N,:)=[zeros(1,4*N-3) 1 t t^2 t^3 t^4];
for i=3:N-1
    p(i,:)=[zeros(1,4*i-3) 1 t t^2 t^3 zeros(1,4*N-4*i+1)];
end
%??????????? ?????? ??????????? ?? ???????????
p_1=diff(p,t);
%??????????? ?????? ??????????? ?? ???????????
p_2=diff(p_1,t);
%??????????? ??????? ????????? ??? ????????? ????????????? ???????????
P(2*N+1,:)=subs(p_1(1,:),t,0);
P(3*N+2,:)=subs(p_2(1,:),t,0);
P(3*N+1,:)=subs(p_1(N,:),t,T);
P(4*N+2,:)=subs(p_2(N,:),t,T);
i=1;
for t1=0:T/N:T-T/N
    P(2*i-1,:)=subs(p(i,:),t,t1);
    P(2*i,:)=subs(p(i,:),t,t1+T/N);
    A(2*i-1,1)=v(i);
    A(2*i,1)=v(i+1);
    i=i+1;
end
i=1;
for t1=T/N:T/N:T-T/N
    P(i+2*N+1,:)=subs(p_1(i,:)-p_1(i+1,:),t,t1);
    P(i+3*N+2,:)=subs(p_2(i,:)-p_2(i+1,:),t,t1);
    i=i+1;
end
A(4*N+2)=0;
R=double(inv(P)*A);
