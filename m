Return-Path: <linux-nfs+bounces-13701-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F52EB28E9D
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Aug 2025 16:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48224AA6277
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Aug 2025 14:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035AD2E9728;
	Sat, 16 Aug 2025 14:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPN4nk9d"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D389E2E4257
	for <linux-nfs@vger.kernel.org>; Sat, 16 Aug 2025 14:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755355879; cv=none; b=J9Iy6C5ts5SHwZx+vv/Z38UflUs6U5u4aLIWFpp7Z4bR4C8DjsnfXKHJpsOWmfvKQFYoFzAuWTa3+/vfEOHVOC0MVMxDghJ9GaEvetUgA0u//A5CT/r9WYKSLBy1zI5UkqDCCdnLY71IB9xPT9o/9zk0SnR7aIxm1ij7TXLDyN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755355879; c=relaxed/simple;
	bh=KQ3/f/c0i5A4I50KkI77PaYDLCjajkU+mTNCaTxSutI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vee7tHVbR4vQ1I3GUgglp3zZacU04dvWlLMOGIKHY2Luv4h6eeFKbUERpF1+qQnd8KBX8zierQ9W1CP9EK+ha2hSxNSHe8zhTse7B7tdNTyhLVs/ph3ozG5ZQQYgSxQD5fL57Q1OdzrPMVIFIgo8mUvyerFkG0f5uR9AuzRUXbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPN4nk9d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16DD1C4CEEF;
	Sat, 16 Aug 2025 14:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755355878;
	bh=KQ3/f/c0i5A4I50KkI77PaYDLCjajkU+mTNCaTxSutI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=VPN4nk9dmn16+Uamd/6NVzZ8QyD0fAExucvQ55LtYPkjq0ZmgkFhLqxvuu9M7dgIS
	 /F5HI7UpaR8Yu+srUODdYtgCZONYtxaMoGoC3gF0eBhRazkQrgTq+U01LiJAQ+YkUE
	 Ops1t+PlqGKUjmDS1rz8uMwrZmtW7A7Uqjh+ZKBjdzkGiApmUgcdt1/nWaz40mD/4i
	 VfKdqm/+G048axfsp2wAzfxFIG/BzHdZyOjSQ+of4FOqxjTQQ3iCor+CToU05w50UG
	 HfOUZgKIVP7LGuekYACNnz437rf2rYwGHksHVd8ZL3kKMneIB5o3hNw9akmNbG9Vao
	 N+j1j2ceTSKow==
Message-ID: <ce7e7d92581a2d447f7c5e70b280431528d289aa.camel@kernel.org>
Subject: Re: parts of pages on NFS being replaced by swaths of NULs
From: Trond Myklebust <trondmy@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Date: Sat, 16 Aug 2025 07:51:17 -0700
In-Reply-To: <972c7790fa69cc64a591b71fcc7a40b2cd477beb.camel@kernel.org>
References: <1c42a7fd9677ad1aa9a3a53eda738b3a6da3728e.camel@kernel.org>
				 <752db17aff35a92b79e4c7bd3003ed890fe91403.camel@kernel.org>
			 <be7114cedde5867041dda00562beebded4cdce9e.camel@kernel.org>
		 <e583450b5d0ccc5d82fc383f58fc4f02495f5c2c.camel@kernel.org>
	 <972c7790fa69cc64a591b71fcc7a40b2cd477beb.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-08-16 at 09:01 -0400, Jeff Layton wrote:
