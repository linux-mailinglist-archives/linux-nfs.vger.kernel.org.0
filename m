Return-Path: <linux-nfs+bounces-10132-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4499A3660D
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Feb 2025 20:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B035C1893438
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Feb 2025 19:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216A7191F88;
	Fri, 14 Feb 2025 19:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BiY5pamG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE6D2AF16
	for <linux-nfs@vger.kernel.org>; Fri, 14 Feb 2025 19:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739560758; cv=none; b=nZHqlASYElJ+6p7s6zqQUzcaMJXQgdKF35USx5Bx07RLZd+fa+Lvea3Y45dQ9+WlMq93Z0U3nUag35p7HR/YAOljUUTFGTDAfEWt11HbWMUpu6QbbSV188BmKqt/pyZCimhw9FvdOJdB5gF6dwq0hHrcOx2cIRM5ulxigPZJCdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739560758; c=relaxed/simple;
	bh=DWXwWvbWaAgjHXtyKPeFFpgjTVbGyy1ZuxSAc0HP1TM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mtg0vTXAtw0tVmuO135jpxYHfvpNehXGh4QcVBgYEvOXUp/qaRydGfEmJdbjcmOjUNkPt2EfNW6m4DU2ec/VJ8QxuO8pBPRwqeJMOSfar1wPY0MvEyLbEoDaRjzUuKUY7nsX+q1B5Ix1HjcOzfrj1WbbAZzbCSeTUHUYWZeBxTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BiY5pamG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9286C4CED1;
	Fri, 14 Feb 2025 19:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739560757;
	bh=DWXwWvbWaAgjHXtyKPeFFpgjTVbGyy1ZuxSAc0HP1TM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=BiY5pamGsiSdNH8WmB8ITyeNZ9pEVxFkqtfTWViwb4CVmcB/TfaXd7TAVFUlaOtsU
	 7E2Zt4ZJaER/7u6xyVNj1m6XD1XfrkRtJTJfq4RzYPTKhgO8tU9PS/zofiQo0Bp44Q
	 x8b9OjGZjxao316X8xDNFsUg9PBwV8HlgAEQJpfQT8EdNyRhKTpsyRvTUVjcarZrlc
	 2pb/kgQvGkklRMNweMDTNVXaJQ1dj8QmVwSJs5yktFWo/0Z7ara4zx/Wqwp2WqLA83
	 +SNBAQsnAF+PwZvwLJhNF1O7xsgA/NJOGE1fP6Jr88HCt/a7tdVdaxxxfuwBIyGXoM
	 2P4MlkaWAagPw==
Message-ID: <4f60405d36f8ab05bb464b24d6ec8b0c5e1e16de.camel@kernel.org>
Subject: Re: [PATCH 2/2] NFSD: allow client to use write delegation stateid
 for READ
From: Jeff Layton <jlayton@kernel.org>
To: Dai Ngo <dai.ngo@oracle.com>, Chuck Lever <chuck.lever@oracle.com>, 
	neilb@suse.de, okorniev@redhat.com, tom@talpey.com
Cc: linux-nfs@vger.kernel.org, sagi@grimberg.me
Date: Fri, 14 Feb 2025 14:19:15 -0500
In-Reply-To: <7a59cfaa-b984-45b3-9c0d-e7ab6cbb65f4@oracle.com>
References: <1739475438-5640-1-git-send-email-dai.ngo@oracle.com>
	 <1739475438-5640-3-git-send-email-dai.ngo@oracle.com>
	 <5eeb042a0a6c69bba89e1334d6ceac872eda03e3.camel@kernel.org>
	 <41f344362f8d1c7a3a3f72dbc8a904ffbccec189.camel@kernel.org>
	 <1380007b-6cd7-4be9-952e-2a834d1a4e01@oracle.com>
	 <7a59cfaa-b984-45b3-9c0d-e7ab6cbb65f4@oracle.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-02-14 at 10:24 -0800, Dai Ngo wrote:
