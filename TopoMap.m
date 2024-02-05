
%% 设置待存放变量的结构体
clear all; clc;
field1='Data';              
field2='LoadName';
field3='Name';
One_Subject = struct(field1,'',field2,'',field3,'');   % 
All_Subject = struct(field1,'',field2,'',field3,'');   % 

%% 读取数据，并保存到结构体中
    % 
    % % % % % % % % % % % % % % % % % % % % %
    % % % % % % % % % % % % % % % % % % % % %
    Name_All=dir('E:\Matlab\外肢体、本体MI差异性实验\数据处理程序\数据\Data\');
    Name_All(1:2)=[];
    for Num=1:length(Name_All)
        Name=Name_All(Num).name;
        LoadName='Hz1720_Topomap_SRF_Good_BaseCor1.mat';  % 
        
        
        load(strcat(...
            'E:\Matlab\外肢体、本体MI差异性实验\数据处理程序\数据\Data\',Name,'\','TFA_Data\','AEEG.mat'));
        load(strcat(...
            'E:\Matlab\外肢体、本体MI差异性实验\数据处理程序\数据\Data\',Name,'\','TFA_Data\','f.mat'));
%         load(strcat(...
%             'E:\Matlab\外肢体、本体MI差异性实验\数据处理程序\数据\Data\',Name,'\','TFA_Data\','t.mat'));
        % % % % % % % % % % % % % % % % % % % % %
        % % % % % % % % % % % % % % % % % % % % %
        
        path=strcat('E:\Matlab\外肢体、本体MI差异性实验\数据处理程序\数据\Data\',Name,'\');  %数据存放路径
        [files,class_num] = GetFiles_path_mat(path); %读取路径文件夹里的所有.mat文件名字
        
        DataNum=1;
        for i=1:class_num(1)
            

            if strcmp(LoadName,files(i).name)==1
                
                Loadfile=strcat(path,files(i).name);% 读取数据
                One_Subject(DataNum).Data=importdata(Loadfile); % 
                One_Subject(DataNum).LoadName=files(i).name;
                One_Subject(DataNum).Name=Name;
                DataNum=DataNum+1;
            end
            
            
        end
        
        All_Subject = [All_Subject,One_Subject];      % 这是将两个结构体拼接
        One_Subject = struct(field1,'',field2,'',field3,''); % One_Subject清空结构体，储存下一个人的
    end
%% 数据读取完毕后，进行合并分析
All_Subject(1)=[]; % 这是因为，B的第一行是空白行，因此给他删去
Data=[];           % 定义一个空白矩阵，存放所有被试的数据    
    SubNum=1;
    for i=1:size(All_Subject,2)
        

            Data(SubNum,:,:) = All_Subject(i).Data;                                    
            SubNum=SubNum+1;
        %end 
        
    end
    % % % % % % % % % % % % % % % % % % % % 
  Data_1=Data;  
  Data=mean(Data,1); %对所有试次进行平均
  Data=reshape(Data,size(Data,2),size(Data,3));
  
  
%% 画脑电拓扑图 %%figure(2)

figure(1);clf
topoplot(Data,AEEG.chanlocs,'numcontour',4,'electrodes','on');
colorbar;

%% 读取数据，并保存到结构体中
All_Subject=[];
for Num=1:length(Name_All)
        Name=Name_All(Num).name;
        LoadName='Hz1720_Topomap_RF_Good_BaseCor1.mat';  % 
        %Name='zhanghaichao';
        % 导入以下三个变量是因为画图时需要该变量，而本程序没有计算到该变量
        load(strcat(...
            'E:\Matlab\外肢体、本体MI差异性实验\数据处理程序\数据\Data\',Name,'\','TFA_Data\','AEEG.mat'));
        load(strcat(...
            'E:\Matlab\外肢体、本体MI差异性实验\数据处理程序\数据\Data\',Name,'\','TFA_Data\','f.mat'));
%         load(strcat(...
%             'E:\Matlab\外肢体、本体MI差异性实验\数据处理程序\数据\Data\',Name,'\','TFA_Data\','t.mat'));
        % % % % % % % % % % % % % % % % % % % % %
        % % % % % % % % % % % % % % % % % % % % %
        
        path=strcat('E:\Matlab\外肢体、本体MI差异性实验\数据处理程序\数据\Data\',Name,'\');  %数据存放路径
        [files,class_num] = GetFiles_path_mat(path); %读取路径文件夹里的所有.mat文件名字
        
        DataNum=1;
        for i=1:class_num(1)
            
    
            if strcmp(LoadName,files(i).name)==1
                
                Loadfile=strcat(path,files(i).name);% 读取数据
                One_Subject(DataNum).Data=importdata(Loadfile); % 将变量Name、files(i).name、以及数据Data储存到结构体中
                One_Subject(DataNum).LoadName=files(i).name;
                One_Subject(DataNum).Name=Name;
                DataNum=DataNum+1;
            end
            
            
        end
        
        All_Subject = [All_Subject,One_Subject];      % 这是将两个结构体拼接
        One_Subject = struct(field1,'',field2,'',field3,''); % One_Subject清空结构体，储存下一个人的
    end
%% 数据读取完毕后，进行合并分析
%All_Subject(1)=[]; % 这是因为，B的第一行是空白行，因此给他删去
Data=[];           % 定义一个空白矩阵，存放所有被试的数据
  
    SubNum=1;
    for i=1:size(All_Subject,2)
        

            Data(SubNum,:,:) = All_Subject(i).Data;                                    
            SubNum=SubNum+1;
        %end 
        
    end
    % % % % % % % % % % % % % % % % % % % % 
  Data_2=Data;  
  Data=mean(Data,1); %对所有试次进行平均
  Data=reshape(Data,size(Data,2),size(Data,3));
  
  
%% 画脑电拓扑图 %%figure(2)

figure(2);clf
topoplot(Data,AEEG.chanlocs,'numcontour',4,'electrodes','on');%,'maplimits',[-0.035 0.035]
colorbar;

 

P_Value=[];
for Chan_Num=1:AEEG.nbchan
    [~,P_Value(Chan_Num),~]=ttest(Data_1(:,Chan_Num)',Data_2(:,Chan_Num)');
%     if P_Value(Chan_Num)<0.05
%         P_Value(Chan_Num)=0;
%     else
%         P_Value(Chan_Num)=1;
%     end
end


figure(3);clf
load mycolor
topoplot(log(P_Value),AEEG.chanlocs,'numcontour',0,'electrodes','on','maplimits',[-5 0]);%,'maplimits',[-0.035 0.035]
colormap(mycolor);  % 使用内置的jet颜色 GRAY, HOT, COOL, BONE, COPPER, PINK, FLAG, PRISM, JET,
caxis([-5 0]); % 设置颜色编辑器的最大最小值为 1 和 -1
colorbar;

