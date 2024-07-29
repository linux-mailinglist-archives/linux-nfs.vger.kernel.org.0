Return-Path: <linux-nfs+bounces-5141-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA24393F75A
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 16:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AF97B21B8F
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 14:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6432914D282;
	Mon, 29 Jul 2024 14:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHEaEKN9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403A5823A9
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jul 2024 14:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722262369; cv=none; b=R0MhZ2V5uWnorhzgBmcS8mIHS/6S+MNEuVfs+JPkgxKSKLv0BqZsigIiM+L+ndarw7Xs7xrYByCphsJHAao4bzCvMgR9/18Odc2cOecSci17Z2+lPGQBQ7NK1y/5+TBKkeQASijLUeQDZN0O/fnWVw/n95mfNba7BdhkZzqAwSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722262369; c=relaxed/simple;
	bh=Bj8nKyKW022ZimJN0PtkH3doaJ3MhMrg07DIuxpeiSk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lGdKKrd917FEIk3oq4hdlxcVQ9tt6u0zyGvvMZ9vN/96+e0xNjzUFOcgSJMJdtbKKyBbO9PKx6fAd5xSTLKrEw/JWUmxkUKhI6q+XECfw+cRUWIJSo71WZHbO3IRPiBGj4eX7VSPFVhYifH2KKwg/o7639zSiMmMjpgfZbrrUnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHEaEKN9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C3D7C32786;
	Mon, 29 Jul 2024 14:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722262368;
	bh=Bj8nKyKW022ZimJN0PtkH3doaJ3MhMrg07DIuxpeiSk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=hHEaEKN9nyDTQ/KPrKrLS86CRZXtd+V7L4Kri0ZxxA2OJ/uUlPbvcffWIu266rhLo
	 rFkT1fNhcHm1BsZjRh0y5HeIseK098xFsjsIR6KfVbShjddx6U98lns3Yg9TDC9Qs9
	 PXPGRKLruzxiapa/5O/oAXV0mp3w7+CoVFFNDnv/ruuQOtNIC+bZ1fz/tLqrTVc0pP
	 17plQQbQ7rTdYtvhBMq4qPcqOjLTv7rE3QJCRAxk6wCqIvbrLjMLRCxZbOycSDpPiH
	 WqjJfhmHJY1Agh7WKX6qIkjRE1dBOEyLKPdaFB2jDWHcAGaQdkADks5AvMKzu5P1nw
	 GSCVlginmd7HA==
Message-ID: <8c17942a9ed617c90f3e99b8ef2fe69969c9c6b1.camel@kernel.org>
Subject: Re: [PATCH v2 2/3] nfsd: Offer write delegations for o_wronly opens
From: Jeff Layton <jlayton@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>, Chuck Lever <chuck.lever@oracle.com>
Cc: Dai Ngo <dai.ngo@oracle.com>, Olga Kornievskaia <aglo@umich.edu>, 
	linux-nfs@vger.kernel.org
Date: Mon, 29 Jul 2024 10:12:46 -0400
In-Reply-To: <0fc73dce-1ab1-4229-a81e-3c058e2bcee3@grimberg.me>
References: <20240728204104.519041-1-sagi@grimberg.me>
	 <20240728204104.519041-3-sagi@grimberg.me>
	 <81765320f56c349298be08457ef2211a581c29f9.camel@kernel.org>
	 <6a78bd6b-b5c4-489c-a7dd-bd688fed8d94@grimberg.me>
	 <cb6cf6834ca3383804b7bd994eeaf310cfbf8c78.camel@kernel.org>
	 <0fc73dce-1ab1-4229-a81e-3c058e2bcee3@grimberg.me>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-07-29 at 16:39 +0300, Sagi Grimberg wrote:
