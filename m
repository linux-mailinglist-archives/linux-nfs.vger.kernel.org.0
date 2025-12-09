Return-Path: <linux-nfs+bounces-17011-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 76967CB06BA
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Dec 2025 16:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8FC193016B8F
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Dec 2025 15:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1352FF653;
	Tue,  9 Dec 2025 15:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZopApb9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1ADD2FFDE1
	for <linux-nfs@vger.kernel.org>; Tue,  9 Dec 2025 15:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765294766; cv=none; b=ECT9WWld9h7bngWWtKpxVKrleJwoKMTzrX5MQjj//HoPmZrDazF50wvqlPJedW+ebhLvoTIwnO9NJm5OTvZ/Ob32vqa+PTpIB8mO3CovPvykH3Sr984fEY7V5sNwhXySBOdatwmkx6xA0ZFqwaVM24fjzL72hCE7Xv36yICAMpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765294766; c=relaxed/simple;
	bh=CFGSNLkB63JH3kpEQCHbbI5n8W2oWS///CRnWemEVY4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GMep/f4ttxxO2G6unqFzPpNHBiUeQYM4E6RmiLNOMLz2YK3Qr0CLqmOq3oXP/S96d6LKeURMPyhy22ccF2WcIVy1VV1fYWs/Z52GTWwQDLvZKq/KD9ml02CxGpHGAGbo3BLZiiQUdTkCFXn7Tpo8/8GU/sPdWr7E238DQhluzFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZopApb9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E04BC4CEF5;
	Tue,  9 Dec 2025 15:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765294766;
	bh=CFGSNLkB63JH3kpEQCHbbI5n8W2oWS///CRnWemEVY4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=SZopApb98Ms+DtTCM4USLk162+OtUcb78vYyOC8Hmp+lMyVDc92lDkiHHqFwgKV7X
	 R3qgG2LYqYFNIyQwDaYLIzshQVAunAyrJuTBbabGWctgiNAGOXhDuiB/fevVXNHS4h
	 law/bQUr9XsUAVoCI71Di7B9RHV5kvPqt0u670Zrqno7aF+cZnXHXb3n0HtnJTx6Ni
	 zGHxW1dSczk6B/kcX/LG7sj3vwBYT639+o4ubnFQtRnsRFA977mdq561r0R7K2tccB
	 6HAK07Fw1yslFH9uN4xQpoJTSgLXuY/01LjPDemmhfL4tGxNz5ITqc/NhUBUJ44V4y
	 90WVnVOoQD9iA==
Message-ID: <0988361336efb7d2b185069a870b1cc7bf356ccc.camel@kernel.org>
Subject: Re: [PATCH] pNFS: Fix a deadlock when returning a delegation during
 open()
From: Trond Myklebust <trondmy@kernel.org>
To: Benjamin Coddington <bcodding@hammerspace.com>
Cc: linux-nfs@vger.kernel.org
Date: Tue, 09 Dec 2025 10:39:25 -0500
In-Reply-To: <3090400A-1FB8-4DE3-AB71-08D2D7451ADD@hammerspace.com>
References: 
	<24ff118a0bc9c9a845df3987e532365e9d6ecf2a.1765224921.git.trond.myklebust@hammerspace.com>
	 <3090400A-1FB8-4DE3-AB71-08D2D7451ADD@hammerspace.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-12-09 at 10:27 -0500, Benjamin Coddington wrote:
