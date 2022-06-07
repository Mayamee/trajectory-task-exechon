function F = splineInterpolationMethod( q_, T, V, A)
 
	N=length(q_);%Количество точек
	P=N-1;%Количество уравнений
	n=4*N-2;%Количество неизвестрых
	Tn=zeros(n);%Матрица известных коэффициентов  
	X=zeros(n,1); %Вектор свободных членов
	X(1:P,1)=q_(1:length(q_)-1).';
	X(N:2*P,1)=q_(2:length(q_)).'; 
	X(2*P+1,1)=V(1);
	X(2*P+N,1)=V(2);
	X(2*P+N+1,1)=A(1);
	X(2*P+2*N,1)=A(2);
	k=0;
	for i=1:P %1 Группа уравнений
		if (i==1) || (i==P)
			ie=5;
		else
			ie=4;
		end
		for j=1:ie %номер коэф
			 Tn(i,k+j)=T(i)^(j-1);
		end
		k=k+ie;
	end
	k=0;
	for i=1:P %2 Группа уравнений
		if (i==1) || (i==P) 
			ie=5;
		else
			ie=4;
		end
		
		for j=1:ie %номер коэф
			Tn(P+i,k+j)=T(i+1)^(j-1);
		end
		k=k+ie;
	end
	k=0;
	for i=1:N %3 Группа уравнений
		if (i==1) || (i==N) 
			ie=5;
			for j=2:ie %номер коэф
				Tn(2*P+i,k+j)=(j-1)*T(i)^(j-2);
			end
		elseif (i==2)
			ie=5;
			for j=2:ie %номер коэф
				Tn(2*P+i,k+j)=(j-1)*T(i)^(j-2);
				Tn(2*P+i,k+j+ie)=-(j-1)*T(i)^(j-2);
			end
			Tn(2*P+i,k+ie+5)=0;
			k=k+ie;
		elseif (i==(N-1))
			ie=4;
			for j=2:ie %номер коэф
				Tn(2*P+i,k+j)=(j-1)*T(i)^(j-2);
				Tn(2*P+i,k+j+ie)=-(j-1)*T(i)^(j-2);
			end
			Tn(2*P+i,k+2*ie+1)=-4*T(i)^(3);
			k=k+ie;
		else
			ie=4;
			for j=2:ie %номер коэф
				Tn(2*P+i,k+j)=(j-1)*T(i)^(j-2);
				Tn(2*P+i,k+j+ie)=-(j-1)*T(i)^(j-2);
			end
			k=k+ie;
		end
	end
	k=0;
	for i=1:N %4 Группа уравнений
		if (i==1) || (i==N) 
			ie=5;
			for j=3:ie %номер коэф
				Tn(N+2*P+i,k+j)=(j-2)*(j-1)*T(i)^(j-3);
			end
		elseif (i==2)
			ie=5;
			for j=3:ie %номер коэф
				Tn(N+2*P+i,k+j)=(j-2)*(j-1)*T(i)^(j-3);
				Tn(N+2*P+i,k+j+ie)=-(j-2)*(j-1)*T(i)^(j-3);
			end
			Tn(N+2*P+i,k+ie+5)=0;
			k=k+ie;
		elseif (i==(N-1))
			ie=4;
			for j=3:ie %номер коэф
				Tn(N+2*P+i,k+j)=(j-2)*(j-1)*T(i)^(j-3);
				Tn(N+2*P+i,k+j+ie)=-(j-2)*(j-1)*T(i)^(j-3);
			end
			Tn(N+2*P+i,k+2*ie+1)=-4*3*T(i)^(2);
			k=k+ie;
		else
			ie=4;
			for j=3:ie %номер коэф
				Tn(N+2*P+i,k+j)=(j-2)*(j-1)*T(i)^(j-3);
				Tn(N+2*P+i,k+j+ie)=-(j-2)*(j-1)*T(i)^(j-3);
			end
			k=k+ie;
		end
	end
	% Расчет вектора неизвестных коэффициентов
	Q=Tn\X;
	syms t
	F_=0;
		%Вычисление функции изменения обобщенной координаты от времени
		k=0;
		for i=1:P
			if (i==1) || (i==P)
				ie=5;
			else
				ie=4;
			end
			for j=1:ie
				F_=F_+Q(k+j)*t^(j-1);
			end
			k=k+ie;
			F(i,:)=F_;
			F_=0;
		end
	end
	