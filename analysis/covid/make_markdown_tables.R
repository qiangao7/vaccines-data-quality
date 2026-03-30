library(readr)
library(knitr)
library(here)
library(fs)
options(width = 1000)
in_dir  <- here("assets", "covid_data_quality_examples")
out_dir <- in_dir

csv_files <- c(
  "count_overall_noninterval_flags.csv",
  "count_campaign_noninterval_flags.csv",
  "count_product_noninterval_flags.csv",
  "count_interval_context.csv",
  "count_interval_campaign_transition.csv",
  "count_interval_product_transition.csv"
)

for (f in csv_files) {
  df <- read_csv(fs::path(in_dir, f))

  md_table <- knitr::kable(df, format = "markdown")

  out_file <- fs::path_ext_set(fs::path(out_dir, f), "md")

  writeLines(
    c(
      paste0("# ", fs::path_ext_remove(f)),
      "",
      md_table,
      ""
    ),
    out_file
  )
}