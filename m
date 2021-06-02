Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 087893983D7
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Jun 2021 10:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbhFBIKV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Jun 2021 04:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhFBIKU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Jun 2021 04:10:20 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74A8C061574
        for <linux-nfs@vger.kernel.org>; Wed,  2 Jun 2021 01:08:37 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id i9so1959841lfe.13
        for <linux-nfs@vger.kernel.org>; Wed, 02 Jun 2021 01:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bell-sw-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FCFE3wcJl4cMUcO5pESrxZ1COffREp/VqksgtbqZj6o=;
        b=DeJ247OxkkB6NPNH+MQs5ePNHPe0V+3jirk92z6LZW74OpXbmvPpWMPmWktDw4WTq7
         EBbim96zlcrsZlEKEYweYoz3b4dmO7EXt67tq/qsD1sOH6AHTzSBs1BPpzKGKjRDn8Qp
         Kct98H/s/6gherlaYK7D+W6eZmuw0ca5VYI8a224NEjtrG1123cowEpJX1L/jF9odICL
         uPXMfYybh/efl6iYDk2Ef2dxQISpP11+6kW9vdUW0cFGVPPpXp1uzfnVgAHBgTrUV6jU
         CJeCMEm/EE30Z0pWImzfzRT+JnYkBL0dm0UGBEOfBsqwINF3niRfT7xoyAv7sHVnbnMA
         cXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FCFE3wcJl4cMUcO5pESrxZ1COffREp/VqksgtbqZj6o=;
        b=ZrLKwqjIblcKxwn3hTf1Y4v1jQJ8APZ876C7YZU6Um4SbplprqJjT31bhJbJk4VRWO
         urMoupE5VSHLiRnJkIfexyd7cL/gKgeLfAoqfdm/oDxb+7oOPlOuyNbaECjhxhA/M/Tb
         8Aig3gMCOdq77YxxTRPoJp5RQ5aIAHIuvm9kndEEMrsc8Ww7dAOvpfvpX4LySV87lhAa
         vY93inWAm7lF8d0hnC2Rzz4FyxBP/KVW6mKOlDzQ8V3H8ckCWMEXHWStoC1s/UcEbjjc
         ezOoARS56JCublC0n3f4XoM8aHUs5u0G28YaycZVqzew8i75NHcUkSq3FvUJOonjdauR
         QQYg==
X-Gm-Message-State: AOAM531P7y3Gpsa5C/tzSRjtATxvACG/2K7C5CbcyF1QUqa1AW6UYDJT
        rB9mniCZx7DlFY9hNVcDp83EiV1GlAeEMMw=
X-Google-Smtp-Source: ABdhPJyYwiM3tYuAQYfbs3auU9QO6USQg3MKAJPq4FydXJn8qt4Rdnb95i6Pbo6Cr44QlLyvnjEf6w==
X-Received: by 2002:ac2:569a:: with SMTP id 26mr12619764lfr.257.1622621316001;
        Wed, 02 Jun 2021 01:08:36 -0700 (PDT)
Received: from [192.168.1.52] ([95.161.221.177])
        by smtp.gmail.com with ESMTPSA id z8sm235607lfg.243.2021.06.02.01.08.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jun 2021 01:08:35 -0700 (PDT)
Subject: Re: [LTP PATCH v2 3/3] nfs_lib.sh: Check running rpc.mountd,
 rpc.statd
To:     Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc:     linux-nfs@vger.kernel.org
References: <20210526172503.18621-1-pvorel@suse.cz>
 <20210526172503.18621-3-pvorel@suse.cz>
From:   Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Message-ID: <02781c77-9fed-b111-c3ad-3043a6e0ca29@bell-sw.com>
Date:   Wed, 2 Jun 2021 11:08:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210526172503.18621-3-pvorel@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 26.05.2021 20:25, Petr Vorel wrote:
> NOTE: we're not checking rpcbind/portmap which is required for NFSv3,
> as it's rpc.mountd dependency.
> 
> Deliberately not add pgrep as required dependency.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> changes v1->v2:
> * check for rpc.mountd, rpc.statd
> (previsously checked for rpc.mountd, rpcbind/portmap)
> 
>  testcases/network/nfs/nfs_stress/nfs_lib.sh | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/testcases/network/nfs/nfs_stress/nfs_lib.sh b/testcases/network/nfs/nfs_stress/nfs_lib.sh
> index 26b670c35..9bef1b86a 100644
> --- a/testcases/network/nfs/nfs_stress/nfs_lib.sh
> +++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
> @@ -27,7 +27,7 @@ TST_PARSE_ARGS=nfs_parse_args
>  TST_USAGE=nfs_usage
>  TST_NEEDS_TMPDIR=1
>  TST_NEEDS_ROOT=1
> -TST_NEEDS_CMDS="$TST_NEEDS_CMDS mount exportfs"
> +TST_NEEDS_CMDS="$TST_NEEDS_CMDS exportfs mount"

Does it change anything?

The rest looks good.

>  TST_SETUP="${TST_SETUP:-nfs_setup}"
>  TST_CLEANUP="${TST_CLEANUP:-nfs_cleanup}"
>  TST_NEEDS_DRIVERS="nfsd"
> @@ -110,11 +110,6 @@ nfs_mount()
>  
>  nfs_setup()
>  {
> -	# Check if current filesystem is NFS
> -	if [ "$(stat -f . | grep "Type: nfs")" ]; then
> -		tst_brk TCONF "Cannot run nfs-stress test on mounted NFS"
> -	fi
> -
>  	local i
>  	local type
>  	local n=0
> @@ -123,6 +118,16 @@ nfs_setup()
>  	local remote_dir
>  	local mount_dir
>  
> +	if [ "$(stat -f . | grep "Type: nfs")" ]; then
> +		tst_brk TCONF "Cannot run nfs-stress test on mounted NFS"
> +	fi
> +
> +	if tst_cmd_available pgrep; then
> +		for i in rpc.mountd rpc.statd; do
> +			pgrep $i > /dev/null || tst_brk TCONF "$i not running"
> +		done
> +	fi
> +
>  	for i in $VERSION; do
>  		type=$(get_socket_type $n)
>  		tst_res TINFO "setup NFSv$i, socket type $type"
> 
