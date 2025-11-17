Return-Path: <linux-nfs+bounces-16473-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A048C6672A
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Nov 2025 23:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C6F00359572
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Nov 2025 22:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4AF329E54;
	Mon, 17 Nov 2025 22:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2mYhdJb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C03326D50;
	Mon, 17 Nov 2025 22:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763419313; cv=none; b=pEMyFqwcF+x5eyt1tMzjjNLrgrvMfbX8ij7XRdaW7XrT5cNZ0uWo94zH7z8JqeJnUneUy6n/fj5PzfkEkVrL50wBZe4TNtM2ecr9cWt7zXVaXfs7NIAm4mH6TfTK5VwyxYioqXoq3SJhaonn6cXK+xPwBoqfC/pC/p2Mpwj4T+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763419313; c=relaxed/simple;
	bh=/np2jtltYtAq19YDeItpEHDUX2fUYvu66KTsE1n83qA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fWPiqPavDhOKqI4v5DWlaBOpWyyK3fxvNWfS8J7V5GEjHLLY0JtTHvtkq1PbvtmsTjb/zCN0A2FaQL4a22+rPjgDB409JkIKoBmWRjih/72RlbYbKQ8OwSdgicxJqWgSZrkCStSVzEQ+bhDUlFN0IP4yP3oNFEEwagQd1gWQ37E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2mYhdJb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 884C0C19425;
	Mon, 17 Nov 2025 22:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763419312;
	bh=/np2jtltYtAq19YDeItpEHDUX2fUYvu66KTsE1n83qA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=J2mYhdJbxp7hWdB2Om1S6jdhAahWTvyvfAqacCatd37gWK4F+e7OxkShQv6ByZGGF
	 bhXh8q2jXvYGCE/ghfFm/24qT2nz1VRCi/OJPo4KemZOTH0v4zOVc5KnhhsYjTnuL+
	 eUWHM8HiCgN0wzHvUGNzT4qnA9ByGKRGICmTTwXhgXhttwif/WHT9l+5C2brYAxWJ1
	 gM20n/6AZyXR70OJRhFVpQA/5XnEXaU8wSDGnHIWGjm8CAsqt17y/SEdXpLX8QYayA
	 t1B1gLaofWsqUEjExHDjG87NNxuzpV0lgVflq/GH9gnG6+v8INZ4DbAIfbe8Mn0r7H
	 Z51DfPwFENoAQ==
Message-ID: <87a10c8f00f5e803723811a7c7a67e03c6cbabb8.camel@kernel.org>
Subject: Re: [PATCH] NFS: ensure nfs_safe_remove() atomic nlink drop
From: Trond Myklebust <trondmy@kernel.org>
To: Aiden Lambert <alambert48@gatech.edu>
Cc: anna@kernel.org, chuck.lever@oracle.org, jlayton@kernel.org, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 17 Nov 2025 17:41:49 -0500
In-Reply-To: <q43d4llud37qniopiaejx5p6hyjhaubvwchnekhekzfbgtbybg@zhunmybqs3dr>
References: 
	<qqu6ndrq6ytkt7rfe7hw62iu34fkt6eckixjgx7bkhqgvzvcm6@h4tj3bkvvidi>
	 <3fa28515be621f91f237d323ff4b97430e73b032.camel@kernel.org>
	 <q43d4llud37qniopiaejx5p6hyjhaubvwchnekhekzfbgtbybg@zhunmybqs3dr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-11-17 at 13:57 -0500, Aiden Lambert wrote:
> On Mon, Nov 17, 2025 at 01:24:54PM -0500, Trond Myklebust wrote:
> > On Mon, 2025-11-17 at 13:03 -0500, Aiden Lambert wrote:
> > > A race condition occurs when both unlink() and link() are running
> > > concurrently on the same inode, and the nlink count from the nfs
> > > server
> > > received in link()->nfs_do_access() clobbers the nlink count of
> > > the
> > > inode in nfs_safe_remove() after the "remove" RPC is made to the
> > > server
> > > but before we decrement the link count. If the nlink value from
> > > nfs_do_access() reflects the decremented nlink of the "remove"
> > > RPC, a
> > > double decrement occurs, which can lead to the dropping of the
> > > client
> > > side inode, causing the link call to return ENOENT. To fix this,
> > > we
> > > record an expected nlink value before the "remove" RPC and
> > > compare it
> > > with the value afterwards---if these two are the same, the drop
> > > is
> > > performed. Note that this does not take into account nlink values
> > > that
> > > are a result of multi-client (un)link operations as these are not
> > > guaranteed to be atomic by the NFS spec.
> >=20
> >=20
> > Why do we end up running nfs_do_access() at all in the above test?
> > That
> > sounds like a bug. We shouldn't ever need to validate if we can
> > create
> > or delete things using ACCESS. That just ends up producing an
> > unnecessary TOCTOU race.
> >=20
> >=20
>=20
> It seems that the call chain is
> 1. vfs_link()
> 2. may_create()
> 3. inode_permission()/nfs_permission() which fails to get a cached
> value as the cache is
> invalidated by the (un)link operations
> 4. nfs_do_access()

