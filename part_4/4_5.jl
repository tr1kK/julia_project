using HorizonSideRobots

function main(r::Robot)
    path = goToTheCornerRec(r, Sud, West)
    putmarker!(r)
    goToTheCornerRec(r, Nord, West)
    putmarker!(r)
    goToTheCornerRec(r, Nord, Ost)
    putmarker!(r)
    goToTheCornerRec(r, Sud, Ost)
    putmarker!(r)

    goToTheCornerRec(r, Sud, West)

    for item in path[end:-1:1]
        followByCountRec(r, item[1], item[2])
    end
end

next(side::HorizonSide) = HorizonSide(mod(Int(side)+1,4))

function inverseSide(side::HorizonSide)
    # Return inverse side
    return HorizonSide(mod(Int(side)+2, 4))
end

function moveIfPossible(r::Robot, direct_side::HorizonSide, needSteps=false)
    orthogonal_side = next(direct_side)
    reverse_side = inverseSide(orthogonal_side)
    num_steps=0

    movedSteps = 0
    while isborder(r,direct_side) == true
        if isborder(r, orthogonal_side) == false
            move!(r, orthogonal_side)
            num_steps += 1
        else
            break
        end
    end

    if isborder(r,direct_side) == false
        move!(r,direct_side)
        movedSteps += 1
        while isborder(r,reverse_side) == true
            move!(r,direct_side)
            movedSteps += 1
        end
        result = true
    else
        result = false
    end
    for _ in 1:num_steps
        move!(r,reverse_side)
    end
    if !needSteps
        return result
    else
        return [result, movedSteps]
    end
end


function goToTheSide(r::Robot,side::HorizonSide)
    side_steps = 0
    while !isborder(r, side)
        move!(r, side)
        side_steps += 1
    end
    while true
        steps, ok = moveIfPossible(r,side, true)
        side_steps += steps
        ok == true || break
    end
    print("Готово\n")

    return side_steps
end


function goToTheCornerRec(r::Robot, side1::HorizonSide, side2::HorizonSide)
    x = goToTheSide(r, side1)
    y = goToTheSide(r, side2)

    pathBack = [[side1, x], [side2, y]]
    return pathBack
end


function followByCountRec(r::Robot, side::HorizonSide, count::Int)
    for i = 1:count
        if !isborder(r, side)
            move!(r, side)
        else
            moveIfPossible(r, side)
        end
    end
end

# include("4_5.jl")
# r=Robot(animate=true)
# main(r)
