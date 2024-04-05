clc;
close all;

md= 10;
dp=0.0001;

for i=1:100000
    DPA(i)= dp + dp*randn();        
    DPB(i)= dp*randn(); 
    val(i)= md + DPB(i);
end

subplot(2,1,1);
plot(DPA,'or');
hold on
plot(DPB,'.b');

subplot(2,1,2);
plot(val,'.b');
a=0;


subplot(2,1,1);
plot(f_L_1_aux,'or');
hold on
plot(f_L_2_aux,'.b');

subplot(2,1,2);
plot(f_R_1_aux,'or');
hold on
plot(f_R_2_aux,'.b');