@Grab(group = 'com.sparkjava', module = 'spark-core', version = '2.1')
import static spark.Spark.*
import javax.servlet.http.HttpServletResponse;


port(8080)



get '/', { req, res ->

  def text=new StringBuilder('Hello from Groovy Server 2!')
   req.cookies().each{
     text<<"<br/> $it"
   }

  return text.toString()
}

get '/login', { req, res ->
  println "test 0"
  res.status(HttpServletResponse.SC_OK)
  def text=new StringBuilder('login!!')
  req.cookies().each{
    text<<"<br/> $it"
  }
  println "test 1"
  res.cookie("shopware_sso_token", "bar", 3600, true);
  println "test 2"

  return text.toString()
}

get '/status', { req, res ->
  res.status(HttpServletResponse.SC_OK)
  def text=new StringBuilder('status!!')
   req.cookies().each{
     text<<"<br/> $it"
   }

  return text.toString()
}

get '/ret200', { req, res ->
  res.status(HttpServletResponse.SC_OK)
  def text=new StringBuilder('OK!!')
   req.cookies().each{
     text<<"<br/> $it"
   }

  return text.toString()
}


get '/ret401', { req, res ->
  res.status(HttpServletResponse.SC_UNAUTHORIZED)

  def text=new StringBuilder('error 401')
   req.cookies().each{
     text<<"<br/> $it"
   }

  return text.toString()
}
