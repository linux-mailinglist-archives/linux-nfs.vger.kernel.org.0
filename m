Return-Path: <linux-nfs+bounces-4689-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDF89295B0
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Jul 2024 00:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28630281D62
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Jul 2024 22:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EA181E;
	Sat,  6 Jul 2024 22:43:49 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862BA4D8CE
	for <linux-nfs@vger.kernel.org>; Sat,  6 Jul 2024 22:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720305829; cv=none; b=BrcyQqlZvTvopTBsplnxyMOtNNR5gzjzegMV7sXv1b+i90DRFfSo4liSnAUg+CiO84VSt93ab8zvCVctf9Ug8I29tPHI0xUzxRYS0uy9KBODhDamCwFX/8RshTNbn66G4hLz0yXSvPLMVhUZ9/yB3SR14aaVOkq7ODnpCUok8qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720305829; c=relaxed/simple;
	bh=qj8Lojo0K+erjF0KN2ykrttVBdxM0p/ID8OfihT9SFg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=l+ehNNPTRZdM6QN1ShOyFpC7Wky8Ny6o3tPqvq5Hp7TyWf7gXWY7BnFPaL+aOkYoH4Ie8EYB0MG/GwvnlxDFUuTUtBiBwdF81WZf9gbUC+9wTWKx4sqNx4hixQQV05Wuj9V2gdO4iXPIxObb0zl2xbzzqP6usvOq5rC/pGbnWgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4265dd11476so1168445e9.1
        for <linux-nfs@vger.kernel.org>; Sat, 06 Jul 2024 15:43:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720305826; x=1720910626;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CTp3wRGF/ntO6awCsqwF/APv+jXOlHkPg8UV8//mdfo=;
        b=jZ//KpesCDJ6+qF6zL/KSiwBXWcp7j94xWRWMitS8XvoukAHhUs0cd4yoxn576X5ds
         lhCKNDYbIeiZsRY2qVTzSHaPIhKIv/LeDCisjOIbF2O8iKt3etzqgDunbhD3I2EO2hMX
         7IlEAfm6MrYYeTXEU32smJr0CpN08Ewr+FxsqsoXrRa2V2F90pKPRsSP9GSZEahMYnmO
         0M+cW53rlZH8AGpHyyg2ajN682oZBjayPTsgO/DqrTDVYL+LUPRSnPgHJjhvhCjERhPp
         FTUAnBnzLuowX+xMTVYfsFiwkOSpOP4RVzCF5BFUC54PpAHcw4rIifcKBRf9mYzAbC/i
         BkXg==
X-Gm-Message-State: AOJu0YxCs3447I+sPFjga+siRovrj4HU+URNH+uSGdzk2cLwsxv9IOtU
	EAkB+xPGjEecYBffDig2lywVWteSFhoa28ZlMmGVmJ3uvbLfJIW3
X-Google-Smtp-Source: AGHT+IEXurGP2YA/DYIrMHwRR9lO5OcboiNdRLphwjNPDM9XPdovWEOaxKZJ4bWLqGl0RD++93k9Bg==
X-Received: by 2002:a05:6000:1542:b0:364:8215:7142 with SMTP id ffacd0b85a97d-3679dd1745dmr5538699f8f.1.1720305825668;
        Sat, 06 Jul 2024 15:43:45 -0700 (PDT)
Received: from [10.100.102.74] (85.65.198.251.dynamic.barak-online.net. [85.65.198.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4265e9de055sm39092925e9.34.2024.07.06.15.43.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jul 2024 15:43:45 -0700 (PDT)
Message-ID: <597ff022-6599-4341-8a98-117e410d2c76@grimberg.me>
Date: Sun, 7 Jul 2024 01:43:44 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfc] nfsd: offer write delegation for O_WRONLY opens
From: Sagi Grimberg <sagi@grimberg.me>
To: Chuck Lever <chuck.lever@oracle.com>, Dai Ngo <dai.ngo@oracle.com>
Cc: linux-nfs@vger.kernel.org
References: <20240706224207.927978-1-sagi@grimberg.me>
Content-Language: en-US
In-Reply-To: <20240706224207.927978-1-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Actually CCing Dai Ngo...
On 07/07/2024 1:42, Sagi Grimberg wrote:
> Many applications open files with O_WRONLY, fully intending to write
> into the opened file. There is no reason why these applications should
> not enjoy a write delegation handed to them.
>
> Cc: Dai Ngo <dai.ngo@oracle.com>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
> Note: I couldn't find any reason to why the initial implementation chose
> to offer write delegations only to NFS4_SHARE_ACCESS_BOTH, but it seemed
> like an oversight to me. So I figured why not just send it out and see who
> objects...
>
>   fs/nfsd/nfs4state.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index a20c2c9d7d45..69d576b19eb6 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -5784,15 +5784,15 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>   	 *  "An OPEN_DELEGATE_WRITE delegation allows the client to handle,
>   	 *   on its own, all opens."
>   	 *
> -	 * Furthermore the client can use a write delegation for most READ
> -	 * operations as well, so we require a O_RDWR file here.
> -	 *
> -	 * Offer a write delegation in the case of a BOTH open, and ensure
> -	 * we get the O_RDWR descriptor.
> +	 * Offer a write delegation in the case of a BOTH open (ensure
> +	 * a O_RDWR descriptor) Or WRONLY open (with a O_WRONLY descriptor).
>   	 */
>   	if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) == NFS4_SHARE_ACCESS_BOTH) {
>   		nf = find_rw_file(fp);
>   		dl_type = NFS4_OPEN_DELEGATE_WRITE;
> +	} else if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
> +		nf = find_writeable_file(fp);
> +		dl_type = NFS4_OPEN_DELEGATE_WRITE;
>   	}
>   
>   	/*


