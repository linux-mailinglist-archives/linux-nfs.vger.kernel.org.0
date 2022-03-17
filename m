Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7FB4DCA24
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Mar 2022 16:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233781AbiCQPiz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Mar 2022 11:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbiCQPiy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Mar 2022 11:38:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B09020A97A
        for <linux-nfs@vger.kernel.org>; Thu, 17 Mar 2022 08:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647531455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xyg1PhIE4lHYfJ5PVeK1wGpx/bF2KbVTrOqGv6rC1os=;
        b=f2mcx4SmEo2PxsHdsy6g0F1frRo8Ch/523Bj8oyG2zjgyEo2olBsQM3z8N+yQf5nU9obcU
        OYT3QQTkMP5s1p+JVJkcrEhJEhOLMDr5XFu3STltDioMm8kHweADFU4KV96LMfgnm33Ji2
        s7riDbPL6UWW6wmq+tIKCBb4DjeVcOo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-358-wDG-Q_IXPo-OOSaqFrrsvQ-1; Thu, 17 Mar 2022 11:37:34 -0400
X-MC-Unique: wDG-Q_IXPo-OOSaqFrrsvQ-1
Received: by mail-qv1-f71.google.com with SMTP id 33-20020a0c8024000000b0043d17ffb0bdso4219908qva.18
        for <linux-nfs@vger.kernel.org>; Thu, 17 Mar 2022 08:37:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Xyg1PhIE4lHYfJ5PVeK1wGpx/bF2KbVTrOqGv6rC1os=;
        b=448lBHN8q9SnYxE4ZMuE+05oBs/1aBlX3lhTgWsEaF/hpV/kGxnVSHfK+gd0YUEFKo
         yEPeq71s309MMlHCKoX2hx1vCDrX+OYBVEAXe0G2gdtYTsD+2E4WqBxIhI0KJ1fSOxD5
         ssq8j2I99GvdEpSCs0FmcI0/YmHXu+QV5V/fvpF752dYa6X8C7LRythT7T36fsCmZJIK
         aKvvT/W5ptaLIuqBATiaDecAo2TVzzojDvE8ag/JwPo79qxIiZ9h9EW2IHX8rt4564Uu
         K470yhwUlwpzqhAVm9oWejkGiK/Ba1EdkawK5I+fengtyd4NfEE+nauawruXXaWyB9HH
         9+sg==
X-Gm-Message-State: AOAM533werDGyCHLeZBY6z3SGAkYMLu/TW8mc1cFQhUoGHg9DYox6kgx
        bcPsoIrFehz1KCZR/QEqIn2N0TVPaPI1ka1IV8oA2x8Ds0rhm0NZYHTMJynPmqquwPf/u9cfoEs
        EaWowH5eEnTeoXLlOW5K4
X-Received: by 2002:a05:620a:44cc:b0:67d:8558:db56 with SMTP id y12-20020a05620a44cc00b0067d8558db56mr3194475qkp.721.1647531453524;
        Thu, 17 Mar 2022 08:37:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzyVHpVZy1pLUpqXc+fUkZMkJANqswbua/UCKq95wqrMsega421hKFkpS89db46q7u6KvDW7g==
X-Received: by 2002:a05:620a:44cc:b0:67d:8558:db56 with SMTP id y12-20020a05620a44cc00b0067d8558db56mr3194456qkp.721.1647531453192;
        Thu, 17 Mar 2022 08:37:33 -0700 (PDT)
Received: from [10.19.60.33] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id w8-20020ac87e88000000b002e1cdc11203sm3850862qtj.18.2022.03.17.08.37.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 08:37:32 -0700 (PDT)
Message-ID: <f3910fdd-d107-1f6c-8cfc-1b7f429f8024@redhat.com>
Date:   Thu, 17 Mar 2022 11:37:31 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC v2 PATCH 7/7] readahead: documentation
Content-Language: en-US
To:     Thiago Becker <tbecker@redhat.com>, linux-nfs@vger.kernel.org
Cc:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        kolga@netapp.com
References: <20220311190617.3294919-1-tbecker@redhat.com>
 <20220311190617.3294919-8-tbecker@redhat.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20220311190617.3294919-8-tbecker@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 3/11/22 2:06 PM, Thiago Becker wrote:
> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1946283
> Signed-off-by: Thiago Becker <tbecker@redhat.com>
> ---
>   tools/nfs-readahead-udev/Makefile.am          |  2 +
>   .../nfs-readahead-udev/nfs-readahead-udev.man | 47 +++++++++++++++++++
>   tools/nfs-readahead-udev/readahead.conf       | 14 ++++++
>   3 files changed, 63 insertions(+)
>   create mode 100644 tools/nfs-readahead-udev/nfs-readahead-udev.man
> 
> diff --git a/tools/nfs-readahead-udev/Makefile.am b/tools/nfs-readahead-udev/Makefile.am
> index 010350aa..eaa9b90e 100644
> --- a/tools/nfs-readahead-udev/Makefile.am
> +++ b/tools/nfs-readahead-udev/Makefile.am
> @@ -10,6 +10,8 @@ udev_rules_DATA = 99-nfs_bdi.rules
>   ra_confdir = $(sysconfdir)
>   ra_conf_DATA = readahead.conf
>   
> +man5_MANS = nfs-readahead-udev.man
> +
>   99-nfs_bdi.rules: 99-nfs_bdi.rules.in $(builddefs)
>   	$(SED) "s|_libexecdir_|@libexecdir@|g" 99-nfs_bdi.rules.in > $@
>   
> diff --git a/tools/nfs-readahead-udev/nfs-readahead-udev.man b/tools/nfs-readahead-udev/nfs-readahead-udev.man
> new file mode 100644
> index 00000000..2477d5b3
> --- /dev/null
> +++ b/tools/nfs-readahead-udev/nfs-readahead-udev.man
> @@ -0,0 +1,47 @@
> +.\" Manpage for nfs-readahead-udev.
> +.nh
> +.ad l
> +.TH man 5 "08 Mar 2022" "1.0" "nfs-readahead-udev man page"
> +.SH NAME
> +
> +nfs-readahead-udev \- Find the readahead for a given NFS mount
> +
> +.SH SYNOPSIS
> +
> +nfs-readahead-udev <device>
> +
> +.SH DESCRIPTION
> +
> +\fInfs-readahead-udev\fR is a tool intended to be used with udev to set the \fIread_ahead_kb\fR parameter of NFS mounts, according to the configuration file (see \fICONFIGURATION\fR). \fIdevice\fR is the device number for the NFS backing device as provided by the kernel.
> +
> +.SH CONFIGURATION
> +
> +The configuration file (\fI/etc/readahead.conf\fR) contains the readahead configuration, and is formatted as follows.
> +
> +<LINES> ::= <LINES> <LINE> | <LINE>
> +
> +<LINE> ::= <TOKENS> <ENDL>
> +
> +<TOKENS> ::= <TOKENS> <TOKEN> | <TOKEN>
> +
> +<TOKEN> ::= default | <PAIR>
> +
> +<PAIR> ::= mountpoint = <mountpoint> | fstype = <nfs|nfs4> | readahead = <readahead>
> +
> +\fImountpoint\fR is the path in the system where the file system is mounted.
> +
> +\fIreadahead\fR is an integer to readahead.
> +
> +\fIfstype\fR is either \fInfs\fR or \fInfs4\fR.
> +
> +.SH SEE ALSO
> +
> +mount.nfs(8), nfs(5), udev(7), bcc-readahead(8)
> +
> +.SH BUGS
> +
> +No known bugs.
> +
> +.SH AUTHOR
I think it might make sense to added some examples
on how the command will be used.

> +
> +Thiago Rafael Becker <trbecker@gmail.com>
> diff --git a/tools/nfs-readahead-udev/readahead.conf b/tools/nfs-readahead-udev/readahead.conf
> index 988b30c7..bce830f1 100644
> --- a/tools/nfs-readahead-udev/readahead.conf
> +++ b/tools/nfs-readahead-udev/readahead.conf
> @@ -1 +1,15 @@
> +# nfs-readahead-udev configuration file.
> +#
> +# This file configures the readahead for nfs mounts when those are anounced by the kernel.
> +# The file is composed on lines that can contain either the default configuration (applied to
> +# any nfs mount that does not match any of the other lines) or a combination of
> +#   mountpoint=<mountpoint> where mountpoint is the mount point for the file system
> +#   fstype=<nfs|nfs4> specifies that this configuration should only apply to a specific nfs
> +#     version.
> +# Every line must contain a readahead option, with the expected readahead value.
>   default				readahead=128
> +
> +# mountpoint=/mnt		readahead=4194304
> +# fstype=nfs			readahead=4194304
> +# fstype=nfs4			readahead=4194304
> +# mountpoint=/mnt	fstype=nfs4	readahead=4194304
Would it make sense to try added these to nfs.conf?

I must admin I'm a bit impressed with your lex and
yacc routines in patch 5, I have not seen those
in a while.. but that does add more dependencies
to nfs-utils and as well as yet another config file
to manage.

steved.

