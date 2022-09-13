Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7691F5B7955
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Sep 2022 20:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiIMSXC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Sep 2022 14:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiIMSWj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Sep 2022 14:22:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7392AE3
        for <linux-nfs@vger.kernel.org>; Tue, 13 Sep 2022 10:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663090733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BBSJfVuICSc79/LbZEVM9PnioSObmaSMxSDczVPNGKA=;
        b=ibgkEGChl1dHZ9sqTgoaew2SQBN7KqnxYdbb1PjEhXhMztu+pU5rJlU0nRkCEYNrNs7OEb
        4Yu4qA9T3F4JziarA+b+qY4efAl/O2JNUdhGgLvOitpffAzUoNx7kDL4r5nmYg2lwJ8Pgb
        RshhaenYcsPD6ZzBVLUDqQb+MJogQUA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-128-WBPkxQfIP8yDTg_GdTLl_g-1; Tue, 13 Sep 2022 13:38:52 -0400
X-MC-Unique: WBPkxQfIP8yDTg_GdTLl_g-1
Received: by mail-qv1-f69.google.com with SMTP id w19-20020a0562140b3300b0049cad77df78so8495022qvj.6
        for <linux-nfs@vger.kernel.org>; Tue, 13 Sep 2022 10:38:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=BBSJfVuICSc79/LbZEVM9PnioSObmaSMxSDczVPNGKA=;
        b=A26EoZerREe+jXGevnhhQaAk/a76HOwwfmvZIFo+gfZ+5mxwjlelimCl8OM+XIe6p2
         glqS1zO6VVJMcOgRoj/00CUR+HpdG+Eh9J8ZkXtQ3ZzvaXs4Lq4t9g8pQJu72qKa/4r2
         6QD/FsiVxoj4GztWgly7Vi+M3i2hM5AXzINE1FTROHj0bXInOOlcMh+2m5vpLUBmQArr
         HgpMdS7I/p9/3lhjxYW5IzCzUKzMGugiKTcW44cLPNZQqTrzgHKsKWYOwuXSWfipMOvu
         Wd7X0gWMF3kBGwY9JKT7MWTydeEZv1xCNJ/VkFiV8Oet60L9U+Qi2/EyYxkYvimC+ioF
         Veug==
X-Gm-Message-State: ACgBeo1W00iMqWn/itxDN01dvIkc5/3KEzKnyUIlSt+0Nu7fARtr8OHu
        b1Z5gdP22Fgea3O50sYz6A0kBixDGpcmUaAYIMKVKGMeqtrO4PWNhplT9r1LnYOmCASUrMf1ZvL
        0XUp+eTDM6wmxePIU/RH3
X-Received: by 2002:a05:622a:5c7:b0:344:8f29:5374 with SMTP id d7-20020a05622a05c700b003448f295374mr28031364qtb.447.1663090731322;
        Tue, 13 Sep 2022 10:38:51 -0700 (PDT)
X-Google-Smtp-Source: AA6agR47RbltlGEqYIGeGAZ3BnWtv0ROSs2xraPN/yvPH3uxpHt3qV5UGc4IRfotgBX2n1M8MMJEog==
X-Received: by 2002:a05:622a:5c7:b0:344:8f29:5374 with SMTP id d7-20020a05622a05c700b003448f295374mr28031349qtb.447.1663090731048;
        Tue, 13 Sep 2022 10:38:51 -0700 (PDT)
Received: from [10.19.60.33] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id d5-20020a05622a15c500b0035bb6298526sm4488209qty.17.2022.09.13.10.38.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 10:38:50 -0700 (PDT)
Message-ID: <4e29b6ba-1824-e6a7-0f68-9c0aa90453cd@redhat.com>
Date:   Tue, 13 Sep 2022 13:38:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3] nfsrahead: fix linking while static linking
Content-Language: en-US
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>,
        linux-nfs@vger.kernel.org
References: <20220809223308.1421081-1-giulio.benetti@benettiengineering.com>
 <20220810214554.107094-1-giulio.benetti@benettiengineering.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20220810214554.107094-1-giulio.benetti@benettiengineering.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 8/10/22 5:45 PM, Giulio Benetti wrote:
> -lmount must preceed -lblkid and to obtain this let's add in configure.ac:
> PKG_CHECK_MODULES([LIBMOUNT], [mount])
> and in tools/nfsrahead/Makefile.am let's substitute explicit `-lmount`
> with:
> $(LIBMOUNT_LIBS)
> This way all the required libraries will be present and in the right order
> when static linking.
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
Committed... (tag: nfs-utils-2-6-3-rc1)

steved
> ---
> V1->V2:
> * modify pkg-conf to pkg-config
> V2->V3:
> * use the correct way for using pkg-config with Autotools
> ---
>   configure.ac                | 3 +++
>   tools/nfsrahead/Makefile.am | 2 +-
>   2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/configure.ac b/configure.ac
> index f1c46c5c..ff85200b 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -273,6 +273,9 @@ AC_LIBCAP
>   dnl Check for -lxml2
>   AC_LIBXML2
>   
> +dnl Check for -lmount
> +PKG_CHECK_MODULES([LIBMOUNT], [mount])
> +
>   # Check whether user wants TCP wrappers support
>   AC_TCP_WRAPPERS
>   
> diff --git a/tools/nfsrahead/Makefile.am b/tools/nfsrahead/Makefile.am
> index 845ea0d5..7e08233a 100644
> --- a/tools/nfsrahead/Makefile.am
> +++ b/tools/nfsrahead/Makefile.am
> @@ -1,6 +1,6 @@
>   libexec_PROGRAMS = nfsrahead
>   nfsrahead_SOURCES = main.c
> -nfsrahead_LDFLAGS= -lmount
> +nfsrahead_LDFLAGS= $(LIBMOUNT_LIBS)
>   nfsrahead_LDADD = ../../support/nfs/libnfsconf.la
>   
>   man5_MANS = nfsrahead.man

