Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 317853D4FE3
	for <lists+linux-nfs@lfdr.de>; Sun, 25 Jul 2021 22:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbhGYTuN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 25 Jul 2021 15:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbhGYTuN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 25 Jul 2021 15:50:13 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37208C061757
        for <linux-nfs@vger.kernel.org>; Sun, 25 Jul 2021 13:30:43 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id i39-20020a9d17270000b02904cf73f54f4bso6104837ota.2
        for <linux-nfs@vger.kernel.org>; Sun, 25 Jul 2021 13:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2J3NMXkYptRaw/YXqza4EYHpdBv9ptv6anPg8Kz5q+0=;
        b=NJP2eMVa4NXutVST+Rn6rWWZZUmPvHxdZliNyEQvmUwU3aoat8fZD0zB/HypY+Fu8k
         oICPp34x10JizXe9Fp4L2fJ2MxS0n3PKJjfDVss3MyICiALIQYHLdvCpOAagRG4+hejt
         68ID1e53jy10A2PlPdy5MMh+5Ywd8rE5uUh6STQuelsWU2Lp3qP99IYcTasZTVNQ/TdP
         i7jYOXlO93fRQJPbDZ0bdcDhSHtE737Ms9T1HPzGt/ee/XCPaxv4GUqMlj6j/JZpXy9F
         PBOEQBX9uAJwei1mVvmih4PzmVCdknHGC+bIj9gq/FqQiK2+5hebZGa8m4DzE90pCYzR
         NHTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2J3NMXkYptRaw/YXqza4EYHpdBv9ptv6anPg8Kz5q+0=;
        b=fcnOCqUooR21EzTx2MrI5THc0bsgo/MrHFtgRpgih1MQ6mf6See71c96DWcYMQAy7X
         gdacSZTiJADuo4qvi88wIhjPRfp//Ka4wjW7xpM9Gl6aa+86mGGOdSSQ5bZaM1HTG8JW
         72nN5FrEPK5uY3wF8DLz1Qb2w8SvMVuafH2V3oQCwfCc+eLbCdYN/SgzgAhv2yoArAA0
         n7ffXTUjFxJNZ52uKG8gjlYx4EFZYsVB+o1gq6E4/CvAR+lsUqBqd5cVrv/jV6WBTdS6
         AQwYDjwn2cnctG0uxKqiPdVxz/161Ue1snzhgv/Bv3XNiqGrH93mVDcU40p/Wb81S410
         WtHg==
X-Gm-Message-State: AOAM531uc6BSiTueB87IUdfjIChtyzKiAVxfrV6j7MXBMsFC7ACjySnZ
        35iY5lYTZ5cai9LrlED7KSmt/1yPOnqzFpgj84c=
X-Google-Smtp-Source: ABdhPJxcJkPZehOsF9NvmAuCBtWAFzLwUeQaoCnrZFOLqza3Pk9BHmsE0uFBJ3eAU39Q/q6BkYt+JJ0DQknYTs6SjEo=
X-Received: by 2002:a9d:5f87:: with SMTP id g7mr7884374oti.278.1627245041993;
 Sun, 25 Jul 2021 13:30:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210712140634.4151943-1-james.hilliard1@gmail.com> <d899537a-1970-c076-c9b6-b358d6aa2798@redhat.com>
In-Reply-To: <d899537a-1970-c076-c9b6-b358d6aa2798@redhat.com>
From:   James Hilliard <james.hilliard1@gmail.com>
Date:   Sun, 25 Jul 2021 14:30:31 -0600
Message-ID: <CADvTj4pKn-o20s1FE8-=5Bwg9uJcLjUA_jAp9Jgg5x460ULm8A@mail.gmail.com>
Subject: Re: [PATCH 1/1] Fix non-default statedir paths.
To:     Steve Dickson <steved@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, Jul 25, 2021 at 10:10 AM Steve Dickson <steved@redhat.com> wrote:
>
> Hello,
>
> My apologies for taking so long to look as this
> patch...
>
> What problem are you solving with this patch?

The statedir path not being set everywhere needed, see:
https://github.com/clearlinux/distribution/issues/2249
https://github.com/clearlinux-pkgs/nfs-utils/commit/6c97e55ef83c1420e7d791c857ad94f2e8c27528

