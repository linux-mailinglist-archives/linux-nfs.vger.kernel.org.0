Return-Path: <linux-nfs+bounces-11582-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A027AAE38C
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 16:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DA947A8344
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 14:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C402874F1;
	Wed,  7 May 2025 14:51:20 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23C62139D2;
	Wed,  7 May 2025 14:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746629480; cv=none; b=g6lRA0u87d/7kL4v5Lu3t+helv6qHSrlVOk/x5sND6UQatU9R+RXPZ+STZbyTU2jE1Md9TkTsNLre7iBvD2UOPJje2GawODDuUKcdeqfrVJ/3sc2RJ4qe+GuA/zog8+JugUIBAHBTAJkezdpNlRlkssQ/I4p1wIPn/BLzwFUN1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746629480; c=relaxed/simple;
	bh=NPA5fWeiy+CdF2Izc2yyx1/a1+9Qt6WzEAMq3XypOaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=As135YLHD4urdbUqrj2FDgXJH4hqGilHTyg4xvLF0P4uJKMhNUVKSskDrXwrXWXYnHurcQc/815nrR/2EwuJSoK33XcjtptT/EAG/e1g2hR/eXsNZ6cL47kwVOIKXeimtEkdIiXNEPeRaYm61P9RT1a2n1hO+3xorW17iMYjWU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3995ff6b066so3495514f8f.3;
        Wed, 07 May 2025 07:51:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746629477; x=1747234277;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=834ecun7GkIpcfgOiJfl+krcWKVVEZ53RPy+KA72j+8=;
        b=sffQ8uAUwQt5uk7fDnvYPAkSsaIt/35q7+vzPepVWZ4G52Cm0h5bkOxz26kU8YXnyf
         Cp25dyGuec+wrFcRwuyL7Khf3Pl3zz2tFcKHvWgVR755anktUq1ySko5wlUIdi78DgmE
         74GNxHA4kfxwQyd6ZF3h/+apCibQ/DATPoUx2jmR+cVZD40U2AJ8CjDJIhekZkQDpUGE
         tYL0OHMhIk2TdZ3zOiZ1NE5vgVebq5j+bGXM0IZrXPbfBiEtck8sRODVtTdOONQ2y4uX
         X7kMIVIkGrBNbHJh4xUy3ZjCCHrxoTNgBdeSDTEiQOEaI+zN6fpXok3dKjg3FQzoYsth
         GbuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZpZXgz3excW9v/SWFBFKnAiOA3im2NoU8JdPxPGmioXHJ6LCdT8ZcxfpnNadYBTsq7NOE4HGrsw==@vger.kernel.org, AJvYcCVWlNGnII/qwP1PrQa9J7qggLzD3UZNzaFn3FdKRWWciI10aPtjMEbH679ZCBTTfiYezU0zeY3jzp3R@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3ew+YDQiudbnBiRyZgc+HA6mTxyV/uVql01aWmOy+eTMHpx3M
	St4yQdl1mmr4BWVggIwARE2klefwsx1pb0S7S6W9xU4mYWxMVbJ7
X-Gm-Gg: ASbGnctUvilF2TDjwTW8nDD91E01FBVFJnd3SURxe0FZ/xCurWyIbuKHUpvjyXmkU1S
	T9W6Si6ZaajOmnv4TrTC+vh6vA82SmBcmRdcSMlNMYt95l4rIxqG43FBnkCbcc443L6e8Gjo4Rq
	Pm5rwGqduMyhPqTBXV+4H/AFAaiGVfa3YwCDN4Ejxl+BLRBe1mDqJUAqpoVIZ5fiEiUf7TJf7Y1
	NGdgcg91+p6tnXp6CMUBJ5dHMrICecY6q5rQTtcseb7j3fpcKFHz2CJQdVP29bC3V+UA4fg5CKW
	FypF45Yn0PN8mmPErX+gt8ivd6AUBWO+lYRRRZ79bMvY4hF6cfbJWW9ktckf5Zc/K7qo0yKRbXc
	+2RpU1eeByPwwCckY
X-Google-Smtp-Source: AGHT+IFoRriMU6u/G78ePtFV+Mux25cjZQlxF2bl1IUWwvPj1gOeuLmcuec2LPLUjNg6YlnXe/SfYg==
X-Received: by 2002:a5d:64e8:0:b0:3a0:809f:1c95 with SMTP id ffacd0b85a97d-3a0b4a6868bmr3113188f8f.53.1746629476779;
        Wed, 07 May 2025 07:51:16 -0700 (PDT)
Received: from [10.50.5.11] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae7caasm17377865f8f.54.2025.05.07.07.51.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 May 2025 07:51:16 -0700 (PDT)
Message-ID: <778e6327-f77a-4f14-a243-197058ed278d@grimberg.me>
Date: Wed, 7 May 2025 17:51:14 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nfs: create a kernel keyring
To: Christoph Hellwig <hch@lst.de>, Chuck Lever <chuck.lever@oracle.com>,
 Trond Myklebust <trondmy@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>, David Howells <dhowells@redhat.com>,
 Jarkko Sakkinen <jarkko@kernel.org>, linux-nfs@vger.kernel.org,
 kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>,
 keyrings@vger.kernel.org
References: <20250507080944.3947782-1-hch@lst.de>
 <20250507080944.3947782-3-hch@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250507080944.3947782-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 07/05/2025 11:09, Christoph Hellwig wrote:
> Create a kernel .nfs keyring similar to the nvme .nvme one.  Unlike for
> a userspace-created keyrind, tlshd is a possesor of the keys with this
> and thus the keys don't need user read permissions.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/nfs/inode.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
>
> diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> index 119e447758b9..fb1fe1bdfe92 100644
> --- a/fs/nfs/inode.c
> +++ b/fs/nfs/inode.c
> @@ -2571,6 +2571,8 @@ static struct pernet_operations nfs_net_ops = {
>   	.size = sizeof(struct nfs_net),
>   };
>   
> +static struct key *nfs_keyring;
> +
>   /*
>    * Initialize NFS
>    */
> @@ -2578,6 +2580,17 @@ static int __init init_nfs_fs(void)
>   {
>   	int err;
>   
> +	if (IS_ENABLED(CONFIG_NFS_V4)) {

xprtsec is sunrpc, meaning it is also supported with nfsv3.

> +		nfs_keyring = keyring_alloc(".nfs",
> +				     GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
> +				     current_cred(),
> +				     (KEY_POS_ALL & ~KEY_POS_SETATTR) |
> +				     (KEY_USR_ALL & ~KEY_USR_SETATTR),
> +				     KEY_ALLOC_NOT_IN_QUOTA, NULL, NULL);
> +		if (IS_ERR(nfs_keyring))
> +			return PTR_ERR(nfs_keyring);
> +	}
> +
>   	err = nfs_sysfs_init();
>   	if (err < 0)
>   		goto out10;
> @@ -2653,6 +2666,8 @@ static void __exit exit_nfs_fs(void)
>   	nfs_fs_proc_exit();
>   	nfsiod_stop();
>   	nfs_sysfs_exit();
> +	if (IS_ENABLED(CONFIG_NFS_V4))
> +		key_put(nfs_keyring);

Same comment

>   }
>   
>   /* Not quite true; I just maintain it */


