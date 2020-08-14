-- seAdpater1 V1.0
-- Adapter für SolarEdge-Wechselrichter zur Anzeige von Livedaten aus dem SolarEdge-Portal, QuickApp für Fibaro HC3
-- Der Adapter fragt ausgewählte Daten des SolarEdge-Wechselrichters zyklisch ab und stellt diese 
-- in einer Übersicht zur Verfügung.

-- Copyright (C) 2020, Thomas Burchert, 10Consult, Germany

-- GNU General Public License (Dieses Programm ist freie Software. Sie können es unter den Bedingungen der GNU General Public License, wie von der Free Software Foundation veröffentlicht, weitergeben und/oder modifizieren, entweder gemäß Version 3 der Lizenz oder (nach Ihrer Wahl) gemäß jeder späteren Version. Die Veröffentlichung dieses Programms erfolgt in der Hoffnung, daß es Ihnen von Nutzen sein wird, aber OHNE IRGENDEINE GARANTIE, sogar ohne die implizite Garantie der MARKTREIFE oder der VERWENDBARKEIT FÜR EINEN BESTIMMTEN ZWECK. Details finden Sie in der GNU General Public License. Sie sollten ein Exemplar der GNU General Public License zusammen mit diesem Programm erhalten haben. Falls nicht, finden Sie ein Exemplar der GNU General Public License zu diesem Programm hier:  <http://www.gnu.org/licenses/>. This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 3 of the License, or (at your option) any later version. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program; if not, see <http://www.gnu.org/licenses/>.

-- Parameter, Settings
--- site_id: ID der Schnittstelle des SolarEdge-Wechselrichters
--- api_key: Zugriffschlüssel für die SolarEdge-Schnittstelle
--- interval: Zeitintervall für die Abfrage der Betriebsdaten
--- wait: yes/no, der Adapter geht mit "yes" in den Wartezustand
--- globaleValues: yes/no, der Adapter speichert mit "yes" die Betriebsdaten zusätzlich im Bereich der globalen Variablen ab, dafür sind die Globalen Variablen dort manuell einzurichten.

-- Init seAdapter
function QuickApp:onInit()
    self:debug("onInit")
    self.http = net.HTTPClient({timeout=10000})
    self:Update("Start seAdapter1")
end
-- Datenabfrage im Zyklus
function QuickApp:Update(message)   
    self.looptime = tonumber(self:getVariable("interval"))*1000 -- 60*1000= rd. 60 sec = 1 Minute
    self:debug("looptime= ", self.looptime)
    self.wait = self:getVariable("wait")
    self.setGlobalValues = self:getVariable("globalvalues")
    self.go = "true" 
    -- Check the Start-Values "interval", "wait" 
    if  (self.looptime == 0) or (self.looptime <= 30) then
    self:warning("seAdapter, error Interval value!") -- Value "interval"= 0 or <=30
    self.go = "false"
    end
    if  (self.wait ~= "no") then
        self:trace("seAdapter is waiting!") -- Value "wait"=yes
        self.go = "false"
    end
    -- to data request
    if (self.go == "true") then
        self:debug("start data request seAdapter")
    -- Daten der SolarEdge-API lesen
    local address = "https://monitoringapi.solaredge.com/site/"..self:getVariable("site_id").."/overview.json?api_key="..self:getVariable("api_key")
    self:debug(address)
    self.http:request(address, {
        options={
            headers = { 
                Accept = "application/json"
            },
            method = 'GET'
        },
        success = function(response)
                self:debug("response status:", response.status) 
                self:debug("headers:", response.headers["Content-Type"]) 
                local sedata = json.decode(response.data)
                
                -- prepare data           
                local timestamp = sedata.overview.lastUpdateTime

                local currpower = sedata.overview.currentPower.power
                currpower = currpower/1000
                currpower = string.format("%.2f", currpower)
            
                local dayenergy = sedata.overview.lastDayData.energy
			    dayenergy = dayenergy/1000
                dayenergy = string.format("%.2f", dayenergy)
            
                local monthenergy = sedata.overview.lastMonthData.energy
                monthenergy = monthenergy/1000
                monthenergy = string.format("%.2f", monthenergy)
            
                local yearenergy = sedata.overview.lastYearData.energy
			    yearenergy = yearenergy/1000
                yearenergy = string.format("%.2f", yearenergy)
            
                local lifetimeenergy = sedata.overview.lifeTimeData.energy
			    lifetimeenergy = lifetimeenergy/1000
                lifetimeenergy = string.format("%.2f", lifetimeenergy)

                local moneylifetime = sedata.overview.lifeTimeData.revenue
                moneylifetime = string.format("%.2f", moneylifetime)
            
                -- Prepare Values to display
                local Vtimestamp = "Letzte Messung: " ..timestamp..""
                self:debug(Vtimestamp)
                self:updateView("LME", "text", Vtimestamp)

                local VcurrPower = "Erzeugung aktuell: " ..currpower.." kW"
                self:debug(VcurrPower)
                self:updateView("CPE", "text", VcurrPower)

                local Vtoday = "Energie heute: " ..dayenergy.." kWh"
                self:debug(Vtoday)
                self:updateView("TPE", "text", Vtoday)

                local VMonth = "Energie diesen Monat: " ..monthenergy.." kWh"
                self:debug(VMonth)
                self:updateView("MPE", "text", VMonth)

                local VYear = "Energie dieses Jahr: " ..yearenergy.." kWh"
                self:debug(VYear)
                self:updateView("YPE", "text", VYear)

                local VLifetime = "Energie Gesamt: " ..lifetimeenergy.." kWh"
                self:debug(VLifetime)
                self:updateView("LTE", "text", VLifetime)

                local VMoneyLifetime = "Einnahmen Gesamt: " ..moneylifetime.." Euro"
                self:debug(VMoneyLifetime)
                self:updateView("LTM", "text", VMoneyLifetime)

                -- Schreiben Globaler Variablen in zentrale Variablenverwaltung
                if  (self.setGlobalValues ~= "no") then
                    fibaro.setGlobalVariable("seTimeStamp", timestamp)
                    fibaro.setGlobalVariable("sePowerCurrent", currpower)
                    fibaro.setGlobalVariable("seEnergyDay", dayenergy)
                    fibaro.setGlobalVariable("seEnergyMonth", monthenergy)
                    fibaro.setGlobalVariable("seEnergyYear", yearenergy)
                    fibaro.setGlobalVariable("seEnergyLifetime", lifetimeenergy)
                    fibaro.setGlobalVariable("seMoneyLifetime", moneylifetime)
                    self:debug("Save Global Values to Fibaro ready")
                end
            end,
            error = function(error)
                self:debug('error: ' .. json.encode(error))
            end
        })
    end
    fibaro.setTimeout(self.looptime, function() 
        self:Update("Next update")
        end)
end
