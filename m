Return-Path: <linux-nfs+bounces-16958-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3678CA715E
	for <lists+linux-nfs@lfdr.de>; Fri, 05 Dec 2025 11:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3CDD5303A12C
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Dec 2025 10:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CDC31B804;
	Fri,  5 Dec 2025 10:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TeMMC3vK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9942D2E6CA8;
	Fri,  5 Dec 2025 10:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764929295; cv=none; b=glDD1dI+0SGuScVsNmxfhKfnjEJzgDAFQIB2qVgyJqeqhArHwjfW1uoPJEPfueQL1my/+piwEAMt/GDEx/eGb9WcTva+CGv5LZr6eOhUmxC0KphviTpGtU+YDsN43cVXpr1xOkbVcCI9VuEqk8vowbdurN+ZyCQBZLor8J+4Ass=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764929295; c=relaxed/simple;
	bh=w9+d27EJSEKCQHiZ8HDuJ+7mHKfnE+TyNr1SgiwomvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AjfPfwwi/CAuKZHbGfGiP1LoUROLOGPPN0k+qGGznTrjP8C4aRGDYkKQPw8dvrKHkDSwSNNXyDH47ozjW3iCx0xl6QLmiNMyAp1ock23bmcsFBK4zR1CkoEhBaObAoLhGYanpMXrp6O5Qt9vC5Ogt5i3RVPPdItJ2/1kcbCUgqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TeMMC3vK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42DD9C4CEF1;
	Fri,  5 Dec 2025 10:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764929293;
	bh=w9+d27EJSEKCQHiZ8HDuJ+7mHKfnE+TyNr1SgiwomvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TeMMC3vK3TWpI2XrPpvSFQqgCAffx3wFauFRzYbpUd9dHXNK8Ix3RhtR0VkNF8/iI
	 WL0ujsVXSlJMkT11zUBZCHUcVIXCbBTEkGw60UvHbzvc+sOOCakTOcb8KvQOGWYvfl
	 9Mj9lZKthDv3KXTZifS/Q5JpOCsIqCVpTXxuUKOPwyGvvrmLVY+0yPEt/9btRtp1BO
	 IF2y79rx5rgVuNSGk4DSjl3nh22V10omgsh+zNBKPc/Y8FlWZB60+O/XaAPoBuQVRU
	 3x+4+Zd5l3JF7i9OuCuWt9ZRhtN7185sXQZWQUVSWPOOxUIoLyfs+tu77rg8xP2Ozs
	 ydnrJezXcUVZg==
Date: Fri, 5 Dec 2025 11:08:08 +0100
From: Christian Brauner <brauner@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Trond Myklebust <trond.myklebust@hammerspace.com>, 
	Trond Myklebust <trondmy@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, linux-nfs@vger.kernel.org, linux-stable@vger.kernel.org
Subject: Re: [6.19 PATCH] nfs/localio: fix regression due to out-of-order
 __put_cred [was: Re: linux-next: manual merge of the nfs tree with Linus'
 tree]
Message-ID: <20251205-zurechnen-verdacht-aa4fc0a2a330@brauner>
References: <20251205111942.4150b06f@canb.auug.org.au>
 <aTIwhhOF847CcQGl@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aTIwhhOF847CcQGl@kernel.org>

