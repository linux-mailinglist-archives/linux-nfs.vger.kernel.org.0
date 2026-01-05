Return-Path: <linux-nfs+bounces-17456-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 318ABCF53EF
	for <lists+linux-nfs@lfdr.de>; Mon, 05 Jan 2026 19:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 26CFE3008C51
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Jan 2026 18:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C4D238C33;
	Mon,  5 Jan 2026 18:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mIY0FPam"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF8D19C54E
	for <linux-nfs@vger.kernel.org>; Mon,  5 Jan 2026 18:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767637845; cv=none; b=tmAZ/ayP/uarhQsEhe2VdakqdeZLAer0IFEbX3wmFqqCwAGLCRv30mvZRLha/UVZTMQO3Pl3oC4GkiRJKFjkfmN3B9jz9icPNjF6jgEkq6ho2uS0iDu4aQXmhqO4CQQh/bjiGu6lTi7KmHsuoVCmTcRCpAWrYE7evTwm1bDPJQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767637845; c=relaxed/simple;
	bh=LHGFMnUOGUmZd/SAA6rTtAkmhFagMW7hTMRuJicxYmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sJ+NSOsswQ+zrn7uNUzVW1kC2U6CYq2QkFdHtX0IZMZUjKeCnVO4pwBABHemeEszo2xV1e8XyGIc19Qf1FdMl8ZdeW9dBOBOwPJ8n0P39K/7MIOtwrtPzxiWizDaSigz0V4V2Cp/Nisn/nWJCcmNNtZYEbSL93vGB/mWxOrY1DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mIY0FPam; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EABADC116D0;
	Mon,  5 Jan 2026 18:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767637845;
	bh=LHGFMnUOGUmZd/SAA6rTtAkmhFagMW7hTMRuJicxYmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mIY0FPamkRNLy9t8uLMe5DsAlRWTEWOj4++zLJGTor3hWmdTVUEPw3z2GwMjLnrwH
	 G7IbcmgHXt9e/e3K9c7ahUAa8NHaOkOHNwcNDbtf2/yhsjIWQ1k1nykD05Ck32PvYa
	 KeUxIt4f988AyyXIB1i8VLkWNDgytobcMzK1z1faM5fILBfwAcbV32mbu/J4wvRBqn
	 kqt8Py+mEhVUxQCbYqaXMjmASmrPk3UfyFVP/wRx2dPLv60n7UPid4P9tzlUhfAcdW
	 rHLcHjV+BRxLk/de09nC80BIeEN2MPxivgVPV4m1hW6JUrr7yWTEUYjeMEsS6qfPXF
	 nZ87V3O0Pidnw==
Date: Mon, 5 Jan 2026 13:30:43 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: Re: [PATCH 3/4] NFS/localio: Handle short writes by retrying
Message-ID: <aVwDU3WuZfzIovt2@kernel.org>
References: <cover.1767459435.git.trond.myklebust@hammerspace.com>
 <aad94ed780fd5ea5deee8967261e5cfeb17b4c04.1767459435.git.trond.myklebust@hammerspace.com>
 <aVv9NqgOeEWJDfnk@kernel.org>
 <2a48660a6da0f53e5d36c4c34050c0f920a8b586.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2a48660a6da0f53e5d36c4c34050c0f920a8b586.camel@kernel.org>

