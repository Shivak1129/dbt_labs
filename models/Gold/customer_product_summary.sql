SELECT
    CUSTOMER_ID,
    FIRST_NAME,
    LAST_NAME,
    EMAIL,
    PRODUCT_NAME,
    CATEGORY,
    PRICE,
    PURCHASE_DATE,
    CURRENT_DELIVERY_STATUS,
    DELIVERY_DATE,
    COURIER_NAME
FROM {{ ref('product_delivery_info') }}  -- ref to the Silver model
WHERE CURRENT_DELIVERY_STATUS != 'Pending'