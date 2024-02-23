function [MAP, MAX_X, MAX_Y] = tratamap()

%%LoadMAP
%resolucao
%100p/pnge50p/bmp
resFig=50; %resoluçãoquetransformapixelemmetros
resAstar=15; %resoluçãoquedefineotamanhodacéluladoA*
%MapanormalparaOcupancyGrid
image=imread('mapaexemplo.bmp');
grayimage = rgb2gray(image);
bwimage = grayimage<0.5;
gridmap = binaryOccupancyMap(bwimage, resFig); % mapa em metros
savefile='mymap.mat';
save(savefile,'gridmap');
show(gridmap);
hold on

% Infla o OccupancyGrid map
robotRadius = 0.1;
mapInflated = copy(gridmap);
inflate(mapInflated,robotRadius);
show(mapInflated);
%figure

matrix = occupancyMatrix(mapInflated); %% o mapa aqui volta a ser representado em pixels
matrix = flip(matrix);
[my,mx]=size(matrix); % verifica o tamanho da matriz resultante da figura lida

% Define o tamanho do mapa em divisao por celula
MAX_X = floor(mx/resFig)*resAstar;
MAX_Y = floor(my/resFig)*resAstar;

%Cria a grade de celulas
MAP = 2*(ones(MAX_X,MAX_Y)); %Space=2


% Obtem as posições dos obstaculos, alvo e robô respectivamente
% obs.: obstacle=-1, Target=0, Robot=1, Space=2
j=1;
for x=1:1:mx % coloquei um passo de 5 para não demorar muito mas sem perda de detalhes
for y=1:1:my
    if matrix(y,x)==1
        xval=floor((x*(MAX_X+1)/mx)+1);
        yval=floor((y*(MAX_Y+1)/my)+1);
        MAP(floor(xval),floor(yval))=-1;
        j=j+1;
    end
end
end
end







