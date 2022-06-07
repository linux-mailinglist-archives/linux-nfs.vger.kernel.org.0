Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDA954240B
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jun 2022 08:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiFHDh2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 7 Jun 2022 23:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238182AbiFHDgE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 7 Jun 2022 23:36:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 22C1B26EB
        for <linux-nfs@vger.kernel.org>; Tue,  7 Jun 2022 13:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654635138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vDubysIRGI7D5gdguuBxE36/EqqJpMQJe695eQRO7o8=;
        b=Iqz0+n2LCFIAIPZt38LqsgYPE6A9kiTC3SwE6kKu14LapZkSJ2qsPMFaw7aZMgimX5i4iq
        cF1VSHhJwB0j1MFjmwcCJ3UjhtmcdbHJvCeAlutetVyfJvgX3N4kbAlPt30M21tp9ZAIY7
        1pHRC9UVB9fa4uFvBqLxVuJ7tk7nHsk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-549-Yxei_rDINEW7Ot0fgusXTQ-1; Tue, 07 Jun 2022 16:52:16 -0400
X-MC-Unique: Yxei_rDINEW7Ot0fgusXTQ-1
Received: by mail-qk1-f197.google.com with SMTP id q7-20020a05620a0d8700b006a6b5428cb1so6617309qkl.2
        for <linux-nfs@vger.kernel.org>; Tue, 07 Jun 2022 13:52:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vDubysIRGI7D5gdguuBxE36/EqqJpMQJe695eQRO7o8=;
        b=IwZvMku9QY9uaJswFBwP8LGFDP2ZLvn7nEaAVjeo0SCcEO2jh1G3hh6AMiGVq+S6wC
         NSQANqAkkkiQ6ziPOjfMyOTUC+83XB3lUFKOO3mg1v7unGOmOsi0P3fegVIx4hBcdaNa
         PVTMecHI5lABtWtNe4g3MmbuH6tPxKDUai4jMFfyJZ4RmhdxBzVxewJjscF/k5y40B2o
         jDiVcDMt/8TByZ/jY+DsIKltQcgfwhy17BarBlCn+hX831KGtwJYS9cbZMIL2dsCqysp
         gympwmQQLhU6IvxXNBmv2hyaQUhDwO+lj/9kgqLmrxGY/2y97OuLG7vcSuPABJ/lJZ21
         va4w==
X-Gm-Message-State: AOAM532V/jafCt4Fb57UMRKlWPIh0QFSXe9JxtfN1vwWyQgnWE9aMMFt
        q2mS/5kuJGsmBjLjPBu2DAN7+GCN4Leu/gZvJ44R7kSnPiSjZdeEIKxRGSo8lQOR2xgjdb2LBHE
        0WfrbBo7lTZoYLi4O7tlq
X-Received: by 2002:ac8:7f4b:0:b0:2f3:d0f4:b5af with SMTP id g11-20020ac87f4b000000b002f3d0f4b5afmr24807643qtk.577.1654635135731;
        Tue, 07 Jun 2022 13:52:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzfFjgGoz9AmeRJ2wisL6XXogdJmIeCr6GIOhyzwzuuLbnta6MCYegHTATsbGX1z2/BOZycHA==
X-Received: by 2002:ac8:7f4b:0:b0:2f3:d0f4:b5af with SMTP id g11-20020ac87f4b000000b002f3d0f4b5afmr24807623qtk.577.1654635135471;
        Tue, 07 Jun 2022 13:52:15 -0700 (PDT)
Received: from [172.31.1.6] ([71.161.96.106])
        by smtp.gmail.com with ESMTPSA id l2-20020a37bb02000000b006a2e2dde144sm14241976qkf.88.2022.06.07.13.52.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 13:52:15 -0700 (PDT)
Message-ID: <1addad04-275f-e24e-3b63-20914a24db1b@redhat.com>
Date:   Tue, 7 Jun 2022 16:52:14 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH nfs-utils] Apply all sysctl settings when NFS-related
 modules are loaded.
