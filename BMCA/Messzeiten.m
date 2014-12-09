function[Messbeginn Messende] = Messzeiten (event)

    x = find(event>0);
    Messbeginn = min(x);
    
    x = find(event(Messbeginn:end)<0);
    Messende =  min(x)+Messbeginn;
    
end