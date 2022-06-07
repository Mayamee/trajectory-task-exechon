function [VELM, T_VELM] = syncM5_Resolve_FNC(dQ, ACC, DEC, MAX_TIME)
    T_ACC = roots([(1 + ACC / DEC); - 2 * MAX_TIME; 2 * dQ / ACC]);
    T_ACC = T_ACC(2, 1);
    T_DEC = T_ACC * ACC / DEC;
    VELM = T_ACC * ACC;
    T_VELM = MAX_TIME - T_ACC - T_DEC;
end
