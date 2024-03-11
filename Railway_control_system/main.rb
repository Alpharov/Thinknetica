require_relative 'modules/company_manufacture'
require_relative 'modules/validation'
require_relative 'modules/instance_counter'
require_relative 'trains/train'
require_relative 'trains/cargo_train'
require_relative 'trains/passenger_train'
require_relative 'wagons/wagon'
require_relative 'wagons/cargo_wagon'
require_relative 'wagons/passenger_wagon'
require_relative 'route'
require_relative 'station'


class Main

  include CompanyManufacture
  include InstanceCounter
  include Validation

  
  def initialize
    @stations = []
    @trains = []
    @routes = []
  end

  def start
    loop do
      show_menu
      input = gets.chomp
      choice(input)
      break if input == '0'
    end
  end

  private

  def show_menu
    puts "Нажмите '0' чтобы выйти"
    puts "Нажмите '1' чтобы создать станцию"
    puts "Нажмите '2' чтобы создать поезд"
    puts "Нажмите '3' чтобы создать маршрут"
    puts "Нажмите '4' чтобы удалить или добавить станцию в маршрут"
    puts "Нажмите '5' чтобы назначить маршрут поезду"
    puts "Нажмите '6' чтобы добавить вагон к поезду"
    puts "Нажмите '7' чтобы отцепить вагон у поезда"
    puts "Нажмите '8' чтобы переместить поезд"
    puts "Нажмите '9' чтобы просмотреть станции и поезда на них"
    puts "Нажмите '10' чтобы просмотреть вагоны у поездов"
    puts "Нажмите '11' чтобы занять место в вагоне"
  end

  def choice(input)
    case input
    when '0'
      puts "До свидания!"
    when '1'
      create_station
    when '2'
      create_train
    when '3'
      create_route
    when '4'
      station_actions
    when '5'
      add_route_to_train
    when '6'
      add_wagon_to_train
    when '7'
      remove_wagon_from_train
    when '8'
      move_train
    when '9'
      check_stations
    when '10'
      check_wagons
    when '11'
      take_in_wagon
    end
  end

  def create_station
    puts "Введите название станции: "
    name = gets.chomp
    @stations << Station.new(name)
  end

  def create_train
    puts "Нажмите 1 чтобы создать грузовой поезд, 2 чтобы пассажирский: "
    type = gets.chomp
    puts "Ввведите номер поезда: "
    number = gets.chomp
    if (type == '1')
      @trains << CargoTrain.new(number)
    elsif (type == '2')
      @trains << PassengerTrain.new(number)
    else
      puts "К сожалению, поезд не удалось создать."
    end
  end

  def create_route
    if (@stations.size < 2)
      puts "Невозможно создать маршрут"
    else
      puts "Выберите начальную станцию: "
      show_stations
      start_station = gets.chomp.to_i

      puts "Веберите конечную станцию: "
      show_stations
      end_station = gets.chomp.to_i

      @routes << Route.new(@stations[start_station], @stations[end_station] )
      puts "Маршрут успешно создан!"
    end
  end


  def station_actions
  	if @routes.empty?
  		puts "Маршрутов нет."
  	else
  		puts "В какой маршрут вы хотите внести изменения?"
  		show_routes
  		route = gets.chomp.to_i
  		puts "Добавить(1) или удалить(2) станцию:"
  		choice = gets.chomp.to_i
  		show_stations
  		if (choice == 1)
  			puts "Какую станцию добавить?"
  			show_stations
  			choice_station = gets.chomp.to_i
  			@routes[route].add_station( @stations[choice_station] )
  		elsif (choice == 2)
  			count = 0
  			puts "Какую станцию удалить?"
  			@routes[route].stations.each do |station|
  				puts "#{station.name} - #{count}"
  				count += 1
  			end
  			delete_station = gets.chomp.to_i
  			@routes[route].delete_station(@stations[delete_station])
  		else
  			"Данные неверны."
  		end
  	end
  end

  def add_route_to_train
    if @trains.empty? || @routes.empty?
      puts "Нет доступных поездов или маршрутов"
    else
      puts "Выберите поезд:"
      show_trains
      train_index = gets.chomp.to_i

      puts "Выберите маршрут:"
      show_routes
      route_index = gets.chomp.to_i

      if @trains[train_index].respond_to?(:set_route)
        @trains[train_index].set_route(@routes[route_index])
        puts "Маршрут успешно назначен поезду."
      else
        puts "Этот тип поезда не поддерживает назначение маршрута."
      end
    end
  end

  def add_wagon_to_train
  	if @trains.empty?
    	puts "Нет доступных поездов."
  	else
    	puts "Выберите поезд:"
    	show_trains
    	train_index = gets.chomp.to_i
    end

    	wagon_type = nil
    loop do
      puts "Выберите тип вагона (1 - Пассажирский, 2 - Грузовой):"
      wagon_type = gets.chomp.to_i
      break if [1, 2].include?(wagon_type)
      puts "Некорректный ввод."
    end

    if wagon_type == 1
      puts "Укажите максимальное количество мест"
      places = gets.chomp.to_i
      @trains[train_index].add_wagon(PassengerWagon.new(places))
    else
      puts "Введите максимальный объём"
      volume = gets.chomp.to_i
      @trains[train_index].add_wagon(CargoWagon.new(volume))
    end

    puts "Вагон успешно добавлен к поезду."
  end


  def remove_wagon_from_train
  	if @trains.empty?
  		puts "Нет доступных поездов."
  	else
  		puts "Выберите поезд:"
  		show_trains
  		train_index = gets.chomp.to_i

  		if @trains[train_index].wagons.empty?
  			puts "У поезда нет вагонов для отсоединения."
  		else
  			@trains[train_index].remove_wagon
  			puts "Вагон успешно отсоединен от поезда."
  		end
  	end
  end

  def move_train
  	if @trains.empty?
    	puts "Нет доступных поездов."
  	else
    	puts "Выберите поезд:"
    	show_trains
    	train_index = gets.chomp.to_i
    end

    if @trains[train_index].route.nil?
      puts "У поезда нет маршрута."
    else
      direction = nil
      loop do
        puts "Выберите направление движения (1 - Вперед, 2 - Назад):"
        direction = gets.chomp.to_i
        break if [1, 2].include?(direction)
        puts "Некорректный ввод. Попробуйте снова."
      end

      if direction == 1
        @trains[train_index].move_forward
      else
        @trains[train_index].move_backward
      end

      puts "Поезд перемещен по маршруту."
    end
  end


  def check_stations
    @stations.each do |station|
      station.each_train do |train|
       puts "Станция #{station.name}"
       puts "Номер поезда - #{train.car_number}, тип - #{train_pretty_type(train)}, кол-во вагонов - #{train.wagons.size}"
      end
    end
  end

  def train_pretty_type(train)
    if (train.type == :passenger)
      "пассажирский"
    else
      "грузовой"
    end
  end

  def show_stations
    @stations.each_with_index do |station, index|
      puts "#{station.name} - #{index}"
    end
  end

  def show_trains
    @trains.each_with_index do |train, index|
      train_type = train.is_a?(PassengerTrain) ? 'Пассажирский' : 'Грузовой'
      car_number = train.car_number ? train.car_number : 'Нет номера'
      puts "#{train_type} поезд #{car_number} - #{index}"
    end
  end

  def show_routes
    @routes.each_with_index do |route, index|
      puts "#{route} - #{index}"
    end
  end

  def check_wagons
    number = 0
    @trains.each do |train|
      train.each_wagon do |wagon|
        puts "Номер вагона - #{number}, тип - #{wagon.type}, свободно место - #{wagon.free_place}"
        number += 1 
      end
    end
  end