> Your patch description is a bit light. ;-)
>
> steved.
> On 7/12/21 10:06 AM, James Hilliard wrote:
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > ---
> >   configure.ac                                  | 19 +++++++++++++++++++
> >   systemd/Makefile.am                           |  5 ++++-
> >   systemd/rpc-pipefs-generator.c                |  2 +-
> >   systemd/rpc_pipefs.target                     |  3 ---
> >   systemd/rpc_pipefs.target.in                  |  3 +++
> >   ....mount => var-lib-nfs-rpc_pipefs.mount.in} |  2 +-
> >   utils/blkmapd/device-discovery.c              |  2 +-
> >   utils/gssd/gssd.h                             |  2 +-
> >   utils/idmapd/idmapd.c                         |  2 +-
> >   9 files changed, 31 insertions(+), 9 deletions(-)
> >   delete mode 100644 systemd/rpc_pipefs.target
> >   create mode 100644 systemd/rpc_pipefs.target.in
> >   rename systemd/{var-lib-nfs-rpc_pipefs.mount => var-lib-nfs-rpc_pipefs.mount.in} (84%)
> >
> > diff --git a/configure.ac b/configure.ac
> > index 93520a80..bc2d0f02 100644
> > --- a/configure.ac
> > +++ b/configure.ac
> > @@ -688,9 +688,28 @@ AC_SUBST([ACLOCAL_AMFLAGS], ["-I $ac_macro_dir \$(ACLOCAL_FLAGS)"])
> >   AC_SUBST([_sysconfdir])
> >   AC_CONFIG_COMMANDS_PRE([eval eval _sysconfdir=$sysconfdir])
> >
> > +# make _statedir available for substituion in config files
> > +# 2 "evals" needed late to expand variable names.
> > +AC_SUBST([_statedir])
> > +AC_CONFIG_COMMANDS_PRE([eval eval _statedir=$statedir])
> > +
> > +if test "$statedir" = "/var/lib/nfs"; then
> > +     rpc_pipefsmount="var-lib-nfs-rpc_pipefs.mount"
> > +else
> > +     rpc_pipefsmount="$(systemd-escape -p "$statedir/rpc_pipefs").mount"
> > +fi
> > +AC_SUBST(rpc_pipefsmount)
> > +
> > +# make _rpc_pipefsmount available for substituion in config files
> > +# 2 "evals" needed late to expand variable names.
> > +AC_SUBST([_rpc_pipefsmount])
> > +AC_CONFIG_COMMANDS_PRE([eval eval _rpc_pipefsmount=$rpc_pipefsmount])
> > +
> >   AC_CONFIG_FILES([
> >       Makefile
> >       systemd/rpc-gssd.service
> > +     systemd/rpc_pipefs.target
> > +     systemd/var-lib-nfs-rpc_pipefs.mount
> >       linux-nfs/Makefile
> >       support/Makefile
> >       support/export/Makefile
> > diff --git a/systemd/Makefile.am b/systemd/Makefile.am
> > index 650ad25c..8c7b676f 100644
> > --- a/systemd/Makefile.am
> > +++ b/systemd/Makefile.am
> > @@ -12,7 +12,9 @@ unit_files =  \
> >       rpc-statd-notify.service \
> >       rpc-statd.service \
> >       \
> > -    proc-fs-nfsd.mount \
> > +    proc-fs-nfsd.mount
> > +
> > +rpc_pipefs_mount_file = \
> >       var-lib-nfs-rpc_pipefs.mount
> >
> >   if CONFIG_NFSV4
> > @@ -75,4 +77,5 @@ genexec_PROGRAMS = nfs-server-generator rpc-pipefs-generator
> >   install-data-hook: $(unit_files)
> >       mkdir -p $(DESTDIR)/$(unitdir)
> >       cp $(unit_files) $(DESTDIR)/$(unitdir)
> > +     cp $(rpc_pipefs_mount_file) $(DESTDIR)/$(unitdir)/$(rpc_pipefsmount)
> >   endif
> > diff --git a/systemd/rpc-pipefs-generator.c b/systemd/rpc-pipefs-generator.c
> > index 8e218aa7..c24db567 100644
> > --- a/systemd/rpc-pipefs-generator.c
> > +++ b/systemd/rpc-pipefs-generator.c
> > @@ -21,7 +21,7 @@
> >   #include "conffile.h"
> >   #include "systemd.h"
> >
> > -#define RPC_PIPEFS_DEFAULT "/var/lib/nfs/rpc_pipefs"
> > +#define RPC_PIPEFS_DEFAULT NFS_STATEDIR "/rpc_pipefs"
> >
> >   static int generate_mount_unit(const char *pipefs_path, const char *pipefs_unit,
> >                              const char *dirname)
> > diff --git a/systemd/rpc_pipefs.target b/systemd/rpc_pipefs.target
> > deleted file mode 100644
> > index 01d4d278..00000000
> > --- a/systemd/rpc_pipefs.target
> > +++ /dev/null
> > @@ -1,3 +0,0 @@
> > -[Unit]
> > -Requires=var-lib-nfs-rpc_pipefs.mount
> > -After=var-lib-nfs-rpc_pipefs.mount
> > diff --git a/systemd/rpc_pipefs.target.in b/systemd/rpc_pipefs.target.in
> > new file mode 100644
> > index 00000000..332f62b6
> > --- /dev/null
> > +++ b/systemd/rpc_pipefs.target.in
> > @@ -0,0 +1,3 @@
> > +[Unit]
> > +Requires=@_rpc_pipefsmount@
> > +After=@_rpc_pipefsmount@
> > diff --git a/systemd/var-lib-nfs-rpc_pipefs.mount b/systemd/var-lib-nfs-rpc_pipefs.mount.in
> > similarity index 84%
> > rename from systemd/var-lib-nfs-rpc_pipefs.mount
> > rename to systemd/var-lib-nfs-rpc_pipefs.mount.in
> > index 26d1c763..4c5d6ce4 100644
> > --- a/systemd/var-lib-nfs-rpc_pipefs.mount
> > +++ b/systemd/var-lib-nfs-rpc_pipefs.mount.in
> > @@ -6,5 +6,5 @@ Conflicts=umount.target
> >
> >   [Mount]
> >   What=sunrpc
> > -Where=/var/lib/nfs/rpc_pipefs
> > +Where=@_statedir@/rpc_pipefs
> >   Type=rpc_pipefs
> > diff --git a/utils/blkmapd/device-discovery.c b/utils/blkmapd/device-discovery.c
> > index 77ebe736..2736ac89 100644
> > --- a/utils/blkmapd/device-discovery.c
> > +++ b/utils/blkmapd/device-discovery.c
> > @@ -63,7 +63,7 @@
> >   #define EVENT_SIZE (sizeof(struct inotify_event))
> >   #define EVENT_BUFSIZE (1024 * EVENT_SIZE)
> >
> > -#define RPCPIPE_DIR  "/var/lib/nfs/rpc_pipefs"
> > +#define RPCPIPE_DIR  NFS_STATEDIR "/rpc_pipefs"
> >   #define PID_FILE    "/run/blkmapd.pid"
> >
> >   #define CONF_SAVE(w, f) do {                        \
> > diff --git a/utils/gssd/gssd.h b/utils/gssd/gssd.h
> > index c52c5b48..519dc431 100644
> > --- a/utils/gssd/gssd.h
> > +++ b/utils/gssd/gssd.h
> > @@ -39,7 +39,7 @@
> >   #include <pthread.h>
> >
> >   #ifndef GSSD_PIPEFS_DIR
> > -#define GSSD_PIPEFS_DIR              "/var/lib/nfs/rpc_pipefs"
> > +#define GSSD_PIPEFS_DIR              NFS_STATEDIR "/rpc_pipefs"
> >   #endif
> >   #define DNOTIFY_SIGNAL              (SIGRTMIN + 3)
> >
> > diff --git a/utils/idmapd/idmapd.c b/utils/idmapd/idmapd.c
> > index 51c71fbb..e2c160e8 100644
> > --- a/utils/idmapd/idmapd.c
> > +++ b/utils/idmapd/idmapd.c
> > @@ -73,7 +73,7 @@
> >   #include "nfslib.h"
> >
> >   #ifndef PIPEFS_DIR
> > -#define PIPEFS_DIR  "/var/lib/nfs/rpc_pipefs/"
> > +#define PIPEFS_DIR  NFS_STATEDIR "/rpc_pipefs/"
> >   #endif
> >
> >   #ifndef NFSD_DIR
> >
>
