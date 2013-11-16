def mean(x)
  sum=0
  x.each {|v| sum += v}
  sum/x.size
end

def hmean(x)
  sum=0
  x.each {|v| sum += (1.0/v)}
  x.size/sum
end

def gmean(x)
  prod=1.0
  x.each {|v| prod *= v}
  prod**(1.0/x.size)
end

def median(x)
  sorted = x.sort
  mid = x.size/2
  sorted[mid]
end

def mode(x)
  f = {}   # Таблица частот.
  fmax = 0 # Максимальная частота.
  m = nil  # Мода.
  x.each do |v|
    f[v] ||= 0
    f[v] += 1
    fmax,m = f[v], v if f[v] > fmax
  end

  return m
end

def variance(x)
  m = mean(x)
  sum = 0.0
  x.each {|v| sum += (v-m)**2 }
  sum/x.size
end

def sigma(x)
  Math.sqrt(variance(x))
end


def correlate(x,y)
  sum = 0.0
  x.each_index do |i|
    sum += x[i]*y[i]
  end

  xymean = sum/x.size.to_f
  xmean = mean(x)
  ymean = mean(y)
  sx = sigma(x)
  sy = sigma(y)
  (xymean-(xmean*ymean))/(sx*sy)
end
