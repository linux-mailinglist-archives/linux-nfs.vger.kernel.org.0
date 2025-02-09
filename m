Return-Path: <linux-nfs+bounces-9975-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3465A2DAB5
	for <lists+linux-nfs@lfdr.de>; Sun,  9 Feb 2025 04:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB8CE18863B0
	for <lists+linux-nfs@lfdr.de>; Sun,  9 Feb 2025 03:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5029F18AE2;
	Sun,  9 Feb 2025 03:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="qbbnBV9A"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E32C14F70;
	Sun,  9 Feb 2025 03:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739072995; cv=none; b=s9yUKTK7tI1bdCWkOeEPtOP5murJDsXcyuNhX/9O+BGjQ77bY+iX6eVpAScRTKmsuNzUGXiBJzzwp6UQ9m8jkhJiOuqL4pc9klri8z+mREaH7e1Pb8McuHvRjy6lanE3qC2TUhQ3QkZ30DK5wb22ASNWbzOLoaIGhuGJF1IdxjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739072995; c=relaxed/simple;
	bh=BAXyD4hipZe1snTLV2EoYm+2i5FjEq48uxfWB/w0w1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nopKMmEiBruEotZ4H3KHBWgeZtrpAsD+DNR208mDteUwRpiGulLXoKLm4C4cuYtsejBvXmB7Q4kF+3iwGjChKGXH/EFky2E2CIbZ8XFo+gpls56ueMCXXfJFynFG7R7HoEcre2ahS/jCFEYqS1AGj/nDRCxF1jYBHmtRyHWiYA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=qbbnBV9A; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4YrD6k6SH3z9sQ5;
	Sun,  9 Feb 2025 04:42:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1739072543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m04RA4OznHMeMccQGW/Q5QOIqkOO+cTX8fddgkQ9Jf4=;
	b=qbbnBV9AK/t4kMPwwQvS48iOul9vL0A9Cuu8wYCRApdFVWKohOYMOKUYBfQvlEZ81DtfQI
	24Uqo2HleZNIBC3JFOF5/vQBQklUITXNlZCBRyAypNn/w1AE5GfpZXa/p58p/Z+rNk01Rl
	68WWabLx9+KHJFOXNicSevoRpopYoT8pgg8Brs1fr4C0xdFPrY2nLFNj1ZfCJNFr0Gw7ZR
	WXAgwILb1cpvTarnWsCxAEASveXq/V9GI5sDIBZkF916e61wcvWZE2dZ0fCMYhJpmb7V+1
	KxpeGAJS02VruyTn0AQNeKToKzQGHtr4ktXIuifmdHW3H5JZJPwC86L3eEt3TA==
Date: Sat, 8 Feb 2025 22:42:19 -0500
From: Ethan Carter Edwards <ethan@ethancedwards.com>
To: Trond Myklebust <trondmy@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>, 
	"kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>
Subject: Re: [PATCH] NFSv4: harden nfs4_get_uniquifier() function
Message-ID: <dupajamhv63sqan3ybqi3sode4qt3ehtmvqa3qnbdxb6uvntsf@6oshvrg2j2f2>
References: <k7n2k4zqqnf6yisotj6ofgne7lvmwgy3yghygvwixfmkyrcwgl@4z26pbujl3gq>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <k7n2k4zqqnf6yisotj6ofgne7lvmwgy3yghygvwixfmkyrcwgl@4z26pbujl3gq>
X-Rspamd-Queue-Id: 4YrD6k6SH3z9sQ5

I wanted to check in on this. Anything I should change?

Thanks,
Ethan

On 25/01/19 11:55PM, Ethan Carter Edwards wrote:
> If the incorrect buffer size were passed into nfs4_get_uniquifier
> function then a memory access error could occur. This change prevents us
> from accidentally passing an unrelated variable into the buffer copy
> function.
> 
> Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
> ---
>  fs/nfs/nfs4proc.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 405f17e6e0b4..18311bf5338d 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -6408,7 +6408,7 @@ static void nfs4_init_boot_verifier(const struct nfs_client *clp,
>  }
>  
>  static size_t
> -nfs4_get_uniquifier(struct nfs_client *clp, char *buf, size_t buflen)
> +nfs4_get_uniquifier(struct nfs_client *clp, char *buf)
>  {
>  	struct nfs_net *nn = net_generic(clp->cl_net, nfs_net_id);
>  	struct nfs_netns_client *nn_clp = nn->nfs_client;
> @@ -6420,12 +6420,12 @@ nfs4_get_uniquifier(struct nfs_client *clp, char *buf, size_t buflen)
>  		rcu_read_lock();
>  		id = rcu_dereference(nn_clp->identifier);
>  		if (id)
> -			strscpy(buf, id, buflen);
> +			strscpy(buf, id, sizeof(buf));
>  		rcu_read_unlock();
>  	}
>  
>  	if (nfs4_client_id_uniquifier[0] != '\0' && buf[0] == '\0')
> -		strscpy(buf, nfs4_client_id_uniquifier, buflen);
> +		strscpy(buf, nfs4_client_id_uniquifier, sizeof(buf));
>  
>  	return strlen(buf);
>  }
> @@ -6449,7 +6449,7 @@ nfs4_init_nonuniform_client_string(struct nfs_client *clp)
>  		1;
>  	rcu_read_unlock();
>  
> -	buflen = nfs4_get_uniquifier(clp, buf, sizeof(buf));
> +	buflen = nfs4_get_uniquifier(clp, buf);
>  	if (buflen)
>  		len += buflen + 1;
>  
> @@ -6496,7 +6496,7 @@ nfs4_init_uniform_client_string(struct nfs_client *clp)
>  	len = 10 + 10 + 1 + 10 + 1 +
>  		strlen(clp->cl_rpcclient->cl_nodename) + 1;
>  
> -	buflen = nfs4_get_uniquifier(clp, buf, sizeof(buf));
> +	buflen = nfs4_get_uniquifier(clp, buf);
>  	if (buflen)
>  		len += buflen + 1;
>  
> -- 
> 2.48.0
> 

