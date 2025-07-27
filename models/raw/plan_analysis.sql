-- MODEL: plan_analysis.sql
-- Description: Uses macros to calculate plan expiry, fiscal quarter, GST, plan status, and filter only prepaid plans

SELECT
    plan_id,
    customer_id,
    plan_name,
    plan_type,
    {{ calculate_expiry('activated_on', 'validity_days') }} AS expiry_date,           -- Adds validity_days to activated_on
    {{ calculate_gst('price') }} AS price_with_gst,                                   -- Adds 18% GST
    {{ is_plan_active('is_active') }} AS status,                                      -- Converts TRUE/FALSE to 'Active'/'Inactive'
    {{ get_fiscal_quarter('activated_on') }} AS activation_quarter                    -- Returns Q1 to Q4
FROM {{ source('tele_telecom_plans', 'TELE_PLANS') }}
WHERE {{ filter_prepaid() }}                                                   -- Filters only prepaid plans