On Thu, Dec 04, 2025 at 08:08:22PM -0500, Mike Snitzer wrote:
> Hi Stephen,
> 
> On Fri, Dec 05, 2025 at 11:19:42AM +1100, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Today's linux-next merge of the nfs tree got a conflict in:
> > 
> >   fs/nfs/localio.c
> > 
> > between commits:
> > 
> >   94afb627dfc2 ("nfs: use credential guards in nfs_local_call_read()")
> >   bff3c841f7bd ("nfs: use credential guards in nfs_local_call_write()")
> >   1d18101a644e ("Merge tag 'kernel-6.19-rc1.cred' of git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs")
> > 
> > from Linus' tree and commit:
> > 
> >   30a4385509b4 ("nfs/localio: fix regression due to out-of-order __put_cred")
> > 
> > from the nfs tree.
> 
> The NFS tree's commit 30a4385509b4 needed to be rebased (taken care of
> below), which complicates the 6.18-stable backport (equivalent of the
> nfs tree's commit 30a4385509b4 must be sent to linux-stable@ rather
> than it being cherry-picked once the below updated fix applied to
> Linus' tree).
> 
> > I fixed it up (I just dropped the nfs tree commit) and can carry the
> > fix as necessary. This is now fixed as far as linux-next is concerned,
> > but any non trivial conflicts should be mentioned to your upstream
> > maintainer when your tree is submitted for merging.  You may also want
> > to consider cooperating with the maintainer of the conflicting tree to
> > minimise any particularly complex conflicts.
> 
> Trond and Linus,
> 
> Here is the fix for 6.19 rebased ontop of Linus' tree:
> 
> From: Mike Snitzer <snitzer@kernel.org>
> Date: Wed, 26 Nov 2025 01:01:25 -0500
> Subject: [PATCH] nfs/localio: fix regression due to out-of-order __put_cred
> 
> Commit f2060bdc21d7 ("nfs/localio: add refcounting for each iocb IO

Ah, ok. So it reintroduced a bug. Thanks for the explanation and the
fix. I was worried we created that bug.

Reviewed-by: Christian Brauner <brauner@kernel.org>

> associated with NFS pgio header") inadvertantly reintroduced the same
> potential for __put_cred() triggering BUG_ON(cred == current->cred)
> that commit 992203a1fba5 ("nfs/localio: restore creds before releasing
> pageio data") fixed.
> 
> Fix this by saving and restoring the cred around each {read,write}_iter
> call within the respective for loop of nfs_local_call_{read,write}
> using scoped_with_creds().
> 
> NOTE: this fix started by first reverting the following commits:
> 
>  94afb627dfc2 ("nfs: use credential guards in nfs_local_call_read()")
>  bff3c841f7bd ("nfs: use credential guards in nfs_local_call_write()")
>  1d18101a644e ("Merge tag 'kernel-6.19-rc1.cred' of git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs")
> 
> followed by narrowly fixing the cred lifetime issue by using
> scoped_with_creds(). In doing so, this commit's changes appear more
> extensive than they really are (as evidenced by comparing to v6.18's
> fs/nfs/localio.c).
> 
> Reported-by: Zorro Lang <zlang@redhat.com>
> Fixes: f2060bdc21d7 ("nfs/localio: add refcounting for each iocb IO associated with NFS pgio header")
> Cc: linux-stable@vger.kernel.org # a custom 6.18-stable backport is required
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
> index 49ed90c6b9f2..f33bfa7b58e6 100644
> --- a/fs/nfs/localio.c
> +++ b/fs/nfs/localio.c
> @@ -615,8 +615,11 @@ static void nfs_local_read_aio_complete(struct kiocb *kiocb, long ret)
>  	nfs_local_pgio_aio_complete(iocb); /* Calls nfs_local_read_aio_complete_work */
>  }
>  
> -static void do_nfs_local_call_read(struct nfs_local_kiocb *iocb, struct file *filp)
> +static void nfs_local_call_read(struct work_struct *work)
>  {
> +	struct nfs_local_kiocb *iocb =
> +		container_of(work, struct nfs_local_kiocb, work);
> +	struct file *filp = iocb->kiocb.ki_filp;
>  	bool force_done = false;
>  	ssize_t status;
>  	int n_iters;
> @@ -633,7 +636,9 @@ static void do_nfs_local_call_read(struct nfs_local_kiocb *iocb, struct file *fi
>  		} else
>  			iocb->kiocb.ki_flags &= ~IOCB_DIRECT;
>  
> -		status = filp->f_op->read_iter(&iocb->kiocb, &iocb->iters[i]);
> +		scoped_with_creds(filp->f_cred)
> +			status = filp->f_op->read_iter(&iocb->kiocb, &iocb->iters[i]);
> +
>  		if (status != -EIOCBQUEUED) {
>  			if (unlikely(status >= 0 && status < iocb->iters[i].count))
>  				force_done = true; /* Partial read */
> @@ -645,16 +650,6 @@ static void do_nfs_local_call_read(struct nfs_local_kiocb *iocb, struct file *fi
>  	}
>  }
>  
> -static void nfs_local_call_read(struct work_struct *work)
> -{
> -	struct nfs_local_kiocb *iocb =
> -		container_of(work, struct nfs_local_kiocb, work);
> -	struct file *filp = iocb->kiocb.ki_filp;
> -
> -	scoped_with_creds(filp->f_cred)
> -		do_nfs_local_call_read(iocb, filp);
> -}
> -
>  static int
>  nfs_local_do_read(struct nfs_local_kiocb *iocb,
>  		  const struct rpc_call_ops *call_ops)
> @@ -822,13 +817,18 @@ static void nfs_local_write_aio_complete(struct kiocb *kiocb, long ret)
>  	nfs_local_pgio_aio_complete(iocb); /* Calls nfs_local_write_aio_complete_work */
>  }
>  
> -static ssize_t do_nfs_local_call_write(struct nfs_local_kiocb *iocb,
> -				       struct file *filp)
> +static void nfs_local_call_write(struct work_struct *work)
>  {
> +	struct nfs_local_kiocb *iocb =
> +		container_of(work, struct nfs_local_kiocb, work);
> +	struct file *filp = iocb->kiocb.ki_filp;
> +	unsigned long old_flags = current->flags;
>  	bool force_done = false;
>  	ssize_t status;
>  	int n_iters;
>  
> +	current->flags |= PF_LOCAL_THROTTLE | PF_MEMALLOC_NOIO;
> +
>  	file_start_write(filp);
>  	n_iters = atomic_read(&iocb->n_iters);
>  	for (int i = 0; i < n_iters ; i++) {
> @@ -842,7 +842,9 @@ static ssize_t do_nfs_local_call_write(struct nfs_local_kiocb *iocb,
>  		} else
>  			iocb->kiocb.ki_flags &= ~IOCB_DIRECT;
>  
> -		status = filp->f_op->write_iter(&iocb->kiocb, &iocb->iters[i]);
> +		scoped_with_creds(filp->f_cred)
> +			status = filp->f_op->write_iter(&iocb->kiocb, &iocb->iters[i]);
> +
>  		if (status != -EIOCBQUEUED) {
>  			if (unlikely(status >= 0 && status < iocb->iters[i].count))
>  				force_done = true; /* Partial write */
> @@ -854,22 +856,6 @@ static ssize_t do_nfs_local_call_write(struct nfs_local_kiocb *iocb,
>  	}
>  	file_end_write(filp);
>  
> -	return status;
> -}
> -
> -static void nfs_local_call_write(struct work_struct *work)
> -{
> -	struct nfs_local_kiocb *iocb =
> -		container_of(work, struct nfs_local_kiocb, work);
> -	struct file *filp = iocb->kiocb.ki_filp;
> -	unsigned long old_flags = current->flags;
> -	ssize_t status;
> -
> -	current->flags |= PF_LOCAL_THROTTLE | PF_MEMALLOC_NOIO;
> -
> -	scoped_with_creds(filp->f_cred)
> -		status = do_nfs_local_call_write(iocb, filp);
> -
>  	current->flags = old_flags;
>  }
>  

