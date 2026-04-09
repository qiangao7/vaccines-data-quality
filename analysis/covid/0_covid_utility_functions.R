# _________________________________________________
# Purpose:
# define useful functions used in the codebase
# this script should be sourced using: 
# source(here("analysis", "covid", "0_covid_utility_functions.R"))
# _________________________________________________

# utility functions ----
roundmid_any <- function(x, to = 1) {
  # like ceiling_any, but centers on (integer) midpoint of the rounding points
  if (to == 0) {
    x
  } else {
    ceiling(x / to) * to - (floor(to / 2) * (x != 0))
  }
}

# ===============================================================
# Helper functions for COVID-19 vaccination data quality summaries
#
# Helper 1a / Helper 1b:
#   - Used for Table 1 (overall) and Table 3 (product)
#   - Compute summary counts with total denominators based on
#     observed records and patients (no campaign restriction)
#
# Helper 1c / Helper 1d:
#   - Used for Table 2 (campaign-level summary)
#   - Compute campaign-specific denominators:
#       * patients alive at campaign start
#       * records contributed by those patients within the campaign
#   - Designed to account for changes in population over time due to death
#
# Helper 2a / Helper 2b:
#   - Used for Tables 4–6 (interval analyses)
#   - Compute interval-based summaries with both:
#       * group-level denominators (within context)
#       * total denominators (all eligible intervals)
#
# Notes:
#   - All "_rounded" outputs use midpoint-6 rounding (SDC)
#   - Rounded variables are explicitly labelled with suffix "_midpoint6"
# ===============================================================

# ---- helper 1a: summary table with total denominator only (unrounded) ----

make_summary_table_total_unrounded <- function(data, group_vars) {

  denom_records_total <- nrow(data)
  denom_patients_total <- dplyr::n_distinct(data$patient_id)

  data |>
    group_by(across(all_of(group_vars))) |>
    summarise(
      n_records = n(),
      n_patients = n_distinct(patient_id),
      .groups = "drop"
    ) |>
    mutate(
      denom_records_total = denom_records_total,
      denom_patients_total = denom_patients_total
    ) |>
    select(
      all_of(group_vars),
      n_records,
      n_patients,
      denom_records_total,
      denom_patients_total
    )
}
# ---- helper 1b: summary table with total denominator only  (rounded)----

make_summary_table_total_rounded <- function(data, group_vars) {

  denom_records_total_midpoint6 <- roundmid_any(nrow(data), sdc_threshold)
  denom_patients_total_midpoint6 <- roundmid_any(dplyr::n_distinct(data$patient_id), sdc_threshold)

  data |>
    group_by(across(all_of(group_vars))) |>
    summarise(
      n_records_midpoint6 = roundmid_any(n(), sdc_threshold),
      n_patients_midpoint6 = roundmid_any(n_distinct(patient_id), sdc_threshold),
      .groups = "drop"
    ) |>
    mutate(
      denom_records_total_midpoint6 = denom_records_total_midpoint6,
      denom_patients_total_midpoint6 = denom_patients_total_midpoint6
    ) |>
    select(
      all_of(group_vars),
      n_records_midpoint6,
      n_patients_midpoint6,
      denom_records_total_midpoint6,
      denom_patients_total_midpoint6
    )
}

# ---- helper 1c: campaign summary with campaign-specific alive denominators (unrounded) ----

make_summary_table_campaign_alive_unrounded <- function(flag_data, event_data) {

  # overall denominators: all observed records and patients
 
  # patient-level death date
  patient_death_df <-
    event_data |>
    select(patient_id, death_date) |>
    distinct() |>
    mutate(
      death_date = as.Date(death_date)
    )

  # campaign-specific alive patients:
  # alive at campaign start = no death recorded OR death on/after campaign start
  patient_campaign_alive_df <-
    tidyr::crossing(
      patient_death_df,
      campaign_info |>
        select(campaign_label, campaign_start_date)
    ) |>
    mutate(
      alive_at_campaign_start =
        is.na(death_date) | death_date >= campaign_start_date
    ) |>
    filter(alive_at_campaign_start) |>
    transmute(
      patient_id,
      campaign = campaign_label
    )

  # group denominator: patients alive at campaign start
  denom_patients_group_df <-
    patient_campaign_alive_df |>
    group_by(campaign) |>
    summarise(
      denom_patients_group = n_distinct(patient_id),
      .groups = "drop"
    )

  # group denominator: records in that campaign contributed by patients alive at campaign start
  denom_records_group_df <-
    event_data |>
    inner_join(
      patient_campaign_alive_df,
      by = c("patient_id", "campaign")
    ) |>
    group_by(campaign) |>
    summarise(
      denom_records_group = n(),
      .groups = "drop"
    )

  # numerator
  numerator_df <-
    flag_data |>
    group_by(campaign, flag_type) |>
    summarise(
      n_records = n(),
      n_patients = n_distinct(patient_id),
      .groups = "drop"
    )

  numerator_df |>
    left_join(denom_patients_group_df, by = "campaign") |>
    left_join(denom_records_group_df, by = "campaign") |>
    select(
      campaign,
      flag_type,
      n_records,
      n_patients,
      denom_records_group,
      denom_patients_group
    )
}