def take_in_wagon
    puts 'В каком поезде вы хотите занять место в вагоне?'
    if @trains.empty?
      puts "Нет доступных поездов."
    else
      puts "Выберите поезд:"
      show_trains
      train_index = gets.chomp.to_i
      train = @trains[train_index]
    end
    
    puts 'Какой вагон?'
    number = 0
    train.each_wagon do |wagon|
      puts "#{number} - #{wagon}"
      number += 1
    end
    choice = gets.chomp.to_i
    wagon = train.wagons[choice]
    if wagon.type == :cargo
      puts "В данном вагоне свободно #{wagon.free_place} от общего объема в #{wagon.total_place}"
      puts 'Сколько объема вы хотите занять?'
      volume = gets.chomp.to_i
      if wagon.free_place >= volume
        wagon.take_place(volume)
        puts "Вы успешно заняли вагон на #{volume}!"
        puts "Загруженность вагона составляет #{wagon.used_place} из #{wagon.total_place}!"
      else
        puts 'Вы не можете занять больше объема чем столько, насколько расчитан вагон!'
      end
      puts 'Вагон уже полностью загружен!' if wagon.free_place.zero?
    elsif wagon.type == :passenger
      puts "В данном вагоне свободно #{wagon.free_place} мест"
      wagon.take_place
      puts "Вы успешно заняли место, в вагоне осталось #{wagon.free_place} свободных мест!"
    end
  end

end

Main.new.start
