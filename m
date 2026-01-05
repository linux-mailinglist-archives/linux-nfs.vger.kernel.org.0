Return-Path: <linux-nfs+bounces-17455-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FF9CF5307
	for <lists+linux-nfs@lfdr.de>; Mon, 05 Jan 2026 19:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F14E830559D4
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Jan 2026 18:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8171327FB3E;
	Mon,  5 Jan 2026 18:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfzZl22h"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAA921CC58
	for <linux-nfs@vger.kernel.org>; Mon,  5 Jan 2026 18:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767636592; cv=none; b=skYzln0/Q9+Rmbihtk/pYMHCkM0Mw5r8e+BkqeMoVT2S+6UAvcslpgLlCw92umN3Eqlq2nNZ+oksU1AAgidyXjLJiqqv9rjurcvsV2YcEFJaGF5tqR3swSc66ZRFPTBOzsy13GpwU+vPxmVAd3dMD1J97weZgJGF10AgNPFDDyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767636592; c=relaxed/simple;
	bh=QfgorMgRTdRZIlz7/EeKwkDjaXO/JEHkVzKCOJF0gOo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RlkGFwDh+rtXldSrl9590pX4actWDTNxSXA/sVL+DVCGot4L5eDA0vW8aUycDWZkwkbgaHLrH937p0wGpgdsQkxQ3henL+4cc53AbE2jj6wYHOq34LjyveyRS95ZzeqO8g61PcTdhrr9/NWEUvGlvaW62cdauS0uYouHPEeEj+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nfzZl22h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE43C116D0;
	Mon,  5 Jan 2026 18:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767636592;
	bh=QfgorMgRTdRZIlz7/EeKwkDjaXO/JEHkVzKCOJF0gOo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=nfzZl22hnuMtZXl9jI+1cgdQ9aJ3qH+6Hiqr280dqj7GsLwk06DWzt/zgfNczebxS
	 OXdaW8KkHMdCQPgz/J+hy3tFVmcd/BHcz9Hg1vLJuohT9fhy/AEkIyIpLsaUjdLOFb
	 4+lDe7lhphJybtg/HowDNFCXr6BGf1nONerh37b/Cq5igZHsFXy9u7oiTtQC/y13T4
	 7fSeOfmkyspw4xNmG2Ta75KS9gLCp3oV1xAhSUWhboi5UhtFmQpz26SviVoL9PAqBr
	 gYIk7h9anR/gD/6Et4ONR1nJ1zwr+TNQdlHB/Efnzgxk+OiBSlWz3erT8DdQzIsEYY
	 eIebUrqh9gbIQ==
Message-ID: <2a48660a6da0f53e5d36c4c34050c0f920a8b586.camel@kernel.org>
Subject: Re: [PATCH 3/4] NFS/localio: Handle short writes by retrying
From: Trond Myklebust <trondmy@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org
Date: Mon, 05 Jan 2026 13:09:50 -0500
In-Reply-To: <aVv9NqgOeEWJDfnk@kernel.org>
References: <cover.1767459435.git.trond.myklebust@hammerspace.com>
	 <aad94ed780fd5ea5deee8967261e5cfeb17b4c04.1767459435.git.trond.myklebust@hammerspace.com>
	 <aVv9NqgOeEWJDfnk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-01-05 at 13:04 -0500, Mike Snitzer wrote:
> On Sat, Jan 03, 2026 at 12:14:59PM -0500, Trond Myklebust wrote:
> > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> >=20
> > The current code for handling short writes in localio just
> > truncates the
> > I/O and then sets an error. While that is close to how the ordinary
> > NFS
> > code behaves, it does mean there is a chance the data that got
> > written
> > is lost because it isn't persisted.
> > To fix this, change localio so that the upper layers can direct the
> > behaviour to persist any unstable data by rewriting it, and then
> > continuing writing until an ENOSPC is hit.
> >=20
> > Fixes: 70ba381e1a43 ("nfs: add LOCALIO support")
> > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>=20
> This is a pretty subtle fix in that it depends on rpc_call_done
> conditionally setting task->tk_action -- is it worth adding a
> relevant
> code comment in nfs_local_pgio_release()?
>=20

That's how restarts work in the RPC code: after the rpc_call_done
callback is done, rpc_exit_task() will check for whether or not the
task->tk_action got reset, and if so, it will prepare a new RPC call.

