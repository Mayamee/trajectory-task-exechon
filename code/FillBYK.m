function [q1, q2, q3, q4, q5] = FillBYK(Q,N)
	sim_time = simtime(N,1);
	q1 = timeseries(Q(1,1:N),sim_time);
	q2 = timeseries(Q(2,1:N),sim_time);
	q3 = timeseries(Q(3,1:N),sim_time);
	q4 = timeseries(Q(4,1:N),sim_time);
	q5 = timeseries(Q(5,1:N),sim_time);
end

