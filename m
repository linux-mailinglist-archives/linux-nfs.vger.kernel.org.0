Return-Path: <linux-nfs+bounces-16368-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB4AC5A5B5
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Nov 2025 23:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8871C3AA944
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Nov 2025 22:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F1D2F6186;
	Thu, 13 Nov 2025 22:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRo45SHI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B172E1C63
	for <linux-nfs@vger.kernel.org>; Thu, 13 Nov 2025 22:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763073680; cv=none; b=UMgQ0kK5n2UhLjkvjtvb0JNqPRcbwYErk4omHdS0XZgVC4HkYUN0s7jM88zsu8AQ33gTil3hL79P9W9ChBNldpuTzBCxhjk4G0YF9l8iYgbE/6PYg+bEAwcDhN83YzWnBbbLzRRQq4WPjdsKGm/nrlQP+sRDNuqjNaDbOSTC6vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763073680; c=relaxed/simple;
	bh=wuhUrBkpYHNqOmOsc3jAamBz7TmQEaj2DohsfZdyVio=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bTT9M50fciSReiZp8P0fMPBZWbZWQhS3ydPsUVdeySS6ZYJ93Mra6n4fnOZJTKQJGNRTjwtJYtWuEsapYUoQi2+J78eUXTOOWej2wBfrAXD+qIueai/XipbeeRD9hqZwwLDs49DeDygaxEepar9iS3hx9XdOxo3laaM+/usYG/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LRo45SHI; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42b3d7c1321so1017107f8f.3
        for <linux-nfs@vger.kernel.org>; Thu, 13 Nov 2025 14:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763073677; x=1763678477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i1g5Jnwv1NM4epHCfRkfVMg4AiQoQf6OvEpUjAmOBrU=;
        b=LRo45SHI+mQZ0M1fxMQjVNYawddFcXKmHCdv6Rup1Zm57qi8TYysywZR2yrH5aw+XU
         boeK5b0zAAfaXo1Az2+IaMmEfJzD+QVc2uHHhpB9jWaqRSqJ8t2C6KTumwfZ+PaURbsD
         lJ3pfDm4tMKZImho8Kb5+6MRU7wp14ChLTEU8+7IxN9o0ZumG4wRY7ahg7EA0Oz0yvBt
         PD/bJD5yzhpM8SbBjtedOb8VEjM1/HLFp18tnCd11VvYH5tP/zP7duGzHloOhYcu4fF2
         ZNxAoQTomt0+qoHr4MW9whFbIIyj8MZ1y/lB2dqA3IuyiGpUHSHJpiv55QrSD32XpNnb
         LJdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763073677; x=1763678477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i1g5Jnwv1NM4epHCfRkfVMg4AiQoQf6OvEpUjAmOBrU=;
        b=H3TUvkSLWb/wWNNr5Kw4OR8q8OgKFe0Ld4QBSLhrXAajLA9bZIX0ce5z9saYtbbnu4
         okqL1D5ODiSxSIrTpY3L5fjCNgGgE0bP4iS8fYccznuT+2Lw0TWIW1giaobNzbhMPXVq
         wcxdEDpd0+VKLhiBShozQGhrzp/2Uirrjn+P/eeZ3iqPWS7tA5VXq7+KvOEHU436kZ5c
         pt21hMMVbgUq/W2uWiUJJRVYN5MTjLSUDLuvTzutJAX5DI6oO0QGX89AFQsR8cSlPgBU
         QgUFp/CTCC4shZDPJFDING7/x4uXrf2WkcRM/XPT05yMGilHbk7N3FTHt1nhik3dBjDC
         Mxrg==
X-Gm-Message-State: AOJu0YyByz/SumjQXEWSynyWRya29YP9SgIuhxxHbcrQl3AJNQAjjlHH
	0rOoKmB196jll76i07A8Ptl5DbpLQho/dow3wS4r1QOglxyn1cDn4fd4Xb3p/Q==
