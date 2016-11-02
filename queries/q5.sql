-- 5) List the titles of Magazines and Journals that were published in the same year.

COL Journal format a50
COL Magazine format a50

SELECT DISTINCT EXTRACT(year FROM P1.publish_date) as "Publish year", J.jtitle as Journal, M.mtitle as Magazine
FROM Catalog_item C, Publishes P1, Publishes P2, Journal J, Magazine M
WHERE P1.catid = J.jid
AND P2.catid = M.mid
AND P1.publish_date = P2.publish_date;

-- Publish year JOURNAL                                            MAGAZINE
-- ------------ -------------------------------------------------- --------------------------------------------------
--         2014 Remarque en toy telle marque                       Canadas History Society Annual Report 2015
--         2002 Water the Epic Struggle for Wealth, Power, and Civ Off-Grid Food Preservation
--              ilization

