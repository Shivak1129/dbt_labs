-- MODEL: enriched_customer_data.sql
-- Description: Combines customer and plan info using macros

WITH latest_plan AS {{ customer_latest_plan() }}

SELECT
    -- Identifiers
    c.customer_id,
    p.plan_id,
    -- Customer Details
    c.full_name,
    c.gender,
    c.age,
    {{ age_category('c.age') }} AS age_group,
    -- Contact and Location
    c.city,
    {{ standardize_state('c.state') }} AS clean_state,
    {{ mask_mobile('c.mobile_number') }} AS masked_mobile,
    c.email,
    {{ is_valid_email('c.email') }} AS is_valid,
     -- Amounts and Pricing
    p.price,
    {{ calculate_gst('p.price') }} AS price_with_gst,
    p.plan_name,
    p.plan_type,
    -- Dates
    c.registered_on,
    {{ get_fiscal_quarter('c.registered_on') }} AS fiscal_quarter,
    p.activated_on,
    p.validity_days,
     {{ is_plan_active('p.is_active') }} AS plan_status,
    {{ calculate_expiry('p.activated_on', 'p.validity_days') }} AS expiry_date

FROM {{ source('tele_customer', 'TELECOM_CUSTOMERS') }} c
LEFT JOIN latest_plan p
    ON c.customer_id = p.customer_id
