require 'libnotify'

def countdown(t)
  while t > 0
    mins, secs = t.divmod(60)
    timer = format("%02d:%02d", mins, secs)
    print(timer + "\r")
    $stdout.flush
    sleep(1)
    t -= 1
  end

  # Notificação com alerta sonoro
  Libnotify.show(
    :body => "Seu tempo acabou!!\n",
    :timeout => 2, # Tempo de exibição da notificação em segundos
    :urgency => :critical # Nível de urgência (pode variar)
  )

  # Tocar um som de notificação (ajuste o caminho conforme necessário)
  system("paplay /usr/share/sounds/freedesktop/stereo/complete.oga")
end

def main()
  system("clear")
  4.times do
    print("TEMPO DE FOCO (em minutos) => ")
    foco = gets.chomp.to_f
    print("TEMPO DE PAUSA (em minutos) => ")
    reset = gets.chomp.to_f

    t_foco = (foco * 60).to_i
    t_reset = (reset * 60).to_i

    puts("\nIniciando #{foco} minutos de foco!")
    countdown(t_foco)

    puts("\nFim do tempo de foco. Hora de uma pausa de #{reset} minutos!")
    countdown(t_reset)
  end
  puts("\nPomodoro concluído!")
end

if __FILE__ == $0
  main()
end
