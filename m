Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5A73D4E9C
	for <lists+linux-nfs@lfdr.de>; Sun, 25 Jul 2021 18:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbhGYPaI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 25 Jul 2021 11:30:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53992 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229545AbhGYPaI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 25 Jul 2021 11:30:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627229437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kmSsECd2wM3sSVV7Pl8MBG6a3rvZxN0UQQIOdKMcE/4=;
        b=fS+2Nf1+T8DtbV50XNkIFjo/S4En8yGoPGITarl/w8hfQ9VdzI/dqdAOZHUvYUc+AgX/wF
        Gqs9pGiuPgWyUGIz+ChT4Uo5EfvApqcnoQa7T3pighDmUoloesigvJaiMIc8HvVO1aRI8n
        gRTsHu4iTBpND6lGbPTCrTu1BlTmg4g=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-WB5Yiu1EOzqJtw1rby6j7w-1; Sun, 25 Jul 2021 12:10:36 -0400
X-MC-Unique: WB5Yiu1EOzqJtw1rby6j7w-1
Received: by mail-qk1-f197.google.com with SMTP id j12-20020a05620a146cb02903ad9c5e94baso6602398qkl.16
        for <linux-nfs@vger.kernel.org>; Sun, 25 Jul 2021 09:10:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kmSsECd2wM3sSVV7Pl8MBG6a3rvZxN0UQQIOdKMcE/4=;
        b=W5LxGyOPQoXx9AkFgAtkrtebM9iyw9xwQPJdw/cCsa9xnegl+Sq61K0JX9p7rHvqgT
         vtv/01gCFAdzyUK/szmed+J85XWA3/y9DCt59dq6DAp/dsBXMCJzuTnbWD63r84vOAcN
         HBBfg2l7xFGmNaO7XXYC4zUJra1L0GR4lhQvykGiByTnvdIxYimkPpTsEUDKcJ61VnbD
         g8ogfw/vP9SsclSbno1r0f5mDodpjqIuZgAsxVrVJ4RFSIkPRbFrXYgXgav14/LWY9TR
         +Yx70K+VNP02tFc0fxSK3zLLhyHzj2/WblU6JgWpA7Y31HfRT0VXplayqif5mr+5bwM4
         3Zrw==
X-Gm-Message-State: AOAM530GYOZMuVusOa/2anOpX2k26pEWskUpYA00ZfDVN09cvIdtwuFM
        1RZ+1zxhzshTUPHp7XcCTa5POpRmLprsAe+DIAZWdKoCeLw0tVK6+/x0YyEMoKbT6DyZKTc2GQp
        yikvqTKEs6lkQn82d5EZuAKhT3A9vz4vgaAfSLEkjP6HbcmrugzgBEctIAlYDr/LuNNUsPQ==
X-Received: by 2002:ac8:6611:: with SMTP id c17mr11803788qtp.392.1627229435941;
        Sun, 25 Jul 2021 09:10:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+Aq87ZD9D+x5CcWnlq5HPeweZjHHlvZMzBbHZqpkaAlPRNdz030bVtwbKynFVlKMtKZ7YWw==
X-Received: by 2002:ac8:6611:: with SMTP id c17mr11803769qtp.392.1627229435650;
        Sun, 25 Jul 2021 09:10:35 -0700 (PDT)
Received: from madhat.boston.devel.redhat.com ([70.109.164.82])
        by smtp.gmail.com with ESMTPSA id 20sm13647865qka.50.2021.07.25.09.10.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jul 2021 09:10:35 -0700 (PDT)
Subject: Re: [PATCH 1/1] Fix non-default statedir paths.
To:     James Hilliard <james.hilliard1@gmail.com>,
        linux-nfs@vger.kernel.org
References: <20210712140634.4151943-1-james.hilliard1@gmail.com>
From:   Steve Dickson <steved@redhat.com>
Message-ID: <d899537a-1970-c076-c9b6-b358d6aa2798@redhat.com>
Date:   Sun, 25 Jul 2021 12:14:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210712140634.4151943-1-james.hilliard1@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

My apologies for taking so long to look as this
patch...

