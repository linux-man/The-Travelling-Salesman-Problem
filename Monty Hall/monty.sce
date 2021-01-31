player_keep_win_list = list()
player_switch_win_list = list()

player_keep_win = 0
player_switch_win = 0

doors = 3

clf
title("Mounty Hall Problem: " + string(doors) + " doors")
xlabel("Games")
ylabel("% Win")

for n = 1:1000
    car = int(rand() * doors) + 1
    door = int(rand() * doors) + 1
    openned_door = int(rand() * doors) + 1
    while openned_door == car | openned_door == door do
        openned_door = int(rand() * doors) + 1
    end

    if door == car then
        player_keep_win = player_keep_win + 1
    end
    player_keep_win_list($ + 1) = player_keep_win

    new_door = int(rand() * doors) + 1
    while new_door == door | new_door == openned_door do
        new_door = int(rand() * doors) + 1
    end
    if new_door == car then
        player_switch_win = player_switch_win + 1
    end
    player_switch_win_list($ + 1) = player_switch_win

    x = 1:length(player_switch_win_list)

    plot(list2vec(player_switch_win_list)'./x, "r")
    plot(list2vec(player_keep_win_list)'./x, "g")
    hl=legend(['Switch door';'Keep door']);
end
