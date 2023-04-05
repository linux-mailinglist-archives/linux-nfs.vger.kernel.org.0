Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639236D83B5
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Apr 2023 18:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbjDEQar (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Apr 2023 12:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233369AbjDEQaq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 5 Apr 2023 12:30:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FCA2115
        for <linux-nfs@vger.kernel.org>; Wed,  5 Apr 2023 09:30:01 -0700 (PDT)
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-zO-K_aCHNs6UKx0eeYXFwA-1; Wed, 05 Apr 2023 12:30:00 -0400
X-MC-Unique: zO-K_aCHNs6UKx0eeYXFwA-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-746b617d095so6238485a.0
        for <linux-nfs@vger.kernel.org>; Wed, 05 Apr 2023 09:29:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680712199; x=1683304199;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3R2e+Py70F6/l2XshaOrAurKVbrVVROj0+CQ7zPSHtY=;
        b=tXvFKyWirB5zQnGNUN0oW0ItXLZP+CGDdRKJZtyr5wAJz1x+jtDcWUybUxnXdEOTYv
         bxlQm2SHfPYZHftlxY8WPZfJvxoWlvmgfIJJk482SXqk2jgoTxLDRcov3hChxO/9h7lN
         kE19ZKNdeule0FKaviYOIq40JuixsoRK/A9Tg54t8050A8Vws54AUCniz/N/ruuwAvtT
         +w89nJ+dzNwfA0pNeuCAi0DcpIWmwNpVMRo18zgCFX8d03GoGkmEV0sMqIW2jVJE6X26
         ZyVxymgvZTyjPI18Uqc11ep/joxSyDfyjRZ93hD2V5Zxl8zBevij2khXdhHzfXD96tm/
         eUYg==
X-Gm-Message-State: AAQBX9cS0N20pW8KavRfaqsdzPxNr1qLAp0o7651/bOzy1FelLs4TZyx
        e0rYsh1lDnssrEdGUlj3gUR30eTJlBia0jh8aRrqLEHBv03DlHVrnYueNIJghqwxUqctTf5/FEk
        3HeB1idWdro8CyDRsRiHRJ4vs6KFe
X-Received: by 2002:a05:6214:5190:b0:5ad:cd4b:3765 with SMTP id kl16-20020a056214519000b005adcd4b3765mr4441355qvb.1.1680712198849;
        Wed, 05 Apr 2023 09:29:58 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZKTusuUx4Ld5JkVa8N4NIsYhOSQayyfkRJV8HU2X9jmUA5C9X8XBuFTu4xJ/hHpMDIkkOjFQ==
X-Received: by 2002:a05:6214:5190:b0:5ad:cd4b:3765 with SMTP id kl16-20020a056214519000b005adcd4b3765mr4441326qvb.1.1680712198495;
        Wed, 05 Apr 2023 09:29:58 -0700 (PDT)
Received: from [172.31.1.6] ([70.109.174.217])
        by smtp.gmail.com with ESMTPSA id r9-20020ae9d609000000b0074a29c9d8b7sm3766256qkk.134.2023.04.05.09.29.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 09:29:57 -0700 (PDT)
Message-ID: <ed63ab9d-e863-5596-1259-7d7efca2cf79@redhat.com>
Date:   Wed, 5 Apr 2023 12:29:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] export: Fix rootdir corner case in next_mnt()
Content-Language: en-US
To:     Richard Weinberger <richard@nod.at>
Cc:     trond.myklebust@hammerspace.com, linux-nfs@vger.kernel.org,
        chris.chilvers@appsbroker.com
References: <20230324121608.16808-1-richard@nod.at>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20230324121608.16808-1-richard@nod.at>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 3/24/23 8:16 AM, Richard Weinberger wrote:
> Currently the following setup causes failure:
> 
> 1. /etc/exports:
> / *(rw,crossmnt,no_subtree_check,fsid=root)
> 
> 2. /etc/nfs.conf:
> [exports]
>   rootdir=/nfs_srv
> 
> 3. Mounts:
> /root/fs1.ext4 on /nfs_srv type ext4 (rw,relatime)
> /root/fs2.ext4 on /nfs_srv/fs2 type ext4 (rw,relatime)
> 
> 4. On the client:
> $ ls /nfs_client/fs2
> ls: cannot open directory '/nfs_client/fs2': Stale file handle
> 
> The problem is that next_mnt() misses the corner case that
> every mount is a sub-mount of "/".
> So it fails to see that /nfs_srv/fs2 is a mountpoint when the
> client asks for fs2 it and as consequence the crossmnt mechanism
> fails.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
Committed... (tag: nfs-utils-2-6-3-rc7)

steved.
> ---
>   support/export/cache.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/support/export/cache.c b/support/export/cache.c
> index 2497d4f48df3..1c526277d3c6 100644
> --- a/support/export/cache.c
> +++ b/support/export/cache.c
> @@ -410,12 +410,16 @@ static char *next_mnt(void **v, char *p)
>   		*v = f;
>   	} else
>   		f = *v;
> -	while ((me = getmntent(f)) != NULL && l > 1) {
> +	while ((me = getmntent(f)) != NULL && l >= 1) {
>   		char *mnt_dir = nfsd_path_strip_root(me->mnt_dir);
>   
>   		if (!mnt_dir)
>   			continue;
>   
> +		/* Everything below "/" is a proper sub-mount */
> +		if (strcmp(p, "/") == 0)
> +			return mnt_dir;
> +
>   		if (strncmp(mnt_dir, p, l) == 0 && mnt_dir[l] == '/')
>   			return mnt_dir;
>   	}

