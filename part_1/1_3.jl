using HorizonSideRobots

function main(r::Robot)
    count_i = move_to_border(r, Nord)
    count_j = move_to_border(r, Ost)
    mark_all(r)
    move_to_border(r, Nord)
    move_to_border(r, Ost)
    for i = 1:count_i
        move!(r, Sud)
    end
    for i = 1:count_j
        move!(r, West)
    end
end

function move_to_border(r::Robot, side::HorizonSide)
    count = 0
    while isborder(r, side) == false
        move!(r, side)
        count += 1
    end
    return(count)
end


function mark_all(r::Robot)
    side = West
    while ((isborder(r, Sud) == false) || (isborder(r, West) == false))
        while isborder(r, side) == false
            putmarker!(r)
            move!(r, side)
        end
        putmarker!(r)
        if isborder(r, Sud) == false
            move!(r, Sud)
        end
        if side == West
            side = Ost
        else
            side = West
        end
    end
end

# include("1_3.jl")
# r = Robot(animate=true)
# main(r)
