Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2EA43D4EE2
	for <lists+linux-nfs@lfdr.de>; Sun, 25 Jul 2021 19:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhGYQYk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 25 Jul 2021 12:24:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22931 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229545AbhGYQYk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 25 Jul 2021 12:24:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627232709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MJHqaLCCqYIxvxkTssM5ZuwUP6YkGDWJUHd6/roPZAs=;
        b=cdzTLF2RXvSmEyvzxq8jBoQvteUzyy3NdsbGqyr8+8k2hmnEgEfJSEZdAUZrwFa1MI7t6Y
        poPw6uuLeh03t/ESpB18aSPjGV1cHhNJ0ZZiispKTFh1j9p2jMdGAGp6iGFsFZdgDh//5F
        zYo9bF7CMF5ehfeAjgRUa9zxxxJJMsg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-1QfShoGaN7WYMKRYtsVumw-1; Sun, 25 Jul 2021 13:05:08 -0400
X-MC-Unique: 1QfShoGaN7WYMKRYtsVumw-1
Received: by mail-qk1-f197.google.com with SMTP id w2-20020a3794020000b02903b54f40b442so6859087qkd.0
        for <linux-nfs@vger.kernel.org>; Sun, 25 Jul 2021 10:05:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MJHqaLCCqYIxvxkTssM5ZuwUP6YkGDWJUHd6/roPZAs=;
        b=aJN+4f2weRvl+VpH5hyXguQl3gSI4kNomAmiD8pWYDtcZMsBY2lUMLoBRQAJOxs0Cy
         5t5mvCRjBRViIMf43ea6G3u+pIDJ5LifB8Q35agZiHFhNDxXUM9AbnEMC68IOtovn0+Y
         KFLC5jxeaanh3biZxypQvQGYNkQsR1c0OxHbIddtWiRBpUv7ytfwhihEFBEiQM8sxICN
         tPH70akWkfxqWPjxWwRcz6tAUZ/IllF0PsIMKQQp+s1eQIz5i2OTXlE1FTgeoA8BOjWD
         hTQSwCcJGWk/pq+BWIkYHDUqCEhXh9/WZ4B9LRKvWT6nbpUenARGGVaA52dlxmggRdzr
         Ij2g==
X-Gm-Message-State: AOAM530iCN67XsCIx+SJK16JnbjPqqFEmA79olnIUholH0yf96qmVo5t
        yXfj+x0LWbNfbNdILpWTl4fPeRoERs8tC+/OrQh0R2iK998mKZlCpg+9BnUn35fW5FsZ+IX0RRB
        mj1YYpDkxN+jIMlbnVJaMmgh8XRWAbvkRt82VeyqjDAztIRzygAfbPh706gEl99StW8PzRA==
X-Received: by 2002:a37:f510:: with SMTP id l16mr13964287qkk.205.1627232707813;
        Sun, 25 Jul 2021 10:05:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6j2RDOQtpx49Ot00hYS81EEcmUBHY5TGsPHybkeOZuDiHW+R+ziWysCXHylIGgOdSuMsmbg==
X-Received: by 2002:a37:f510:: with SMTP id l16mr13964267qkk.205.1627232707554;
        Sun, 25 Jul 2021 10:05:07 -0700 (PDT)
Received: from madhat.boston.devel.redhat.com ([70.109.164.82])
        by smtp.gmail.com with ESMTPSA id o24sm13646553qtt.21.2021.07.25.10.05.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jul 2021 10:05:07 -0700 (PDT)
Subject: Re: [PATCH] nfs-utils: fix time_t build error on 64-bits platforms
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>,
        linux-nfs@vger.kernel.org
References: <20210722152411.1156295-1-giulio.benetti@benettiengineering.com>
From:   Steve Dickson <steved@redhat.com>
Message-ID: <793a60e6-4adb-99f5-89de-1c0877347e4c@redhat.com>
Date:   Sun, 25 Jul 2021 13:09:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210722152411.1156295-1-giulio.benetti@benettiengineering.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

On 7/22/21 11:24 AM, Giulio Benetti wrote:
> When passing time_t type to "%ld" on 64-bits platforms where time_t is a
> 'long long' we encouter this build failure:
> error: format ‘%ld’ expects argument of type ‘long int’, but argument 4 has type ‘time_t’ {aka ‘long long int’} [-Werror=format=]
> 
> So let's change "%ld" markers to "%lld" assuming it to be a 64-bits and
> cast variables to '(long long)' if the type is a time_t.
Just an FYI... I will be using Petr's patches [1] and [2]
since they used the inittypes defines which seem a
bit more portable and they do the same thing.

steved.

[1] https://marc.info/?l=linux-nfs&m=162697054816925&w=2
[2] https://marc.info/?l=linux-nfs&m=162697054816926&w=2
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
> ---
>   utils/nfsdcltrack/nfsdcltrack.c | 2 +-
>   utils/nfsdcltrack/sqlite.c      | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/utils/nfsdcltrack/nfsdcltrack.c b/utils/nfsdcltrack/nfsdcltrack.c
> index e926f1c0..437477bb 100644
> --- a/utils/nfsdcltrack/nfsdcltrack.c
> +++ b/utils/nfsdcltrack/nfsdcltrack.c
> @@ -525,7 +525,7 @@ cltrack_gracedone(const char *timestr)
>   	if (*tail)
>   		return -EINVAL;
>   
> -	xlog(D_GENERAL, "%s: grace done. gracetime=%ld", __func__, gracetime);
> +	xlog(D_GENERAL, "%s: grace done. gracetime=%lld", __func__, (long long)gracetime);
>   
>   	ret = sqlite_remove_unreclaimed(gracetime);
>   
> diff --git a/utils/nfsdcltrack/sqlite.c b/utils/nfsdcltrack/sqlite.c
> index f79aebb3..6e603087 100644
> --- a/utils/nfsdcltrack/sqlite.c
> +++ b/utils/nfsdcltrack/sqlite.c
> @@ -544,8 +544,8 @@ sqlite_remove_unreclaimed(time_t grace_start)
>   	int ret;
>   	char *err = NULL;
>   
> -	ret = snprintf(buf, sizeof(buf), "DELETE FROM clients WHERE time < %ld",
> -			grace_start);
> +	ret = snprintf(buf, sizeof(buf), "DELETE FROM clients WHERE time < %lld",
> +			(long long)grace_start);
>   	if (ret < 0) {
>   		return ret;
>   	} else if ((size_t)ret >= sizeof(buf)) {
> 

