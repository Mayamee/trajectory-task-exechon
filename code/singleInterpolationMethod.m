function F = singleInterpolationMethod( coord, T_coord, v,T_V, a ,T_A )
 
	%Функция интерполяции одним многочленом 
	%на выходе законы изменения координаты, скорости и ускорения
	N=length(coord)+length(v)+length(a);%количество условий
	P=[coord v a].';% вектор свободных членов
	time=[T_coord T_V T_A]; % вектор времени
	Q=zeros(1,N);%матрица неизвестных коэффициентов 
	T=zeros(N,N);%Матрица известных коэффициентов
	syms t
	%Составление матрицы известных коэффициентов
	for i=1:length(coord)
		for j=1:N
			T(i,j)=time(i)^(j-1);
		end
	end
	for i=length(coord)+1:length(coord)+length(v)
		for j=2:N
			T(i,j)=(j-1)*time(i)^(j-2);
		end
	end
	for i=N-length(a)+1:N
		for j=3:N
			T(i,j)=(j-1)*(j-2)*time(i)^(j-3);
		end
	end    
	T_=inv(T); %Matrix inverse
	Q=T_*P;
	F_q=0; %Вычисление функции изменения обобщенной координаты от времени    
	for i=1:N
		F_q=F_q+Q(i)*t^(i-1);
	end
	F_v=0; %Вычисление функции изменения обобщенной скорости от времени  
	for i=2:N
		F_v=F_v+Q(i)*(i-1)*t^(i-2);
	end
	F_a=0; %Вычисление функции изменения обобщенного ускорения от времени  
	for i=3:N
		F_a=F_a+Q(i)*(i-1)*(i-2)*t^(i-3);
	end
	F = [F_q, F_v, F_a];
	 
	end
	