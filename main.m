% SMS4 cipher implementation (encryption)
% Based on "SM4 Block Cipher Algorithm", url:
% Based also on the description of "Linear and Differential Cryptanalysis 
% of Reduced SM4 Block cipher" by Kim et al.
% Author : kpcrypto.net

clear all;
close all;

% USER INPUT --------------------------------------------------------------


% sm4 key
key = [hex2dec('01') hex2dec('23') hex2dec('45') hex2dec('67') ...
             hex2dec('89') hex2dec('ab') hex2dec('cd') hex2dec('ef') ...
             hex2dec('fe') hex2dec('dc') hex2dec('ba') hex2dec('98') ...
             hex2dec('76') hex2dec('54') hex2dec('32') hex2dec('10')]

% sm4 input plaintext
plaintext = [hex2dec('01') hex2dec('23') hex2dec('45') hex2dec('67') ...
             hex2dec('89') hex2dec('ab') hex2dec('cd') hex2dec('ef') ...
             hex2dec('fe') hex2dec('dc') hex2dec('ba') hex2dec('98') ...
             hex2dec('76') hex2dec('54') hex2dec('32') hex2dec('10') ...             
             ]
         
% END OF USER INPUT -------------------------------------------------------


% number of plaintexts to encrypt 
no_inputs = size(plaintext, 1);

% key schedule function
rk = key_expansion(key);

for i=1:no_inputs
    % convert from 8-bit to 32-bit representation
    x1 = typecast(uint8(flip(plaintext(i,1:4))), 'uint32');
    x2 = typecast(uint8(flip(plaintext(i,5:8))), 'uint32');
    x3 = typecast(uint8(flip(plaintext(i,9:12))), 'uint32');
    x4 = typecast(uint8(flip(plaintext(i,13:16))), 'uint32');


x(1:4) = [x1 x2 x3 x4];

% store all intermediate results in x
z = uint32(zeros(1, 32));
x = horzcat(x, z);


% for 32 encryption rounds
for i=1:32
    % core operations
    t1 = bitxor(bitxor(bitxor(x(i+1), x(i+2)), x(i+3)), rk(i+4));
    t2 = L(tau(t1));
    x(i+4) = bitxor(x(i), t2);
end

% reverse transformation
y1 = x(36);
y2 = x(35);
y3 = x(34);
y4 = x(33);


y = [y1 y2 y3 y4];

% convert from 32-bit to 8-bit representation
ciphertext = typecast(uint32(y), 'uint8')

end
