CPP             = g++
RM              = rm -f
CPP_FLAGS       = -Wall -c -I. -O2 -std=c++11 -I/usr/include/x86_64-linux-gnu -ldl -lm -DU_USING_ICU_NAMESPACE=0 -shared

PREFIX			= /usr
#Edit these lines to correspond with your own directories
LIBRARY_DIR		= $(shell ${PHP_CONFIG} --extension-dir)
PHP_CONFIG_DIR	= /etc/php5/cli/conf.d

LD              = g++
LD_FLAGS        = -Wall -shared -O2 
RESULT          = intl_dtpg.so

PHPINIFILE		= 42-intl_dtpg.ini

SOURCES			= $(wildcard *.cpp)
OBJECTS         = $(SOURCES:%.cpp=%.o)

all:	${OBJECTS} ${RESULT}

${RESULT}: ${OBJECTS}
		${LD} ${LD_FLAGS} -o $@ ${OBJECTS} -lphpcpp -licuio -licui18n -licuuc -licudata

clean:
		${RM} *.obj *~* ${OBJECTS} ${RESULT}

${OBJECTS}: 
		${CPP} ${CPP_FLAGS} -fpic -o $@ ${@:%.o=%.cpp}

install:
		cp -f ${RESULT} ${LIBRARY_DIR}
		cp -f ${PHPINIFILE}	${PHP_CONFIG_DIR}
