# This file was generated, do not modify it. # hide
using ReinforcementLearning
using Random
using Flux
rng = MersenneTwister(123)
env = CartPoleEnv(;T = Float32, rng = rng)
ns, na = length(get_state(env)), length(get_actions(env))
agent = Agent(
    policy = QBasedPolicy(
        learner = BasicDQNLearner(
            approximator = NeuralNetworkApproximator(
                model = Chain(
                    Dense(ns, 128, relu; initW = glorot_uniform(rng)),
                    Dense(128, 128, relu; initW = glorot_uniform(rng)),
                    Dense(128, na; initW = glorot_uniform(rng)),
                ) |> cpu,
                optimizer = ADAM(),
            ),
            batch_size = 32,
            min_replay_history = 100,
            loss_func = huber_loss,
            rng = rng,
        ),
        explorer = EpsilonGreedyExplorer(
            kind = :exp,
            ϵ_stable = 0.01,
            decay_steps = 500,
            rng = rng,
        ),
    ),
    trajectory = CircularCompactSARTSATrajectory(
        capacity = 1000,
        state_type = Float32,
        state_size = (ns,),
    ),
)
println(agent) # hide