
npm run build-dev

if [ ! -f ../explorer-core-plugins/packages/eth-common/package.json ]; then
    echo "not found '../explorer-core-plugins/packages/eth-common'"
    exit
fi
if [ ! -f ../explorer-core-plugins/packages/eth-lite/package.json ]; then
    echo "not found '../explorer-core-plugins/packages/eth-lite'"
    exit
fi

# acp install대신 acp link를 사용하려면, config.dev.json의 라이브러리 버전정보를 지워야함.
acp link \
     ../explorer-core-plugins/packages/eth-common \
     ../explorer-core-plugins/packages/eth-lite

# 아래처럼 repository 라이브러리에 대해 acp install을 사용하려면, 
# config.dev.json의 라이브러리 버전정보를 지워야함.
# acp install --dev \
#     @alethio/explorer-plugin-3box \
#     @alethio/explorer-plugin-eth-ibft2
acp install --dev @alethio/explorer-plugin-eth-ibft2

npm start
