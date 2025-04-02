Return-Path: <linux-nfs+bounces-10992-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAFBA793D9
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Apr 2025 19:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD177170780
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Apr 2025 17:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300751C5F13;
	Wed,  2 Apr 2025 17:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="Ht7+YlnS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE86E1A38E1;
	Wed,  2 Apr 2025 17:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743615070; cv=none; b=HAWUsRDZJEsRW+rVhZ+myYBnHQlkKwCIyeXKdO85WwpetZtEvN54enxcOrqgfJ/t4YYd4E7a2dBLUtZSvvhcrcmsEA0pG6xkQwoYidOM6kfaqxKPLLYLPC+wEKECA3xaWGmlBClICJ7Sa5LStx+XkgmkPPK1dh9e5yJ/hJztHP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743615070; c=relaxed/simple;
	bh=hQZElL9dtPmCVL0Z4NkiVaj24cdfHIudayPnvK6PQFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KftbyNogyOzJk7odov2040DkhJas614v1NKyDvYCTLKNR8B+FbH/7BvdUwqd3zeAeBdfJKugsiRZ3dBuDOx9qSsy6UMjvkvTwyxFS0l33FyGvUB0WXHpfs28OBRRzQNsUNKnTGZysQ7dcQUPrT4AoMdS2GAvBQEexPuDYbdoRG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=Ht7+YlnS; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=owalu71vA94GLpyhv8YYokgK8S4IScde/oftkQ21Km8=; b=Ht7+YlnSYGbsiOiQ
	B4VMnt5Pn2AHoxyaLjRZ/hiVfzaT7nmsa45kyqvhbeTU56fAdPqPgcWxmQSMfWlyAdsgud/vbGtlL
	Vwx7SNbpyC6L6PfgyTwVY/CMYx2NHM6IBwE/PQDFDtzhSC8iOezeeWLAxztP+qmYIa1grlb/YKhoD
	QsO4/KOIMxM95aYq0iLBCrYPWsyY5/ydRD+lsRY5U5HyTGLiKOZy4oRgvzxl/qGPkpLTbIK2VTWQw
	7j55hR1AVq1HVek5grOLz17rMKDnrwuJGsG6nXsyru1ajESjpRGfbTzWzIfM+N6oPOZ/TmbrGJOJS
	ycL8DO14Gdd7fSPuGQ==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1u01vY-008d5h-1k;
	Wed, 02 Apr 2025 17:31:00 +0000
Date: Wed, 2 Apr 2025 17:31:00 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: trondmy@kernel.org, anna@kernel.org, linux-nfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NFS: Remove unused function nfs_umount
Message-ID: <Z-10VGi6E8g3gi4Q@gallifrey>
References: <20250218215250.263709-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20250218215250.263709-1-linux@treblig.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 17:30:34 up 329 days,  4:44,  1 user,  load average: 0.06, 0.04,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* linux@treblig.org (linux@treblig.org) wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> nfs_umount() has been unused since 2013's
> commit 4580a92d44e2 ("NFS: Use server-recommended security flavor by
> default (NFSv3)")
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Hi,
  I'd appreciate a review on this one please.

Dave (just going cleaning up his old patch list)
> ---
>  fs/nfs/internal.h   |  1 -
>  fs/nfs/mount_clnt.c | 68 ---------------------------------------------
>  2 files changed, 69 deletions(-)
> 
> diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
> index fae2c7ae4acc..36dcbb928c5f 100644
> --- a/fs/nfs/internal.h
> +++ b/fs/nfs/internal.h
> @@ -207,7 +207,6 @@ struct nfs_mount_request {
>  };
>  
>  extern int nfs_mount(struct nfs_mount_request *info, int timeo, int retrans);
> -extern void nfs_umount(const struct nfs_mount_request *info);
>  
>  /* client.c */
>  extern const struct rpc_program nfs_program;
> diff --git a/fs/nfs/mount_clnt.c b/fs/nfs/mount_clnt.c
> index 57c9dd700b58..db8dfb920394 100644
> --- a/fs/nfs/mount_clnt.c
> +++ b/fs/nfs/mount_clnt.c
> @@ -223,74 +223,6 @@ int nfs_mount(struct nfs_mount_request *info, int timeo, int retrans)
>  	goto out;
>  }
>  
> -/**
> - * nfs_umount - Notify a server that we have unmounted this export
> - * @info: pointer to umount request arguments
> - *
> - * MOUNTPROC_UMNT is advisory, so we set a short timeout, and always
> - * use UDP.
> - */
> -void nfs_umount(const struct nfs_mount_request *info)
> -{
> -	static const struct rpc_timeout nfs_umnt_timeout = {
> -		.to_initval = 1 * HZ,
> -		.to_maxval = 3 * HZ,
> -		.to_retries = 2,
> -	};
> -	struct rpc_create_args args = {
> -		.net		= info->net,
> -		.protocol	= IPPROTO_UDP,
> -		.address	= (struct sockaddr *)info->sap,
> -		.addrsize	= info->salen,
> -		.timeout	= &nfs_umnt_timeout,
> -		.servername	= info->hostname,
> -		.program	= &mnt_program,
> -		.version	= info->version,
> -		.authflavor	= RPC_AUTH_UNIX,
> -		.flags		= RPC_CLNT_CREATE_NOPING,
> -		.cred		= current_cred(),
> -	};
> -	struct rpc_message msg	= {
> -		.rpc_argp	= info->dirpath,
> -	};
> -	struct rpc_clnt *clnt;
> -	int status;
> -
> -	if (strlen(info->dirpath) > MNTPATHLEN)
> -		return;
> -
> -	if (info->noresvport)
> -		args.flags |= RPC_CLNT_CREATE_NONPRIVPORT;
> -
> -	clnt = rpc_create(&args);
> -	if (IS_ERR(clnt))
> -		goto out_clnt_err;
> -
> -	dprintk("NFS: sending UMNT request for %s:%s\n",
> -		(info->hostname ? info->hostname : "server"), info->dirpath);
> -
> -	if (info->version == NFS_MNT3_VERSION)
> -		msg.rpc_proc = &clnt->cl_procinfo[MOUNTPROC3_UMNT];
> -	else
> -		msg.rpc_proc = &clnt->cl_procinfo[MOUNTPROC_UMNT];
> -
> -	status = rpc_call_sync(clnt, &msg, 0);
> -	rpc_shutdown_client(clnt);
> -
> -	if (unlikely(status < 0))
> -		goto out_call_err;
> -
> -	return;
> -
> -out_clnt_err:
> -	dprintk("NFS: failed to create UMNT RPC client, status=%ld\n",
> -			PTR_ERR(clnt));
> -	return;
> -
> -out_call_err:
> -	dprintk("NFS: UMNT request failed, status=%d\n", status);
> -}
> -
>  /*
>   * XDR encode/decode functions for MOUNT
>   */
> -- 
> 2.48.1
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

