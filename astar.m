function [caminho]=astar(xStart,yStart,xTarget,yTarget,MAP,MAX_X,MAX_Y,mapx,mapy)

% Vamos mapear esses pontos inicial e final
MAP(xTarget,yTarget)=0;
MAP(xStart,yStart)=1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ALGORITMO A*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Estrutura da Lista Aberta

% LIST 1/0 |X val |Y val |Parent X val | Parent Y val |h(n)
% |g(n) | f(n) |

OPEN=[];

% Estrutura da Lista Fechada
% X val| Yval |
% CLOSED=zeros(MAX_VAL,2);

CLOSED=[];
% Coloca todos os obstaculos na Lista Fechada
k=1; % Dummy counter
for i=1:MAX_X
   for j=1:MAX_Y
        if(MAP(i,j) == -1)
            CLOSED(k,1)=i; 
            CLOSED(k,2)=j; 
            k=k+1;
        end
    end
end
CLOSED_COUNT=size(CLOSED,1);
xNode=xStart;
yNode=yStart;
OPEN_COUNT=1;
path_cost=0; %hn
goal_distance=sqrt((xNode-xTarget)^2+(yNode-yTarget)^2);
OPEN(OPEN_COUNT,:)=insert_open(xNode,yNode,xNode,yNode,path_cost,goal_distance,goal_distance);
OPEN(OPEN_COUNT,1)=0;
CLOSED_COUNT=CLOSED_COUNT+1;
CLOSED(CLOSED_COUNT,1)=xNode;
CLOSED(CLOSED_COUNT,2)=yNode;
NoPath=1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  START ALGORITHM

while ((xNode ~= xTarget || yNode ~= yTarget) && NoPath == 1)
exp_array=expand_array(xNode,yNode,path_cost,xTarget,yTarget,CLOSED,MAX_X,MAX_Y);
exp_count=size(exp_array,1);

for i=1:exp_count
    flag=0;
    for j=1:OPEN_COUNT
        if(exp_array(i,1) == OPEN(j,2) && exp_array(i,2) == OPEN(j,3) )
            OPEN(j,8)=min(OPEN(j,8),exp_array(i,5)); %#ok<*SAGROW>
            if OPEN(j,8)== exp_array(i,5)
                %UPDATE PARENTS,gn,hn
                OPEN(j,4)=xNode;
                OPEN(j,5)=yNode;
                OPEN(j,6)=exp_array(i,3);
                OPEN(j,7)=exp_array(i,4);
            end %End of minimum fn check
            flag=1;
        end %End of node check
%         if flag == 1
%             break;
    end %End of j for
    if flag == 0
        OPEN_COUNT = OPEN_COUNT+1;
        OPEN(OPEN_COUNT,:)=insert_open(exp_array(i,1),exp_array(i,2),xNode,yNode,exp_array(i,3),exp_array(i,4),exp_array(i,5));
    end %End of insert new element into the OPEN list
end %End of i for

    
 index_min_node = min_fn(OPEN,OPEN_COUNT,xTarget,yTarget);
  if (index_min_node ~= -1)    
   %Set xNode and yNode to the node with minimum fn
   xNode=OPEN(index_min_node,2);
   yNode=OPEN(index_min_node,3);
   path_cost=OPEN(index_min_node,6); %Update the cost of reaching the parent node
  %Move the Node to list CLOSED
  CLOSED_COUNT=CLOSED_COUNT+1;
  CLOSED(CLOSED_COUNT,1)=xNode;
  CLOSED(CLOSED_COUNT,2)=yNode;
  OPEN(index_min_node,1)=0;
  else
      %No path exists to the Target!!
      NoPath=0; %Exits the loop!
  end %End of index_min_node check
end %End of While Loop

i=size(CLOSED,1);
Optimal_path=[];
xval=CLOSED(i,1);
yval=CLOSED(i,2);
i=1;
Optimal_path(i,1)=xval;
Optimal_path(i,2)=yval;
i=i+1;

if ( (xval == xTarget) && (yval == yTarget))
    inode=0;
   %Traverse OPEN and determine the parent nodes
   parent_x=OPEN(node_index(OPEN,xval,yval),4);%node_index returns the index of the node
   parent_y=OPEN(node_index(OPEN,xval,yval),5);
   
   while( parent_x ~= xStart || parent_y ~= yStart)
           Optimal_path(i,1) = parent_x;
           Optimal_path(i,2) = parent_y;
           %Get the grandparents:-)
           inode=node_index(OPEN,parent_x,parent_y);
           parent_x=OPEN(inode,4);%node_index returns the index of the node
           parent_y=OPEN(inode,5);
           i=i+1;
   end

else
 pause(1);
 h=msgbox('Sorry, No path exists to the Target!','warn');
 uiwait(h,5);
end

caminho=[Optimal_path(:,1),Optimal_path(:,2)];
[cx,cy]=size(caminho);
cix=(xStart*mapx)/(MAX_X+1);
ciy=(yStart*mapy)/(MAX_Y+1);
plot(cix,ciy,'bo');
ctx=(xTarget*mapx)/(MAX_X+1);
cty=(yTarget*mapy)/(MAX_Y+1);
plot(ctx,cty,'gd');
text(ctx,cty,'Target')
j=1;
for i=cx:-1:1
       op(j,1)=(caminho(i,1)*mapx)/(MAX_X+1);
       op(j,2)=(caminho(i,2)*mapy)/(MAX_Y+1);
       plot(op(j,1),op(j,2),'.b','LineWidth',10);
       hold on
       j=j+1;
end
caminho=op;
end