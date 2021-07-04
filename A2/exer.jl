using Dates
#exer2
#primes and divisors
function divisors(n::Int64)
    return filter(x->n%x==0, collect(2:(div(n,2))))
end
#primes
function primes(n::Int64)
    return filter(n->divisors(n)==[],collect(2:n))
end

#pythagorean Triples
function pythagorean(n)
    result=[(1,1,1)]
    for x=1:n, y=1:n,z=1:n
        if x^2 +y^2 == z^2 && x<y
            push!(result,(x,y,z))
        end
    end
    popfirst!(result)
    return result
end

#join
function join(s, as)
    if length(as)==0
        return
    end
    result = as[1]
    for i = 2:length(as)
        result= result*s*as[i]
    end
    return result
end


#exer3
#merge
function merge(a1, a2)
    result= [0]
    i=1
    j=1
    while i<=length(a1) && j<=length(a2)
        if a1[i] <= a2[j]
            push!(result, a1[i])
            i+=1
        else
            push!(result, a2[j])
            j+=1
        end
    end
    while i<=length(a1)
        push!(result, a1[i])
        i+=1
    end
    while j<=length(a2)
        push!(result, a2[j])
        j+=1
    end
    popfirst!(result)
    return result
end
#merge sort
function mergeSort(arr)
    if length(arr)<=1
        return arr
    end
    a1 = arr[1:div(length(arr),2)]
    a2 = arr[div(length(arr),2)+1: length(arr)]
    r1 = mergeSort(a1)
    r2 = mergeSort(a2)
    result= merge(r1,r2)
    return result
end

#Dates
function isFriday(d::Date)
    if Dates.dayname(d) == "Friday"
        return true
    else
        return false
    end
end

function isPrimeDay(d:: Date)
    if divisors(Dates.day(d))==[]
        return true
    else
        return false
    end
end



println(isPrimeDay(Date("2021-07-24")))