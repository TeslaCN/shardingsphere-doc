echo config user kimmking
git config --global user.email "kimmking@163.com"
git config --global user.name "kimmking"

count=0
export TZ="Asia/Shanghai"

#######################################
##        SHARDINGSPHERE/DOCS        ##
#######################################
echo "[1] ====>>>> process shardingsphere/docs"
echo git clone https://github.com/apache/shardingsphere

git clone https://github.com/apache/shardingsphere _shardingsphere 

echo check diff
if  [ ! -s old_version_ss ]  ; then
    echo init > old_version_ss 
fi
cd _shardingsphere
git log -1 -p docs > new_version_ss
diff ../old_version_ss new_version_ss > result_version
if  [ ! -s result_version ]  ; then
    echo "shardingsphere docs sources didn't change and nothing to do!"
    cd ..
    rm -rf _shardingsphere
else
    count=1
    echo "check shardingsphere something new, launch a build..."
    cd ..
    rm -rf old_version_ss
    mv _shardingsphere/new_version_ss ./old_version_ss
    
    cp -rf _shardingsphere/docs ./
    rm -rf _shardingsphere
    mv docs ssdocs
    
    echo build hugo ss documents
    sh ./ssdocs/build.sh
    cp -rf ssdocs/target ./
    rm -rf ssdocs
    mv target sstarget
    
    echo replace old files
    # Overwrite HTLM files
    echo copy document/current to dest dir
    if [ ! -d "document/current"  ];then
      mkdir -p document/current
    else
      echo document/current  exist
      rm -rf document/current/*
    fi
    cp -fr sstarget/document/current/* document/current
    
    echo copy community to dest dir
    if [ ! -d "community"  ];then
      mkdir -p community
    else
      echo community  exist
      rm -rf community/*
    fi
    cp -fr sstarget/community/* community
    
    echo copy blog to dest dir
    if [ ! -d "blog"  ];then
      mkdir -p blog
    else
      echo blog  exist
      rm -rf iblog/*
    fi
    cp -fr sstarget/blog/* blog
    
    rm -rf sstarget
fi

#######################################
##  SHARDINGSPHERE-ELASTICJOB/DOCS   ##
#######################################
echo "[2] ====>>>> process shardingsphere-elasticjob/docs"
echo git clone https://github.com/apache/shardingsphere-elasticjob

git clone https://github.com/apache/shardingsphere-elasticjob _elasticjob 

echo check diff
if  [ ! -s old_version_ej ]  ; then
    echo init > old_version_ej 
fi
cd _elasticjob
git log -1 -p docs > new_version_ej
diff ../old_version_ej new_version_ej > result_version
if  [ ! -s result_version ]  ; then
    echo "elasticjob docs sources didn't change and nothing to do!"
    cd ..
    rm -rf _elasticjob
else
    count=2
    echo "check elasticjob something new, launch a build..."
    cd ..
    rm -rf old_version_ej
    mv _elasticjob/new_version_ej ./old_version_ej
    
    mkdir ejdocs
    cp -rf _elasticjob/docs/* ./ejdocs
    rm -rf _elasticjob
    
    echo build hugo elasticjob documents
    sh ./ejdocs/build.sh
    mkdir ejtarget
    cp -rf ejdocs/public/* ./ejtarget
    rm -rf ejdocs
    
    echo replace old files
    # Overwrite HTLM files
    echo copy elasticjob/current to dest dir
    if [ ! -d "elasticjob/current"  ];then
      mkdir -p elasticjob/current
    else
      echo elasticjob/current  exist
      rm -rf elasticjob/current/*
    fi
    cp -fr ejtarget/* elasticjob/current
    
    rm -rf ejtarget
    ls -al
fi

if [ $count -eq 0 ];then
    echo "Both ShardingSphere&ElasticJob docs are not Changed, Skip&Return now."
else
    exit 0
    echo git push new files
    git add .
    export TZ="Asia/Shanghai"
    dateStr=`date "+%Y-%m-%d %H:%M:%S %Z"`
    git commit -m  "Update shardingsphere documents at $dateStr."
    git push
fi
