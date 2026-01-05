Return-Path: <linux-nfs+bounces-17454-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F203CF526B
	for <lists+linux-nfs@lfdr.de>; Mon, 05 Jan 2026 19:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6312E303DA8C
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Jan 2026 18:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4058730C353;
	Mon,  5 Jan 2026 18:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z1aIOFOW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197D92F0C5B
	for <linux-nfs@vger.kernel.org>; Mon,  5 Jan 2026 18:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767636280; cv=none; b=j5tiPRy+6Rfx5srXV9OxP/S6OAuSEOKfrzxOGsEhgliPL9c2IUcRpWy5VQ4vvlrfI/bE/1KqIZdpmqP4Cdmis5e7cu69U6AuCuFmH6/pXxCGBEjtFggOtQ2LyqESLu+swBNiVubtSUo0+pYEy//V9xZic1D1vh256RVKCSEPk6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767636280; c=relaxed/simple;
	bh=rIe2nJF1OMJqzizu9KdTlm2CnrKPGgcDhfk0ddXYXN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kKyqeSOAtkLmMZSsOj9vrS3FnISwdSa+LGnvyhWtE4gksyo/pRKe/0+ImcZwLNrlobAXiia1Lb5Hlt0JYIKjll8dT1Q+2N7yzNlX1fTtk7x1noiYucLRaMF4b0P3WQ2pl0BQCdE1KQi53B/dkRkn19Vz3rua/5QdHL9hFDlWTfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z1aIOFOW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B51A7C116D0;
	Mon,  5 Jan 2026 18:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767636280;
	bh=rIe2nJF1OMJqzizu9KdTlm2CnrKPGgcDhfk0ddXYXN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z1aIOFOW7UPJpkesC8p2By4jVmBk5TChDsevMlPbxig+UUCugDYz0oeN8ptu/siYk
	 m00iWr83t5oGZcsSp9UlkYHRyQfvOY2jkuA02FlU5wcmsCfgivo6O//ab5ezjlimnh
	 RM7QYQdsNXELmxELZYNp2q3s/W94HCWGVWgBnxrpqrWezMgLjetZUhB+36XQeaIvkR
	 O3Kag1npVveLxOJpWSxE3xLbhjSTik852N0JvT6YRjwUFZr8ZIgY/jNfWIuddkrCHf
	 QPQ8OBkUsA7JLc3y93NfqrLFskOreQP4eRHqehS5y0IIdkvgJrxl2hOQYPtROEuY0R
	 h5BTx8lbwedPg==
Date: Mon, 5 Jan 2026 13:04:38 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: Re: [PATCH 3/4] NFS/localio: Handle short writes by retrying
Message-ID: <aVv9NqgOeEWJDfnk@kernel.org>
References: <cover.1767459435.git.trond.myklebust@hammerspace.com>
 <aad94ed780fd5ea5deee8967261e5cfeb17b4c04.1767459435.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aad94ed780fd5ea5deee8967261e5cfeb17b4c04.1767459435.git.trond.myklebust@hammerspace.com>

On Sat, Jan 03, 2026 at 12:14:59PM -0500, Trond Myklebust wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> The current code for handling short writes in localio just truncates the
> I/O and then sets an error. While that is close to how the ordinary NFS
> code behaves, it does mean there is a chance the data that got written
> is lost because it isn't persisted.
> To fix this, change localio so that the upper layers can direct the
> behaviour to persist any unstable data by rewriting it, and then
> continuing writing until an ENOSPC is hit.
> 
> Fixes: 70ba381e1a43 ("nfs: add LOCALIO support")
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>

This is a pretty subtle fix in that it depends on rpc_call_done
conditionally setting task->tk_action -- is it worth adding a relevant
code comment in nfs_local_pgio_release()?

Additional inline review comment below.

