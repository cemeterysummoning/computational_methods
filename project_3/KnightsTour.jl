moves = [(1, 2), (1, -2), (-1, -2), (-1, 2), (2, 1), (2, -1), (-2, -1), (-2, 1)]
function printBoard(board, n)
    for i in 1:n
        for j in 1:n
            num = board[i, j]
            print(num)
            if num / 10 >= 10
                print("  ")
            elseif num / 10  >= 1
                print("   ")
            else
                print("    ")
            end
        end
        println()
    end
end

function checkMove(board, i, j, n)
    if i < 1 || j < 1
        return false 
    elseif i > n || j > n
        return false
    elseif (board[i, j] == 0)
        return true
    else
        return false 
    end
end

function isFull(board, n)
    for i in 1:n
        for j in 1:n
            if (board[i, j] == 0)
                return false
            end
        end
    end
    return true
end

function countMoves(board, i, j, n)
    count = 0
    for k in 1:8
        temp_location = (i + moves[k][1], j + moves[k][2])
        if temp_location[1] < 1 || temp_location[2] < 1
            continue
        elseif checkMove(board, temp_location[1], temp_location[2], n)
            count += 1
        end
    end 
    return count
end

function listMoves(board, i, j, n)
    moves_list = Vector()
    for k in 1:8
        temp_location = (i + moves[k][1], j + moves[k][2])
        if temp_location[1] < 1 || temp_location[2] < 1
            continue
        else
            append!(moves_list, [temp_location])
        end
    end
    sort!(moves_list, by = x -> countMoves(board, x[1], x[2], n))
    return moves_list
end

function tour(board, i, j, count, n)
    if isFull(board, n)
        return true
    end

    moves_list = listMoves(board, i, j, n)

    for k in 1:length(moves_list)
        new_i = moves_list[k][1]
        new_j = moves_list[k][2]

        if checkMove(board, new_i, new_j, n)
            board[new_i, new_j] = count + 1

            if tour(board, new_i, new_j, count + 1, n)
                return true
            else
                board[new_i, new_j] = 0
                return false
            end
        end
                
    end
    return false
end

board = zeros(Int, 20, 20)
tour(board, 1, 1, 0, 20)
printBoard(board, 20)