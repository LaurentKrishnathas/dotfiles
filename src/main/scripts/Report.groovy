
import jenkins.model.Jenkins

def printlnRed(def text){
	println "\033[31m$text\033[0m" 
}

def printlnGreen(def text){
	println "\033[32m$text\033[0m" 
}

def isFailed(def job){
	job.lastBuild != null && job.lastBuild.result == hudson.model.Result.FAILURE
}

def isSuccess(def job){
	job.lastBuild != null && job.lastBuild.result == hudson.model.Result.SUCCESS
}

List list=Jenkins.instance.allItems.collect{it.allJobs}.flatten()

//filtering
list=list.findAll{job->!job.name.startsWith("z") && !job.name.startsWith("queue") && !job.name.startsWith("template")}
if(args.length>0){
	List tmpList=[]
	args.each{pattern->
		tmpList<<list.findAll{it.name.contains(pattern)}
	}
	list=tmpList.flatten()
}

list.each{job->
	def status=""
	def preStatus=""
	
	if(job.building){
		status="BUIDING"
	}else if(job.inQueue){
		status="INQUEUE"
	}
	
	if(job.lastBuild != null){
		preStatus=job.lastBuild.result
	}

	def text="$job.name, prestatus: $preStatus, status: $status"

	if(isFailed(job)){
		printlnRed text
	}else if(isSuccess(job)) {
		printlnGreen text
	}else{
		println text
	}
}
// println("ssss \033[31mRed.   \033[32m, Green.    \033[33m, Yellow.     \033[34m, Blue.     \033[0m");