What problem are you solving with this patch?
Your patch description is a bit light. ;-)

steved.
On 7/12/21 10:06 AM, James Hilliard wrote:
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>   configure.ac                                  | 19 +++++++++++++++++++
>   systemd/Makefile.am                           |  5 ++++-
>   systemd/rpc-pipefs-generator.c                |  2 +-
>   systemd/rpc_pipefs.target                     |  3 ---
>   systemd/rpc_pipefs.target.in                  |  3 +++
>   ....mount => var-lib-nfs-rpc_pipefs.mount.in} |  2 +-
>   utils/blkmapd/device-discovery.c              |  2 +-
>   utils/gssd/gssd.h                             |  2 +-
>   utils/idmapd/idmapd.c                         |  2 +-
>   9 files changed, 31 insertions(+), 9 deletions(-)
>   delete mode 100644 systemd/rpc_pipefs.target
>   create mode 100644 systemd/rpc_pipefs.target.in
>   rename systemd/{var-lib-nfs-rpc_pipefs.mount => var-lib-nfs-rpc_pipefs.mount.in} (84%)
> 
> diff --git a/configure.ac b/configure.ac
> index 93520a80..bc2d0f02 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -688,9 +688,28 @@ AC_SUBST([ACLOCAL_AMFLAGS], ["-I $ac_macro_dir \$(ACLOCAL_FLAGS)"])
>   AC_SUBST([_sysconfdir])
>   AC_CONFIG_COMMANDS_PRE([eval eval _sysconfdir=$sysconfdir])
>   
> +# make _statedir available for substituion in config files
> +# 2 "evals" needed late to expand variable names.
> +AC_SUBST([_statedir])
> +AC_CONFIG_COMMANDS_PRE([eval eval _statedir=$statedir])
> +
> +if test "$statedir" = "/var/lib/nfs"; then
> +	rpc_pipefsmount="var-lib-nfs-rpc_pipefs.mount"
> +else
> +	rpc_pipefsmount="$(systemd-escape -p "$statedir/rpc_pipefs").mount"
> +fi
> +AC_SUBST(rpc_pipefsmount)
> +
> +# make _rpc_pipefsmount available for substituion in config files
> +# 2 "evals" needed late to expand variable names.
> +AC_SUBST([_rpc_pipefsmount])
> +AC_CONFIG_COMMANDS_PRE([eval eval _rpc_pipefsmount=$rpc_pipefsmount])
> +
>   AC_CONFIG_FILES([
>   	Makefile
>   	systemd/rpc-gssd.service
> +	systemd/rpc_pipefs.target
> +	systemd/var-lib-nfs-rpc_pipefs.mount
>   	linux-nfs/Makefile
>   	support/Makefile
>   	support/export/Makefile
> diff --git a/systemd/Makefile.am b/systemd/Makefile.am
> index 650ad25c..8c7b676f 100644
> --- a/systemd/Makefile.am
> +++ b/systemd/Makefile.am
> @@ -12,7 +12,9 @@ unit_files =  \
>       rpc-statd-notify.service \
>       rpc-statd.service \
>       \
> -    proc-fs-nfsd.mount \
> +    proc-fs-nfsd.mount
> +
> +rpc_pipefs_mount_file = \
>       var-lib-nfs-rpc_pipefs.mount
>   
>   if CONFIG_NFSV4
> @@ -75,4 +77,5 @@ genexec_PROGRAMS = nfs-server-generator rpc-pipefs-generator
>   install-data-hook: $(unit_files)
>   	mkdir -p $(DESTDIR)/$(unitdir)
>   	cp $(unit_files) $(DESTDIR)/$(unitdir)
> +	cp $(rpc_pipefs_mount_file) $(DESTDIR)/$(unitdir)/$(rpc_pipefsmount)
>   endif
> diff --git a/systemd/rpc-pipefs-generator.c b/systemd/rpc-pipefs-generator.c
> index 8e218aa7..c24db567 100644
> --- a/systemd/rpc-pipefs-generator.c
> +++ b/systemd/rpc-pipefs-generator.c
> @@ -21,7 +21,7 @@
>   #include "conffile.h"
>   #include "systemd.h"
>   
> -#define RPC_PIPEFS_DEFAULT "/var/lib/nfs/rpc_pipefs"
> +#define RPC_PIPEFS_DEFAULT NFS_STATEDIR "/rpc_pipefs"
>   
>   static int generate_mount_unit(const char *pipefs_path, const char *pipefs_unit,
>   			       const char *dirname)
> diff --git a/systemd/rpc_pipefs.target b/systemd/rpc_pipefs.target
> deleted file mode 100644
> index 01d4d278..00000000
> --- a/systemd/rpc_pipefs.target
> +++ /dev/null
> @@ -1,3 +0,0 @@
> -[Unit]
> -Requires=var-lib-nfs-rpc_pipefs.mount
> -After=var-lib-nfs-rpc_pipefs.mount
> diff --git a/systemd/rpc_pipefs.target.in b/systemd/rpc_pipefs.target.in
> new file mode 100644
> index 00000000..332f62b6
> --- /dev/null
> +++ b/systemd/rpc_pipefs.target.in
> @@ -0,0 +1,3 @@
> +[Unit]
> +Requires=@_rpc_pipefsmount@
> +After=@_rpc_pipefsmount@
> diff --git a/systemd/var-lib-nfs-rpc_pipefs.mount b/systemd/var-lib-nfs-rpc_pipefs.mount.in
> similarity index 84%
> rename from systemd/var-lib-nfs-rpc_pipefs.mount
> rename to systemd/var-lib-nfs-rpc_pipefs.mount.in
> index 26d1c763..4c5d6ce4 100644
> --- a/systemd/var-lib-nfs-rpc_pipefs.mount
> +++ b/systemd/var-lib-nfs-rpc_pipefs.mount.in
> @@ -6,5 +6,5 @@ Conflicts=umount.target
>   
>   [Mount]
>   What=sunrpc
> -Where=/var/lib/nfs/rpc_pipefs
> +Where=@_statedir@/rpc_pipefs
>   Type=rpc_pipefs
> diff --git a/utils/blkmapd/device-discovery.c b/utils/blkmapd/device-discovery.c
> index 77ebe736..2736ac89 100644
> --- a/utils/blkmapd/device-discovery.c
> +++ b/utils/blkmapd/device-discovery.c
> @@ -63,7 +63,7 @@
>   #define EVENT_SIZE (sizeof(struct inotify_event))
>   #define EVENT_BUFSIZE (1024 * EVENT_SIZE)
>   
> -#define RPCPIPE_DIR	"/var/lib/nfs/rpc_pipefs"
> +#define RPCPIPE_DIR	NFS_STATEDIR "/rpc_pipefs"
>   #define PID_FILE	"/run/blkmapd.pid"
>   
>   #define CONF_SAVE(w, f) do {			\
> diff --git a/utils/gssd/gssd.h b/utils/gssd/gssd.h
> index c52c5b48..519dc431 100644
> --- a/utils/gssd/gssd.h
> +++ b/utils/gssd/gssd.h
> @@ -39,7 +39,7 @@
>   #include <pthread.h>
>   
>   #ifndef GSSD_PIPEFS_DIR
> -#define GSSD_PIPEFS_DIR		"/var/lib/nfs/rpc_pipefs"
> +#define GSSD_PIPEFS_DIR		NFS_STATEDIR "/rpc_pipefs"
>   #endif
>   #define DNOTIFY_SIGNAL		(SIGRTMIN + 3)
>   
> diff --git a/utils/idmapd/idmapd.c b/utils/idmapd/idmapd.c
> index 51c71fbb..e2c160e8 100644
> --- a/utils/idmapd/idmapd.c
> +++ b/utils/idmapd/idmapd.c
> @@ -73,7 +73,7 @@
>   #include "nfslib.h"
>   
>   #ifndef PIPEFS_DIR
> -#define PIPEFS_DIR  "/var/lib/nfs/rpc_pipefs/"
> +#define PIPEFS_DIR  NFS_STATEDIR "/rpc_pipefs/"
>   #endif
>   
>   #ifndef NFSD_DIR
> 

