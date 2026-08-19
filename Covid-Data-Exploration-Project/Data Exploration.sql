CREATE DATABASE portfolio;

-- Correcting Data Column Type

ALTER TABLE portfolio.CovidDeaths
MODIFY COLUMN date VARCHAR(255);

ALTER TABLE portfolio.CovidVaccinations
MODIFY COLUMN date VARCHAR(255);

UPDATE portfolio.CovidDeaths
SET date = DATE_ADD('1899-12-30', INTERVAL date DAY);

UPDATE portfolio.CovidVaccinations
SET date = DATE_ADD('1899-12-30', INTERVAL date DAY);

Select *
From portfolio.CovidDeaths
Where continent is not null
order by 3,4;


-- Select Data that we are going to be starting with

Select location, total_cases,  new_cases, total_deaths, population
From portfolio.CovidDeaths
Where continent is not null
order by 1,2;

-- Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid in your country

SELECT location, date, total_cases, total_deaths, (total_deaths / total_cases) * 100 as DeathsPercentage
From portfolio.CovidDeaths
Where location = "Armenia"
Order By 1,2;

-- Total Cases vs Population
-- Shows what percentage of population infected with Covid

Select Location, date, Population, total_cases,  (total_cases/population)*100 as PercentPopulationInfected
From portfolio.CovidDeaths
Where location like '%states%'
order by 1,2;

-- Countries with Highest Infection Rate compared to Population

Select location, population, Max(total_cases) as HighestInfectioncount,
(max(total_cases) / population) * 100 as infectedPercentage
From portfolio.CovidDeaths
GROUP BY location, population
ORDER BY infectedPercentage desc;


-- Countries with Highest Death Count per Population

Select location, Max(total_deaths) as TotalDeathCount
From portfolio.CovidDeaths
Where continent is not null
group by location
order by TotalDeathCount desc;

-- BREAKING THINGS DOWN BY CONTINENT

-- Showing continents with the highest death count per population

Select continent, Max(total_deaths) as TotalDeathCount
From portfolio.CovidDeaths
Where continent is not null
group by continent
order by TotalDeathCount desc;

-- Global numbers

SELECT SUM(new_cases) as total_cases,
SUM(new_deaths) as total_deaths,
(SUM(new_deaths) / SUM(new_cases)) * 100 as DeathPercentage
From portfolio.CovidDeaths
where continent is not null
Order By 1,2;

select *
from portfolio.CovidDeaths as dea
join portfolio.CovidVaccinations as vac
    on dea.location = vac.location
    and dea.date = vac.date;

-- Total Population vs Vaccinations
-- Shows Percentage of Population that has recieved at least one Covid Vaccine

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(vac.new_vaccinations)      OVER(partition by dea.location order by dea.location, dea.date) as total_vaccinations
from portfolio.CovidDeaths as dea
join portfolio.CovidVaccinations as vac
    on dea.location = vac.location
    and dea.date = vac.date
where dea.continent is not null
order by 2,3;

-- Using CTE to perform Calculation on Partition By in previous query

WITH PopVsVac (continent, location, date, population, new_vaccinations, total_vaccinations)
as (
    select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(vac.new_vaccinations)      OVER(partition by dea.location order by dea.location, dea.date) as total_vaccinations
from portfolio.CovidDeaths as dea
join portfolio.CovidVaccinations as vac
    on dea.location = vac.location
    and dea.date = vac.date
where dea.continent is not null
    )
select *, (total_vaccinations / population) * 100
from PopVsVac;


-- Using Temp Table to perform Calculation on Partition By in previous query
use portfolio;
DROP Table if exists PercentPopulationVaccinate
Create Table PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
);

Insert into PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(vac.new_vaccinations) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
-- , (RollingPeopleVaccinated/population)*100
From portfolio.CovidDeaths dea
Join portfolio.CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null;

Select *, (RollingPeopleVaccinated/Population)*100
From PercentPopulationVaccinated;

-- Creating View to store data for later visualizations

Create View PercentPopulationVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(vac.new_vaccinations) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
-- , (RollingPeopleVaccinated/population)*100
From portfolio.CovidDeaths dea
Join portfolio.CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null;