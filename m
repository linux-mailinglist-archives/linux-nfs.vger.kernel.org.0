Return-Path: <linux-nfs+bounces-13409-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4DFB1A838
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Aug 2025 18:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B600163E02
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Aug 2025 16:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CAD28AAE7;
	Mon,  4 Aug 2025 16:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jij15pKt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB5428A72E
	for <linux-nfs@vger.kernel.org>; Mon,  4 Aug 2025 16:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754326464; cv=none; b=Fz8xH+UsC0GdMSHBG39fQFm8qGNrs8cbulwWaDw00GYLEDgqhzt4lCbcpNUD6MUHlZJNQTAhlN1OGDSo+cX+jHkMjlM2Wmr8a/v3CK8g7rMRVkfmsl/j0hZEbBe/duwm76dBjO9PQSx14k13xCQ6i44/DT3uXkV04zcPwOyLEAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754326464; c=relaxed/simple;
	bh=wcdVqqF2J3VJ8DssweqjZgSe/1Lwf1zk9lpFKt/rk0o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S8+pcbadrSZ63fqADnN0yK2vP5C44Aj6/GGuA30xuhCmXhAy/GLBT/gjX9mSmuBuF0Hk0WgNSo7ZR6nUZL9smbRukbHWT9gwaJ/IouoWNRDKNOE3FP6DydFbCI7e8LWjHDtv9C5vx/qx0oc3vQq7f/797VVM7V2taj1ZIABzSgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jij15pKt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7525C4CEE7;
	Mon,  4 Aug 2025 16:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754326464;
	bh=wcdVqqF2J3VJ8DssweqjZgSe/1Lwf1zk9lpFKt/rk0o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Jij15pKthFM/Ic1SMZM+pJF/tpmOd7NjQBEyC+i6sa9xNv3vZYzjIrG+9Cm5f8s0r
	 pFbiMBrzewgNuzAyXDIc8m9JZWUGnmLes+VjenoXSxy9rC+YwCGG/ANvfXV8P0tu9X
	 E1jlxtNGIrJb8+QzY8bPAVE//g6P4ZkffeHHMVSTj3BESYMIrkaNtLPIvDi9fDLIMO
	 UoImN0+fVB3qg5lgj7Be55MbCn1N6diGjRibrFx7sKg5ruZdzIfIR5WsZoW5wUDSYn
	 HlAuvP2m5eMkHLv2ZXEvDZIupOn491sFTiubDTAK/VI/myWITlu6hIvXQk3EvKkMZ6
	 zXwzaLGPtpLiQ==
Message-ID: <5036eb3f8190034811ee380d4df3ed6036de5148.camel@kernel.org>
Subject: Re: [PATCH 2/2] NFSv4: Remove duplicate lookups, capability probes
 and fsinfo calls
From: Trond Myklebust <trondmy@kernel.org>
To: Benjamin Coddington <bcodding@redhat.com>
Cc: linux-nfs@vger.kernel.org
Date: Mon, 04 Aug 2025 09:54:22 -0700
In-Reply-To: <4FB030C4-24BD-40ED-8442-8A0BFC970269@redhat.com>
References: <cover.1754270543.git.trond.myklebust@hammerspace.com>
	 <c7c737e442abb6984cef194fd8d66acab2e0b83f.1754270543.git.trond.myklebust@hammerspace.com>
	 <4FB030C4-24BD-40ED-8442-8A0BFC970269@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-08-04 at 12:43 -0400, Benjamin Coddington wrote:
