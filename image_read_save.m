function image_read_save

panelColor=get(0,'DefaultUicontrolBackgroundColor');

%����HandleVisibility����ָ�����Ƕ���ľ�����Ա���ô����
    function readFileFcn(src,evt)
        [fname,dirpath]=uigetfile({'*.jpeg';'*.bmp';'*.png'});
        file=[dirpath fname];
        set(readImage,'String',file);
    end
    function showImageFcn(src,evt)
        file=get(readImage,'String');
        if(length(file)~=0)
            figure;
            imshow(file);
        end
    end

    function saveToFileFcn(src,evt)
         [fname,dirpath]=uigetfile({'*.txt'});
         file=[dirpath fname];
         fid=fopen(file,'wt');
         file=get(readImage,'String');
         data=imread(file);
         n=ndims(data);
         switch n
             case 2
                 [i,j]=size(data);
                 if(i>=100 & j>=100)
                     data1=data(1:100,1:100);
                 else
                     data1=data;
                 end
             case 3
                 [i,j,k]=size(data);
                 if(i>=100 & j>=100)
                     data1=data(1:100,1:100,1);
                 else
                     data1=data(:,:,1);
                 end
         end
         fprintf(fid,'%d',data1);
         fclose(fid);
    end
f=figure('Units','characters',...
    'Position',[30 30 120 36],...
    'Color',panelColor,...
    'HandleVisibility','callback',...
    'Renderer','painters',...
    'Name','read&save image',...
    'Toolbar','figure');

readImage=uicontrol(f,'Style','edit','Units','characters',...
    'Position',[0.1 18 70 3],...
    'BackgroundColor','white',...
    'String','���������ѡ��Ҫ��ʾ��ͼƬ');
readFile=uicontrol(f,'Style','pushbutton','Units','characters',...
    'Position',[71,18,10,3],...
    'BackgroundColor','white',...
    'String','ѡ��ͼƬ',...
    'Callback',@readFileFcn);
showImage=uicontrol(f,'Style','pushbutton','Units','characters',...
    'Position',[82,18,10,3],...
    'BackgroundColor','white',...
    'String','��ʾͼƬ',...
    'Callback',@showImageFcn);
saveToFile=uicontrol(f,'Style','pushbutton','Units','characters',...
    'Position',[93,18,10,3],...
    'BackgroundColor','white',...
    'String','�������ı�',...
    'Callback',@saveToFileFcn);





end