On Mon, Jan 05, 2026 at 01:09:50PM -0500, Trond Myklebust wrote:
> On Mon, 2026-01-05 at 13:04 -0500, Mike Snitzer wrote:
> > On Sat, Jan 03, 2026 at 12:14:59PM -0500, Trond Myklebust wrote:
> > > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > 
> > > The current code for handling short writes in localio just
> > > truncates the
> > > I/O and then sets an error. While that is close to how the ordinary
> > > NFS
> > > code behaves, it does mean there is a chance the data that got
> > > written
> > > is lost because it isn't persisted.
> > > To fix this, change localio so that the upper layers can direct the
> > > behaviour to persist any unstable data by rewriting it, and then
> > > continuing writing until an ENOSPC is hit.
> > > 
> > > Fixes: 70ba381e1a43 ("nfs: add LOCALIO support")
> > > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > 
> > This is a pretty subtle fix in that it depends on rpc_call_done
> > conditionally setting task->tk_action -- is it worth adding a
> > relevant
> > code comment in nfs_local_pgio_release()?
> > 
> 
> That's how restarts work in the RPC code: after the rpc_call_done
> callback is done, rpc_exit_task() will check for whether or not the
> task->tk_action got reset, and if so, it will prepare a new RPC call.
> 
> > Additional inline review comment below.
> > 
> > > ---
> > >  fs/nfs/localio.c | 64 +++++++++++++++++++++++++++++++++++---------
> > > ----
> > >  1 file changed, 47 insertions(+), 17 deletions(-)
> > > 
> > > diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
> > > index c5f975bb5a64..87abebbedbab 100644
> > > --- a/fs/nfs/localio.c
> > > +++ b/fs/nfs/localio.c
> > > @@ -58,6 +58,11 @@ struct nfs_local_fsync_ctx {
> > >  static bool localio_enabled __read_mostly = true;
> > >  module_param(localio_enabled, bool, 0644);
> > >  
> > > +static int nfs_local_do_read(struct nfs_local_kiocb *iocb,
> > > +			     const struct rpc_call_ops *call_ops);
> > > +static int nfs_local_do_write(struct nfs_local_kiocb *iocb,
> > > +			      const struct rpc_call_ops
> > > *call_ops);
> > > +
> > >  static inline bool nfs_client_is_local(const struct nfs_client
> > > *clp)
> > >  {
> > >  	return !!rcu_access_pointer(clp->cl_uuid.net);
> > > @@ -542,13 +547,50 @@ nfs_local_iocb_release(struct nfs_local_kiocb
> > > *iocb)
> > >  	nfs_local_iocb_free(iocb);
> > >  }
> > >  
> > > -static void
> > > -nfs_local_pgio_release(struct nfs_local_kiocb *iocb)
> > > +static void nfs_local_pgio_restart(struct nfs_local_kiocb *iocb,
> > > +				   struct nfs_pgio_header *hdr)
> > > +{
> > > +	int status = 0;
> > > +
> > > +	iocb->kiocb.ki_pos = hdr->args.offset;
> > > +	iocb->kiocb.ki_flags &= ~(IOCB_DSYNC | IOCB_SYNC |
> > > IOCB_DIRECT);
> > > +	iocb->kiocb.ki_complete = NULL;
> > > +	iocb->aio_complete_work = NULL;
> > > +	iocb->end_iter_index = -1;
> > > +
> > > +	switch (hdr->rw_mode) {
> > > +	case FMODE_READ:
> > > +		nfs_local_iters_init(iocb, ITER_DEST);
> > > +		status = nfs_local_do_read(iocb, hdr-
> > > >task.tk_ops);
> > > +		break;
> > > +	case FMODE_WRITE:
> > > +		nfs_local_iters_init(iocb, ITER_SOURCE);
> > > +		status = nfs_local_do_write(iocb, hdr-
> > > >task.tk_ops);
> > > +		break;
> > > +	default:
> > > +		status = -EOPNOTSUPP;
> > > +	}
> > 
> > If this is a restart, then hdr->rw_mode will never not be FMODE_READ
> > or FMODE_WRITE.  As such, hdr->task.tk_ops will have been initialized
> > (as a side-effect of the original nfs_local_do_{read,write}) _and_
> > reinitialized by the above new calls to them.
> > 
> > My point: "default" case shouldn't ever be possible.  So should a
> > comment be added?  Switch to BUG_ON?  Do nothing about it?
> > 
> 
> I considered a BUG_ON(), but it shouldn't really matter. All this does
> now is cancel the restart.

OK, thanks.

Reviewed-by: Mike Snitzer <snitzer@kernel.org>