> On 3 Aug 2025, at 21:29, Trond Myklebust wrote:
>=20
> > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> >=20
> > When crossing into a new filesystem, the NFSv4 client will look up
> > the
> > new directory, and then call nfs4_server_capabilities() as well as
> > nfs4_do_fsinfo() at least twice.
> >=20
> > This patch removes the duplicate calls, and reduces the initial
> > lookup
> > to retrieve just a minimal set of attributes.
> >=20
> > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > ---
> > =C2=A0fs/nfs/nfs4_fs.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 5 ++-
> > =C2=A0fs/nfs/nfs4getroot.c | 14 +++----
> > =C2=A0fs/nfs/nfs4proc.c=C2=A0=C2=A0=C2=A0 | 87 ++++++++++++++++++++----=
----------------
> > ----
> > =C2=A03 files changed, 48 insertions(+), 58 deletions(-)
> >=20
> > diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
> > index d3ca91f60fc1..c34c89af9c7d 100644
> > --- a/fs/nfs/nfs4_fs.h
> > +++ b/fs/nfs/nfs4_fs.h
> > @@ -63,7 +63,7 @@ struct nfs4_minor_version_ops {
> > =C2=A0	bool	(*match_stateid)(const nfs4_stateid *,
> > =C2=A0			const nfs4_stateid *);
> > =C2=A0	int	(*find_root_sec)(struct nfs_server *, struct
> > nfs_fh *,
> > -			struct nfs_fsinfo *);
> > +				 struct nfs_fattr *);
> > =C2=A0	void	(*free_lock_state)(struct nfs_server *,
> > =C2=A0			struct nfs4_lock_state *);
> > =C2=A0	int	(*test_and_free_expired)(struct nfs_server *,
> > @@ -296,7 +296,8 @@ extern int nfs4_call_sync(struct rpc_clnt *,
> > struct nfs_server *,
> > =C2=A0extern void nfs4_init_sequence(struct nfs4_sequence_args *, struc=
t
> > nfs4_sequence_res *, int, int);
> > =C2=A0extern int nfs4_proc_setclientid(struct nfs_client *, u32,
> > unsigned short, const struct cred *, struct nfs4_setclientid_res
> > *);
> > =C2=A0extern int nfs4_proc_setclientid_confirm(struct nfs_client *,
> > struct nfs4_setclientid_res *arg, const struct cred *);
> > -extern int nfs4_proc_get_rootfh(struct nfs_server *, struct nfs_fh
> > *, struct nfs_fsinfo *, bool);
> > +extern int nfs4_proc_get_rootfh(struct nfs_server *, struct nfs_fh
> > *,
> > +				struct nfs_fattr *, bool);
> > =C2=A0extern int nfs4_proc_bind_conn_to_session(struct nfs_client *,
> > const struct cred *cred);
> > =C2=A0extern int nfs4_proc_exchange_id(struct nfs_client *clp, const
> > struct cred *cred);
> > =C2=A0extern int nfs4_destroy_clientid(struct nfs_client *clp);
> > diff --git a/fs/nfs/nfs4getroot.c b/fs/nfs/nfs4getroot.c
> > index 1a69479a3a59..e67ea345de69 100644
> > --- a/fs/nfs/nfs4getroot.c
> > +++ b/fs/nfs/nfs4getroot.c
> > @@ -12,30 +12,28 @@
> >=20
> > =C2=A0int nfs4_get_rootfh(struct nfs_server *server, struct nfs_fh
> > *mntfh, bool auth_probe)
> > =C2=A0{
> > -	struct nfs_fsinfo fsinfo;
> > +	struct nfs_fattr *fattr =3D nfs_alloc_fattr();
> > =C2=A0	int ret =3D -ENOMEM;
> >=20
> > -	fsinfo.fattr =3D nfs_alloc_fattr();
> > -	if (fsinfo.fattr =3D=3D NULL)
> > +	if (fattr =3D=3D NULL)
> > =C2=A0		goto out;
> >=20
> > =C2=A0	/* Start by getting the root filehandle from the server */
> > -	ret =3D nfs4_proc_get_rootfh(server, mntfh, &fsinfo,
> > auth_probe);
> > +	ret =3D nfs4_proc_get_rootfh(server, mntfh, fattr,
> > auth_probe);
> > =C2=A0	if (ret < 0) {
> > =C2=A0		dprintk("nfs4_get_rootfh: getroot error =3D %d\n", -
> > ret);
> > =C2=A0		goto out;
> > =C2=A0	}
> >=20
> > -	if (!(fsinfo.fattr->valid & NFS_ATTR_FATTR_TYPE)
> > -			|| !S_ISDIR(fsinfo.fattr->mode)) {
> > +	if (!(fattr->valid & NFS_ATTR_FATTR_TYPE) ||
> > !S_ISDIR(fattr->mode)) {
> > =C2=A0		printk(KERN_ERR "nfs4_get_rootfh:"
> > =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 " getroot encountered non-=
directory\n");
> > =C2=A0		ret =3D -ENOTDIR;
> > =C2=A0		goto out;
> > =C2=A0	}
> >=20
> > -	memcpy(&server->fsid, &fsinfo.fattr->fsid, sizeof(server-
> > >fsid));
> > +	memcpy(&server->fsid, &fattr->fsid, sizeof(server->fsid));
> > =C2=A0out:
> > -	nfs_free_fattr(fsinfo.fattr);
> > +	nfs_free_fattr(fattr);
> > =C2=A0	return ret;
> > =C2=A0}
> > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > index c7c7ec22f21d..7d2b67e06cc3 100644
> > --- a/fs/nfs/nfs4proc.c
> > +++ b/fs/nfs/nfs4proc.c
> > @@ -4240,15 +4240,18 @@ static int nfs4_discover_trunking(struct
> > nfs_server *server,
> > =C2=A0}
> >=20
> > =C2=A0static int _nfs4_lookup_root(struct nfs_server *server, struct
> > nfs_fh *fhandle,
> > -		struct nfs_fsinfo *info)
> > +			=C2=A0=C2=A0=C2=A0=C2=A0 struct nfs_fattr *fattr)
> > =C2=A0{
> > -	u32 bitmask[3];
> > +	u32 bitmask[3] =3D {
> > +		[0] =3D FATTR4_WORD0_TYPE | FATTR4_WORD0_CHANGE |
> > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FATTR4_WORD0_SIZE | FATTR4_WORD0_FSID=
,
>=20
> Just a thought when noticing this change --
>=20
> Don't we want at least FATTR4_WORD0_FILEID and
> FATTR4_WORD1_MOUNTED_ON_FILEID as well here?


Only FATTR4_WORD0_TYPE and FATTR4_WORD0_FSID are used by the caller, so
we don't actually need FATTR4_WORD0_CHANGE or FATTR4_WORD0_SIZE either.
I put them in so that the test for the auth flavour would have more
chances of catching a problem.

Note that neither FATTR4_WORD0_FILEID or FATTR4_WORD1_MOUNTED_ON_FILEID
are mandatory attributes, so I also chose to avoid them + all the
timestamps for that reason.

>=20
> Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
>=20
> Ben
>=20

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

