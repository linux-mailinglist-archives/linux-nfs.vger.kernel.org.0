Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948DA5BEDEE
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Sep 2022 21:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbiITTiY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 20 Sep 2022 15:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbiITTiW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 20 Sep 2022 15:38:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7ACC7675D
        for <linux-nfs@vger.kernel.org>; Tue, 20 Sep 2022 12:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663702695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kzhnmDhUbUkOL02BpvD/nzqHPxF+uzYqpSwhuJTW4CI=;
        b=hXQsb/9Le4ZyqHBMBngWgToCUIVYQeQHT4fEWw8mj22JXuSthjDASb/GzEjt1/xYOwxsva
        VINSAHxoWWjxSukgnOMOlEJnmhFB6XxmkZIVpUEEx/Puo/mYFkP3DL/+B9u8u7ASRLBjIS
        +q4MrTRCo52WPQSnCbbZvtdqhzsJKkU=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-458-t3_l5lfaMhOUtJGvwigk8A-1; Tue, 20 Sep 2022 15:37:54 -0400
X-MC-Unique: t3_l5lfaMhOUtJGvwigk8A-1
Received: by mail-qk1-f197.google.com with SMTP id n15-20020a05620a294f00b006b5768a0ed0so2725331qkp.7
        for <linux-nfs@vger.kernel.org>; Tue, 20 Sep 2022 12:37:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=kzhnmDhUbUkOL02BpvD/nzqHPxF+uzYqpSwhuJTW4CI=;
        b=K+vMz4jcRku0KRuU20u461kyvhl9R9IMsKIefZwep//mCXiPkpmkXkzSseVSKqTibU
         CY13DgFNARbX04cvyEdNq6PfGzcptq3oZYJyaDOrqi3O7oiZhI+b1Og30rmzG8k6JqIb
         VhnO5l6rndfOlNBhHMo4ANc6Mou+0Z1P3+vVjhQHiVR/3lg2ZdnJj09oltZonVIqMpw4
         H4VnDqWp2+kMp4Z7AIW6XmH4anLL7+TnOUUExMuPQ+Qhw3MNGyWKbwsdju8/wtNPibLy
         XbGk+cSTHPv6zzRcNTXnSKVzWrH4Zu7smH0jMxcQGhH9CTNoqMn8k/mM9dhswUvvlHXh
         8VNw==
X-Gm-Message-State: ACrzQf2uhlWeAvTZijTb+L64KEOcHPNFFQWyvCHt6KAG5tHGpc106x2V
        jUAyX/7JSre+w/Kg/eXPHEnDqpDbyriMvLNH/hJR9vMVWN5k0eWYRpjKifcUvbcB99fznlVcw0X
        IcAhU8rBf7IOStxTnH7xg
X-Received: by 2002:a05:620a:254e:b0:6c9:cc85:c41a with SMTP id s14-20020a05620a254e00b006c9cc85c41amr17979697qko.260.1663702664428;
        Tue, 20 Sep 2022 12:37:44 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7fW9XarXKxdirVePoNxXoRBb45ht6GX357m4CeEba64yCjEkt4q28QgFeA3yZuGHu79XkedA==
X-Received: by 2002:a05:620a:254e:b0:6c9:cc85:c41a with SMTP id s14-20020a05620a254e00b006c9cc85c41amr17979687qko.260.1663702664148;
        Tue, 20 Sep 2022 12:37:44 -0700 (PDT)
Received: from [172.31.1.6] ([71.161.93.20])
        by smtp.gmail.com with ESMTPSA id r10-20020a05620a298a00b006bb366779a4sm482096qkp.6.2022.09.20.12.37.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 12:37:43 -0700 (PDT)
Message-ID: <2561e8c5-ce9c-6649-389e-08c49d919cf2@redhat.com>
Date:   Tue, 20 Sep 2022 15:37:42 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] configure.ac: allow to disable nfsrahead tool
Content-Language: en-US
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>,
        linux-nfs@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>
References: <20220919221832.2234294-1-giulio.benetti@benettiengineering.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20220919221832.2234294-1-giulio.benetti@benettiengineering.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 9/19/22 6:18 PM, Giulio Benetti wrote:
> This allows to make libmount not mandatory but depending on nfsrahead
> since it only requires it. This is useful when cross-compiling because
> in that case we need rpcgen only built for host but not nfsrahead that
> also require libmount. So this reduces the dependencies for host
> building.
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
Committed... (tag: nfs-utils-2-6-3-rc2)

steved.
> ---
>   configure.ac      | 13 ++++++++++---
>   tools/Makefile.am |  6 +++++-
>   2 files changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index ff85200b..5d9cbf31 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -249,6 +249,16 @@ AC_ARG_ENABLE(nfsdcld,
>   	enable_nfsdcld=$enableval,
>   	enable_nfsdcld="yes")
>   
> +AC_ARG_ENABLE(nfsrahead,
> +	[AS_HELP_STRING([--disable-nfsrahead],[disable nfsrahead command @<:@default=no@:>@])],
> +	enable_nfsrahead=$enableval,
> +	enable_nfsrahead="yes")
> +	AM_CONDITIONAL(CONFIG_NFSRAHEAD, [test "$enable_nfsrahead" = "yes" ])
> +	if test "$enable_nfsrahead" = yes; then
> +		dnl Check for -lmount
> +		PKG_CHECK_MODULES([LIBMOUNT], [mount])
> +	fi
> +
>   AC_ARG_ENABLE(nfsdcltrack,
>   	[AS_HELP_STRING([--disable-nfsdcltrack],[disable NFSv4 clientid tracking programs @<:@default=no@:>@])],
>   	enable_nfsdcltrack=$enableval,
> @@ -273,9 +283,6 @@ AC_LIBCAP
>   dnl Check for -lxml2
>   AC_LIBXML2
>   
> -dnl Check for -lmount
> -PKG_CHECK_MODULES([LIBMOUNT], [mount])
> -
>   # Check whether user wants TCP wrappers support
>   AC_TCP_WRAPPERS
>   
> diff --git a/tools/Makefile.am b/tools/Makefile.am
> index 40c17c37..48fd0cdf 100644
> --- a/tools/Makefile.am
> +++ b/tools/Makefile.am
> @@ -12,6 +12,10 @@ if CONFIG_NFSDCLD
>   OPTDIRS += nfsdclddb
>   endif
>   
> -SUBDIRS = locktest rpcdebug nlmtest mountstats nfs-iostat rpcctl nfsdclnts nfsrahead $(OPTDIRS)
> +if CONFIG_NFSRAHEAD
> +OPTDIRS += nfsrahead
> +endif
> +
> +SUBDIRS = locktest rpcdebug nlmtest mountstats nfs-iostat rpcctl nfsdclnts $(OPTDIRS)
>   
>   MAINTAINERCLEANFILES = Makefile.in

