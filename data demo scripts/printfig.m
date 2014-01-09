inc = 1;
h = get(gcf,'CurrentAxes');
while ~isempty(h)
    print(gcf,'-dtiff',strcat('figure',int2str(inc)));
    close;
    h = get(gcf,'CurrentAxes');
    inc = inc+1;
end

