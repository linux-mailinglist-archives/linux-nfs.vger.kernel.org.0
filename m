Return-Path: <linux-nfs+bounces-11352-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E62ADAA12B8
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Apr 2025 18:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A2811BA59BD
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Apr 2025 16:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC83253358;
	Tue, 29 Apr 2025 16:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWOy6KMw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9E924168A
	for <linux-nfs@vger.kernel.org>; Tue, 29 Apr 2025 16:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745945670; cv=none; b=ewOggKr3Wlkpu8dZpKP3PwsGlHbG4mxvyFUiwBl6sES/FsMx1Uz7F9zRXxYGM/N1y3KxvlCDybbcmdtOoJSqkKFCM18pBzYQRyLGDSqTd508ZosS4C9k3V/u9rQnXcngGbN/nUqN0wUlE6NvyETAvHDMJpmsxjaHLcNYhrrLRh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745945670; c=relaxed/simple;
	bh=PHIHdUE9RS7Ttq0eJdrJI94inAlrNPeY+I7Z3pivoS4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ufti/2Di4X8bJYxgXvszComv8ZFQzo55L7MGiY1nqBtFx7kgaFmCGGC4moN0REBsXMrcX0vfcvmjf0+erECV0G95aSZBYpmZJe4nrDtzXpeqiM4R/X6zyZNqdx4uXRgMvKsqEUrtTp3+IVRY09uFiRZKrXIAOxB5v5EbvKkoiUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWOy6KMw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84D8FC4CEE3;
	Tue, 29 Apr 2025 16:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745945670;
	bh=PHIHdUE9RS7Ttq0eJdrJI94inAlrNPeY+I7Z3pivoS4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=LWOy6KMwTvwQFNGEhVjUT+Ssya5hSAG8C6GBaCxvea/dxtBnK9YAHS0EI+MQWhrK9
	 ya/ra5tHxgsK5q5Fw9U7pkedk31LK8D8j2yygxQetiHzWE2tE9q9JPvSWIirs87xEL
	 RxjEvbEkkgLMRmgEBpGzRWmEKwbyRbZa6vnoBAK0UY7Aj7hyLkFcQK4D4zSPGi7Oa5
	 2HLDVIDYamPXphExequAcx6fSu7V7hrBKMVhXoV5O8xIKMRo132vp08FM3d9PFymN9
	 EMsUf5jv/Qy2rfS4gxspUOQLEP0VA6JdCBqENBGklG9YOi53/lKWc4fL0gDT6GuLVZ
	 x0e6gbUCHA7QA==
Message-ID: <9a09c8681702df0d8a1e3cefb8fb75113e1677b9.camel@kernel.org>
Subject: Re: [PATCH] NFS: Avoid flushing data while holding directory locks
 in nfs_rename()
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, trondmy@kernel.org, Anna Schumaker
	 <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Date: Tue, 29 Apr 2025 09:54:29 -0700
In-Reply-To: <2526363b-1f4a-4999-9f9a-8c4c5c6c132d@oracle.com>
References: 
	<a804c54445a3f028007763e05285d765afcab0f9.1745794273.git.trond.myklebust@hammerspace.com>
	 <2526363b-1f4a-4999-9f9a-8c4c5c6c132d@oracle.com>
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

On Tue, 2025-04-29 at 12:14 -0400, Chuck Lever wrote:
> On 4/27/25 7:01 PM, trondmy@kernel.org wrote:
> > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> >=20
> > The Linux client assumes that all filehandles are non-volatile for
> > renames within the same directory (otherwise sillyrename cannot work).
> > However, the existence of the Linux 'subtree_check' export option has
> > meant that nfs_rename() has always assumed it needs to flush writes
> > before attempting to rename.
> >=20
> > Since NFSv4 does allow the client to query whether or not the server
> > exhibits this behaviour, and since knfsd does actually set the
> > appropriate flag when 'subtree_check' is enabled on an export, it
> > should be OK to optimise away the write flushing behaviour in the cases
> > where it is clearly not needed.
>=20
> No objection to the high level goal, seems like a sensible change.
>=20
> So NFSv3 still has the flushing requirement, but NFSv4 can disable that
> requirement as long as the server in question asserts FH4_VOLATILE_ANY
> and FH4_VOL_RENAME, correct?
>=20

(Note that there is a v2 patch that was posted soon after this)

It's actually the reverse: if the server doesn't assert either
FH4_VOL_RENAME or FH4_VOLATILE_ANY, then you're able to disable that
requirement.

