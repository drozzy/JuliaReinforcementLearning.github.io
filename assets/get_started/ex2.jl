# This file was generated, do not modify it. # hide
using ReinforcementLearning # hide
using Plots

experiment = E`JuliaRL_BasicDQN_CartPole`
experiment.agent.policy.learner.γ = 0.98
hook = TotalRewardPerEpisode()

run(experiment.agent, experiment.env, experiment.stop_condition, hook)
plot(hook.rewards)
savefig(joinpath(@OUTPUT, "reward_gamma.svg"))  # hide