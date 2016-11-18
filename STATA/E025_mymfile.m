% Edited in Nov 3rd, 2016
% Task "Nov 3, 2016"
% E025
%%
clear 
close all

%%%%%%%%%%%%%%%%   Import Data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd('D:\GN Luo\20161103_STATA_#161026');
cd E025

[num,txt,raw]=xlsread('E025_SUM.xlsx');
% Request the numeric data, text data, and combined data from the Excel 
% file in the first example.

%%%%%%%%%%%%%%%%   Clean Data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
Year = num(:,1);
Quater = num(:,2);

date = NaN(size(Year));
for i = 1:size(Year,1)
    date(i) = datenum(Year(i),3*Quater(i),1);
end

Percentage = num(:,7);
Professions = txt(2:end,3);
Age = txt(2:end,4);
Sex = txt(2:end,5);

%%%%%%%%%%%%%%%%   Plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

date2 = date(cellfun(@(x)isequal(x,'Aged 15 and over'),Age));
Percentage2 = Percentage(cellfun(@(x)isequal(x,'Aged 15 and over'),Age));
Sex2 = Sex(cellfun(@(x)isequal(x,'Aged 15 and over'),Age));
Professions2 = Professions(cellfun(@(x)isequal(x,'Aged 15 and over'),Age));


date2 = date2(cellfun(@(x)isequal(x,'Both sexes'),Sex2));
Percentage2 = Percentage2(cellfun(@(x)isequal(x,'Both sexes'),Sex2));
Professions2 = Professions2(cellfun(@(x)isequal(x,'Both sexes'),Sex2));

date2 = date2(cellfun(@(x)logical(1-isequal(x,'All occupations')),Professions2));
Percentage2 = Percentage2(cellfun(@(x)logical(1-isequal(x,'All occupations'))...
    ,Professions2));
Professions2 = Professions2(cellfun(@(x)logical(1-isequal(x,'All occupations'))...
    ,Professions2));

[G_pr,ID_pr]=findgroups(Professions2);
% G is the group number  
% ID is the txt content  


figure;
hold on

for j = 1:max(G_pr)
    plot(date2(G_pr==j),Percentage2(G_pr==j),'-o','LineWidth',2);
end
datetick('x',1,'keepticks');
%  MATLAB® date formats 'dd-mmm-yyyy'
grid on
xlabel('time');ylabel('Percentage(+%)');
title(['Both sexes / Aged 15 and over']);
set(gca,'xTickLabelRotation',45);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% format legend
val_len = cellfun(@(x) numel(x),ID_pr);
% length of each string in ID_it

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
len_leg=30;
% specify the max length of legend
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5%%%%%%%%%%

if max(val_len)<len_leg
    l=legend(ID_pr,'Location','eastoutside','FontSize',8);
else
    for k = 1:size(ID_pr,1)
        if val_len(k)>len_leg 
            temp = cell2mat(ID_pr(k));
            ID_pr(k)=mat2cell(temp(1:len_leg),1,len_leg);       
        end
    end
    l=legend(ID_pr,'Location','eastoutside','FontSize',8);
end
title(l,'Professions');

hold off

strgcf=strcat('20161103_E025_M_Percent_');
saveas(gcf,strgcf,'eps');
saveas(gcf,strgcf,'tif');
savefig(gcf,strgcf);
    
