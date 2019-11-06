# Use this ubuntu for better apt downloading speed
FROM trinhpham/docker-ubuntu-with-mirror:latest

# Install all needed libraries to run
RUN apt-get update && \
    apt-get install -qqy --no-install-recommends \
    build-essential \
    wget \
    make \
    libgtk2.0-0 && \
    apt clean all

# Create all required folders
RUN mkdir -p /workspace/configuration/ && \
    mkdir -p /usr/local/OpenStm32/

# Add the auto installation script of OpenStm32
ADD auto-install.xml ./

# Add workspace customized configurations
#   + Not auto build on importing project
ADD st_pref.ini /workspace/configuration/

# Add our main build script
ADD build.sh /

# Download the latest OpenStm32
RUN wget -q --show-progress --progress=bar:force:noscroll --no-check-certificate https://www.ac6-tools.com/downloads/SW4STM32/install_sw4stm32_linux_64bits-latest.run && \
    chmod a+x install_sw4stm32_linux_64bits-latest.run

# Silently install OpenStm32 using previous auto installation script
RUN ./install_sw4stm32_linux_64bits-latest.run -f auto-install.xml

# As MCU toolchain is only extracted automatically when using GUI
# Headless build would fail unless we help to extract it into the correct place
RUN PLUGIN_PATH=`find /usr/local/OpenStm32/plugins -maxdepth 1 -type d -name 'fr.ac6.mcu.externaltools.arm-none.linux64*' -print -quit` && \
    MCU_PATH=`find ${PLUGIN_PATH}/tools -maxdepth 1 -type f -name 'st-gnu-arm-gcc*' -print -quit` && \
    tar -jxvf $MCU_PATH -C ${PLUGIN_PATH}/tools && \
    mv `find ${PLUGIN_PATH}/tools -maxdepth 1 -type d -name 'st-gnu-arm-gcc*' -print -quit` ${PLUGIN_PATH}/tools/compiler

WORKDIR /workspace

CMD [ "/build.sh"]
