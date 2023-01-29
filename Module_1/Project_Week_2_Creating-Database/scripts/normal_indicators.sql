USE dbenergy;

-- MAINT TABLE IN RAW FORMAT
SELECT * FROM main_tb_raw LIMIT 10;

-- NORMALIZING PER YEAR FOR TIME SERIES ANALYSIS
-- (x-x.min)/(x.max-x.min)
-- BEFORE NORMALIZING WHICH COUNTRIES?!!!

-- - ------ NORMALIZE QUANTITIES ----------
/* CREATE VIEW main_tb_select	AS
    SELECT * 
	FROM main_tb_raw */
	CREATE VIEW main_tb_select_pcap	AS
    SELECT * 
	FROM main_tb_raw_pcap
	WHERE 
		iso_code = "FRA"
		OR
		iso_code = "DEU"
		OR
		iso_code= "QAT"
		 OR
		iso_code = "USA"
		 OR
		iso_code = "CRI"
		OR
		iso_code = "BRN"
		OR
		iso_code = "THA"
		OR
		iso_code = "NGA"
		OR
		iso_code = "NLD"
		OR
		iso_code = "MEX"
;

SELECT * FROM main_tb_select_pcap LIMIT 1;

-- indicator energy8_demand vs Delta POp
/* SELECT *, 
	LAG(population,1) OVER ( ORDER BY year ASC) as previous_pop 
FROM 
    (SELECT * 
	FROM main_tb_raw
	WHERE 
		iso_code = "FRA") as test;*/

-- SELECT (population - LAG(population,1))/LAG(population,1) as deltapop
CREATE TABLE electricity_gen
SELECT main_tb_select.*, 
	(main_tb_select.electricity_demand-minmaxtb.mindemand)/(minmaxtb.maxdemand - minmaxtb.mindemand ) as en_demand_norm,
    (main_tb_select.electricity_generation-minmaxtb.mingen)/(minmaxtb.maxgen - minmaxtb.mingen ) as en_gen_norm,
    (main_tb_select.renewables_electricity-minmaxtb.mingenrew)/(minmaxtb.maxgenrew - minmaxtb.mingenrew ) as ren_gen_norm,
    (main_tb_select.fossil_electricity-minmaxtb.mingenfoss)/(minmaxtb.maxgenfoss - minmaxtb.mingenfoss ) as foss_gen_norm,
    (main_tb_select.nuclear_electricity-minmaxtb.mingennuc)/(minmaxtb.maxgennuc - minmaxtb.mingennuc ) as nuc_gen_norm,
    (main_tb_select.other_renewable_electricity-minmaxtb.mingenothrew)/(minmaxtb.maxgenothrew - minmaxtb.mingenothrew ) as otherren_gen_norm,
    (main_tb_select.co2_emis-minmaxtb.minco2)/(minmaxtb.maxco2 - minmaxtb.minco2 ) as co2_emis_norm
FROM main_tb_select
LEFT JOIN
	(
	SELECT year,
				MIN(electricity_demand) as mindemand,MAX(electricity_demand) as maxdemand,
                MIN(electricity_generation) as mingen, MAX(electricity_generation) as maxgen,
                MIN(renewables_electricity) as mingenrew, MAX(renewables_electricity) as maxgenrew,
                MIN(fossil_electricity) as mingenfoss, MAX(fossil_electricity) as maxgenfoss,
                MIN(nuclear_electricity) as mingennuc, MAX(nuclear_electricity) as maxgennuc,
                MIN(other_renewable_electricity) as mingenothrew, MAX(other_renewable_electricity) as maxgenothrew,
                MIN(co2_emis) as minco2, MAX(co2_emis) as maxco2
		FROM main_tb_select
		WHERE electricity_demand IS NOT NULL
			AND electricity_generation IS NOT NULL
			AND iso_code IS NOT NULL
			AND electricity_demand > 0
	GROUP BY year) as minmaxtb
ON main_tb_select.year = minmaxtb.year
ORDER BY country ASC
;
 
-- PER CAPITAAA
CREATE TABLE electricity_gen_pcap
SELECT main_tb_select_pcap.*, 
	(main_tb_select_pcap.electricity_demand-minmaxtb.mindemand)/(minmaxtb.maxdemand - minmaxtb.mindemand ) as en_demand_norm,
    (main_tb_select_pcap.electricity_generation-minmaxtb.mingen)/(minmaxtb.maxgen - minmaxtb.mingen ) as en_gen_norm,
    (main_tb_select_pcap.renewables_electricity-minmaxtb.mingenrew)/(minmaxtb.maxgenrew - minmaxtb.mingenrew ) as ren_gen_norm,
     (main_tb_select_pcap.fossil_electricity-minmaxtb.mingenfoss)/(minmaxtb.maxgenfoss - minmaxtb.mingenfoss ) as foss_gen_norm,
    (main_tb_select_pcap.nuclear_electricity-minmaxtb.mingennuc)/(minmaxtb.maxgennuc - minmaxtb.mingennuc ) as nuc_gen_norm,
    (main_tb_select_pcap.other_renewable_electricity-minmaxtb.mingenothrew)/(minmaxtb.maxgenothrew - minmaxtb.mingenothrew ) as otherren_gen_norm,
    (main_tb_select_pcap.co2_emis-minmaxtb.minco2)/(minmaxtb.maxco2 - minmaxtb.minco2 ) as co2_emis_norm
FROM main_tb_select_pcap
LEFT JOIN
	(
	SELECT year,
				MIN(electricity_demand) as mindemand,MAX(electricity_demand) as maxdemand,
                MIN(electricity_generation) as mingen, MAX(electricity_generation) as maxgen,
                MIN(renewables_electricity) as mingenrew, MAX(renewables_electricity) as maxgenrew,
                MIN(fossil_electricity) as mingenfoss, MAX(fossil_electricity) as maxgenfoss,
                MIN(nuclear_electricity) as mingennuc, MAX(nuclear_electricity) as maxgennuc,
                MIN(other_renewable_electricity) as mingenothrew, MAX(other_renewable_electricity) as maxgenothrew,
                -- MIN(renewables_elec_per_capita) as mingenrewpcap, MAX(renewables_elec_per_capita) as maxgenrewpcap,
                MIN(co2_emis) as minco2, MAX(co2_emis) as maxco2
		FROM main_tb_select_pcap
		WHERE electricity_demand IS NOT NULL
			AND electricity_generation IS NOT NULL
			AND iso_code IS NOT NULL
			AND electricity_demand > 0
	GROUP BY year) as minmaxtb
ON main_tb_select_pcap.year = minmaxtb.year
ORDER BY country ASC
;

/* SELECT  year,
				MIN(electricity_demand) as mindemand,MAX(electricity_demand) as maxdemand,
                MIN(electricity_generation) as mingen, MAX(electricity_generation) as maxgen,
                MIN(renewables_electricity) as mingenrew, MAX(renewables_electricity) as maxgenrew,
                -- MIN(renewables_elec_per_capita) as mingenrewpcap, MAX(renewables_elec_per_capita) as maxgenrewpcap,
                MIN(co2_emis) as minco2, MAX(co2_emis) as maxco2
		FROM main_tb_select
		WHERE electricity_demand IS NOT NULL
			AND electricity_generation IS NOT NULL
			AND iso_code IS NOT NULL
			AND electricity_demand > 0
	GROUP BY year;


SELECT year, MAX(co2_emis)
FROM main_tb_select
GROUP BY year;
*/