X-Gm-Gg: ASbGncuxg19P3ROqm4vI98ir12n/dKXFjp9JIXhqf6XvAkAAEhc0/ZsEuWbuzMPjfZU
	GHNgIE6JaLzzNvi+lAoBaKmmo6Kv/dClanZ0he4mbRWe96GQIku1deWsEdDdInMttVD1GavK11+
	l+l72mJnPc1TRG1BnJHOInmMImX3O/Eoo9GZiEQIBPbjZvZZrSdw1eY6HgcR2x+wdc2LsIl+gag
	CSaLrzuPQYRhbq7daTwmQdaJKUufUhLERJ+PMke8/7XoeaL/Dk8DUhvP+Qq8VK92yRDTzDLy5pa
	zbw210UwD82XRvJ8GwvFveGGV/6jpkvKw4s+aIh+zYI41T1Nqj2bhme3ZpV/H/7JsDybjyjHX8G
	F5gETzDQTfMWTrf1gmdIZ2NDdNpuiEcGgmR3GUN7CPq3KpwXNptZK8QRmukBMtBRMT4aq/i6LGj
	neQIuJbnYk6wmkhm5ornV8Rsf65n4ZemlM/+dY3vblXEaDAEbBlyhvPSQ/6nslu8A=
X-Google-Smtp-Source: AGHT+IH2BFZsetaKWD12tbOxB3F3a9438JU7fo2sbGwmxQg+1hfuR4AZeJjpUN53s3HuHom2sH7TWw==
X-Received: by 2002:a5d:5d0b:0:b0:42b:4267:83e9 with SMTP id ffacd0b85a97d-42b59342cb8mr797340f8f.2.1763073677140;
        Thu, 13 Nov 2025 14:41:17 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f0b622sm6129433f8f.29.2025.11.13.14.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 14:41:16 -0800 (PST)
Date: Thu, 13 Nov 2025 22:41:13 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Sergey Shtylyov <s.shtylyov@omp.ru>
Cc: <linux-nfs@vger.kernel.org>, Trond Myklebust <trondmy@kernel.org>, Anna
 Schumaker <anna@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] NFSv4: prevent integer overflow while calling
 nfs4_set_lease_period()
Message-ID: <20251113224113.4f752ccc@pumpkin>
In-Reply-To: <e0d1a313-f359-4ad0-bee3-3fcf0ffc0cda@omp.ru>
References: <e0d1a313-f359-4ad0-bee3-3fcf0ffc0cda@omp.ru>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Nov 2025 23:37:03 +0300
Sergey Shtylyov <s.shtylyov@omp.ru> wrote:

