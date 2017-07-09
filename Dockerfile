FROM tim03/libffi:3.2.1
LABEL maintainer Chen, Wenli <chenwenli@chenwenli.com>

WORKDIR /usr/src
ADD https://www.python.org/ftp/python/2.7.13/Python-2.7.13.tar.xz .
COPY md5sums .
RUN md5sum -c md5sums
RUN \
	tar xvf Python-2.7.13.tar.xz && \
	mv -v Python-2.7.13 Python && \
	pushd Python && \
	./configure --prefix=/usr       \
            --enable-shared     \
            --with-system-expat \
            --with-system-ffi   \
            --with-ensurepip=yes \
            --enable-unicode=ucs4 && \
	make -j"$(nproc+1)" && \
	(make -k test || true) && \
	make install && \
	chmod -v 755 /usr/lib/libpython2.7.so.1.0 && \
	popd && \
	rm -rf Python
	
