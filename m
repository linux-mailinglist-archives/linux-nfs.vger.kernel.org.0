Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFE733D63AE
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jul 2021 18:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239078AbhGZPub (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Jul 2021 11:50:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23408 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237909AbhGZPuP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Jul 2021 11:50:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627317043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/A1LupBXmdSXOW41a3SrqoRejiXwTb/03suhZ1TeZrc=;
        b=LjeOdCo+tixqEVaTOGWMAGVYP4i6YR44oASWHqC7e0CcepgwqD2h4IVp8UxfLYgIJXF3Iy
        Z4wAkKVso1zKy6w/TyhvaGPPx00k/E5qoV3Kp1HAXKaejtq7RsXHF/LH4gTSQwf4RZmh/l
        dk9G/Xb7NZn2LR3TIQXrOmLCieUgofQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-pwFFFFOAOOqXJtoJNEz2Iw-1; Mon, 26 Jul 2021 12:30:42 -0400
X-MC-Unique: pwFFFFOAOOqXJtoJNEz2Iw-1
Received: by mail-qk1-f198.google.com with SMTP id bm25-20020a05620a1999b02903a9c3f8b89fso9445957qkb.2
        for <linux-nfs@vger.kernel.org>; Mon, 26 Jul 2021 09:30:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/A1LupBXmdSXOW41a3SrqoRejiXwTb/03suhZ1TeZrc=;
        b=bE0WKQr9SGYRcZyBklplENVGf3biF0oAoq5RX0CYDR2oN7DuEErd3mJWBytDQ3nxtT
         ovofxingLvjbjHLMxvi4Qf22gxhzCx/KrTrm4aWYgo6+UYWBsG1mPE4IexhxwspJRio4
         ioDUseqDIO2hF3PCRt/PwIP4jAJNzzkrb44yPUlIr3rLZeOIFMiUinmYO9Oa5mAH/KTR
         Vwfyc93+WWe1DhKZS3NAwWqqUV7i7STih3KsrumZypOsk1OTVGPpY/j1yaVozypZJdHc
         qvsjZGnVVlpUgSW4Uhi+2amw0+lNNs11QdA9gndfeHiN/UcZ6jSCyYwzorCByfO6tKFK
         6xAg==
X-Gm-Message-State: AOAM5328wEaWPFprG/vMrnKSOG6NfZ+NfoZDfTbl3flohHnKZOw0xUKf
        Qdoto2P2tknNczUQ3hPg58DZfYzw2P156eQ9NTCUhBzdvKcltcYTm2deDKynEO4FVWuNONekko6
        IvvOtebA7QsRlFlzD+KoZPVOeP7x1yILuTtLiyFDanFNBWxCFD+AZtScTQpZrlZR6mCFBCA==
X-Received: by 2002:ac8:5546:: with SMTP id o6mr15918051qtr.69.1627317041628;
        Mon, 26 Jul 2021 09:30:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrjuRlOEvolrXp+kWjsewHmUybLbIpZEbBGwmjhXonmGXbqgM1MZKdmuok+ymVY/rzZ4uicA==
X-Received: by 2002:ac8:5546:: with SMTP id o6mr15918031qtr.69.1627317041359;
        Mon, 26 Jul 2021 09:30:41 -0700 (PDT)
Received: from madhat.boston.devel.redhat.com ([70.109.164.82])
        by smtp.gmail.com with ESMTPSA id v4sm230379qkf.52.2021.07.26.09.30.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 09:30:40 -0700 (PDT)
Subject: Re: [PATCH 1/1] Fix non-default statedir paths.
To:     James Hilliard <james.hilliard1@gmail.com>,
        linux-nfs@vger.kernel.org
References: <20210712140634.4151943-1-james.hilliard1@gmail.com>
From:   Steve Dickson <steved@redhat.com>
Message-ID: <acd44eb9-9b0d-1494-d438-4c3d114ac5ad@redhat.com>
Date:   Mon, 26 Jul 2021 12:30:40 -0400
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



On 7/12/21 10:06 AM, James Hilliard wrote:
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Committed... (tag: nfs-utils-2-5-5-rc1)

steved
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

