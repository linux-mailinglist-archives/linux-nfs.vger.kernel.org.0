Return-Path: <linux-nfs+bounces-13783-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DE3B2CBF9
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Aug 2025 20:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8231B522950
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Aug 2025 18:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D4B30F526;
	Tue, 19 Aug 2025 18:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKT7jJjn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559933043C7
	for <linux-nfs@vger.kernel.org>; Tue, 19 Aug 2025 18:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755628121; cv=none; b=hbWbksDRgOoKslivzpE6m2eymDa146ZBjm3+d+gagO8pvOyFZsqpC9yXuz8b41EPSiRB36sneStlnjaVJPLObaHSn+k0LaOQaH4kpcPH9sfshmPy1Xvd1JDnrTZu3fCbYuNmluBE/ZBaedn4PSzn89DjzZiRlgZtfXAoxRGOxj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755628121; c=relaxed/simple;
	bh=nhZgordabF6FNPyoqyMy+LZf7vOo8aBdj8y3H1E3WmM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mm/l5qR/7Fc9rdDUeyODOx575MGFkJ7yI8wpspfmvxta3qJGI8TUE+6z6p6uNnIuecaoF1DJiAHcQl3gRMqN91Lv1ZG975oxHZKEUn2DVDHSZvzNGxcLsFT/Db1RY+7YWlG8AC468d00pR7XWi5G+HK9rFNzrOtlceCXm1R0V78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKT7jJjn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55C5BC4CEF1;
	Tue, 19 Aug 2025 18:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755628120;
	bh=nhZgordabF6FNPyoqyMy+LZf7vOo8aBdj8y3H1E3WmM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=RKT7jJjnYQ6Ql5S+FTjHweIBJUXR61VGGEeyLt/ZNOqt5/PG+9JHIBOh1VK9DH7Bf
	 g6yCTOdhSRtNXjiHCiX+MIIxMELPnnxPXetjfOgLaY1mihByZ+bxBVF3rTmnZsY75v
	 B9XzEGGtPTH0TrZQDW7aTuxlkLaYDpaLVSk1GpTdQ5XDjEYnYNhOv6cXBFuWrGiKkw
	 KMp1jyxLMKO/5Lt9qmUjsLPyqfYu+WGStdqWrjpFxiKVseEa+bAWevZjmCJoPTD85R
	 7rZ3zyxdV4Ct5QJxiKuuAJdcg0qBIlSkJbuc6xkhBGSVLDL1XAgACWJrUZwLMY/JRm
	 K+g79LxeegHAA==
Message-ID: <901355448adc0db38b1dd4a3bc9f99f15651fcad.camel@kernel.org>
Subject: Re: parts of pages on NFS being replaced by swaths of NULs
From: Trond Myklebust <trondmy@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, Joe
 Quanaim <jdq@meta.com>, Andrew Steffen <aksteffen@meta.com>
Date: Tue, 19 Aug 2025 11:28:39 -0700
In-Reply-To: <91cdd62fb2c8c4e5632ae8d1f830451577d6c3f1.camel@kernel.org>
References: <1c42a7fd9677ad1aa9a3a53eda738b3a6da3728e.camel@kernel.org>
						 <752db17aff35a92b79e4c7bd3003ed890fe91403.camel@kernel.org>
					 <be7114cedde5867041dda00562beebded4cdce9e.camel@kernel.org>
				 <e583450b5d0ccc5d82fc383f58fc4f02495f5c2c.camel@kernel.org>
			 <972c7790fa69cc64a591b71fcc7a40b2cd477beb.camel@kernel.org>
		 <ce7e7d92581a2d447f7c5e70b280431528d289aa.camel@kernel.org>
	 <91cdd62fb2c8c4e5632ae8d1f830451577d6c3f1.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-08-19 at 13:10 -0400, Jeff Layton wrote:
