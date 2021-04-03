using HorizonSideRobots

function turn_side(side)
    if side == Nord
        return West
    end
    if side == Sud
        return West
    end
    if side == Ost
        return Sud
    end
    if side == West
        return Sud
    end
end


function invert_side(side)
    if side == Nord
        return Sud
    end
    if side == Sud
        return Nord
    end
    if side == Ost
        return West
    end
    if side == West
        return Ost
    end
end


function gotobegin(r)
    a = 0
    b = 0
    while(!((isborder(r, West)) & (isborder(r, Sud))))
        a = a + gotoborder(r, West)
        b = b + gotoborder(r, Sud)
    end
    return(a, b)
end


function gotoborder(r, side)
    count = 0
    while(!isborder(r, side))
        move!(r, side)
        count = count + 1
    end
    return count
end
function measure_field(r)
    y = gotoborder(r, Nord)
    gotoborder(r, Sud)
    x = gotoborder(r, Ost)
    gotoborder(r, West)
    return (x,y)
end


function goto_coord(r, side, coord)
    while(coord > 0)
        coord = coord - 1
        move!(r, side)
    end
end


function main(r, n)
    gotobegin(r)
    x_dim,y_dim = measure_field(r)
    x_dim = x_dim
    x = 0
    y = 0
    while(x<x_dim)
        y = 0
        while(y<y_dim)
            if (((y%2n) >= 0) & ((y%2n) <= n-1)) & (((x%2n) >= 0) & ((x%2n) <= n-1))
                putmarker!(r)
            end
            move!(r, Nord)
            y = y + 1
        end
        if (((y%2n) >= 0) & ((y%2n) <= n-1)) & (((x%2n) >= 0) & ((x%2n) <= n-1))
            putmarker!(r)
        end
        gotoborder(r, Sud)
        x = x + 1
        if(x!=x_dim)
            move!(r, Ost)
        end
    end
    gotobegin(r)
    i=0
    while(i<n)
        i = i + 1
        move!(r, Nord)
        move!(r, Ost)
    end
    x=0
    while(x<x_dim-n+1)
        y = 0
        while(y<y_dim-n)
            if (((y%2n) >= 0) & ((y%2n) <= n-1)) & (((x%2n) >= 0) & ((x%2n) <= n-1))
                putmarker!(r)
            end
            move!(r, Nord)
            y = y + 1
        end
        if (((y%2n) >= 0) & ((y%2n) <= n-1)) & (((x%2n) >= 0) & ((x%2n) <= n-1))
            putmarker!(r)
        end
        gotoborder(r, Sud)
        i=0
        while(i<n)
            i = i + 1
            move!(r, Nord)
        end
        x = x + 1
        if(x!=x_dim-n+1)
            move!(r, Ost)
        end
    end
end

# include("3_3.jl")
# r = Robot(animate=true)
# main(r)