> On 2/14/25 6:26 AM, Chuck Lever wrote:
> > On 2/13/25 6:29 PM, Jeff Layton wrote:
> > > On Thu, 2025-02-13 at 16:07 -0500, Jeff Layton wrote:
> > > > On Thu, 2025-02-13 at 11:37 -0800, Dai Ngo wrote:
> > > > > Allow read using write delegation stateid granted on OPENs with
> > > > > OPEN4_SHARE_ACCESS_WRITE only, to accommodate clients whose WRITE
> > > > > implementation may unavoidably do (e.g., due to buffer cache
> > > > > constraints).
> > > > >=20
> > > > > When this condition is detected in nfsd4_encode_read the access
> > > > > mode FMODE_READ is temporarily added to the file's f_mode and is
> > > > > removed when the read is done.
> > > > >=20
> > > > > Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> > > > > ---
> > > > >   fs/nfsd/nfs4proc.c | 15 ++++++++++++++-
> > > > >   fs/nfsd/nfs4xdr.c  |  8 ++++++++
> > > > >   fs/nfsd/xdr4.h     |  1 +
> > > > >   3 files changed, 23 insertions(+), 1 deletion(-)
> > > > >=20
> > > > > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > > > > index f6e06c779d09..be43627bbf78 100644
> > > > > --- a/fs/nfsd/nfs4proc.c
> > > > > +++ b/fs/nfsd/nfs4proc.c
> > > > > @@ -973,7 +973,18 @@ nfsd4_read(struct svc_rqst *rqstp, struct nf=
sd4_compound_state *cstate,
> > > > >   	/* check stateid */
> > > > >   	status =3D nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->=
current_fh,
> > > > >   					&read->rd_stateid, RD_STATE,
> > > > > -					&read->rd_nf, NULL);
> > > > > +					&read->rd_nf, &read->rd_wd_stid);
> > > > > +	/*
> > > > > +	 * rd_wd_stid is needed for nfsd4_encode_read to allow write
> > > > > +	 * delegation stateid used for read. Its refcount is decremente=
d
> > > > > +	 * by nfsd4_read_release when read is done.
> > > > > +	 */
> > > > > +	if (!status && read->rd_wd_stid &&
> > > > > +		(read->rd_wd_stid->sc_type !=3D SC_TYPE_DELEG ||
> > > > > +		delegstateid(read->rd_wd_stid)->dl_type !=3D NFS4_OPEN_DELEGAT=
E_WRITE)) {
> > > > > +		nfs4_put_stid(read->rd_wd_stid);
> > > > > +		read->rd_wd_stid =3D NULL;
> > > > > +	}
> > > > >  =20
> > > > >   	read->rd_rqstp =3D rqstp;
> > > > >   	read->rd_fhp =3D &cstate->current_fh;
> > > > > @@ -984,6 +995,8 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfs=
d4_compound_state *cstate,
> > > > >   static void
> > > > >   nfsd4_read_release(union nfsd4_op_u *u)
> > > > >   {
> > > > > +	if (u->read.rd_wd_stid)
> > > > > +		nfs4_put_stid(u->read.rd_wd_stid);
> > > > >   	if (u->read.rd_nf)
> > > > >   		nfsd_file_put(u->read.rd_nf);
> > > > >   	trace_nfsd_read_done(u->read.rd_rqstp, u->read.rd_fhp,
> > > > > diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> > > > > index e67420729ecd..3996678bab3f 100644
> > > > > --- a/fs/nfsd/nfs4xdr.c
> > > > > +++ b/fs/nfsd/nfs4xdr.c
> > > > > @@ -4498,6 +4498,7 @@ nfsd4_encode_read(struct nfsd4_compoundres =
*resp, __be32 nfserr,
> > > > >   	unsigned long maxcount;
> > > > >   	__be32 wire_data[2];
> > > > >   	struct file *file;
> > > > > +	bool wronly =3D false;
> > > > >  =20
> > > > >   	if (nfserr)
> > > > >   		return nfserr;
> > > > > @@ -4515,10 +4516,17 @@ nfsd4_encode_read(struct nfsd4_compoundre=
s *resp, __be32 nfserr,
> > > > >   	maxcount =3D min_t(unsigned long, read->rd_length,
> > > > >   			 (xdr->buf->buflen - xdr->buf->len));
> > > > >  =20
> > > > > +	if (!(file->f_mode & FMODE_READ) && read->rd_wd_stid) {
> > > > > +		/* allow READ using write delegation stateid */
> > > > > +		wronly =3D true;
> > > > > +		file->f_mode |=3D FMODE_READ;
> > > > > +	}
> > > > Is that really OK? Can we just upgrade the f_mode like that?
>=20
> It seems too simple but it works. I tested with pynfs, nfstest and
> git test, also with reexported NFS share.
>=20

I don't think it's that simple. Some filesystems will have problems
here. There has been talk for years about allowing fcntl(F_SETFL, ...)
to change the file access mode, but that still has never materialized.

=20
> > > >=20
> > > > Also, what happens with more exotic exported filesystems like NFS?
> > > >=20
> > > > For example, if I'm reexporting NFS, the backend NFS server may not
> > > > allow you to do a READ operation using a OPEN4_SHARE_ACCESS_WRITE o=
nly
> > > > stateid. Won't this break in that case?
> > > >=20
> > > Hmm...bad example since we don't allow delegations on reexported NFS
> > > these days.
>=20
> As of 6.14-rc1 the NFSD grants delegations on reexported NFS shares as
> long as the server where the shares reside grants delegations. And this
> seems to work properly; delegations are recalled when expected.
>=20

Ahh, I was thinking of this patch in Chuck's nfsd-testing branch:

commit 2d7501a673a5d855a941409e6003a0b2afbbe149
Author: Mike Snitzer <snitzer@kernel.org>
Date:   Mon Feb 10 11:25:53 2025 -0500

    nfsd: disallow file locking and delegations for NFSv4 reexport
   =20
    We do not and cannot support file locking with NFS reexport over
    NFSv4.x for the same reason we don't do it for NFSv3: NFS reexport
    server reboot cannot allow clients to recover locks because the source
    NFS server has not rebooted, and so it is not in grace.  Since the
    source NFS server is not in grace, it cannot offer any guarantees that
    the file won't have been changed between the locks getting lost and
    any attempt to recover/reclaim them.  The same applies to delegations
    and any associated locks, so disallow them too.
   =20
    Clients are no longer allowed to get file locks or delegations from a
    reexport server, any attempts will fail with operation not supported.
   =20
    Update the "Reboot recovery" section accordingly in
    Documentation/filesystems/nfs/reexport.rst
   =20
    Signed-off-by: Mike Snitzer <snitzer@kernel.org>
    Reviewed-by: Jeff Layton <jlayton@kernel.org>
    Signed-off-by: Chuck Lever <chuck.lever@oracle.com>


> > >   Reexporting Ceph or SMB might be a better example. They'll
> > > likely both have problems if you try to issue a read on the result fr=
om
> > > a O_WRONLY open. I think you will probably need to rework the way
> > > nfs4_file's track their struct files.
> > >=20
> > > IOW, when the client does a OPEN4_SHARE_ACCESS_WRITE-only open, you
> > > need to get a struct file that is FMODE_READ|FMODE_WRITE to hang off
> > > the delegation.
>=20
> There won't be any existing struct file with FMODE_READ|FMODE_WRITE when
> nfs4_set_delegation is called if the client opens the file with access
> mode OPEN4_SHARE_ACCESS_WRITE. Unless we create a new one which means now
> we have 2 struct file's for the same nfs4_file, it seems like problematic=
.
>=20
> > >   But, you'll also need to fix up the accounting for the
> > > share/deny mode locking to ignore that you _actually_ have it open fo=
r
> > > read too in that case.
>=20
> If I understand you correctly, you suggest that we upgrade the file acces=
s
> mode to FMODE_READ|FMODE_WRITE permanently if the client opens the file w=
ith
> OPEN4_SHARE_ACCESS_WRITE only. That works too but we have to remove the
> FMODE_READ from the struct file if the delegation is recalled.
>=20
>=20

I don't see a problem with leaving the backend file open
FMODE_READ|FMODE_WRITE in that case. You can just stop allowing reads
on it at the nfsd layer.

>=20
> > For the record, I agree with Jeff's suggested approach.
> >=20
> >=20
> > > Smoke and mirrors...
> > >=20
> > > > >   	if (file->f_op->splice_read && splice_ok)
> > > > >   		nfserr =3D nfsd4_encode_splice_read(resp, read, file, maxcoun=
t);
> > > > >   	else
> > > > >   		nfserr =3D nfsd4_encode_readv(resp, read, file, maxcount);
> > > > > +	if (wronly)
> > > > > +		file->f_mode &=3D ~FMODE_READ;
> > > > >   	if (nfserr) {
> > > > >   		xdr_truncate_encode(xdr, eof_offset);
> > > > >   		return nfserr;
> > > > > diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> > > > > index c26ba86dbdfd..2f053beed899 100644
> > > > > --- a/fs/nfsd/xdr4.h
> > > > > +++ b/fs/nfsd/xdr4.h
> > > > > @@ -426,6 +426,7 @@ struct nfsd4_read {
> > > > >   	struct svc_rqst		*rd_rqstp;          /* response */
> > > > >   	struct svc_fh		*rd_fhp;            /* response */
> > > > >   	u32			rd_eof;             /* response */
> > > > > +	struct nfs4_stid	*rd_wd_stid;        /* internal */
> > > > >   };
> > > > >  =20
> > > > >   struct nfsd4_readdir {
> >=20

--=20
Jeff Layton <jlayton@kernel.org>