> Additional inline review comment below.
>=20
> > ---
> > =C2=A0fs/nfs/localio.c | 64 +++++++++++++++++++++++++++++++++++--------=
-
> > ----
> > =C2=A01 file changed, 47 insertions(+), 17 deletions(-)
> >=20
> > diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
> > index c5f975bb5a64..87abebbedbab 100644
> > --- a/fs/nfs/localio.c
> > +++ b/fs/nfs/localio.c
> > @@ -58,6 +58,11 @@ struct nfs_local_fsync_ctx {
> > =C2=A0static bool localio_enabled __read_mostly =3D true;
> > =C2=A0module_param(localio_enabled, bool, 0644);
> > =C2=A0
> > +static int nfs_local_do_read(struct nfs_local_kiocb *iocb,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0 const struct rpc_call_ops *call_ops);
> > +static int nfs_local_do_write(struct nfs_local_kiocb *iocb,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct rpc_call_ops
> > *call_ops);
> > +
> > =C2=A0static inline bool nfs_client_is_local(const struct nfs_client
> > *clp)
> > =C2=A0{
> > =C2=A0	return !!rcu_access_pointer(clp->cl_uuid.net);
> > @@ -542,13 +547,50 @@ nfs_local_iocb_release(struct nfs_local_kiocb
> > *iocb)
> > =C2=A0	nfs_local_iocb_free(iocb);
> > =C2=A0}
> > =C2=A0
> > -static void
> > -nfs_local_pgio_release(struct nfs_local_kiocb *iocb)
> > +static void nfs_local_pgio_restart(struct nfs_local_kiocb *iocb,
> > +				=C2=A0=C2=A0 struct nfs_pgio_header *hdr)
> > +{
> > +	int status =3D 0;
> > +
> > +	iocb->kiocb.ki_pos =3D hdr->args.offset;
> > +	iocb->kiocb.ki_flags &=3D ~(IOCB_DSYNC | IOCB_SYNC |
> > IOCB_DIRECT);
> > +	iocb->kiocb.ki_complete =3D NULL;
> > +	iocb->aio_complete_work =3D NULL;
> > +	iocb->end_iter_index =3D -1;
> > +
> > +	switch (hdr->rw_mode) {
> > +	case FMODE_READ:
> > +		nfs_local_iters_init(iocb, ITER_DEST);
> > +		status =3D nfs_local_do_read(iocb, hdr-
> > >task.tk_ops);
> > +		break;
> > +	case FMODE_WRITE:
> > +		nfs_local_iters_init(iocb, ITER_SOURCE);
> > +		status =3D nfs_local_do_write(iocb, hdr-
> > >task.tk_ops);
> > +		break;
> > +	default:
> > +		status =3D -EOPNOTSUPP;
> > +	}
>=20
> If this is a restart, then hdr->rw_mode will never not be FMODE_READ
> or FMODE_WRITE.=C2=A0 As such, hdr->task.tk_ops will have been initialize=
d
> (as a side-effect of the original nfs_local_do_{read,write}) _and_
> reinitialized by the above new calls to them.
>=20
> My point: "default" case shouldn't ever be possible.=C2=A0 So should a
> comment be added?=C2=A0 Switch to BUG_ON?=C2=A0 Do nothing about it?
>=20

I considered a BUG_ON(), but it shouldn't really matter. All this does
now is cancel the restart.

> Mike
>=20
> > +
> > +	if (status !=3D 0) {
> > +		nfs_local_iocb_release(iocb);
> > +		hdr->task.tk_status =3D status;
> > +		nfs_local_hdr_release(hdr, hdr->task.tk_ops);
> > +	}
> > +}
> > +
> > +static void nfs_local_pgio_release(struct nfs_local_kiocb *iocb)
> > =C2=A0{
> > =C2=A0	struct nfs_pgio_header *hdr =3D iocb->hdr;
> > +	struct rpc_task *task =3D &hdr->task;
> > +
> > +	task->tk_action =3D NULL;
> > +	task->tk_ops->rpc_call_done(task, hdr);
> > =C2=A0
> > -	nfs_local_iocb_release(iocb);
> > -	nfs_local_hdr_release(hdr, hdr->task.tk_ops);
> > +	if (task->tk_action =3D=3D NULL) {
> > +		nfs_local_iocb_release(iocb);
> > +		task->tk_ops->rpc_release(hdr);
> > +	} else
> > +		nfs_local_pgio_restart(iocb, hdr);
> > =C2=A0}
> > =C2=A0
> > =C2=A0/*
> > @@ -776,19 +818,7 @@ static void nfs_local_write_done(struct
> > nfs_local_kiocb *iocb)
> > =C2=A0		pr_info_ratelimited("nfs: Unexpected direct I/O
> > write alignment failure\n");
> > =C2=A0	}
> > =C2=A0
> > -	/* Handle short writes as if they are ENOSPC */
> > -	status =3D hdr->res.count;
> > -	if (status > 0 && status < hdr->args.count) {
> > -		hdr->mds_offset +=3D status;
> > -		hdr->args.offset +=3D status;
> > -		hdr->args.pgbase +=3D status;
> > -		hdr->args.count -=3D status;
> > -		nfs_set_pgio_error(hdr, -ENOSPC, hdr-
> > >args.offset);
> > -		status =3D -ENOSPC;
> > -		/* record -ENOSPC in terms of nfs_local_pgio_done
> > */
> > -		(void) nfs_local_pgio_done(iocb, status, true);
> > -	}
> > -	if (hdr->task.tk_status < 0)
> > +	if (status < 0)
> > =C2=A0		nfs_reset_boot_verifier(hdr->inode);
> > =C2=A0}
> > =C2=A0
> > --=20
> > 2.52.0
> >=20

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