> The nfs_client::cl_lease_time field (as well as the jiffies variable it's
> used with) is declared as *unsigned long*, which is 32-bit type on 32-bit
> arches and 64-bit type on 64-bit arches. When nfs4_set_lease_period() that
> sets nfs_client::cl_lease_time is called, 32-bit nfs_fsinfo::lease_time
> field is multiplied by HZ -- that might overflow before being implicitly
> cast to *unsigned long*. Actually, there's no need to multiply by HZ at all
> the call sites of nfs4_set_lease_period() -- it makes more sense to do that
> once, inside that function, calling check_mul_overflow() and falling back
> to 1 hour on an actual overflow...
> 
> Found by Linux Verification Center (linuxtesting.org) with the Svace static
> analysis tool.
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> Cc: stable@vger.kernel.org
> 
> ---
> The patch is against the master branch of Trond Myklebust's linux-nfs.git repo.
> 
> Changes in version #3:
> - changed the lease period overflow fallback to 1 hour, updated the patch
>   description accordingly.
> 
> Changes in version #2:
> - made use of check_mul_overflow() instead of mul_u32_u32();
> - capped the multiplication result at ULONG_MAX instead of returning -ERANGE,
>   keeping nfs4_set_lease_period() *void*;
> - rewrote the patch description accordingly.
> 
>  fs/nfs/nfs4_fs.h    |    3 +--
>  fs/nfs/nfs4proc.c   |    2 +-
>  fs/nfs/nfs4renewd.c |   10 +++++++---
>  fs/nfs/nfs4state.c  |    2 +-
>  4 files changed, 10 insertions(+), 7 deletions(-)
> 
> Index: linux-nfs/fs/nfs/nfs4_fs.h
> ===================================================================
> --- linux-nfs.orig/fs/nfs/nfs4_fs.h
> +++ linux-nfs/fs/nfs/nfs4_fs.h
> @@ -464,8 +464,7 @@ struct nfs_client *nfs4_alloc_client(con
>  extern void nfs4_schedule_state_renewal(struct nfs_client *);
>  extern void nfs4_kill_renewd(struct nfs_client *);
>  extern void nfs4_renew_state(struct work_struct *);
> -extern void nfs4_set_lease_period(struct nfs_client *clp, unsigned long lease);
> -
> +extern void nfs4_set_lease_period(struct nfs_client *clp, u32 period);
>  
>  /* nfs4state.c */
>  extern const nfs4_stateid current_stateid;
> Index: linux-nfs/fs/nfs/nfs4proc.c
> ===================================================================
> --- linux-nfs.orig/fs/nfs/nfs4proc.c
> +++ linux-nfs/fs/nfs/nfs4proc.c
> @@ -5478,7 +5478,7 @@ static int nfs4_do_fsinfo(struct nfs_ser
>  		err = _nfs4_do_fsinfo(server, fhandle, fsinfo);
>  		trace_nfs4_fsinfo(server, fhandle, fsinfo->fattr, err);
>  		if (err == 0) {
> -			nfs4_set_lease_period(server->nfs_client, fsinfo->lease_time * HZ);
> +			nfs4_set_lease_period(server->nfs_client, fsinfo->lease_time);
>  			break;
>  		}
>  		err = nfs4_handle_exception(server, err, &exception);
> Index: linux-nfs/fs/nfs/nfs4renewd.c
> ===================================================================
> --- linux-nfs.orig/fs/nfs/nfs4renewd.c
> +++ linux-nfs/fs/nfs/nfs4renewd.c
> @@ -137,11 +137,15 @@ nfs4_kill_renewd(struct nfs_client *clp)
>   * nfs4_set_lease_period - Sets the lease period on a nfs_client
>   *
>   * @clp: pointer to nfs_client
> - * @lease: new value for lease period
> + * @period: new value for lease period (in seconds)
>   */
> -void nfs4_set_lease_period(struct nfs_client *clp,
> -		unsigned long lease)
> +void nfs4_set_lease_period(struct nfs_client *clp, u32 period)
>  {
> +	unsigned long lease;
> +
> +	if (check_mul_overflow(period, HZ, &lease))
> +		lease = 60UL * 60UL * HZ; /* one hour */

That isn't good enough, just a few lines higher there is:
	timeout = (2 * clp->cl_lease_time) / 3 + (long)clp->cl_last_renewal
		- (long)jiffies;

So the value has to be multipliable by 2 without overflowing.
I also suspect the modulo arithmetic also only works if the values
are 'much smaller than long'.
With HZ = 1000 and a requested period of 1000 hours the multiply (just)
fits in 32 bits - but none of the code is going to work at all.

It would be simpler and safer to just put a sanity upper limit on period.
I've no idea what normal/sane values are (lower as well as upper).
But perhaps you want:
	/* For sanity clamp between 10 mins and 100 hours */
	lease = clamp(period, 10 * 60, 100 * 60 * 60) * HZ;

> +
>  	spin_lock(&clp->cl_lock);
>  	clp->cl_lease_time = lease;
>  	spin_unlock(&clp->cl_lock);

Do I see a lock that doesn't?

	David

> Index: linux-nfs/fs/nfs/nfs4state.c
> ===================================================================
> --- linux-nfs.orig/fs/nfs/nfs4state.c
> +++ linux-nfs/fs/nfs/nfs4state.c
> @@ -103,7 +103,7 @@ static int nfs4_setup_state_renewal(stru
>  
>  	status = nfs4_proc_get_lease_time(clp, &fsinfo);
>  	if (status == 0) {
> -		nfs4_set_lease_period(clp, fsinfo.lease_time * HZ);
> +		nfs4_set_lease_period(clp, fsinfo.lease_time);
>  		nfs4_schedule_state_renewal(clp);
>  	}
>  
> 