# ---- helper 1d: campaign summary with campaign-specific alive denominators (midpoint6 rounded) ----

make_summary_table_campaign_alive_rounded <- function(flag_data, event_data) {

  # overall denominators: all observed records and patients
 
  # patient-level death date
  patient_death_df <-
    event_data |>
    select(patient_id, death_date) |>
    distinct() |>
    mutate(
      death_date = as.Date(death_date)
    )

  # campaign-specific alive patients
  patient_campaign_alive_df <-
    tidyr::crossing(
      patient_death_df,
      campaign_info |>
        select(campaign_label, campaign_start_date)
    ) |>
    mutate(
      alive_at_campaign_start =
        is.na(death_date) | death_date >= campaign_start_date
    ) |>
    filter(alive_at_campaign_start) |>
    transmute(
      patient_id,
      campaign = campaign_label
    )

  # group denominator: patients alive at campaign start
  denom_patients_group_df <-
    patient_campaign_alive_df |>
    group_by(campaign) |>
    summarise(
      denom_patients_group_midpoint6 = roundmid_any(n_distinct(patient_id), sdc_threshold),
      .groups = "drop"
    )

  # group denominator: records in that campaign contributed by patients alive at campaign start
  denom_records_group_df <-
    event_data |>
    inner_join(
      patient_campaign_alive_df,
      by = c("patient_id", "campaign")
    ) |>
    group_by(campaign) |>
    summarise(
      denom_records_group_midpoint6 = roundmid_any(n(), sdc_threshold),
      .groups = "drop"
    )

  # numerator
  numerator_df <-
    flag_data |>
    group_by(campaign, flag_type) |>
    summarise(
      n_records_midpoint6 = roundmid_any(n(), sdc_threshold),
      n_patients_midpoint6 = roundmid_any(n_distinct(patient_id), sdc_threshold),
      .groups = "drop"
    )

  numerator_df |>
    left_join(denom_patients_group_df, by = "campaign") |>
    left_join(denom_records_group_df, by = "campaign") |>
    select(
      campaign,
      flag_type,
      n_records_midpoint6,
      n_patients_midpoint6,
      denom_records_group_midpoint6,
      denom_patients_group_midpoint6
    )
}

# ---- helper 2a: interval table with group and total denominators (unrounded) ----
make_interval_table_unrounded <- function(data, group_var) {

  denom_records_total <- nrow(data)
  denom_patients_total <- dplyr::n_distinct(data$patient_id)

  summary_df <-
    data |>
    group_by(across(all_of(c(group_var, "interval_bin")))) |>
    summarise(
      n_records = n(),
      n_patients = n_distinct(patient_id),
      .groups = "drop"
    )

  denom_df_group <-
    data |>
    group_by(across(all_of(group_var))) |>
    summarise(
      denom_records_group = n(),
      denom_patients_group = n_distinct(patient_id),
      .groups = "drop"
    )

  summary_df |>
    left_join(denom_df_group, by = group_var) |>
    mutate(
      denom_records_total = denom_records_total,
      denom_patients_total = denom_patients_total
    ) |>
    select(
      all_of(group_var),
      interval_bin,
      n_records,
      n_patients,
      denom_records_group,
      denom_patients_group,
      denom_records_total,
      denom_patients_total
    )
}

# ---- helper 2b: interval table with within-group + total denominator (rounded)----

make_interval_table_rounded <- function(data, group_var) {

  denom_records_total_midpoint6 <- roundmid_any(nrow(data), sdc_threshold)
  denom_patients_total_midpoint6 <- roundmid_any(dplyr::n_distinct(data$patient_id), sdc_threshold)

  summary_df <-
    data |>
    group_by(across(all_of(c(group_var, "interval_bin")))) |>
    summarise(
      n_records_midpoint6 = roundmid_any(n(), sdc_threshold),
      n_patients_midpoint6 = roundmid_any(n_distinct(patient_id), sdc_threshold),
      .groups = "drop"
    )

  denom_df_group <-
    data |>
    group_by(across(all_of(group_var))) |>
    summarise(
      denom_records_group_midpoint6 = roundmid_any(n(), sdc_threshold),
      denom_patients_group_midpoint6 = roundmid_any(n_distinct(patient_id), sdc_threshold),
      .groups = "drop"
    )

  summary_df |>
    left_join(denom_df_group, by = group_var) |>
    mutate(
      denom_records_total_midpoint6 = denom_records_total_midpoint6,
      denom_patients_total_midpoint6 = denom_patients_total_midpoint6
    ) |>
    select(
      all_of(group_var),
      interval_bin,
      n_records_midpoint6,
      n_patients_midpoint6,
      denom_records_group_midpoint6,
      denom_patients_group_midpoint6,
      denom_records_total_midpoint6,
      denom_patients_total_midpoint6
    )
}