> I'm wondering how confident we are that other server implementations
> behave reasonably. Yes, they are broken if they don't behave, but there
> is still risk of introducing a regression.

> > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > ---
> >  fs/nfs/client.c           |  2 ++
> >  fs/nfs/dir.c              | 15 ++++++++++++++-
> >  include/linux/nfs_fs_sb.h |  6 ++++++
> >  3 files changed, 22 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/fs/nfs/client.c b/fs/nfs/client.c
> > index 2115c1189c2d..6d63b958c4bb 100644
> > --- a/fs/nfs/client.c
> > +++ b/fs/nfs/client.c
> > @@ -1105,6 +1105,8 @@ struct nfs_server *nfs_create_server(struct fs_co=
ntext *fc)
> >  		if (server->namelen =3D=3D 0 || server->namelen > NFS2_MAXNAMLEN)
> >  			server->namelen =3D NFS2_MAXNAMLEN;
> >  	}
> > +	/* Linux 'subtree_check' borkenness mandates this setting */
>=20
> Assuming you are going to respin this patch to deal with the build bot
> warnings, can you make this comment more useful? "borkenness" sounds
> like you are dealing with a server bug here, but that's not really
> the case. subtree_check is working as designed: it requires the extra
> flushing. The no_subtree_check case does not, IIUC.
>=20
> It would be better to explain this need strictly in terms of file handle
> volatility, no?
>=20
>=20
> > +	server->fh_expire_type =3D NFS_FH_VOL_RENAME;
> > =20
> >  	if (!(fattr->valid & NFS_ATTR_FATTR)) {
> >  		error =3D ctx->nfs_mod->rpc_ops->getattr(server, ctx->mntfh,
> > diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> > index bd23fc736b39..d0e0b435a843 100644
> > --- a/fs/nfs/dir.c
> > +++ b/fs/nfs/dir.c
> > @@ -2676,6 +2676,18 @@ nfs_unblock_rename(struct rpc_task *task, struct=
 nfs_renamedata *data)
> >  	unblock_revalidate(new_dentry);
> >  }
> > =20
> > +static bool nfs_rename_is_unsafe_cross_dir(struct dentry *old_dentry,
> > +					   struct dentry *new_dentry)
> > +{
> > +	struct nfs_server *server =3D NFS_SB(old_dentry->d_sb);
> > +
> > +	if (old_dentry->d_parent !=3D new_dentry->d_parent)
> > +		return false;
> > +	if (server->fh_expire_type & NFS_FH_RENAME_UNSAFE)
> > +		return !(server->fh_expire_type & NFS_FH_NOEXPIRE_WITH_OPEN);
> > +	return true;
> > +}
> > +
> >  /*
> >   * RENAME
> >   * FIXME: Some nfsds, like the Linux user space nfsd, may generate a
> > @@ -2763,7 +2775,8 @@ int nfs_rename(struct mnt_idmap *idmap, struct in=
ode *old_dir,
> > =20
> >  	}
> > =20
> > -	if (S_ISREG(old_inode->i_mode))
> > +	if (S_ISREG(old_inode->i_mode) &&
> > +	    nfs_rename_is_unsafe_cross_dir(old_dentry, new_dentry))
> >  		nfs_sync_inode(old_inode);
> >  	task =3D nfs_async_rename(old_dir, new_dir, old_dentry, new_dentry,
> >  				must_unblock ? nfs_unblock_rename : NULL);
> > diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
> > index 71319637a84e..6732c7e04d19 100644
> > --- a/include/linux/nfs_fs_sb.h
> > +++ b/include/linux/nfs_fs_sb.h
> > @@ -236,6 +236,12 @@ struct nfs_server {
> >  	u32			acl_bitmask;	/* V4 bitmask representing the ACEs
> >  						   that are supported on this
> >  						   filesystem */
> > +	/* The following #defines numerically match the NFSv4 equivalents */
> > +#define NFS_FH_NOEXPIRE_WITH_OPEN (0x1)
> > +#define NFS_FH_VOLATILE_ANY (0x2)
> > +#define NFS_FH_VOL_MIGRATION (0x4)
> > +#define NFS_FH_VOL_RENAME (0x8)
> > +#define NFS_FH_RENAME_UNSAFE (NFS_FH_VOLATILE_ANY | NFS_FH_VOL_RENAME)
> >  	u32			fh_expire_type;	/* V4 bitmask representing file
> >  						   handle volatility type for
> >  						   this filesystem */
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>

