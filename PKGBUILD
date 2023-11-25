# Maintainer: Brian Holdsworth
pkgname=idun-zcc
pkgver=2.2
pkgrel=1
pkgdesc="Developement kit for Z80 computers"
arch=('x86_64' 'armv7h')
url="http://github.com/idun-project/idun-zcc"
license=('custom:The Clarified Artistic License')
depends=('libxml2')
makedepends=('ccache' 're2c' 'ragel' 'perl' 'cpanminus' 'perl-yaml-tiny' 'perl-path-tiny' 'perl-clone' 'dos2unix')
backup=(etc/profile.d/z88dk.sh)
source=(https://github.com/z88dk/z88dk/releases/download/v${pkgver}/z88dk-src-${pkgver}.tgz
        z88dk.sh
        build.sh
        c128_libs_includes.tgz)
sha256sums=('942aef3f5c55209a76925c8df681271e8340cf6623bedcb5a2933d4024657a41'
            '4eef7c67e5b142db3006a4076876cdae9f386a7b94a66841a5a8fac869bea156'
            '0d92ce58ed6766fbe5051c604fcdff60baaf892166fe0170d5cdd83b36bd34e7'
            'SKIP')
install=update_bashrc.sh

prepare() {
  cp -u build.sh "${srcdir}/z88dk/"
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
  make -C libsrc prefix="/usr" DESTDIR="${pkgdir}/usr" install
  make prefix="/usr" DESTDIR="${pkgdir}/usr" install

  # Uncomment for a cleaner install directory - no functionality will be lost
  rm -rf ${pkgdir}/usr/share/z88dk/libsrc/target/{zx,zxn,ts2068}/newlib/obj
  rm -rf ${pkgdir}/usr/share/z88dk/libsrc/target/zx-common/fcntl/esxdos/obj
  rm -rf ${pkgdir}/usr/share/z88dk/libsrc/target/zx/fzx/obj/{z80,z80n}

  install -dm755 ${pkgdir}/etc/profile.d/
  install -m644 ${srcdir}/z88dk.sh ${pkgdir}/etc/profile.d/
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
