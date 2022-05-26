Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A3753528D
	for <lists+linux-nfs@lfdr.de>; Thu, 26 May 2022 19:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237053AbiEZRdd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 May 2022 13:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348292AbiEZRdc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 26 May 2022 13:33:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 914FA3CFCF
        for <linux-nfs@vger.kernel.org>; Thu, 26 May 2022 10:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653586410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w1kNxvGfvb8+HYC/IlcBr7/A4AKfDbmnUFoG4jJS794=;
        b=RNMKybsToKJq2cSWOI9IZoyx6oQUPoqij/Tklnissuti4wMOAK4F7/mGQmCR+5Lb4CiR8B
        mKaijJ2Ew+t1K8D9YOVpyZYgnWoN+k+WWHLUELY/4eayoGFaV/Hw+QpwxyRkn5lT6s9PbJ
        5g1IJnpd1TipGEWQOAMF4M+w5RHUD5w=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669-73b7epRxONG75sA9_SyUcg-1; Thu, 26 May 2022 13:33:29 -0400
X-MC-Unique: 73b7epRxONG75sA9_SyUcg-1
Received: by mail-qt1-f200.google.com with SMTP id l20-20020ac81494000000b002f91203eeacso2302203qtj.10
        for <linux-nfs@vger.kernel.org>; Thu, 26 May 2022 10:33:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=w1kNxvGfvb8+HYC/IlcBr7/A4AKfDbmnUFoG4jJS794=;
        b=zqQK3KFUU/hVbaMhTVnPMvzuH67jpZr1S2hpPVUHXLEgRI6FvyZb84zRDdkQPyBfF8
         iQEFR+hclbNyDclChgRyKTcJnl6jl9Jbtt0wwYRhCvOT58rVUYT7FROa3EWagcpBaHms
         WoDLMdXUoHI8SbP3EsW+IWLuRf9pv2RbzEgyOV14LHSRt/ltNcv/NUoPILQn6PaNIYgf
         jUfwXLbBQHPra5HN/uFxfuWHNdAH5dHko6+UdcyLBheVdm6XJKaZqnNtJ9MEspeuNwV9
         4jo24z1GN8GaIeb6/B8XDYPG1ToAA4orokbeH2jldEI2km76hguMwOZorr/f6C4kWBlm
         WTBw==
X-Gm-Message-State: AOAM530T3MHj86z82Pprv76PJCf28kvBaGleiQZVPgPbGjKk58XjKX1v
        44IZ2EudA5li65A0gte8J2B0SrX4JJHWhzFOwDMhlDwtlmyA2UyD3x3g83IDcMWmnFsWEkq/r9e
        v6GmTcxiO+hf9UbAvXj7o
X-Received: by 2002:a05:622a:1a08:b0:2fb:e220:271b with SMTP id f8-20020a05622a1a0800b002fbe220271bmr4673096qtb.221.1653586408605;
        Thu, 26 May 2022 10:33:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJypuMy0h4KSRp6ftmtRXY2pRz3cMofw53ibt2xOHCSV7Zl7fNXCYhqpQkKZMpurHcQCvCjjdA==
X-Received: by 2002:a05:622a:1a08:b0:2fb:e220:271b with SMTP id f8-20020a05622a1a0800b002fbe220271bmr4673080qtb.221.1653586408346;
        Thu, 26 May 2022 10:33:28 -0700 (PDT)
Received: from [10.19.60.33] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 72-20020a370c4b000000b0069fc13ce1e1sm1545123qkm.18.2022.05.26.10.33.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 May 2022 10:33:28 -0700 (PDT)
Message-ID: <75ee3189-22fe-48ca-9e04-69648b300b6a@redhat.com>
Date:   Thu, 26 May 2022 13:33:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] mountd: Check 'nfsd/clients' directory presence instead
 of kernel version
Content-Language: en-US
To:     Konstantin Khorenko <khorenko@virtuozzo.com>,
        linux-nfs@vger.kernel.org
References: <20220516185555.643087-1-khorenko@virtuozzo.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20220516185555.643087-1-khorenko@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 5/16/22 2:55 PM, Konstantin Khorenko wrote:
> Kernel major version does not always provide 100% certainty about
> presence or absence of a feature, for example:
>   - some distros backport feature from mainstream kernel to older kernels
>   - if NFS server is run inside a system container the reported kernel
>     version inside the container may be faked
> 
> So let's determine the feature presence by checking
> '/proc/fs/nfsd/clients/' directory presence instead of checking the
> kernel version.
> 
> Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
Committed... (tag: nfs-utils-2-6-2-rc5)

steved.
> ---
>   support/export/v4clients.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/support/export/v4clients.c b/support/export/v4clients.c
> index 5e4f1058..5f15b614 100644
> --- a/support/export/v4clients.c
> +++ b/support/export/v4clients.c
> @@ -8,9 +8,9 @@
>   #include <unistd.h>
>   #include <stdlib.h>
>   #include <sys/inotify.h>
> +#include <sys/stat.h>
>   #include <errno.h>
>   #include "export.h"
> -#include "version.h"
>   
>   /* search.h declares 'struct entry' and nfs_prot.h
>    * does too.  Easiest fix is to trick search.h into
> @@ -24,7 +24,10 @@ static int clients_fd = -1;
>   
>   void v4clients_init(void)
>   {
> -	if (linux_version_code() < MAKE_VERSION(5, 3, 0))
> +	struct stat sb;
> +
> +	if (!stat("/proc/fs/nfsd/clients", &sb) == 0 ||
> +	    !S_ISDIR(sb.st_mode))
>   		return;
>   	if (clients_fd >= 0)
>   		return;

