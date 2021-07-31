Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64F5A3DC6B0
	for <lists+linux-nfs@lfdr.de>; Sat, 31 Jul 2021 17:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbhGaPga (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 31 Jul 2021 11:36:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37802 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229541AbhGaPga (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 31 Jul 2021 11:36:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627745782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=auHkz939N1N4RJTuaOnRhUCEPExja4gJLAvSuZEmS94=;
        b=ZiFe+dT8s507epuCl1dyWPRVzYGbY7IG/58kjw2fDjzy6oMeubjOl6SU2/r2LfxJohMK3v
        b3RvVtbQTqn+LFCAxt8IzuPVXlqeo1fvBvUfyUgbqlSEEKKoP/O5rsAQRsFJ915pJPYdVD
        y7kj4YOso2bNIOF8JHImNnsg56SNLUE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-MJcGjaxdPpGmI0tBxgsPIQ-1; Sat, 31 Jul 2021 11:36:21 -0400
X-MC-Unique: MJcGjaxdPpGmI0tBxgsPIQ-1
Received: by mail-qv1-f71.google.com with SMTP id y10-20020a0cd98a0000b029032ca50bbea1so8182420qvj.12
        for <linux-nfs@vger.kernel.org>; Sat, 31 Jul 2021 08:36:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=auHkz939N1N4RJTuaOnRhUCEPExja4gJLAvSuZEmS94=;
        b=o6soVX/rEjr7Z1fphlpEMpmoez9eh6DkHl6deIBLxoQ5X9AYBRlzyUhvwdgrg6Hyif
         i0YOKy9DIvzT7Z2Sw2wHLfCwsx0eF3ZK/eQaECv9V1wypMmDGFCsSaXPuQVWW/I8yIuu
         GIO7s8ltNg55Z3OZCzWIh9yxjR7oaRfVPr4mFTfKBsd5/c3O36omtZ2pohshMm4KTRpS
         2FusWYFXE2OWKOLCxdTJYxLrvJMwhUGC1bwfezNavqO7OeiLo3RnA++Yvz7N/1ybQRGS
         iStct1q0i0UWY5mSUwlc08NIK37litU+lbC2zb5YVdssBo5noHUlD0Lmd55IbY493ZDp
         kPGA==
X-Gm-Message-State: AOAM530VHzqBuIm46CDoJTSPRpwGM0njstcz2zhmIq6m6KyRiEIkwvQo
        5Bx67WT6huQPP+ra+YnZvorhyOZxT29Uz0xgM7eM0FmV5oiTUFW5IgXHoHqR8chUsPz2R28b5Kh
        YnSxEQXbDj2+vxTFDnTWtJgkWg9VXAJ0ZPqfZtzDpEWThdXwTIhpOGrvvG3h1bT4iLqwFUQ==
X-Received: by 2002:ac8:57c4:: with SMTP id w4mr6928256qta.39.1627745780272;
        Sat, 31 Jul 2021 08:36:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1UW7HRfmH1IdNMLaazYg4JeofEKosXKqUbBkztEI2g9HAUeIPeYUIT0bEhm7f0Qh6FQiwtw==
X-Received: by 2002:ac8:57c4:: with SMTP id w4mr6928237qta.39.1627745780029;
        Sat, 31 Jul 2021 08:36:20 -0700 (PDT)
Received: from madhat.boston.devel.redhat.com ([70.109.164.82])
        by smtp.gmail.com with ESMTPSA id h16sm2000028qtx.23.2021.07.31.08.36.19
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Jul 2021 08:36:19 -0700 (PDT)
Subject: Re: [PATCH] nfsdcltrack: Use uint64_t instead of time_t
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20210728013608.167759-1-steved@redhat.com>
Message-ID: <2117a312-3080-c63f-32ed-5e4d5ae3617b@redhat.com>
Date:   Sat, 31 Jul 2021 11:36:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210728013608.167759-1-steved@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 7/27/21 9:36 PM, Steve Dickson wrote:
> With recent commits (4f2a5b64,5a53426c) that fixed
> compile errors on x86_64 machines, caused similar
> errors on i686 machines.
> 
> The variable type that was being used was a time_t,
> which changes size between architects, which
> caused the compile error.
> 
> Changing the variable to uint64_t fixed the issue.
> 
> Signed-off-by: Steve Dickson <steved@redhat.com>
Committed....

steved.
> ---
>   utils/nfsdcltrack/nfsdcltrack.c | 2 +-
>   utils/nfsdcltrack/sqlite.c      | 2 +-
>   utils/nfsdcltrack/sqlite.h      | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/utils/nfsdcltrack/nfsdcltrack.c b/utils/nfsdcltrack/nfsdcltrack.c
> index 0b37c094..7c1c4bcc 100644
> --- a/utils/nfsdcltrack/nfsdcltrack.c
> +++ b/utils/nfsdcltrack/nfsdcltrack.c
> @@ -508,7 +508,7 @@ cltrack_gracedone(const char *timestr)
>   {
>   	int ret;
>   	char *tail;
> -	time_t gracetime;
> +	uint64_t gracetime;
>   
>   
>   	ret = sqlite_prepare_dbh(storagedir);
> diff --git a/utils/nfsdcltrack/sqlite.c b/utils/nfsdcltrack/sqlite.c
> index cea4a411..cf0c6a45 100644
> --- a/utils/nfsdcltrack/sqlite.c
> +++ b/utils/nfsdcltrack/sqlite.c
> @@ -540,7 +540,7 @@ out_err:
>    * remove any client records that were not reclaimed since grace_start.
>    */
>   int
> -sqlite_remove_unreclaimed(time_t grace_start)
> +sqlite_remove_unreclaimed(uint64_t grace_start)
>   {
>   	int ret;
>   	char *err = NULL;
> diff --git a/utils/nfsdcltrack/sqlite.h b/utils/nfsdcltrack/sqlite.h
> index 06e7c044..ba8cdfa8 100644
> --- a/utils/nfsdcltrack/sqlite.h
> +++ b/utils/nfsdcltrack/sqlite.h
> @@ -26,7 +26,7 @@ int sqlite_insert_client(const unsigned char *clname, const size_t namelen,
>   int sqlite_remove_client(const unsigned char *clname, const size_t namelen);
>   int sqlite_check_client(const unsigned char *clname, const size_t namelen,
>   				const bool has_session);
> -int sqlite_remove_unreclaimed(const time_t grace_start);
> +int sqlite_remove_unreclaimed(const uint64_t grace_start);
>   int sqlite_query_reclaiming(const time_t grace_start);
>   
>   #endif /* _SQLITE_H */
> 

