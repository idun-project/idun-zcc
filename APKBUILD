# Maintainer: Brian Holdsworth <brian@focus42llc.com>
pkgname=idun-zcc
pkgver=2.3
pkgrel=0
pkgdesc="Developement kit for Z80 computers"
arch="aarch64"
url="http://github.com/idun-project/idun-zcc"
license="ClArtistic"
depends="libxml2"
makedepends="gmp-dev gmp-static libxml2-dev libxml2-static perl-app-cpanminus perl-dev"
source="z88dk-src-${pkgver}.tgz"
options="!check"

prepare() {
  cp build.sh "${srcdir}/z88dk/"
  cp z88dk.sh "${srcdir}/z88dk/"
  tar xfz c128_libs_includes.tgz -C "${srcdir}/z88dk/" --overwrite 
  sudo cpanm Modern::Perl CPU::Z80::Assembler
}

build() {
  cd "${srcdir}/z88dk"

  export PATH="${srcdir}/z88dk"/bin:$PATH
  export ZCCCFG="${srcdir}/z88dk"/lib/config
  export Z80_OZFILES="${srcdir}/z88dk"/lib/
  export MAKEFLAGS="-j1"
  ./build.sh -C -l
  ./build.sh -p c128
  ./build.sh -p cpm
}

package() {
  cd "${srcdir}/z88dk"
  make -C libsrc PREFIX="/usr" DESTDIR="${pkgdir}" install
  make PREFIX="/usr" DESTDIR="${pkgdir}" install

  # Uncomment for a cleaner install directory - no functionality will be lost
  rm -rf ${pkgdir}/usr/share/z88dk/libsrc/target/{zx,zxn,ts2068}/newlib/obj
  rm -rf ${pkgdir}/usr/share/z88dk/libsrc/target/zx-common/fcntl/esxdos/obj
  rm -rf ${pkgdir}/usr/share/z88dk/libsrc/target/zx/fzx/obj/{z80,z80n}

  install -dm755 ${pkgdir}/etc/profile.d/
  install -m644 ${srcdir}/z88dk/z88dk.sh ${pkgdir}/etc/profile.d/
  # Include docs
  install -dm755 ${pkgdir}/usr/share/doc/z88dk
  install -dm755 ${pkgdir}/usr/share/doc/z88dk/images
  install -dm755 ${pkgdir}/usr/share/doc/z88dk/resources
  install -dm755 ${pkgdir}/usr/share/doc/z88dk/target/gl
  install -dm755 ${pkgdir}/usr/share/doc/z88dk/features
  find doc/* -not \( -path doc/netman -prune \) -not \( -path doc/images -prune \) \
       -not \( -path doc/resources -prune \) -not \( -path doc/target -prune \) \
       -not \( -path doc/features -prune \) | xargs -i install -m644 "{}" \
       "${pkgdir}/usr/share/doc/z88dk"
  find doc/images/* | xargs -i install -m644 "{}" "${pkgdir}/usr/share/doc/z88dk/images"
  find doc/resources/* | xargs -i install -m644 "{}" "${pkgdir}/usr/share/doc/z88dk/resources"
  find doc/target/gl/* | xargs -i install -m644 "{}" "${pkgdir}/usr/share/doc/z88dk/target/gl"
  find doc/features/* | xargs -i install -m644 "{}" "${pkgdir}/usr/share/doc/z88dk/features"

  # License
  install -D -m755 LICENSE "${pkgdir}/usr/share/licenses/z88dk/LICENSE"
}
sha512sums="
8781502161a568cc23e42c97de54e87775c31e9e0bf7a4993cb63900d6f940d58755a41f1bbf456d3340a25d704db108df8fbafd79deb845cd16d055448d2399  z88dk-src-2.3.tgz
"
