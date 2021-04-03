using HorizonSideRobots

function main(r::Robot)
    a = move_to_border(r, Sud)
    b = move_to_border(r, Ost)
    count = move_to_border(r, West)
    for i = count:-1:0
        putmarker!(r)
        move_and_mark(r, Ost, i)
        move(r, West, i)
        if (isborder(r, West) == true) && (isborder(r, Nord) == true)
            break
        end
        move!(r, Nord)
    end
    move_to_border(r, Sud)
    move_to_border(r, Ost)
    move(r, Nord, a)
    move(r, West, b)
end

function move_to_border(r::Robot, side::HorizonSide)
    count = 0
    while isborder(r, side) == false
        move!(r, side)
        count += 1
    end
    return(count)
end


function move_and_mark(r::Robot, side, leng)
    for i = 1:leng
        move!(r, side)
        putmarker!(r)
    end
end

function move(r::Robot, side, leng)
    for i = 1:leng
        move!(r, side)
    end
end

# include("1_4.jl")
# r = Robot(animate=true)
# main(r)
