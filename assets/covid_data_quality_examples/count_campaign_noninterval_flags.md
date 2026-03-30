# count_campaign_noninterval_flags

|campaign       |flag_type                    | n_records| n_patients| denom_records_total| denom_patients_total| pct_records_total| pct_patients_total|
|:--------------|:----------------------------|---------:|----------:|-------------------:|--------------------:|-----------------:|------------------:|
|Pre-2020-07-01 |flag_implausible_early_date  |        65|         65|                3515|                  995|               1.8|                6.5|
|Pre-2020-07-01 |flag_product_before_approval |        65|         65|                3515|                  995|               1.8|                6.5|
|Pre-roll-out   |flag_pre_rollout_date        |        75|         75|                3515|                  995|               2.1|                7.5|
|Pre-roll-out   |flag_product_before_approval |        75|         75|                3515|                  995|               2.1|                7.5|
|Primary series |flag_pre_rollout_date        |         5|          5|                3515|                  995|               0.1|                0.5|
|Primary series |flag_product_before_approval |       375|        285|                3515|                  995|              10.7|               28.6|
|Primary series |flag_same_day_mixed_product  |        15|          5|                3515|                  995|               0.4|                0.5|
|Primary series |flag_same_day_multiple       |        35|         15|                3515|                  995|               1.0|                1.5|
|Primary series |flag_same_day_same_product   |        25|         15|                3515|                  995|               0.7|                1.5|
|Primary series |flag_unapproved_product      |        15|         15|                3515|                  995|               0.4|                1.5|
|Autumn 2021    |flag_product_before_approval |       235|        195|                3515|                  995|               6.7|               19.6|
|Autumn 2021    |flag_same_day_mixed_product  |        15|          5|                3515|                  995|               0.4|                0.5|
|Autumn 2021    |flag_same_day_multiple       |        15|          5|                3515|                  995|               0.4|                0.5|
|Autumn 2021    |flag_same_day_same_product   |         5|          5|                3515|                  995|               0.1|                0.5|
|Autumn 2021    |flag_unapproved_product      |        15|         15|                3515|                  995|               0.4|                1.5|
|Spring 2022    |flag_product_before_approval |       215|        175|                3515|                  995|               6.1|               17.6|
|Spring 2022    |flag_same_day_mixed_product  |        15|          5|                3515|                  995|               0.4|                0.5|
|Spring 2022    |flag_same_day_multiple       |        15|          5|                3515|                  995|               0.4|                0.5|
|Spring 2022    |flag_same_day_same_product   |         5|          5|                3515|                  995|               0.1|                0.5|
|Spring 2022    |flag_unapproved_product      |         5|          5|                3515|                  995|               0.1|                0.5|
|Autumn 2022    |flag_product_before_approval |       175|        145|                3515|                  995|               5.0|               14.6|
|Autumn 2022    |flag_same_day_mixed_product  |         5|          5|                3515|                  995|               0.1|                0.5|
|Autumn 2022    |flag_same_day_multiple       |        15|          5|                3515|                  995|               0.4|                0.5|
|Autumn 2022    |flag_same_day_same_product   |         5|          5|                3515|                  995|               0.1|                0.5|
|Autumn 2022    |flag_unapproved_product      |         5|          5|                3515|                  995|               0.1|                0.5|
|Spring 2023    |flag_product_before_approval |        85|         65|                3515|                  995|               2.4|                6.5|
|Spring 2023    |flag_same_day_mixed_product  |         5|          5|                3515|                  995|               0.1|                0.5|
|Spring 2023    |flag_same_day_multiple       |        15|          5|                3515|                  995|               0.4|                0.5|
|Spring 2023    |flag_same_day_same_product   |        15|          5|                3515|                  995|               0.4|                0.5|
|Spring 2023    |flag_unapproved_product      |         5|          5|                3515|                  995|               0.1|                0.5|
|Autumn 2023    |flag_product_before_approval |        75|         65|                3515|                  995|               2.1|                6.5|
|Autumn 2023    |flag_same_day_mixed_product  |        15|          5|                3515|                  995|               0.4|                0.5|
|Autumn 2023    |flag_same_day_multiple       |        25|         15|                3515|                  995|               0.7|                1.5|
|Autumn 2023    |flag_same_day_same_product   |         5|          5|                3515|                  995|               0.1|                0.5|
|Autumn 2023    |flag_unapproved_product      |        15|         15|                3515|                  995|               0.4|                1.5|
|Spring 2024    |flag_product_before_approval |        55|         55|                3515|                  995|               1.6|                5.5|
|Spring 2024    |flag_same_day_mixed_product  |        15|          5|                3515|                  995|               0.4|                0.5|
|Spring 2024    |flag_same_day_multiple       |        15|          5|                3515|                  995|               0.4|                0.5|
|Spring 2024    |flag_same_day_same_product   |         5|          5|                3515|                  995|               0.1|                0.5|
|Spring 2024    |flag_unapproved_product      |         5|          5|                3515|                  995|               0.1|                0.5|
|Autumn 2024    |flag_same_day_mixed_product  |        15|          5|                3515|                  995|               0.4|                0.5|
|Autumn 2024    |flag_same_day_multiple       |        25|         15|                3515|                  995|               0.7|                1.5|
|Autumn 2024    |flag_same_day_same_product   |         5|          5|                3515|                  995|               0.1|                0.5|
|Autumn 2024    |flag_unapproved_product      |        15|         15|                3515|                  995|               0.4|                1.5|
|Spring 2025    |flag_same_day_mixed_product  |         5|          5|                3515|                  995|               0.1|                0.5|
|Spring 2025    |flag_same_day_multiple       |        15|          5|                3515|                  995|               0.4|                0.5|
|Spring 2025    |flag_same_day_same_product   |         5|          5|                3515|                  995|               0.1|                0.5|
|Spring 2025    |flag_unapproved_product      |         5|          5|                3515|                  995|               0.1|                0.5|
|Autumn 2025    |flag_same_day_mixed_product  |         5|          5|                3515|                  995|               0.1|                0.5|
|Autumn 2025    |flag_same_day_multiple       |        25|         15|                3515|                  995|               0.7|                1.5|
|Autumn 2025    |flag_same_day_same_product   |        15|          5|                3515|                  995|               0.4|                0.5|
|Autumn 2025    |flag_unapproved_product      |         5|          5|                3515|                  995|               0.1|                0.5|

