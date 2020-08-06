# This file was generated, do not modify it. # hide
using ReinforcementLearning
using Random # hide
Random.seed!(123) # hide
hook = TotalRewardPerEpisode()
run(
    Agent(
        ;policy = RandomPolicy(env),
        trajectory = VectorialCompactSARTSATrajectory(
            state_type=Bool,
            action_type=Any,
            reward_type=Int,
            terminal_type=Bool,
        ),
    ),
    LotteryEnv(),
    StopAfterEpisode(1_000),
    hook
)

println(sum(hook.rewards) / 1_000)