video = xmlread('test.xml');
parameter = video.getElementsByTagName('parameter').item(0);
keyframes = parameter.getElementsByTagName('keyframe');
res =containers.Map
for i = 0:keyframes.getLength - 1
      keyframe = keyframes.item(i);
      when = char(keyframe.getElementsByTagName('when').item(0).getTextContent());
      value = char(keyframe.getElementsByTagName('value').item(0).getTextContent());
      res(when) = value;
end
%res就是你要的数据，是一个map表  res.keys获取时间数组 res.values获取缩放比例数组，看下面的Command Window。
%你果想知道5265这个时间点的缩放比例，就scale = res('5265')就行了
scale=res('5265')