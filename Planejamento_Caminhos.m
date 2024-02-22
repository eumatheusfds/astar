function Planejamento_Caminhos()

[MAP, MAX_X, MAX_Y] = tratamap();

xTarget=120; % em celula p/ meu mapa (bmp)
yTarget=90;

TRsx=0.8;
TRsy=0.2;

mapx = 9; % 9p p/ bmp
mapy = 7; % 7p p/ bmp


xStart = floor((TRsx)*(MAX_X + 1)/mapx); % em celula
yStart = floor((TRsy)*(MAX_Y + 1)/mapy);

caminho = astar(xStart, yStart, xTarget, yTarget, MAP, MAX_X, MAX_Y, mapx, mapy);

end