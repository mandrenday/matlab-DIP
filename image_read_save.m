function image_read_save

panelColor=get(0,'DefaultUicontrolBackgroundColor');

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
%对于打开文件使用fopen，但是fopen一般都是默认以二进制的模式打开的，所以如果需要以文本模式打开，则需要加上t，如下面的wt
%然后将数组或是其他的保存到文件中则使用fprintf。文件用完后需要使用fclose进行关闭
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
%其中HandleVisibility属性指定的是对象的句柄可以被怎么调用
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
    'String','请输入或是选择要显示的图片');
readFile=uicontrol(f,'Style','pushbutton','Units','characters',...
    'Position',[71,18,10,3],...
    'BackgroundColor','white',...
    'String','选择图片',...
    'Callback',@readFileFcn);
showImage=uicontrol(f,'Style','pushbutton','Units','characters',...
    'Position',[82,18,10,3],...
    'BackgroundColor','white',...
    'String','显示图片',...
    'Callback',@showImageFcn);
saveToFile=uicontrol(f,'Style','pushbutton','Units','characters',...
    'Position',[93,18,10,3],...
    'BackgroundColor','white',...
    'String','保存至文本',...
    'Callback',@saveToFileFcn);





end