>=20
> I finally caught something concrete today. I had the attached
> bpftrace
> script running while running the reproducer on a dozen or so
> machines,
> and it detected a hole in some data being written:
>=20
> -------------8<---------------
> Attached 2 probes
> Missing nfs_page: ino=3D10122173116 idx=3D2 flags=3D0x15ffff0000000029
> Hole: ino=3D10122173116 idx=3D3 off=3D10026 size=3D2262
> Prev folio: idx=3D2 flags=3D0x15ffff0000000028 pgbase=3D0 bytes=3D4096 re=
q=3D0
> prevreq=3D0xffff8955b2f55980
> -------------8<---------------
>=20
> What this tells us is that the page at idx=3D2 got submitted to
> nfs_do_writepage() (so it was marked dirty in the pagecache), but
> when
> it got there, folio->private was NULL and it was ignored.
>=20
> The kernel in this case is based on v6.9, so it's (just) pre-large-
> folio support. It has a fair number of NFS patches, but not much to
> this portion of the code. Most of them are are containerization
> fixes.
>=20
> I'm looking askance at nfs_inode_remove_request(). It does this:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (nfs_page_group_sync_on_bit=
(req, PG_REMOVE)) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 struct folio *folio =3D nfs_page_to_folio(req-
> >wb_head);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 struct address_space *mapping =3D folio->mapping;
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 spin_lock(&mapping->i_private_lock);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (likely(folio)) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 folio->p=
rivate =3D NULL;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 folio_cl=
ear_private(folio);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clear_bi=
t(PG_MAPPED, &req->wb_head-
> >wb_flags);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 spin_unlock(&mapping->i_private_lock);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> If nfs_page_group_sync_on_bit() returns true, then the nfs_page gets
> detached from the folio. Meanwhile, if a new write request comes in
> just after that, nfs_lock_and_join_requests() will call
> nfs_cancel_remove_inode() to try to "cancel" PG_REMOVE:
>=20
> static int
> nfs_cancel_remove_inode(struct nfs_page *req, struct inode *inode)
> {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!test_bit(PG_REMOVE, &req-=
>wb_flags))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return 0;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D nfs_page_group_lock(re=
q);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return ret;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (test_and_clear_bit(PG_REMO=
VE, &req->wb_flags))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 nfs_page_set_inode_ref(req, inode);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nfs_page_group_unlock(req);=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> }=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
>=20
> ...but that does not reattach the nfs_page to the folio. Should it?
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0

That's not sufficient AFAICS. Does the following patch work?

8<------------------------------------------------------------
From fc9690dda01f001c6cd11665701394da8ebba1ab Mon Sep 17 00:00:00 2001
Message-ID: <fc9690dda01f001c6cd11665701394da8ebba1ab.1755355810.git.trond.=
myklebust@hammerspace.com>
From: Trond Myklebust <trond.myklebust@hammerspace.com>
Date: Sat, 16 Aug 2025 07:25:20 -0700
Subject: [PATCH] NFS: Fix a race when updating an existing write

After nfs_lock_and_join_requests() tests for whether the request is
still attached to the mapping, nothing prevents a call to
nfs_inode_remove_request() from succeeding until we actually lock the
page group.
The reason is that whoever called nfs_inode_remove_request() doesn't
necessarily have a lock on the page group head.

So in order to avoid races, let's take the page group lock earlier in
nfs_lock_and_join_requests(), and hold it across the removal of the
request in nfs_inode_remove_request().

Reported-by: Jeff Layton <jlayton@kernel.org>
Fixes: c3f2235782c3 ("nfs: fold nfs_folio_find_and_lock_request into nfs_lo=
ck_and_join_requests")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pagelist.c        |  9 +++++----
 fs/nfs/write.c           | 29 ++++++++++-------------------
 include/linux/nfs_page.h |  1 +
 3 files changed, 16 insertions(+), 23 deletions(-)

diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index 11968dcb7243..6e69ce43a13f 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -253,13 +253,14 @@ nfs_page_group_unlock(struct nfs_page *req)
 	nfs_page_clear_headlock(req);
 }
=20
-/*
- * nfs_page_group_sync_on_bit_locked
+/**
+ * nfs_page_group_sync_on_bit_locked - Test if all requests have @bit set
+ * @req: request in page group
+ * @bit: PG_* bit that is used to sync page group
  *
  * must be called with page group lock held
  */
