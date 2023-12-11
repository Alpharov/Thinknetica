require_relative 'trains/train'
require_relative 'trains/cargo_train'
require_relative 'trains/passenger_train'
require_relative 'wagons/wagon'
require_relative 'wagons/cargo_wagon'
require_relative 'wagons/passenger_wagon'
require_relative 'route'
require_relative 'station'

class Main

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
      @trains[train_index].add_wagon(PassengerWagon.new)
    else
      @trains[train_index].add_wagon(CargoWagon.new)
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
      puts "Станция #{station.name}"
      puts "Поезда на станции #{station.name}"
      station.trains.each do |train|
        train_pretty_type(train)
      end
    end
  end

  def train_pretty_type(train)
    if (train.type == :passenger)
      puts "#{train} - пассажирский"
    else
      puts "#{train} - грузовой"
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
end

Main.new.start