> On 8 Dec 2025, at 16:05, Trond Myklebust wrote:
>=20
> > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> >=20
> > Ben Coddington reports seeing a hang in the following stack trace:
>=20
> Thanks!!=C2=A0 Question below:
>=20
> > =C2=A0 0 [ffffd0b50e1774e0] __schedule at ffffffff9ca05415
> > =C2=A0 1 [ffffd0b50e177548] schedule at ffffffff9ca05717
> > =C2=A0 2 [ffffd0b50e177558] bit_wait at ffffffff9ca061e1
> > =C2=A0 3 [ffffd0b50e177568] __wait_on_bit at ffffffff9ca05cfb
> > =C2=A0 4 [ffffd0b50e1775c8] out_of_line_wait_on_bit at ffffffff9ca05ea5
> > =C2=A0 5 [ffffd0b50e177618] pnfs_roc at ffffffffc154207b [nfsv4]
> > =C2=A0 6 [ffffd0b50e1776b8] _nfs4_proc_delegreturn at ffffffffc1506586
> > [nfsv4]
> > =C2=A0 7 [ffffd0b50e177788] nfs4_proc_delegreturn at ffffffffc1507480
> > [nfsv4]
> > =C2=A0 8 [ffffd0b50e1777f8] nfs_do_return_delegation at ffffffffc1523e4=
1
> > [nfsv4]
> > =C2=A0 9 [ffffd0b50e177838] nfs_inode_set_delegation at ffffffffc1524a7=
5
> > [nfsv4]
> > =C2=A010 [ffffd0b50e177888] nfs4_process_delegation at ffffffffc14f41dd
> > [nfsv4]
> > =C2=A011 [ffffd0b50e1778a0] _nfs4_opendata_to_nfs4_state at
> > ffffffffc1503edf [nfsv4]
> > =C2=A012 [ffffd0b50e1778c0] _nfs4_open_and_get_state at ffffffffc1504e5=
6
> > [nfsv4]
> > =C2=A013 [ffffd0b50e177978] _nfs4_do_open at ffffffffc15051b8 [nfsv4]
> > =C2=A014 [ffffd0b50e1779f8] nfs4_do_open at ffffffffc150559c [nfsv4]
> > =C2=A015 [ffffd0b50e177a80] nfs4_atomic_open at ffffffffc15057fb [nfsv4=
]
> > =C2=A016 [ffffd0b50e177ad0] nfs4_file_open at ffffffffc15219be [nfsv4]
> > =C2=A017 [ffffd0b50e177b78] do_dentry_open at ffffffff9c09e6ea
> > =C2=A018 [ffffd0b50e177ba8] vfs_open at ffffffff9c0a082e
> > =C2=A019 [ffffd0b50e177bd0] dentry_open at ffffffff9c0a0935
> >=20
> > The issue is that the delegreturn is being asked to wait for a
> > layout
> > return that cannot complete because a state recovery was initiated.
> > The
> > state recovery cannot complete until the open() finishes processing
> > the
> > delegations it was given.
> >=20
> > The solution is to propagate the existing flags that indicate a
> > non-blocking call to the function pnfs_roc(), so that it knows not
> > to
> > wait in this situation.
> >=20
> > Reported-by: Benjamin Coddington <bcodding@hammerspace.com>
> > Fixes: 29ade5db1293 ("pNFS: Wait on outstanding layoutreturns to
> > complete in pnfs_roc()")
> > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > ---
> > =C2=A0fs/nfs/nfs4proc.c |=C2=A0 6 ++---
> > =C2=A0fs/nfs/pnfs.c=C2=A0=C2=A0=C2=A0=C2=A0 | 58 ++++++++++++++++++++++=
+++++++++++----------
> > ----
> > =C2=A0fs/nfs/pnfs.h=C2=A0=C2=A0=C2=A0=C2=A0 | 17 ++++++--------
> > =C2=A03 files changed, 51 insertions(+), 30 deletions(-)
> >=20
> > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > index ec1ce593dea2..51da62ba6559 100644
> > --- a/fs/nfs/nfs4proc.c
> > +++ b/fs/nfs/nfs4proc.c
> > @@ -3894,8 +3894,8 @@ int nfs4_do_close(struct nfs4_state *state,
> > gfp_t gfp_mask, int wait)
> > =C2=A0	calldata->res.seqid =3D calldata->arg.seqid;
> > =C2=A0	calldata->res.server =3D server;
> > =C2=A0	calldata->res.lr_ret =3D -NFS4ERR_NOMATCHING_LAYOUT;
> > -	calldata->lr.roc =3D pnfs_roc(state->inode,
> > -			&calldata->lr.arg, &calldata->lr.res,
> > msg.rpc_cred);
> > +	calldata->lr.roc =3D pnfs_roc(state->inode, &calldata-
> > >lr.arg,
> > +				=C2=A0=C2=A0=C2=A0 &calldata->lr.res,
> > msg.rpc_cred, wait);
> > =C2=A0	if (calldata->lr.roc) {
> > =C2=A0		calldata->arg.lr_args =3D &calldata->lr.arg;
> > =C2=A0		calldata->res.lr_res =3D &calldata->lr.res;
> > @@ -7005,7 +7005,7 @@ static int _nfs4_proc_delegreturn(struct
> > inode *inode, const struct cred *cred,
> > =C2=A0	data->inode =3D nfs_igrab_and_active(inode);
> > =C2=A0	if (data->inode || issync) {
> > =C2=A0		data->lr.roc =3D pnfs_roc(inode, &data->lr.arg,
> > &data->lr.res,
> > -					cred);
> > +					cred, issync);
> > =C2=A0		if (data->lr.roc) {
> > =C2=A0			data->args.lr_args =3D &data->lr.arg;
> > =C2=A0			data->res.lr_res =3D &data->lr.res;
> > diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
> > index 7ce2e840217c..33bc6db0dc92 100644
> > --- a/fs/nfs/pnfs.c
> > +++ b/fs/nfs/pnfs.c
> > @@ -1533,10 +1533,9 @@ static int
> > pnfs_layout_return_on_reboot(struct pnfs_layout_hdr *lo)
> > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > PNFS_FL_LAYOUTRETURN_PRIVILEGED);
> > =C2=A0}
> >=20
> > -bool pnfs_roc(struct inode *ino,
> > -		struct nfs4_layoutreturn_args *args,
> > -		struct nfs4_layoutreturn_res *res,
> > -		const struct cred *cred)
> > +bool pnfs_roc(struct inode *ino, struct nfs4_layoutreturn_args
> > *args,
> > +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct nfs4_layoutreturn_res *res, con=
st struct cred
> > *cred,
> > +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool sync)
> > =C2=A0{
> > =C2=A0	struct nfs_inode *nfsi =3D NFS_I(ino);
> > =C2=A0	struct nfs_open_context *ctx;
> > @@ -1547,7 +1546,7 @@ bool pnfs_roc(struct inode *ino,
> > =C2=A0	nfs4_stateid stateid;
> > =C2=A0	enum pnfs_iomode iomode =3D 0;
> > =C2=A0	bool layoutreturn =3D false, roc =3D false;
> > -	bool skip_read =3D false;
> > +	bool skip_read;
> >=20
> > =C2=A0	if (!nfs_have_layout(ino))
> > =C2=A0		return false;
> > @@ -1560,20 +1559,14 @@ bool pnfs_roc(struct inode *ino,
> > =C2=A0		lo =3D NULL;
> > =C2=A0		goto out_noroc;
> > =C2=A0	}
> > -	pnfs_get_layout_hdr(lo);
> > -	if (test_bit(NFS_LAYOUT_RETURN_LOCK, &lo->plh_flags)) {
> > -		spin_unlock(&ino->i_lock);
> > -		rcu_read_unlock();
> > -		wait_on_bit(&lo->plh_flags, NFS_LAYOUT_RETURN,
> > -				TASK_UNINTERRUPTIBLE);
> > -		pnfs_put_layout_hdr(lo);
> > -		goto retry;
> > -	}
> >=20
> > =C2=A0	/* no roc if we hold a delegation */
> > +	skip_read =3D false;
> > =C2=A0	if (nfs4_check_delegation(ino, FMODE_READ)) {
> > -		if (nfs4_check_delegation(ino, FMODE_WRITE))
> > +		if (nfs4_check_delegation(ino, FMODE_WRITE)) {
> > +			lo =3D NULL;
> > =C2=A0			goto out_noroc;
> > +		}
> > =C2=A0		skip_read =3D true;
> > =C2=A0	}
> >=20
> > @@ -1582,12 +1575,43 @@ bool pnfs_roc(struct inode *ino,
> > =C2=A0		if (state =3D=3D NULL)
> > =C2=A0			continue;
> > =C2=A0		/* Don't return layout if there is open file state
> > */
> > -		if (state->state & FMODE_WRITE)
> > +		if (state->state & FMODE_WRITE) {
> > +			lo =3D NULL;
> > =C2=A0			goto out_noroc;
> > +		}
> > =C2=A0		if (state->state & FMODE_READ)
> > =C2=A0			skip_read =3D true;
> > =C2=A0	}
> >=20
> > +	if (skip_read) {
> > +		bool writes =3D false;
> > +
> > +		list_for_each_entry(lseg, &lo->plh_segs, pls_list)
> > {
> > +			if (lseg->pls_range.iomode !=3D IOMODE_READ)
> > {
>=20
>=20
> ^^ This seems clever, can iomode be zero here, perhaps if another
> layout
> type doesn't know the rules for it?

The only valid iomodes for a layout segment are IOMODE_READ and
IOMODE_RW. If the server doesn't obey that rule, then it is violating
the NFSv4.x protocol, and should be taken out behind the shed.

>=20
> Otherwise, looks good - thanks for the rescue!=C2=A0=C2=A0 It would have =
taken
> me
> a month to get this far.
>=20
> Reviewed-by: Benjamin Coddington <bcodding@hammerspace.com>
>=20
> I've been musing about NFS growing something like is_sync() scoped
> thing
> that the kernel uses in other places - then we could modify our
> wait_on_bit() interfaces to complain about it.
> </half-baked thought>
>=20
> Ben

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