> ---
>  fs/nfs/localio.c | 64 +++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 47 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
> index c5f975bb5a64..87abebbedbab 100644
> --- a/fs/nfs/localio.c
> +++ b/fs/nfs/localio.c
> @@ -58,6 +58,11 @@ struct nfs_local_fsync_ctx {
>  static bool localio_enabled __read_mostly = true;
>  module_param(localio_enabled, bool, 0644);
>  
> +static int nfs_local_do_read(struct nfs_local_kiocb *iocb,
> +			     const struct rpc_call_ops *call_ops);
> +static int nfs_local_do_write(struct nfs_local_kiocb *iocb,
> +			      const struct rpc_call_ops *call_ops);
> +
>  static inline bool nfs_client_is_local(const struct nfs_client *clp)
>  {
>  	return !!rcu_access_pointer(clp->cl_uuid.net);
> @@ -542,13 +547,50 @@ nfs_local_iocb_release(struct nfs_local_kiocb *iocb)
>  	nfs_local_iocb_free(iocb);
>  }
>  
> -static void
> -nfs_local_pgio_release(struct nfs_local_kiocb *iocb)
> +static void nfs_local_pgio_restart(struct nfs_local_kiocb *iocb,
> +				   struct nfs_pgio_header *hdr)
> +{
> +	int status = 0;
> +
> +	iocb->kiocb.ki_pos = hdr->args.offset;
> +	iocb->kiocb.ki_flags &= ~(IOCB_DSYNC | IOCB_SYNC | IOCB_DIRECT);
> +	iocb->kiocb.ki_complete = NULL;
> +	iocb->aio_complete_work = NULL;
> +	iocb->end_iter_index = -1;
> +
> +	switch (hdr->rw_mode) {
> +	case FMODE_READ:
> +		nfs_local_iters_init(iocb, ITER_DEST);
> +		status = nfs_local_do_read(iocb, hdr->task.tk_ops);
> +		break;
> +	case FMODE_WRITE:
> +		nfs_local_iters_init(iocb, ITER_SOURCE);
> +		status = nfs_local_do_write(iocb, hdr->task.tk_ops);
> +		break;
> +	default:
> +		status = -EOPNOTSUPP;
> +	}

If this is a restart, then hdr->rw_mode will never not be FMODE_READ
or FMODE_WRITE.  As such, hdr->task.tk_ops will have been initialized
(as a side-effect of the original nfs_local_do_{read,write}) _and_
reinitialized by the above new calls to them.

My point: "default" case shouldn't ever be possible.  So should a
comment be added?  Switch to BUG_ON?  Do nothing about it?

Mike

> +
> +	if (status != 0) {
> +		nfs_local_iocb_release(iocb);
> +		hdr->task.tk_status = status;
> +		nfs_local_hdr_release(hdr, hdr->task.tk_ops);
> +	}
> +}
> +
> +static void nfs_local_pgio_release(struct nfs_local_kiocb *iocb)
>  {
>  	struct nfs_pgio_header *hdr = iocb->hdr;
> +	struct rpc_task *task = &hdr->task;
> +
> +	task->tk_action = NULL;
> +	task->tk_ops->rpc_call_done(task, hdr);
>  
> -	nfs_local_iocb_release(iocb);
> -	nfs_local_hdr_release(hdr, hdr->task.tk_ops);
> +	if (task->tk_action == NULL) {
> +		nfs_local_iocb_release(iocb);
> +		task->tk_ops->rpc_release(hdr);
> +	} else
> +		nfs_local_pgio_restart(iocb, hdr);
>  }
>  
>  /*
> @@ -776,19 +818,7 @@ static void nfs_local_write_done(struct nfs_local_kiocb *iocb)
>  		pr_info_ratelimited("nfs: Unexpected direct I/O write alignment failure\n");
>  	}
>  
> -	/* Handle short writes as if they are ENOSPC */
> -	status = hdr->res.count;
> -	if (status > 0 && status < hdr->args.count) {
> -		hdr->mds_offset += status;
> -		hdr->args.offset += status;
> -		hdr->args.pgbase += status;
> -		hdr->args.count -= status;
> -		nfs_set_pgio_error(hdr, -ENOSPC, hdr->args.offset);
> -		status = -ENOSPC;
> -		/* record -ENOSPC in terms of nfs_local_pgio_done */
> -		(void) nfs_local_pgio_done(iocb, status, true);
> -	}
> -	if (hdr->task.tk_status < 0)
> +	if (status < 0)
>  		nfs_reset_boot_verifier(hdr->inode);
>  }
>  
> -- 
> 2.52.0
> 

