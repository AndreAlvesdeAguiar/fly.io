class MoonController < ApplicationController
  def index
    @current_phase = current_moon_phase
    @next_phases = next_moon_phases(30) # Ajuste o número de fases futuras que você deseja exibir
    @current_season = current_season
  end

  private

  def current_moon_phase
    date = Date.today
    phase = calculate_moon_phase(date)
    { phase: phase_name(phase), start_time: calculate_moon_phase_start_time(date, phase) }
    
  end

  def next_moon_phases(count)
    date = Date.today
    phases = []

    while phases.length < count
      phase = calculate_moon_phase(date)
      phases << { date: date, phase: phase_name(phase), start_time: calculate_moon_phase_start_time(date, phase) }
      date += 1
    end

    phases
  end

  def calculate_moon_phase(date)
    year = date.year
    month = date.month
    day = date.day

    # Cálculo do número juliano para a data
    a = (14 - month) / 12
    y = year + 4800 - a
    m = month + 12 * a - 3
    julian_day = day + ((153 * m + 2) / 5) + 365 * y + (y / 4) - (y / 100) + (y / 400) - 32045

    # Cálculo da idade da lua em dias
    base_date = Date.new(2000, 1, 6) # Data base para cálculo da idade da lua
    moon_age = (julian_day - base_date.jd) % 29.53

    # Cálculo da fase da lua
    phase = (moon_age / 29.53 * 8).to_i

    phase
  end

  def calculate_moon_phase_start_time(date, phase)
    year = date.year
    month = date.month
    day = date.day

    case phase
    when 0 # Lua Nova
      calculate_phase_start_time(year, month, day)
    when 1, 2, 3 # Lua Crescente
      calculate_phase_start_time(year, month, day, 1, 6)
    when 4 # Lua Cheia
      calculate_phase_start_time(year, month, day, 3, 12)
    when 5, 6, 7 # Lua Minguante
      calculate_phase_start_time(year, month, day, 4, 6)
    end
  end

  def calculate_phase_start_time(year, month, day, hour = 0, minute = 0)
    time = Time.new(year, month, day, hour, minute)
    time.strftime('%Y-%m-%d %H:%M:%S')
  end

  def phase_name(phase)
    phase_names = ['Lua Nova', 'Lua Crescente', 'Lua Crescente', 'Lua Crescente', 'Lua Cheia', 'Lua Minguante', 'Lua Minguante', 'Lua Minguante']
    phase_names[phase]
  end

  def current_season
    today = Date.today
    seasons = {
      verão: { start_date: Date.new(today.year, 12, 22), end_date: Date.new(today.year + 1, 3, 20) },
      outono: { start_date: Date.new(today.year, 3, 21), end_date: Date.new(today.year, 6, 20) },
      inverno: { start_date: Date.new(today.year, 6, 21), end_date: Date.new(today.year, 9, 22) },
      primavera: { start_date: Date.new(today.year, 9, 23), end_date: Date.new(today.year, 12, 21) }
    }

    season = seasons.detect { |_, dates| (dates[:start_date]..dates[:end_date]).cover?(today) }
    {
      name: season&.first&.capitalize,
      start_date: season&.last&.[](:start_date),
      end_date: season&.last&.[](:end_date)
    }
  end
end