-static bool
-nfs_page_group_sync_on_bit_locked(struct nfs_page *req, unsigned int bit)
+bool nfs_page_group_sync_on_bit_locked(struct nfs_page *req, unsigned int =
bit)
 {
 	struct nfs_page *head =3D req->wb_head;
 	struct nfs_page *tmp;
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index fa5c41d0989a..8b7c04737967 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -153,20 +153,10 @@ nfs_page_set_inode_ref(struct nfs_page *req, struct i=
node *inode)
 	}
 }
=20
-static int
-nfs_cancel_remove_inode(struct nfs_page *req, struct inode *inode)
+static void nfs_cancel_remove_inode(struct nfs_page *req, struct inode *in=
ode)
 {
-	int ret;
-
-	if (!test_bit(PG_REMOVE, &req->wb_flags))
-		return 0;
-	ret =3D nfs_page_group_lock(req);
-	if (ret)
-		return ret;
 	if (test_and_clear_bit(PG_REMOVE, &req->wb_flags))
 		nfs_page_set_inode_ref(req, inode);
-	nfs_page_group_unlock(req);
-	return 0;
 }
=20
 /**
@@ -585,19 +575,18 @@ static struct nfs_page *nfs_lock_and_join_requests(st=
ruct folio *folio)
 		}
 	}
=20
+	ret =3D nfs_page_group_lock(head);
+	if (ret < 0)
+		goto out_unlock;
+
 	/* Ensure that nobody removed the request before we locked it */
 	if (head !=3D folio->private) {
+		nfs_page_group_unlock(head);
 		nfs_unlock_and_release_request(head);
 		goto retry;
 	}
=20
-	ret =3D nfs_cancel_remove_inode(head, inode);
-	if (ret < 0)
-		goto out_unlock;
-
-	ret =3D nfs_page_group_lock(head);
-	if (ret < 0)
-		goto out_unlock;
+	nfs_cancel_remove_inode(head, inode);
=20
 	/* lock each request in the page group */
 	for (subreq =3D head->wb_this_page;
@@ -786,7 +775,8 @@ static void nfs_inode_remove_request(struct nfs_page *r=
eq)
 {
 	struct nfs_inode *nfsi =3D NFS_I(nfs_page_to_inode(req));
=20
-	if (nfs_page_group_sync_on_bit(req, PG_REMOVE)) {
+	nfs_page_group_lock(req);
+	if (nfs_page_group_sync_on_bit_locked(req, PG_REMOVE)) {
 		struct folio *folio =3D nfs_page_to_folio(req->wb_head);
 		struct address_space *mapping =3D folio->mapping;
=20
@@ -798,6 +788,7 @@ static void nfs_inode_remove_request(struct nfs_page *r=
eq)
 		}
 		spin_unlock(&mapping->i_private_lock);
 	}
+	nfs_page_group_unlock(req);
=20
 	if (test_and_clear_bit(PG_INODE_REF, &req->wb_flags)) {
 		atomic_long_dec(&nfsi->nrequests);
diff --git a/include/linux/nfs_page.h b/include/linux/nfs_page.h
index 169b4ae30ff4..9aed39abc94b 100644
--- a/include/linux/nfs_page.h
+++ b/include/linux/nfs_page.h
@@ -160,6 +160,7 @@ extern void nfs_join_page_group(struct nfs_page *head,
 extern int nfs_page_group_lock(struct nfs_page *);
 extern void nfs_page_group_unlock(struct nfs_page *);
 extern bool nfs_page_group_sync_on_bit(struct nfs_page *, unsigned int);
+extern bool nfs_page_group_sync_on_bit_locked(struct nfs_page *, unsigned =
int);
 extern	int nfs_page_set_headlock(struct nfs_page *req);
 extern void nfs_page_clear_headlock(struct nfs_page *req);
 extern bool nfs_async_iocounter_wait(struct rpc_task *, struct nfs_lock_co=
ntext *);
--=20
2.50.1


