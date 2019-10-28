function K = key_expansion(key)

% KEY EXPANSION 

% fixed parameter of key expansion
% CK = uint32([  ...
%     hex2dec('00070e15') hex2dec('1c232a31') hex2dec('383f464d') hex2dec('545b6269') ...
%     hex2dec('70777e85') hex2dec('8c939aa1') hex2dec('a8afb6bd') hex2dec('c4cbd2d9') ...
%     hex2dec('e0e7eef5') hex2dec('fc030a11') hex2dec('181f262d') hex2dec('343b4249') ...
%     hex2dec('50575e65') hex2dec('6c737a81') hex2dec('888f969d') hex2dec('a4abb2b9') ...
%     hex2dec('c0c7ced5') hex2dec('dce3eaf1') hex2dec('f8ff060d') hex2dec('141b2229') ...
%     hex2dec('30373e45') hex2dec('4c535a61') hex2dec('686f767d') hex2dec('848b9299') ...
%     hex2dec('a0a7aeb5') hex2dec('bcc3cad1') hex2dec('d8dfe6ed') hex2dec('f4fb0209') ...
%     hex2dec('10171e25') hex2dec('2c333a41') hex2dec('484f565d') hex2dec('646b7279') ...
%     ]);
CK = [462357 472066609 943670861 1415275113 1886879365 2358483617 2830087869 3301692121 3773296373 4228057617 404694573 876298825 1347903077 1819507329 2291111581 2762715833 3234320085 3705924337 4177462797 337322537 808926789 1280531041 1752135293 2223739545 2695343797 3166948049 3638552301 4110090761 269950501 741554753 1213159005 1684763257];

% initial user key
for i=1:4
    MK(i) = typecast(uint8(key(4*i:-1:4*i-3)), 'uint32');
end



K = uint32(zeros(36,1));
% Ki = Mi XOR FKi
K(1) = bitxor(MK(1), hex2dec('a3b1bac6'));
K(2) = bitxor(MK(2), hex2dec('56aa3350'));
K(3) = bitxor(MK(3), hex2dec('677d9197'));
K(4) = bitxor(MK(4), hex2dec('b27022dc'));
% key expansion loop
for i=0:31
    % operation T'
    x = bitxor(bitxor(bitxor(K(i+2), K(i+3)), K(i+4)), CK(i+1));
    T = Lprime(tau(x)); 
    
    K(i+5) = bitxor(K(i+1), T);

end