>=20
>=20
>=20
> On 29/07/2024 16:10, Jeff Layton wrote:
> > On Mon, 2024-07-29 at 15:58 +0300, Sagi Grimberg wrote:
> > >=20
> > >=20
> > > On 29/07/2024 15:10, Jeff Layton wrote:
> > > > On Sun, 2024-07-28 at 23:41 +0300, Sagi Grimberg wrote:
> > > > > In order to support write delegations with O_WRONLY opens, we
> > > > > need to
> > > > > allow the clients to read using the write delegation stateid
> > > > > (Per
> > > > > RFC
> > > > > 8881 section 9.1.2. Use of the Stateid and Locking).
> > > > >=20
> > > > > Hence, we check for NFS4_SHARE_ACCESS_WRITE set in open
> > > > > request,
> > > > > and
> > > > > in case the share access flag does not set
> > > > > NFS4_SHARE_ACCESS_READ
> > > > > as
> > > > > well, we'll open the file locally with O_RDWR in order to
> > > > > allow
> > > > > the
> > > > > client to use the write delegation stateid when issuing a
> > > > > read in
> > > > > case
> > > > > it may choose to.
> > > > >=20
> > > > > Plus, find_rw_file singular call-site is now removed, remove
> > > > > it
> > > > > altogether.
> > > > >=20
> > > > > Note: reads using special stateids that conflict with pending
> > > > > write
> > > > > delegations are undetected, and will be covered in a follow
> > > > > on
> > > > > patch.
> > > > >=20
> > > > > Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> > > > > ---
> > > > > =C2=A0=C2=A0=C2=A0fs/nfsd/nfs4proc.c=C2=A0 | 18 +++++++++++++++++=
-
> > > > > =C2=A0=C2=A0=C2=A0fs/nfsd/nfs4state.c | 42 ++++++++++++++++++++--=
-----------
> > > > > -----
> > > > > ----
> > > > > =C2=A0=C2=A0=C2=A0fs/nfsd/xdr4.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 2 ++
> > > > > =C2=A0=C2=A0=C2=A03 files changed, 39 insertions(+), 23 deletions=
(-)
> > > > >=20
> > > > > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > > > > index 7b70309ad8fb..041bcc3ab5d7 100644
> > > > > --- a/fs/nfsd/nfs4proc.c
> > > > > +++ b/fs/nfsd/nfs4proc.c
> > > > > @@ -979,8 +979,22 @@ nfsd4_read(struct svc_rqst *rqstp,
> > > > > struct
> > > > > nfsd4_compound_state *cstate,
> > > > > =C2=A0=C2=A0=C2=A0	/* check stateid */
> > > > > =C2=A0=C2=A0=C2=A0	status =3D nfs4_preprocess_stateid_op(rqstp, c=
state,
> > > > > &cstate-
> > > > > > current_fh,
> > > > > =C2=A0=C2=A0=C2=A0					&read->rd_stateid,
> > > > > RD_STATE,
> > > > > -					&read->rd_nf, NULL);
> > > > > +					&read->rd_nf, &read-
> > > > > > rd_wd_stid);
> > > > > =C2=A0=C2=A0=20
> > > > > +	/*
> > > > > +	 * rd_wd_stid is needed for nfsd4_encode_read to
> > > > > allow
> > > > > write
> > > > > +	 * delegation stateid used for read. Its refcount is
> > > > > decremented
> > > > > +	 * by nfsd4_read_release when read is done.
> > > > > +	 */
> > > > > +	if (!status) {
> > > > > +		if (read->rd_wd_stid &&
> > > > > +		=C2=A0=C2=A0=C2=A0 (read->rd_wd_stid->sc_type !=3D
> > > > > SC_TYPE_DELEG
> > > > > > >=20
> > > > > +		=C2=A0=C2=A0=C2=A0=C2=A0 delegstateid(read->rd_wd_stid)->dl_ty=
pe
> > > > > !=3D
> > > > > +					NFS4_OPEN_DELEGATE_W
> > > > > RITE
> > > > > )) {
> > > > > +			nfs4_put_stid(read->rd_wd_stid);
> > > > > +			read->rd_wd_stid =3D NULL;
> > > > > +		}
> > > > > +	}
> > > > > =C2=A0=C2=A0=C2=A0	read->rd_rqstp =3D rqstp;
> > > > > =C2=A0=C2=A0=C2=A0	read->rd_fhp =3D &cstate->current_fh;
> > > > > =C2=A0=C2=A0=C2=A0	return status;
> > > > > @@ -990,6 +1004,8 @@ nfsd4_read(struct svc_rqst *rqstp,
> > > > > struct
> > > > > nfsd4_compound_state *cstate,
> > > > > =C2=A0=C2=A0=C2=A0static void
> > > > > =C2=A0=C2=A0=C2=A0nfsd4_read_release(union nfsd4_op_u *u)
> > > > > =C2=A0=C2=A0=C2=A0{
> > > > > +	if (u->read.rd_wd_stid)
> > > > > +		nfs4_put_stid(u->read.rd_wd_stid);
> > > > > =C2=A0=C2=A0=C2=A0	if (u->read.rd_nf)
> > > > > =C2=A0=C2=A0=C2=A0		nfsd_file_put(u->read.rd_nf);
> > > > > =C2=A0=C2=A0=C2=A0	trace_nfsd_read_done(u->read.rd_rqstp, u-
> > > > > >read.rd_fhp,
> > > > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > > > index 0645fccbf122..538b6e1127a2 100644
> > > > > --- a/fs/nfsd/nfs4state.c
> > > > > +++ b/fs/nfsd/nfs4state.c
> > > > > @@ -639,18 +639,6 @@ find_readable_file(struct nfs4_file *f)
> > > > > =C2=A0=C2=A0=C2=A0	return ret;
> > > > > =C2=A0=C2=A0=C2=A0}
> > > > > =C2=A0=C2=A0=20
> > > > > -static struct nfsd_file *
> > > > > -find_rw_file(struct nfs4_file *f)
> > > > > -{
> > > > > -	struct nfsd_file *ret;
> > > > > -
> > > > > -	spin_lock(&f->fi_lock);
> > > > > -	ret =3D nfsd_file_get(f->fi_fds[O_RDWR]);
> > > > > -	spin_unlock(&f->fi_lock);
> > > > > -
> > > > > -	return ret;
> > > > > -}
> > > > > -
> > > > > =C2=A0=C2=A0=C2=A0struct nfsd_file *
> > > > > =C2=A0=C2=A0=C2=A0find_any_file(struct nfs4_file *f)
> > > > > =C2=A0=C2=A0=C2=A0{
> > > > > @@ -5784,15 +5772,11 @@ nfs4_set_delegation(struct nfsd4_open
> > > > > *open,
> > > > > struct nfs4_ol_stateid *stp,
> > > > > =C2=A0=C2=A0=C2=A0	 *=C2=A0 "An OPEN_DELEGATE_WRITE delegation al=
lows the
> > > > > client
> > > > > to
> > > > > handle,
> > > > > =C2=A0=C2=A0=C2=A0	 *=C2=A0=C2=A0 on its own, all opens."
> > > > > =C2=A0=C2=A0=C2=A0	 *
> > > > > -	 * Furthermore the client can use a write delegation
> > > > > for
> > > > > most READ
> > > > > -	 * operations as well, so we require a O_RDWR file
> > > > > here.
> > > > > -	 *
> > > > > -	 * Offer a write delegation in the case of a BOTH
> > > > > open,
> > > > > and
> > > > > ensure
> > > > > -	 * we get the O_RDWR descriptor.
> > > > > +	 * Offer a write delegation for WRITE or BOTH access
> > > > > =C2=A0=C2=A0=C2=A0	 */
> > > > > -	if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH)
> > > > > =3D=3D
> > > > > NFS4_SHARE_ACCESS_BOTH) {
> > > > > -		nf =3D find_rw_file(fp);
> > > > > +	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE)
> > > > > {
> > > > > =C2=A0=C2=A0=C2=A0		dl_type =3D NFS4_OPEN_DELEGATE_WRITE;
> > > > > +		nf =3D find_writeable_file(fp);
> > > > > =C2=A0=C2=A0=C2=A0	}
> > > > > =C2=A0=C2=A0=20
> > > > > =C2=A0=C2=A0=C2=A0	/*
> > > > > @@ -5934,8 +5918,8 @@ static void
> > > > > nfsd4_open_deleg_none_ext(struct
> > > > > nfsd4_open *open, int status)
> > > > > =C2=A0=C2=A0=C2=A0 * open or lock state.
> > > > > =C2=A0=C2=A0=C2=A0 */
> > > > > =C2=A0=C2=A0=C2=A0static void
> > > > > -nfs4_open_delegation(struct nfsd4_open *open, struct
> > > > > nfs4_ol_stateid
> > > > > *stp,
> > > > > -		=C2=A0=C2=A0=C2=A0=C2=A0 struct svc_fh *currentfh)
> > > > > +nfs4_open_delegation(struct svc_rqst *rqstp, struct
> > > > > nfsd4_open
> > > > > *open,
> > > > > +		struct nfs4_ol_stateid *stp, struct svc_fh
> > > > > *currentfh)
> > > > > =C2=A0=C2=A0=C2=A0{
> > > > > =C2=A0=C2=A0=C2=A0	struct nfs4_delegation *dp;
> > > > > =C2=A0=C2=A0=C2=A0	struct nfs4_openowner *oo =3D openowner(stp-
> > > > > > st_stateowner);
> > > > > @@ -5994,6 +5978,20 @@ nfs4_open_delegation(struct nfsd4_open
> > > > > *open,
> > > > > struct nfs4_ol_stateid *stp,
> > > > > =C2=A0=C2=A0=C2=A0		dp->dl_cb_fattr.ncf_cur_fsize =3D stat.size;
> > > > > =C2=A0=C2=A0=C2=A0		dp->dl_cb_fattr.ncf_initial_cinfo =3D
> > > > > =C2=A0=C2=A0=C2=A0			nfsd4_change_attribute(&stat,
> > > > > d_inode(currentfh->fh_dentry));
> > > > > +		if ((open->op_share_access &
> > > > > NFS4_SHARE_ACCESS_BOTH)
> > > > > !=3D NFS4_SHARE_ACCESS_BOTH) {
> > > > > +			struct nfsd_file *nf =3D NULL;
> > > > > +
> > > > > +			/* make sure the file is opened
> > > > > locally
> > > > > for
> > > > > O_RDWR */
> > > > > +			status =3D
> > > > > nfsd_file_acquire_opened(rqstp,
> > > > > currentfh,
> > > > > +				nfs4_access_to_access(NFS4_S
> > > > > HARE
> > > > > _ACC
> > > > > ESS_BOTH),
> > > > > +				open->op_filp, &nf);
> > > > > +			if (status) {
> > > > > +				nfs4_put_stid(&dp->dl_stid);
> > > > > +				destroy_delegation(dp);
> > > > > +				goto out_no_deleg;
> > > > > +			}
> > > > > +			stp->st_stid.sc_file->fi_fds[O_RDWR]
> > > > > =3D
> > > > > nf;
> > > > I have a bit of a concern here. When we go to put access
> > > > references
> > > > to
> > > > the fi_fds, that's done according to the st_access_bmap. Here
> > > > though,
> > > > you're adding an extra reference for the O_RDWR fd, but I don't
> > > > see
> > > > where you're calling set_access for that on the delegation
> > > > stateid?
> > > > Am
> > > > I missing where that happens? Not doing that may lead to fd
> > > > leaks
> > > > if it
> > > > was missed.
> > > Ah, this is something that I did not fully understand...
> > > However it looks like st_access_bmap is not something that is
> > > accounted on the delegation stateid...
> > >=20
> > > Can I simply set it on the open stateid (stp)?
> > That would likely fix the leak, but I'm not sure that's the best
> > approach. You have an NFS4_SHARE_ACCESS_WRITE-only stateid here,
> > and
> > that would turn it a NFS4_SHARE_ACCESS_BOTH one, wouldn't it?
> >=20
> > It wouldn't surprise me if that might break a testcase or two.
>=20
> Well, if the server handed out a write delegation, isn't it
> effectively=20
> equivalent to
> NFS4_SHARE_ACCESS_BOTH open?

For the delegation, yes, but you're proposing to change an open stateid
that was explicitly requested to be ACCESS_WRITE into ACCESS_BOTH.

Given that you're doing this for a write delegation, that sort of
implies that no other client has it open. Maybe it's OK in that case,
but I think that if you do that then you'd need to convert the open
stateid back into being ACCESS_WRITE when the delegation goes away.

Otherwise you wouldn't (for instance) be able to set a DENY_READ on the
file after doing an O_WRONLY open on it.

Thinking about this a bit more though, I wonder if we ought to consider
reworking the nfs4_file access altogether, especially in light of the
recent delstid draft. Today, the open stateids hold all of the access
refs, so if those go away while there is still an outstanding
delegation, there's no guarantee we'll consider the file open at all
anymore (AFAICS).

Eventually we want to implement delstid support, in which case we'll
need to support the situation where we may give out a delegation with
no open stateid. It might be better to rework things along those lines
instead.
--=20
Jeff Layton <jlayton@kernel.org>

