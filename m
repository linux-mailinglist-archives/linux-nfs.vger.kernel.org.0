Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49662496DDD
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Jan 2022 21:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiAVUGB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 22 Jan 2022 15:06:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:39406 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229517AbiAVUGA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 22 Jan 2022 15:06:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642881960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AGVQS4sccssewquBFfnz8CDiFUEe9PmxYPu5F/G0PQM=;
        b=adfoqF2uVZL4bd8OpLgzSqtC0VNEBzIdPRKzYhhG1bhUZdI4SAf10adw/zpIw7VZ+LRPsa
        BzXbTvvMeB8hAtVpZTt5BBsvYoDaJl9fR3n2hoVLMsPJ9ej7Ti8Jyb4K1nS7lXPZgP0edG
        +xX1fflu0s4cd+GjhIXKZQvm7NVR18I=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-201-h6WiZnBJMCq8wPRHIzsljA-1; Sat, 22 Jan 2022 15:05:58 -0500
X-MC-Unique: h6WiZnBJMCq8wPRHIzsljA-1
Received: by mail-qv1-f72.google.com with SMTP id f7-20020a056214076700b0041c20941155so13439449qvz.15
        for <linux-nfs@vger.kernel.org>; Sat, 22 Jan 2022 12:05:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AGVQS4sccssewquBFfnz8CDiFUEe9PmxYPu5F/G0PQM=;
        b=i5BHr0LuzB7g09DCNJhyuYzgZiRzt1HvGKwRfJ0kYxlFgwJGWvPZ34iRe6J50bzGlw
         kFGmduJtnMVjSqo72Uk/gBdvYdmZ0DNTCQNkezFR8z/W66TfBDOc6jzBUJunj6m6EtfP
         K9ghgXPiV50z4bltMQkdq3SxVL26YXTi4sOFFX9lwjmWyGz86/2pPGdoxWe//VcUryaB
         bYABdgXbwy54pxK3veYPrcoShRaoLA8VZQmD4PPb0TLiEvNvPj7kOtSRSne2XXeB2Np2
         sIhXYXrKVWDeiRGdGAL8e+EYGI+gtl8duah1UD4RPnod2T/OWDTr8H4Hw/HdXrxk+uqP
         7prQ==
X-Gm-Message-State: AOAM532C8Rg6dgILVoiPIwE9RD5BjU/KwFHF7hBer1QEtu7vWA3UGJ+N
        xGXp0wYMSzFgP5RI1u/wZzOBMQ+7hb2Ny9dO/IeLjbJ4VKM4FRUZJVdxQqkvzRDpz1lhiSIOlGr
        rEqPYtUgT/jthQzLEcZuB
X-Received: by 2002:a05:620a:31a7:: with SMTP id bi39mr6975126qkb.226.1642881958253;
        Sat, 22 Jan 2022 12:05:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyNPckFPyiaBuF5kpRXiuMgtkoIhZr7e9+tXnWFL0bwQpPO4nqh4KhegwTwk/NVPlZnQ8l2/Q==
X-Received: by 2002:a05:620a:31a7:: with SMTP id bi39mr6975115qkb.226.1642881957970;
        Sat, 22 Jan 2022 12:05:57 -0800 (PST)
Received: from [172.31.1.6] ([70.109.152.127])
        by smtp.gmail.com with ESMTPSA id j186sm4836188qkd.32.2022.01.22.12.05.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jan 2022 12:05:57 -0800 (PST)
Message-ID: <67d7bba1-d4e5-00be-c198-8501df6e61e1@redhat.com>
Date:   Sat, 22 Jan 2022 15:05:56 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 1/1] utils: Fix left debug info
Content-Language: en-US
To:     Petr Vorel <pvorel@suse.cz>, linux-nfs@vger.kernel.org
Cc:     Yongcheng Yang <yongcheng.yang@gmail.com>
References: <20220122180243.19355-1-pvorel@suse.cz>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20220122180243.19355-1-pvorel@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hey!

This patch is pretty messed up.

On 1/22/22 13:02, Petr Vorel wrote:
> Patch for 497ffdf8 ('manpage: remove the no longer supported value
> "vers2"') [1] didn't contain printf in exportfs.c (looks like debugging
> info) and errno handling in stropts.c (maybe work on other patch) which
> were applied. Thus removing it.
Someone pointed it to me that  with 2 v3 auto-negotiation
on the same mount the is error EPROTONOSUPPORT
instead of EBUSY so this test
      if (errno != EBUSY)
	errno = olderrno;

seemed to work but unfortunately I can
not find the patch/bz or thread we were
communicating in... So I am going to
remove the test until I get (or find) the
official patch

Committed!

thanks,

steved.

> 
> [1] https://lore.kernel.org/linux-nfs/20220117031356.13361-1-yoyang@redhat.com/raw
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>   utils/exportfs/exportfs.c | 2 --
>   utils/mount/stropts.c     | 3 +--
>   2 files changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/utils/exportfs/exportfs.c b/utils/exportfs/exportfs.c
> index c247425b..6ba615d1 100644
> --- a/utils/exportfs/exportfs.c
> +++ b/utils/exportfs/exportfs.c
> @@ -307,14 +307,12 @@ static int exportfs_generic(char *arg, char *options, int verbose)
>   {
>   	char *path;
>   
> -printf("exportfs_generic: arg '%s'\n", arg);
>   	if ((path = strchr(arg, ':')) != NULL)
>   		*path++ = '\0';
>   
>   	if (!path || *path != '/')
>   		return 1;
>   
> -printf("exportfs_generic: path '%s'\n", path);
>   	exportfs_parsed(arg, path, options, verbose);
>   	return 0;
>   }
> diff --git a/utils/mount/stropts.c b/utils/mount/stropts.c
> index 3ca69862..3c4e218a 100644
> --- a/utils/mount/stropts.c
> +++ b/utils/mount/stropts.c
> @@ -973,8 +973,7 @@ fall_back:
>   	if ((result = nfs_try_mount_v3v2(mi, FALSE)))
>   		return result;
>   
> -	if (errno != EBUSY)
> -		errno = olderrno;
> +	errno = olderrno;
>   	return result;
>   }
>   

