# Question 1
import Pkg; Pkg.add("Distributions"); Pkg.add("QuantEcon")
using Distributions, QuantEcon

function profit_max_q(a, c, mu, sigma, method, n)
        b = rand(LogNormal(mu, sigma), n)
        if method == "mc"
            q = Float64((a-c)/(2*mean(b)))
            return q
        elseif method == "quad"
            nodes_weights = qnwlogn(n, mu, sigma) #http://quantecon.github.io/QuantEcon.jl/latest/api/QuantEcon.html
            nodes = nodes_weights[1]
            weights = nodes_weights[2]
            mean_b = sum(nodes .* weights)
            q = Float64((a-c)/(2*mean_b))
        end
        return q
    end

profit_max_q(3,1,1,1,"mc",10)

# we dont have to worry about code_warntype
@code_warntype profit_max_q(3,1,1,1,"mc",10)


# Question 2
using Distributions
function estimate_pi(lower,upper,num_draws)
    n_land_in_circle = 0
    x = rand(Uniform(lower, upper), num_draws)
    y = rand(Uniform(lower, upper), num_draws)
        for i in 1:num_draws
        r_sq = x[i]^2 + y[i]^2
            if r_sq < 1
                n_land_in_circle += 1
            end
        end
    return n_land_in_circle / num_draws * 4
 end

estimate_pi(0,1,1000000)