> On Sat, 2025-08-16 at 07:51 -0700, Trond Myklebust wrote:
> > On Sat, 2025-08-16 at 09:01 -0400, Jeff Layton wrote:
> > >=20
> > > I finally caught something concrete today. I had the attached
> > > bpftrace
> > > script running while running the reproducer on a dozen or so
> > > machines,
> > > and it detected a hole in some data being written:
> > >=20
> > > -------------8<---------------
> > > Attached 2 probes
> > > Missing nfs_page: ino=3D10122173116 idx=3D2 flags=3D0x15ffff000000002=
9
> > > Hole: ino=3D10122173116 idx=3D3 off=3D10026 size=3D2262
> > > Prev folio: idx=3D2 flags=3D0x15ffff0000000028 pgbase=3D0 bytes=3D409=
6
> > > req=3D0
> > > prevreq=3D0xffff8955b2f55980
> > > -------------8<---------------
> > >=20
> > > What this tells us is that the page at idx=3D2 got submitted to
> > > nfs_do_writepage() (so it was marked dirty in the pagecache), but
> > > when
> > > it got there, folio->private was NULL and it was ignored.
> > >=20
> > > The kernel in this case is based on v6.9, so it's (just) pre-
> > > large-
> > > folio support. It has a fair number of NFS patches, but not much
> > > to
> > > this portion of the code. Most of them are are containerization
> > > fixes.
> > >=20
> > > I'm looking askance at nfs_inode_remove_request(). It does this:
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (nfs_page_group_sync_on=
_bit(req, PG_REMOVE)) {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 struct folio *folio =3D nfs_page_to_folio(req-
> > > > wb_head);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 struct address_space *mapping =3D folio->mapping;
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 spin_lock(&mapping->i_private_lock);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (likely(folio)) {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 folio=
->private =3D NULL;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 folio=
_clear_private(folio);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clear=
_bit(PG_MAPPED, &req->wb_head-
> > > > wb_flags);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 }
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 spin_unlock(&mapping->i_private_lock);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > >=20
> > > If nfs_page_group_sync_on_bit() returns true, then the nfs_page
> > > gets
> > > detached from the folio. Meanwhile, if a new write request comes
> > > in
> > > just after that, nfs_lock_and_join_requests() will call
> > > nfs_cancel_remove_inode() to try to "cancel" PG_REMOVE:
> > >=20
> > > static int
> > > nfs_cancel_remove_inode(struct nfs_page *req, struct inode
> > > *inode)
> > > {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!test_bit(PG_REMOVE, &=
req->wb_flags))
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return 0;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D nfs_page_group_loc=
k(req);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return ret;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (test_and_clear_bit(PG_=
REMOVE, &req->wb_flags))
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 nfs_page_set_inode_ref(req, inode);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nfs_page_group_unlock(req)=
;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > }=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > >=20
> > > ...but that does not reattach the nfs_page to the folio. Should
> > > it?
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> >=20
> > That's not sufficient AFAICS. Does the following patch work?
> >=20
> > 8<------------------------------------------------------------
> > From fc9690dda01f001c6cd11665701394da8ebba1ab Mon Sep 17 00:00:00
> > 2001
> > Message-ID:
> > <fc9690dda01f001c6cd11665701394da8ebba1ab.1755355810.git.trond.mykl
> > ebust@hammerspace.com>
> > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> > Date: Sat, 16 Aug 2025 07:25:20 -0700
> > Subject: [PATCH] NFS: Fix a race when updating an existing write
> >=20
> > After nfs_lock_and_join_requests() tests for whether the request is
> > still attached to the mapping, nothing prevents a call to
> > nfs_inode_remove_request() from succeeding until we actually lock
> > the
> > page group.
> > The reason is that whoever called nfs_inode_remove_request()
> > doesn't
> > necessarily have a lock on the page group head.
> >=20
> > So in order to avoid races, let's take the page group lock earlier
> > in
> > nfs_lock_and_join_requests(), and hold it across the removal of the
> > request in nfs_inode_remove_request().
> >=20
> > Reported-by: Jeff Layton <jlayton@kernel.org>
> > Fixes: c3f2235782c3 ("nfs: fold nfs_folio_find_and_lock_request
> > into nfs_lock_and_join_requests")
> > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > ---
> > =C2=A0fs/nfs/pagelist.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 9 +++++----
> > =C2=A0fs/nfs/write.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 29 ++++++++++-------------------
> > =C2=A0include/linux/nfs_page.h |=C2=A0 1 +
> > =C2=A03 files changed, 16 insertions(+), 23 deletions(-)
> >=20
> > diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
> > index 11968dcb7243..6e69ce43a13f 100644
> > --- a/fs/nfs/pagelist.c
> > +++ b/fs/nfs/pagelist.c
> > @@ -253,13 +253,14 @@ nfs_page_group_unlock(struct nfs_page *req)
> > =C2=A0	nfs_page_clear_headlock(req);
> > =C2=A0}
> > =C2=A0
> > -/*
> > - * nfs_page_group_sync_on_bit_locked
> > +/**
> > + * nfs_page_group_sync_on_bit_locked - Test if all requests have
> > @bit set
> > + * @req: request in page group
> > + * @bit: PG_* bit that is used to sync page group
> > =C2=A0 *
> > =C2=A0 * must be called with page group lock held
> > =C2=A0 */
> > -static bool
> > -nfs_page_group_sync_on_bit_locked(struct nfs_page *req, unsigned
> > int bit)
> > +bool nfs_page_group_sync_on_bit_locked(struct nfs_page *req,
> > unsigned int bit)
> > =C2=A0{
> > =C2=A0	struct nfs_page *head =3D req->wb_head;
> > =C2=A0	struct nfs_page *tmp;
> > diff --git a/fs/nfs/write.c b/fs/nfs/write.c
> > index fa5c41d0989a..8b7c04737967 100644
> > --- a/fs/nfs/write.c
> > +++ b/fs/nfs/write.c
> > @@ -153,20 +153,10 @@ nfs_page_set_inode_ref(struct nfs_page *req,
> > struct inode *inode)
> > =C2=A0	}
> > =C2=A0}
> > =C2=A0
> > -static int
> > -nfs_cancel_remove_inode(struct nfs_page *req, struct inode *inode)
> > +static void nfs_cancel_remove_inode(struct nfs_page *req, struct
> > inode *inode)
> > =C2=A0{
> > -	int ret;
> > -
> > -	if (!test_bit(PG_REMOVE, &req->wb_flags))
> > -		return 0;
> > -	ret =3D nfs_page_group_lock(req);
> > -	if (ret)
> > -		return ret;
> > =C2=A0	if (test_and_clear_bit(PG_REMOVE, &req->wb_flags))
> > =C2=A0		nfs_page_set_inode_ref(req, inode);
> > -	nfs_page_group_unlock(req);
> > -	return 0;
> > =C2=A0}
> > =C2=A0
> > =C2=A0/**
> > @@ -585,19 +575,18 @@ static struct nfs_page
> > *nfs_lock_and_join_requests(struct folio *folio)
> > =C2=A0		}
> > =C2=A0	}
> > =C2=A0
> > +	ret =3D nfs_page_group_lock(head);
> > +	if (ret < 0)
> > +		goto out_unlock;
> > +
> > =C2=A0	/* Ensure that nobody removed the request before we locked
> > it */
> > =C2=A0	if (head !=3D folio->private) {
> > +		nfs_page_group_unlock(head);
> > =C2=A0		nfs_unlock_and_release_request(head);
> > =C2=A0		goto retry;
> > =C2=A0	}
> > =C2=A0
> > -	ret =3D nfs_cancel_remove_inode(head, inode);
> > -	if (ret < 0)
> > -		goto out_unlock;
> > -
> > -	ret =3D nfs_page_group_lock(head);
> > -	if (ret < 0)
> > -		goto out_unlock;
> > +	nfs_cancel_remove_inode(head, inode);
> > =C2=A0
> > =C2=A0	/* lock each request in the page group */
> > =C2=A0	for (subreq =3D head->wb_this_page;
> > @@ -786,7 +775,8 @@ static void nfs_inode_remove_request(struct
> > nfs_page *req)
> > =C2=A0{
> > =C2=A0	struct nfs_inode *nfsi =3D NFS_I(nfs_page_to_inode(req));
> > =C2=A0
> > -	if (nfs_page_group_sync_on_bit(req, PG_REMOVE)) {
> > +	nfs_page_group_lock(req);
> > +	if (nfs_page_group_sync_on_bit_locked(req, PG_REMOVE)) {
> > =C2=A0		struct folio *folio =3D nfs_page_to_folio(req-
> > >wb_head);
> > =C2=A0		struct address_space *mapping =3D folio->mapping;
> > =C2=A0
> > @@ -798,6 +788,7 @@ static void nfs_inode_remove_request(struct
> > nfs_page *req)
> > =C2=A0		}
> > =C2=A0		spin_unlock(&mapping->i_private_lock);
> > =C2=A0	}
> > +	nfs_page_group_unlock(req);
> > =C2=A0
> > =C2=A0	if (test_and_clear_bit(PG_INODE_REF, &req->wb_flags)) {
> > =C2=A0		atomic_long_dec(&nfsi->nrequests);
> > diff --git a/include/linux/nfs_page.h b/include/linux/nfs_page.h
> > index 169b4ae30ff4..9aed39abc94b 100644
> > --- a/include/linux/nfs_page.h
> > +++ b/include/linux/nfs_page.h
> > @@ -160,6 +160,7 @@ extern void nfs_join_page_group(struct nfs_page
> > *head,
> > =C2=A0extern int nfs_page_group_lock(struct nfs_page *);
> > =C2=A0extern void nfs_page_group_unlock(struct nfs_page *);
> > =C2=A0extern bool nfs_page_group_sync_on_bit(struct nfs_page *, unsigne=
d
> > int);
> > +extern bool nfs_page_group_sync_on_bit_locked(struct nfs_page *,
> > unsigned int);
> > =C2=A0extern	int nfs_page_set_headlock(struct nfs_page *req);
> > =C2=A0extern void nfs_page_clear_headlock(struct nfs_page *req);
> > =C2=A0extern bool nfs_async_iocounter_wait(struct rpc_task *, struct
> > nfs_lock_context *);
>=20
> I backported this patch to the kernel we've been using to reproduce
> this and have had the test running for almost 24 hours now. The
> longest
> it's taken to reproduce on this test rig is about 12 hours. So, the
> initial signs are good.
>=20
> The patch also looks good to me. This one took a while to track down,
> and I needed a lot of help to set up the test rig. Can you add these?
>=20
> Tested-by: Joe Quanaim <jdq@meta.com>
> Tested-by: Andrew Steffen <aksteffen@meta.com>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>=20
> Joe and Andrew spent a lot of time getting us a reproducer.
>=20
> I assume we also want to send this to stable? I'm pretty sure the
> Fixes: tag is wrong. The kernel we were using didn't have that patch.
> I
> took a look at some earlier releases, and AFAICT, this bug has been
> present for a long time -- at least since v6.0 and probably well
> before.
>=20

I've set
Fixes: bd37d6fce184 ("NFSv4: Convert nfs_lock_and_join_requests() to use nf=
s_page_find_head_request()")

on the very latest commit tags. That's about as far back as I can trace
it before going cross-eyed.
--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

