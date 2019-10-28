function result = Lprime(x)

% B <<< 13
t1 = bitand(x, 4294443008);
t1 = bitshift(t1, -19);
t2 = bitshift(x, 13);
result = bitxor(t1, t2);

% B xor (B <<< 13)
result = bitxor(x, result);

% B <<< 23
t1 = bitand(x, 4294966784);
t1 = bitshift(t1, -9);
t2 = bitshift(x, 23);
t3 = bitxor(t1, t2);

% (B xor (B <<< 13)) xor (B <<< 23)
result = bitxor(result, t3);

end