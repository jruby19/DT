%%% script to run QCmulti

%% load justin catalog

% a=load('../allfinaljun20');
a=load('../allcatjun24');

clear jcat
[y,m,d,h,mnt,sec,lat,lon,dep,mag,evid]=deal(a(:,1),a(:,2),a(:,3),a(:,4),a(:,5),a(:,6),a(:,7),a(:,8),a(:,9),a(:,10),a(:,15));
g=find(lat>36.95 & lat<37.35 & lon<-97.45 & lon>-98.1);
[y,m,d,h,mnt,sec,lat,lon,dep,mag,evid]=deal(a(g,1),a(g,2),a(g,3),a(g,4),a(g,5),a(g,6),a(g,7),a(g,8),a(g,9),a(g,10),a(g,15));
jday=datenum(y,m,d,h,mnt,sec);

for i=1:length(evid)
    jcat.id{i}=num2str(evid(i));
    jcat.evtype{i}='earthquake';
end
jcat.data=[jday lat lon dep mag];
jcat.id=jcat.id';
jcat.evtype=jcat.evtype';
jcat.name='Justin''s Catalog';
jcat.file='AllFinalJun20';
jcat.format=1;

%% load Comcat
clear ccat
[y,m,d,h,mnt,sec,lat,lon,dep,mag,mt]=LoadComCat(datenum(1973,1,1),datenum(2016,10,1),0,[37 40 -102 -94.5]);
a=[y' m' d' h' mnt' sec' lat' lon' dep' mag'];
g=find(lat>36.95 & lat<37.35 & lon<-97.45 & lon>-98.1);
[y,m,d,h,mnt,sec,lat,lon,dep,mag]=deal(a(g,1),a(g,2),a(g,3),a(g,4),a(g,5),a(g,6),a(g,7),a(g,8),a(g,9),a(g,10));
cday=datenum(y,m,d,h,mnt,sec);

for i=1:length(mag)
    ccat.id{i}=num2str(i);
    ccat.evtype{i}='earthquake';
end

ccat.data=[cday lat lon dep mag];
ccat.id=ccat.id';
ccat.evtype=ccat.evtype';
ccat.name='ComCat';
ccat.file='WebDownload';
ccat.format=1;

AT='no';
cat1=jcat;
cat2=ccat;
reg='ALL'; %all areas
maglim=0;
timewindow=16;
distwindow=20;
magdelmax=1.3;
depdelmax=8;

%make comparisons
addpath ~/Desktop/CatStat-master/QCmulti/
QCmulti