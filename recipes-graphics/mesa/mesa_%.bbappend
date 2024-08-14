DEPENDS += "libvdpau"

PROVIDES += "libegl"

PACKAGECONFIG_x86 = " osmesa opengl dri3 xa r600 gallium gallium-llvm "
PACKAGECONFIG_x86-64 = " osmesa opengl dri3 xa r600 gallium gallium-llvm "

PACKAGECONFIG:append = " gbm egl gles dri \
                ${@bb.utils.contains('DISTRO_FEATURES', 'x11', 'x11', '', d)}\
                ${@bb.utils.contains('DISTRO_FEATURES', 'wayland', 'wayland', '', d)}\
                " 


GALLIUMDRIVERS:append:armv7a = ",freedreno"
GALLIUMDRIVERS:append:aarch64 = ",freedreno"

PACKAGECONFIG:append:armv7a = " gallium \
                         ${@bb.utils.contains('DISTRO_FEATURES', 'x11', 'xa', '', d)} \
                       "
PACKAGECONFIG:append:aarch64 = " gallium \
                         ${@bb.utils.contains('DISTRO_FEATURES', 'x11', 'xa', '', d)} \
                       "

EXTRA_OECONF += "ac_cv_path_ac_pt_LLVM_CONFIG=${STAGING_BINDIR_CROSS}/llvm-config"

FILES_${PN}-dbg += "${libdir}/vdpau/.debug"
FILES_${PN}-dev += "${libdir}/vdpau/*.so"

FILES_mesa-megadriver += "${libdir}/vdpau/*.so.*"

