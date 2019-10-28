function result = L(x)

% B <<< 2
t1 = bitand(x, 3221225472);
t1 = bitshift(t1, -30);
t2 = bitshift(x, 2);
result = bitxor(t1, t2);

% B xor (B <<< 2)
result = bitxor(x, result);

% B <<< 10
t1 = bitand(x, 4290772992);
t1 = bitshift(t1, -22);
t2 = bitshift(x, 10);
t3 = bitxor(t1, t2);

% (B xor (B <<< 2)) xor (B <<< 10)
result = bitxor(result, t3);

% B <<< 18
t1 = bitand(x, 4294950912);
t1 = bitshift(t1, -14);
t2 = bitshift(x, 18);
t3 = bitxor(t1, t2);

% (B xor (B <<< 2)) xor (B <<< 10) xor (B <<< 18)
result = bitxor(result, t3);

% B <<< 24
t1 = bitand(x, 4294967040);
t1 = bitshift(t1, -8);
t2 = bitshift(x, 24);
t3 = bitxor(t1, t2);

% (B xor (B <<< 2)) xor (B <<< 10) xor (B <<< 18)  xor (B <<< 24)
result = bitxor(result, t3);


end