I'm still confused. Why wouldn't the S_IFDIR case in nfs_permission()
be filtering away the call to nfs_do_access()?

Either way, I think this cannot be fixed without treating it as a
generic attribute race. Your patch is sort of correct, but there are
loopholes that it won't catch either, so let's just fix it the way that
we fix all attribute races: by using the generation counter to tell us
when such a race may have occurred.

8<---------------------------------------
From bd4928ec799b31c492eb63f9f4a0c1e0bb4bb3f7 Mon Sep 17 00:00:00 2001
Message-ID: <bd4928ec799b31c492eb63f9f4a0c1e0bb4bb3f7.1763418720.git.trond.=
myklebust@hammerspace.com>
From: Trond Myklebust <trond.myklebust@hammerspace.com>
Date: Mon, 17 Nov 2025 15:28:17 -0500
Subject: [PATCH] NFS: Avoid changing nlink when file removes and attribute
 updates race

If a file removal races with another operation that updates its
attributes, then skip the change to nlink, and just mark the attributes
as being stale.

Reported-by: Aiden Lambert <alambert48@gatech.edu>
Fixes: 59a707b0d42e ("NFS: Ensure we revalidate the inode correctly after r=
emove or rename")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index ea9f6ca8f30f..d557b0443e8b 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1894,13 +1894,15 @@ static int nfs_dentry_delete(const struct dentry *d=
entry)
 }
=20
 /* Ensure that we revalidate inode->i_nlink */
-static void nfs_drop_nlink(struct inode *inode)
+static void nfs_drop_nlink(struct inode *inode, unsigned long gencount)
 {
+	struct nfs_inode *nfsi =3D NFS_I(inode);
+
 	spin_lock(&inode->i_lock);
 	/* drop the inode if we're reasonably sure this is the last link */
-	if (inode->i_nlink > 0)
+	if (inode->i_nlink > 0 && gencount =3D=3D nfsi->attr_gencount)
 		drop_nlink(inode);
-	NFS_I(inode)->attr_gencount =3D nfs_inc_attr_generation_counter();
+	nfsi->attr_gencount =3D nfs_inc_attr_generation_counter();
 	nfs_set_cache_invalid(
 		inode, NFS_INO_INVALID_CHANGE | NFS_INO_INVALID_CTIME |
 			       NFS_INO_INVALID_NLINK);
@@ -1914,8 +1916,9 @@ static void nfs_drop_nlink(struct inode *inode)
 static void nfs_dentry_iput(struct dentry *dentry, struct inode *inode)
 {
 	if (dentry->d_flags & DCACHE_NFSFS_RENAMED) {
+		unsigned long gencount =3D READ_ONCE(NFS_I(inode)->attr_gencount);
 		nfs_complete_unlink(dentry, inode);
-		nfs_drop_nlink(inode);
+		nfs_drop_nlink(inode, gencount);
 	}
 	iput(inode);
 }
@@ -2507,9 +2510,11 @@ static int nfs_safe_remove(struct dentry *dentry)
=20
 	trace_nfs_remove_enter(dir, dentry);
 	if (inode !=3D NULL) {
+		unsigned long gencount =3D READ_ONCE(NFS_I(inode)->attr_gencount);
+
 		error =3D NFS_PROTO(dir)->remove(dir, dentry);
 		if (error =3D=3D 0)
-			nfs_drop_nlink(inode);
+			nfs_drop_nlink(inode, gencount);
 	} else
 		error =3D NFS_PROTO(dir)->remove(dir, dentry);
 	if (error =3D=3D -ENOENT)
@@ -2709,6 +2714,7 @@ int nfs_rename(struct mnt_idmap *idmap, struct inode =
*old_dir,
 {
 	struct inode *old_inode =3D d_inode(old_dentry);
 	struct inode *new_inode =3D d_inode(new_dentry);
+	unsigned long new_gencount =3D 0;
 	struct dentry *dentry =3D NULL;
 	struct rpc_task *task;
 	bool must_unblock =3D false;
@@ -2761,6 +2767,7 @@ int nfs_rename(struct mnt_idmap *idmap, struct inode =
*old_dir,
 		} else {
 			block_revalidate(new_dentry);
 			must_unblock =3D true;
+			new_gencount =3D NFS_I(new_inode)->attr_gencount;
 			spin_unlock(&new_dentry->d_lock);
 		}
=20
@@ -2800,7 +2807,7 @@ int nfs_rename(struct mnt_idmap *idmap, struct inode =
*old_dir,
 			new_dir, new_dentry, error);
 	if (!error) {
 		if (new_inode !=3D NULL)
-			nfs_drop_nlink(new_inode);
+			nfs_drop_nlink(new_inode, new_gencount);
 		/*
 		 * The d_move() should be here instead of in an async RPC completion
 		 * handler because we need the proper locks to move the dentry.  If
--=20
2.51.1



--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

