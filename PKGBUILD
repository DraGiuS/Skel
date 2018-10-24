# Maintainer: Yosh <christophe.ribots@gmail.com>

_pkgbase='citra-valentin'
pkgbase="$_pkgbase-git"
pkgname=("$_pkgbase-git")
pkgver=r8938.47f41c2f4
pkgrel=1
pkgdesc="An experimental open-source Nintendo 3DS emulator/debugger,valentinvanellslande fork"
arch=('i686' 'x86_64')
url="https://valentinvanelslande.github.io/citra"
license=('GPL2')
makedepends=('git' 'cmake' 'sdl2' 'qt5-base' 'shared-mime-info' 
'desktop-file-utils' 'qt5-multimedia' 'qt5-wayland')
source=("$_pkgbase::git+https://github.com/DraGiuS/citra")
md5sums=('SKIP')

pkgver() {
	cd "$srcdir/$_pkgbase"
	echo "r$(git rev-list --count HEAD).$(git rev-parse --short HEAD)"
}

prepare() {
	cd "$srcdir/$_pkgbase"
	mkdir -p build

	git submodule init
	git submodule update --init --recursive
}

build() {
	cd "$srcdir/$_pkgbase/build"
	cmake .. \
	  -DCMAKE_INSTALL_PREFIX=/usr \
	  -DCMAKE_BUILD_TYPE=Release \
	  -DUSE_DISCORD_PRESENCE=ON \
          -DUSE_SYSTEM_CURL=ON
	make -j5
}

package_citra-valentin-git() {
	depends=('sdl2' 'libpng')

	install -Dm755 "$srcdir/$_pkgbase/build/bin/citra" "$pkgdir/usr/bin/citra"

	cd "$srcdir/$_pkgbase/build"
	make DESTDIR="$pkgdir/" install
        install -dm755 "${pkgdir}/usr/share/applications"
        install -dm755 "${pkgdir}/usr/share/icons"
	cp -r "${srcdir}/citra-valentin/dist/citra.desktop" "${pkgdir}/usr/share/applications/"
}

