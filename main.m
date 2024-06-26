rgb=imread('lena.jpeg');

[H,S,I]=rgbtohsi(rgb);

% subplot(1, 3, 1), imshow(H), title('H Channel');
% subplot(1, 3, 2), imshow(S), title('S Channel');
% subplot(1, 3, 3), imshow(I), title('I Channel');


% subplot(1,5,1);
% imshow(myedge(I,'scharr',true));
% title('scharr');
% 
subplot(1,1,1);
imshow(myedge(I,'prewitt',false));
title('prewitt');
% 
% subplot(1,5,3);
% imshow(myedge(I,'sobel',true));
% title('sobel');
% 
% subplot(1,5,4);
% imshow(myedge(I,'kirsch',false));
% title('kirsch');
% 
% subplot(1,5,5);
% imshow(applyMarrHildreth(I,0.5,3,0));
% title('kirsch');
%applyLoGThreshold(I,25, 4,0);