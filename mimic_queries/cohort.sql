SELECT icustays.stay_id
FROM `physionet-data.mimic_icu.icustays`  icustays
LEFT JOIN `physionet-data.mimic_hosp.emar` emar
ON icustays.hadm_id=emar.hadm_id
LEFT JOIN  `physionet-data.mimic_hosp.pharmacy` pharmacy
ON pharmacy.pharmacy_id=emar.pharmacy_id
WHERE event_txt = 'Administered'
and icustays.intime<=emar.scheduletime
AND datetime_add(icustays.intime, INTERVAL 24 HOUR)  >= emar.scheduletime
AND (
   upper(emar.medication) LIKE '%ENOXAPARIN%'
   OR
   (upper(emar.medication) LIKE '%HEPARIN%' AND pharmacy.route = 'SC')
)