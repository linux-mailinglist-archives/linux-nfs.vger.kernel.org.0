Return-Path: <linux-nfs+bounces-15760-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D1CC1C32D
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Oct 2025 17:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DD11B5A843F
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Oct 2025 16:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC51C34DCF2;
	Wed, 29 Oct 2025 16:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QoxRAjjI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B19337699
	for <linux-nfs@vger.kernel.org>; Wed, 29 Oct 2025 16:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761755016; cv=none; b=DIatz32WF99dXNf4noYZJhAEeeNRgkGKitcGE2AQCgcjQBD+u4Ky0tl48VNdpHgoaCHq6FozM0dCUk8YNumGT1EyazoITukv2YKSFbttI+iGYXW8AXK+xTkriL7K/+Zkhy9K/01BIeliPzQG1rEETs6k87Vk39B6lyHZ7aUiggo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761755016; c=relaxed/simple;
	bh=+xmvkskQ0BNrVIhUIuhXDjFF6sRBXeR29OiJmSICWmI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o2gxt/pQbkF8BjfjjGSeOVrZ8aNf9PQv5ViXuKvMwbtPxJ5J/HvJ0fJfYvJLeVTfTaSoMRnqje4DfMTzf1Na0+kZqkwC43tcioyNqEPnZmEqC7qrnJ0rUR42f3ndsvva5NtTnYbt3SXA4PnzaHtfY+1BMMbALC+95MDqK6g0tns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QoxRAjjI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42B1AC4CEF7;
	Wed, 29 Oct 2025 16:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761755016;
	bh=+xmvkskQ0BNrVIhUIuhXDjFF6sRBXeR29OiJmSICWmI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=QoxRAjjI3YLe1vbdFBikRIx0NPpWZUDjN5312k01n/+RfUhGMLCmcHjDEThNXPG0J
	 O5xEg5DwVUMIdtPc3Y4gJ5cQbNwGlr2KHxHBNejNJmwju4i4ttOjEBlaDy645cSNm6
	 XOK55jTlcnNeNNfkQqkPMyChRjzB++rKgWQd+hButj7Jm4qWfqGMVRhcd07Y3gGKYn
	 bncFq3dZkmvXJ6v+xrObhJ9fEmjKRWHrPZwKKgNY4xpGBM8Dle5iQJ3HFHd8Q3YfGF
	 hVVnx2VdyW39AmggmO0q74ggS5TUDUMDqpaodxfp1d1FgsfXd/oJz8ETQGy4V30Ogb
	 GMuxzlHcDhhTg==
Message-ID: <17d8613559d9ca7a0bccc918846b180d7e8e5626.camel@kernel.org>
Subject: Re: [PATCH v2 2/2] NFSv2/v3: Fix handling of O_DIRECTORY in
 nfs_atomic_open_v23()
From: Trond Myklebust <trondmy@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, Stephen
 Abbene	 <sabbene87@gmail.com>
Date: Wed, 29 Oct 2025 12:23:35 -0400
In-Reply-To: <176168923910.1793333.9587671564912340853@noble.neil.brown.name>
References: 
	=?utf-8?q?=3C03e3a5a82187cfc7936b87ce92ee001b27e18878=2E17616868?= =?utf-8?q?33=2Egit=2Etrond=2Emyklebust=40hammerspace=2Ecom=3E=2C_=3C733195c?= =?utf-8?q?f9970e6590f556548a18a57dfe6114ab9=2E1761686833=2Egit=2Etrond=2Emy?= =?utf-8?q?klebust=40hammerspace=2Ecom=3E?= <176168923910.1793333.9587671564912340853@noble.neil.brown.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-29 at 09:07 +1100, NeilBrown wrote:
> On Wed, 29 Oct 2025, Trond Myklebust wrote:
> > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> >=20
> > If the application sets the O_DIRECTORY flag, and tries to open a
> > regular file, the correct response is to return -ENOTDIR as is done
> > in
> > the NFSv4 atomic open case.
> >=20
> > Fixes: 7c6c5249f061 ("NFS: add atomic_open for NFSv3 to handle
> > O_TRUNC correctly.")
> > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > ---
> > =C2=A0fs/nfs/dir.c | 18 +++++++++++++++++-
> > =C2=A01 file changed, 17 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> > index ea9f6ca8f30f..dedd12cc1fc8 100644
> > --- a/fs/nfs/dir.c
> > +++ b/fs/nfs/dir.c
> > @@ -2259,6 +2259,7 @@ int nfs_atomic_open_v23(struct inode *dir,
> > struct dentry *dentry,
> > =C2=A0			umode_t mode)
> > =C2=A0{
> > =C2=A0	struct dentry *res =3D NULL;
> > +	struct inode *inode;
> > =C2=A0	/* Same as look+open from lookup_open(), but with
> > different O_TRUNC
> > =C2=A0	 * handling.
> > =C2=A0	 */
> > @@ -2267,7 +2268,7 @@ int nfs_atomic_open_v23(struct inode *dir,
> > struct dentry *dentry,
> > =C2=A0	if (dentry->d_name.len > NFS_SERVER(dir)->namelen)
> > =C2=A0		return -ENAMETOOLONG;
> > =C2=A0
> > -	if (open_flags & O_CREAT) {
> > +	if ((open_flags & O_CREAT) && !(open_flags & O_DIRECTORY))
> > {
>=20
> Since=20
> Commit: 43b450632676 ("open: return EINVAL for O_DIRECTORY |
> O_CREAT")
>=20
> the new test is redundant.=C2=A0 Doesn't hurt for documentation purposes
> though.
>=20
> > =C2=A0		error =3D nfs_do_create(dir, dentry, mode,
> > open_flags);
> > =C2=A0		if (!error) {
> > =C2=A0			file->f_mode |=3D FMODE_CREATED;
> > @@ -2275,12 +2276,27 @@ int nfs_atomic_open_v23(struct inode *dir,
> > struct dentry *dentry,
> > =C2=A0		} else if (error !=3D -EEXIST || open_flags &
> > O_EXCL)
> > =C2=A0			return error;
> > =C2=A0	}
> > +
> > =C2=A0	if (d_in_lookup(dentry)) {
> > =C2=A0		/* The only flags nfs_lookup considers are
> > =C2=A0		 * LOOKUP_EXCL and LOOKUP_RENAME_TARGET, and
> > =C2=A0		 * we want those to be zero so the lookup isn't
> > skipped.
> > =C2=A0		 */
> > =C2=A0		res =3D nfs_lookup(dir, dentry, 0);
> > +		if (!res) {
> > +			inode =3D d_inode(dentry);
> > +			if ((open_flags & O_DIRECTORY) && inode &&
> > +			=C2=A0=C2=A0=C2=A0 !(S_ISDIR(inode->i_mode) ||
> > S_ISLNK(inode->i_mode)))
> > +				res =3D ERR_PTR(-ENOTDIR);
> > +		} else if (!IS_ERR(res)) {
> > +			inode =3D d_inode(res);
> > +			if ((open_flags & O_DIRECTORY) && inode &&
> > +			=C2=A0=C2=A0=C2=A0 !(S_ISDIR(inode->i_mode) ||
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 S_ISLNK(inode->i_mode))) {
> > +				dput(res);
> > +				res =3D ERR_PTR(-ENOTDIR);
> > +			}
>=20
> I think do_open() in namei.c provides these checks
>=20
> 	if ((nd->flags & LOOKUP_DIRECTORY) && !d_can_lookup(nd-
> >path.dentry))
> 		return -ENOTDIR;
>=20
> Does this patch add something not covered there?

I was looking at the issues around CVE-2022-24448.
After spending the night looking again at the original syzkaller
report, I'm thinking I may have misread what was going on there.

In the end, I'm wondering if that issue may actually have been fixed by
commit 17b985def2a8 ("nfs: use locks_inode_context helper").

So yes, perhaps we should just drop this patch for now.

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

