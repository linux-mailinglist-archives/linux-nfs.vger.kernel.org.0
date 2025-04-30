Return-Path: <linux-nfs+bounces-11379-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B48FDAA57EF
	for <lists+linux-nfs@lfdr.de>; Thu,  1 May 2025 00:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24D08501644
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Apr 2025 22:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E1E2248AA;
	Wed, 30 Apr 2025 22:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5H0Ymmr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6D822424E
	for <linux-nfs@vger.kernel.org>; Wed, 30 Apr 2025 22:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746051667; cv=none; b=RpICHXBcw7hbLrvzndNC4IQVXl4AJzAWf9sIpIx4JZrWhwP1LYxdvW3+zOXBicNo1PXry06GqkAZICOw68JBM52m/QqSQyzJbrmil/QkajjhAXekA87x7fCJl4Rb9O1TBV6WLkhWZid86rk1m+NbR4W84Sla6g0oeXZdOrxEaj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746051667; c=relaxed/simple;
	bh=2jSgZWQRhovwVYX6nv5LrGxVaGHc6tDV5dq9kqG3I1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c2/Md+Yb1s7zyuChbsfYMTwHcOjB3cSm/JDVii6AbhU9yb8+ztokQLrj+jzIvfyBnar3Nezejx6oOcNPUHRx/KZbqR0UXO1jOztkeFpdlrYJyovhGS0T9VjIRaWWaMUzrfVCmUJagI/jbshhGq/e5dMPD7QBCcojSSSfwzWXJyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5H0Ymmr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E504C4CEE7;
	Wed, 30 Apr 2025 22:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746051665;
	bh=2jSgZWQRhovwVYX6nv5LrGxVaGHc6tDV5dq9kqG3I1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f5H0Ymmrhn+BY0Azjv8JombtoBvjCJiVSZmeEyHTC+njn4EB+homdS97MesLk2C+S
	 qKXpY/ZPaqzrQ355+CJSptk0ilOh9lwtIe28V8GSY7R+kjjhShvkIbOx9owtUYTX8c
	 evBtEyQPe0r/Bq2o/pxPlxhvO2OZc4JKDmNQhjILj9V++Nuh4Kk+CDHcsl6+9zvMgt
	 +kxnDBEgUReKhYa0vpTVaQ/JKE8dMqFSC4crX8yVrxQ0bJ6CxDgH7TtT7x+IOvJ56C
	 vnN3G20FsrPDS0MIsp007HBRgtRZgV+83zbfGj2FfolOzqtfb9t3aLVq530T9T8PCL
	 OIMmU/RzcIgqg==
Date: Wed, 30 Apr 2025 18:21:04 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/6] nfs_localio: use cmpxchg() to install new
 nfs_file_localio
Message-ID: <aBKiUDGk4qifnKa2@kernel.org>
References: <20250430040429.2743921-1-neil@brown.name>
 <20250430040429.2743921-2-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430040429.2743921-2-neil@brown.name>

On Wed, Apr 30, 2025 at 02:01:11PM +1000, NeilBrown wrote:
> Rather than using nfs_uuid.lock to protect installing
> a new ro_file or rw_file, change to use cmpxchg().
> Removing the file already uses xchg() so this improves symmetry
> and also makes the code a little simpler.
> 
> Also remove the optimisation of not taking the lock, and not removing
> the nfs_file_localio from the linked list, when both ->ro_file and
> ->rw_file are already NULL.  Given that ->nfs_uuid was not NULL, it is
> extremely unlikely that neither ->ro_file or ->rw_file is NULL so
> this optimisation can be of little value and it complicates
> understanding of the code - why can the list_del_init() be skipped?
> 
> Finally, move the assignment of NULL to ->nfs_uuid until after
> the last action on the nfs_file_localio (the list_del_init).  As soon as
> this is NULL a racing nfs_close_local_fh() can bypass all the locking
> and go on to free the nfs_file_localio, so we must be certain to be
> finished with it first.
> 
> Fixes: 86e00412254a ("nfs: cache all open LOCALIO nfsd_file(s) in client")
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/nfs/localio.c           | 11 +++--------
>  fs/nfs_common/nfslocalio.c | 36 ++++++++++++++++--------------------
>  2 files changed, 19 insertions(+), 28 deletions(-)
> 
> diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
> index 5c21caeae075..3674dd86f095 100644
> --- a/fs/nfs/localio.c
> +++ b/fs/nfs/localio.c
> @@ -279,14 +279,9 @@ nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
>  		if (IS_ERR(new))
>  			return NULL;
>  		/* try to swap in the pointer */
> -		spin_lock(&clp->cl_uuid.lock);
> -		nf = rcu_dereference_protected(*pnf, 1);
> -		if (!nf) {
> -			nf = new;
> -			new = NULL;
> -			rcu_assign_pointer(*pnf, nf);
> -		}
> -		spin_unlock(&clp->cl_uuid.lock);
> +		nf = unrcu_pointer(cmpxchg(pnf, NULL, RCU_INITIALIZER(new)));
> +		if (!nf)
> +			swap(nf, new);
>  		rcu_read_lock();
>  	}
>  	nf = nfs_local_file_get(nf);
> diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
> index 6a0bdea6d644..d72eecb85ea9 100644
> --- a/fs/nfs_common/nfslocalio.c
> +++ b/fs/nfs_common/nfslocalio.c
> @@ -285,28 +285,24 @@ void nfs_close_local_fh(struct nfs_file_localio *nfl)
>  		return;
>  	}
>  
> -	ro_nf = rcu_access_pointer(nfl->ro_file);
> -	rw_nf = rcu_access_pointer(nfl->rw_file);
> -	if (ro_nf || rw_nf) {
> -		spin_lock(&nfs_uuid->lock);
> -		if (ro_nf)
> -			ro_nf = rcu_dereference_protected(xchg(&nfl->ro_file, NULL), 1);
> -		if (rw_nf)
> -			rw_nf = rcu_dereference_protected(xchg(&nfl->rw_file, NULL), 1);
> -
> -		/* Remove nfl from nfs_uuid->files list */
> -		RCU_INIT_POINTER(nfl->nfs_uuid, NULL);
> -		list_del_init(&nfl->list);
> -		spin_unlock(&nfs_uuid->lock);
> -		rcu_read_unlock();
> +	ro_nf = unrcu_pointer(xchg(&nfl->ro_file, NULL));
> +	rw_nf = unrcu_pointer(xchg(&nfl->rw_file, NULL));
>  
> -		if (ro_nf)
> -			nfs_to_nfsd_file_put_local(ro_nf);
> -		if (rw_nf)
> -			nfs_to_nfsd_file_put_local(rw_nf);
> -		return;
> -	}
> +	spin_lock(&nfs_uuid->lock);
> +	/* Remove nfl from nfs_uuid->files list */
> +	list_del_init(&nfl->list);
> +	spin_unlock(&nfs_uuid->lock);
>  	rcu_read_unlock();
> +	/* Now we can allow racing nfs_close_local_fh() to
> +	 * skip the locking.
> +	 */
> +	RCU_INIT_POINTER(nfl->nfs_uuid, NULL);
> +
> +	if (ro_nf)
> +		nfs_to_nfsd_file_put_local(ro_nf);
> +	if (rw_nf)
> +		nfs_to_nfsd_file_put_local(rw_nf);
> +	return;
>  }

This return at the end of the function isn't needed.

>  EXPORT_SYMBOL_GPL(nfs_close_local_fh);
>  
> -- 
> 2.49.0
> 
> 

