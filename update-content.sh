#!bin/bash 
blogHome=/data/blog
gitLog=/tmp/gitlog.txt
update_code(){
    cd ${blogHome} && git pull origin master 
    git_commit=$(git log|grep -Eo [a-Z,0-9]{40}|head -1)
    pkg_stat=$(grep ${git_commit} ${gitLog}|wc -l)
    if [ ${pkg_stat} -ne 1 ]
        then
            docker-compose up -d allmark
            docker-compose restart allmark
            echo ${git_commit} >> ${gitLog}
    fi
}
update_code
