FROM trinhpham/docker-ubuntu-with-mirror:latest

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    wget \
    make \
    libgtk2.0-0 && \
    apt clean all

ADD auto-install.xml ./
ADD build.sh /

RUN wget http://www.ac6-tools.com/downloads/SW4STM32/install_sw4stm32_linux_64bits-latest.run && \
    chmod a+x install_sw4stm32_linux_64bits-latest.run && \
    mkdir -p /usr/local/OpenStm32/ && \
    ./install_sw4stm32_linux_64bits-latest.run -f auto-install.xml

RUN PLUGIN_PATH=`find /usr/local/OpenStm32/plugins -maxdepth 1 -type d -name 'fr.ac6.mcu.externaltools.arm-none.linux64*' -print -quit` && \
    MCU_PATH=`find ${PLUGIN_PATH}/tools -maxdepth 1 -type f -name 'st-gnu-arm-gcc*' -print -quit` && \
    tar -jxvf $MCU_PATH -C ${PLUGIN_PATH}/tools

WORKDIR /workspace

CMD [ "/build.sh"]
