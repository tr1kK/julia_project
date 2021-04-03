using HorizonSideRobots
sides = (Nord, Sud, Ost, West)

function main(r::Robot)
    for side in sides
        putmark(r, side)
        move_by_marks(r, inverse(side))
    end
    putmarker!(r)
end

function putmark(r::Robot, side::HorizonSide)
    while isborder(r, side) == false
        move!(r, side)
        putmarker!(r)
    end
end


function move_by_marks(r::Robot, side::HorizonSide)
    while ismarker(r) == true
        move!(r, side)
    end
end

inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2, 4)) 

# include("1_1.jl")
# r = Robot(animate=true)
# main(r)
