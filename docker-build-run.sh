# 환경변수 셋팅
# JWT가 필요없는 경우, 이미지 실행 부분의 환경 변수 입력 부분도 수정 필요함.
export APP_BASE_URL='https://explorer.chainz.biz'
#export APP_NODE_URL='https://public.batan.bchub.io'
export APP_NODE_URL='https://besu.chainz.network'
export APP_NODE_JWT='eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJwZXJtaX..........P9ofhoQ'
IMG_NAME='chainz-explorer'
IMG_TAG=$IMG_NAME':0.6'

EXPLORER_NAME='mainnet-'$IMG_NAME

# 라이브러리? 확인 및 준비
if [ ! -f ./config.chainz.docker.json ]; then
    echo "not found './config.chainz.docker.json'"
    exit
fi
if [ ! -f ../explorer-core-plugins/packages/eth-common/package.json ]; then
    echo "not found '../explorer-core-plugins/packages/eth-common'"
    exit
fi
if [ ! -f ../explorer-core-plugins/packages/eth-lite/package.json ]; then
    echo "not found '../explorer-core-plugins/packages/eth-lite'"
    exit
fi

if [ -d ./packages ]; then
    echo "found './packages'"
    rm -dr ./packages
fi
echo 'Copy'
cp -R ../explorer-core-plugins/packages .

# 이미지 생성
echo 'Docker build'
docker build -t $IMG_TAG -f ./Dockerfile-ethlite .

echo 'Docker run'
ENV_STR="APP_BASE_URL:$APP_BASE_URL APP_NODE_URL:$APP_NODE_URL APP_NODE_JWT:$APP_NODE_JWT"
echo 'ENV: '$ENV_STR
echo 'TAG: '$IMG_TAG

# 이미지 실행
#docker run --name $EXPLORER_NAME -e APP_NODE_URL -e APP_BASE_URL -p 80:80 $IMG_TAG
#docker run --name $EXPLORER_NAME -e APP_NODE_URL -e APP_NODE_JWT -p 80:80 $IMG_TAG
docker run --name $EXPLORER_NAME -e APP_BASE_URL -e APP_NODE_URL -e APP_NODE_JWT -p 80:80 $IMG_TAG