Content-Language: en-US
To:     NeilBrown <neilb@suse.de>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <165335769457.22265.5383162992195478413@noble.neil.brown.name>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <165335769457.22265.5383162992195478413@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 5/23/22 10:01 PM, NeilBrown wrote:
> 
> sysctl settings (e.g.  /etc/sysctl.conf and others) are normally loaded
> once at boot.  If the module that implements some settings is no yet
> loaded, those settings don't get applied.
> 
> Various NFS modules support various sysctl settings.  If they are loaded
> after boot, they miss out.
> 
> So add commands to modprobe.d/50-nfs.conf to apply the relevant settings
> when the module is loaded.
> 
> I have placed this in the "systemd" directory because it seemed the
> least bad choice.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
Committed... (tag: nfs-utils-2-6-2-rc6)

steved.
> ---
>   systemd/50-nfs.conf | 16 ++++++++++++++++
>   systemd/Makefile.am | 10 ++++++++--
>   2 files changed, 24 insertions(+), 2 deletions(-)
>   create mode 100644 systemd/50-nfs.conf
> 
> diff --git a/systemd/50-nfs.conf b/systemd/50-nfs.conf
> new file mode 100644
> index 000000000000..b56b2d765969
> --- /dev/null
> +++ b/systemd/50-nfs.conf
> @@ -0,0 +1,16 @@
> +# Ensure all NFS systctl settings get applied when modules load
> +
> +# sunrpc module supports "sunrpc.*" sysctls
> +install sunrpc /sbin/modprobe --ignore-install sunrpc $CMDLINE_OPTS && /sbin/sysctl -q --pattern sunrpc --system
> +
> +# rpcrdma module supports sunrpc.svc_rdma.*
> +install rpcrdma /sbin/modprobe --ignore-install rpcrdma $CMDLINE_OPTS && /sbin/sysctl -q --pattern sunrpc.svc_rdma --system
> +
> +# lockd module supports "fs.nfs.nlm*" and "fs.nfs.nsm*" sysctls
> +install lockd /sbin/modprobe --ignore-install lockd $CMDLINE_OPTS && /sbin/sysctl -q --pattern fs.nfs.n[sl]m --system
> +
> +# nfsv4 module supports "fs.nfs.*" sysctls (nfs_callback_tcpport and idmap_cache_timeout)
> +install nfsv4 /sbin/modprobe --ignore-install nfsv4 $CMDLINE_OPTS && /sbin/sysctl -q --pattern 'fs.nfs.(nfs_callback_tcpport|idmap_cache_timeout)' --system
> +
> +# nfs module supports "fs.nfs.*" sysctls
> +install nfs /sbin/modprobe --ignore-install nfs $CMDLINE_OPTS && /sbin/sysctl -q --pattern fs.nfs --system
> diff --git a/systemd/Makefile.am b/systemd/Makefile.am
> index e7f5d818a913..63a50bf2c07e 100644
> --- a/systemd/Makefile.am
> +++ b/systemd/Makefile.am
> @@ -2,6 +2,8 @@
>   
>   MAINTAINERCLEANFILES = Makefile.in
>   
> +modprobe_files = 50-nfs.conf
> +
>   unit_files =  \
>       nfs-client.target \
>       rpc_pipefs.target \
> @@ -51,7 +53,7 @@ endif
>   
>   man5_MANS	= nfs.conf.man
>   man7_MANS	= nfs.systemd.man
> -EXTRA_DIST = $(unit_files) $(man5_MANS) $(man7_MANS)
> +EXTRA_DIST = $(unit_files) $(modprobe_files) $(man5_MANS) $(man7_MANS)
>   
>   generator_dir = $(unitdir)/../system-generators
>   
> @@ -73,8 +75,12 @@ rpc_pipefs_generator_LDADD = ../support/nfs/libnfs.la
>   
>   if INSTALL_SYSTEMD
>   genexec_PROGRAMS = nfs-server-generator rpc-pipefs-generator
> -install-data-hook: $(unit_files)
> +install-data-hook: $(unit_files) $(modprobe_files)
>   	mkdir -p $(DESTDIR)/$(unitdir)
>   	cp $(unit_files) $(DESTDIR)/$(unitdir)
>   	cp $(rpc_pipefs_mount_file) $(DESTDIR)/$(unitdir)/$(rpc_pipefsmount)
> +else
> +install-data-hook: $(modprobe_files)
>   endif
> +	mkdir -p $(DESTDIR)/usr/lib/modprobe.d
> +	cp $(modprobe_files) $(DESTDIR)/usr/lib/modprobe.d/

