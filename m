Return-Path: <linux-nfs+bounces-13786-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99986B2CD44
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Aug 2025 21:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 517D22A487D
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Aug 2025 19:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DB81F3BB5;
	Tue, 19 Aug 2025 19:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBxADoRx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516C121ADCB
	for <linux-nfs@vger.kernel.org>; Tue, 19 Aug 2025 19:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755632914; cv=none; b=Fq7Z9aLBljWsY9i4Lciy5J/Zj+mGLH8szETNh9Qj2DiFr7SDJQLdHq/XSl6pDVb13wR8cik+LQTp7frzL4N1tK6Ojw2NX4w9jg5/EUMSrq1C5vEdi/tbjWbuw2mfvHIxpG4HlCmpA7zFOuN30WNDsqH9DxrdBy/MqNhYnnczif4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755632914; c=relaxed/simple;
	bh=c4m5b5e7C2Z11vk+4PCFvRrpn1yijXXx88HKLzgrIy8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ewsNlJw2YgvGeka8AZcvaIuQBhQZybEQh4dAtfQtsOlvH+9GerZHHV2E3HtYFNlFlaOYOAfuNMhe5ETWkqL0oZNDO42im8IuZnD9xM4dHAsc2rhh9R4fRGSyd9+LTTddC/lw9BMRNYTpNtsYjDjB9brijKrOkmzENmFIrXYwbPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBxADoRx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F9AC113D0;
	Tue, 19 Aug 2025 19:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755632913;
	bh=c4m5b5e7C2Z11vk+4PCFvRrpn1yijXXx88HKLzgrIy8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=NBxADoRxIaRikour5dBzx/fvBxvGSqYd9DScBNfr5eWQue+XIMeBCXvpLXT+unxNc
	 93TGso9/yG+zq3adG+mefzIEAHEidZBPsES2z0j7KMWyT30vMGKhlj3KeAhds4usR+
	 e7KIKHg99frrckjnKSGcaOb0qBOh8vBRoHpQTXNFDRlfmYdA2DwrahMbUczz/5xXAR
	 S08zDt8Kb1yzx3s+QoJdh3C6k1hsuE4Rs05x58WDg3jDopc+u+LUdoRCmz8ClO7wx3
	 6STMobic0CT8AhDEIS9saO4OK9CYPgFRLyLDjubms/IkqbXiWFzp/M3/cB53lIHjg2
	 nnhpxwr32BAdA==
Message-ID: <b7ee5254a556321c55cff1fb4520f28f39125bb0.camel@kernel.org>
Subject: Re: parts of pages on NFS being replaced by swaths of NULs
From: Jeff Layton <jlayton@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, Joe
 Quanaim <jdq@meta.com>, Andrew Steffen <aksteffen@meta.com>
Date: Tue, 19 Aug 2025 15:48:32 -0400
In-Reply-To: <901355448adc0db38b1dd4a3bc9f99f15651fcad.camel@kernel.org>
References: <1c42a7fd9677ad1aa9a3a53eda738b3a6da3728e.camel@kernel.org>
							 <752db17aff35a92b79e4c7bd3003ed890fe91403.camel@kernel.org>
						 <be7114cedde5867041dda00562beebded4cdce9e.camel@kernel.org>
					 <e583450b5d0ccc5d82fc383f58fc4f02495f5c2c.camel@kernel.org>
				 <972c7790fa69cc64a591b71fcc7a40b2cd477beb.camel@kernel.org>
			 <ce7e7d92581a2d447f7c5e70b280431528d289aa.camel@kernel.org>
		 <91cdd62fb2c8c4e5632ae8d1f830451577d6c3f1.camel@kernel.org>
	 <901355448adc0db38b1dd4a3bc9f99f15651fcad.camel@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-08-19 at 11:28 -0700, Trond Myklebust wrote:
> On Tue, 2025-08-19 at 13:10 -0400, Jeff Layton wrote:
> > On Sat, 2025-08-16 at 07:51 -0700, Trond Myklebust wrote:
> > > On Sat, 2025-08-16 at 09:01 -0400, Jeff Layton wrote:
> > > >=20
> > > > I finally caught something concrete today. I had the attached
> > > > bpftrace
> > > > script running while running the reproducer on a dozen or so
> > > > machines,
> > > > and it detected a hole in some data being written:
> > > >=20
> > > > -------------8<---------------
> > > > Attached 2 probes
> > > > Missing nfs_page: ino=3D10122173116 idx=3D2 flags=3D0x15ffff0000000=
029
> > > > Hole: ino=3D10122173116 idx=3D3 off=3D10026 size=3D2262
> > > > Prev folio: idx=3D2 flags=3D0x15ffff0000000028 pgbase=3D0 bytes=3D4=
096
> > > > req=3D0
> > > > prevreq=3D0xffff8955b2f55980
> > > > -------------8<---------------
> > > >=20
> > > > What this tells us is that the page at idx=3D2 got submitted to
> > > > nfs_do_writepage() (so it was marked dirty in the pagecache), but
> > > > when
> > > > it got there, folio->private was NULL and it was ignored.
> > > >=20
> > > > The kernel in this case is based on v6.9, so it's (just) pre-
> > > > large-
> > > > folio support. It has a fair number of NFS patches, but not much
> > > > to
> > > > this portion of the code. Most of them are are containerization
> > > > fixes.
> > > >=20
> > > > I'm looking askance at nfs_inode_remove_request(). It does this:
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (nfs_page_group_sync_=
on_bit(req, PG_REMOVE)) {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 struct folio *folio =3D nfs_page_to_folio(req-
> > > > > wb_head);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 struct address_space *mapping =3D folio->mapping;
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock(&mapping->i_private_lock);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 if (likely(folio)) {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fo=
lio->private =3D NULL;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fo=
lio_clear_private(folio);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=
ear_bit(PG_MAPPED, &req->wb_head-
> > > > > wb_flags);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 spin_unlock(&mapping->i_private_lock);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > >=20
> > > > If nfs_page_group_sync_on_bit() returns true, then the nfs_page
> > > > gets
> > > > detached from the folio. Meanwhile, if a new write request comes
> > > > in
> > > > just after that, nfs_lock_and_join_requests() will call
> > > > nfs_cancel_remove_inode() to try to "cancel" PG_REMOVE:
> > > >=20
> > > > static int
> > > > nfs_cancel_remove_inode(struct nfs_page *req, struct inode
> > > > *inode)
> > > > {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!test_bit(PG_REMOVE,=
 &req->wb_flags))
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D nfs_page_group_l=
ock(req);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (test_and_clear_bit(P=
G_REMOVE, &req->wb_flags))
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 nfs_page_set_inode_ref(req, inode);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nfs_page_group_unlock(re=
q);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > }=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > >=20
> > > > ...but that does not reattach the nfs_page to the folio. Should
> > > > it?
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0
> > >=20
> > > That's not sufficient AFAICS. Does the following patch work?
> > >=20
> > > 8<------------------------------------------------------------
> > > From fc9690dda01f001c6cd11665701394da8ebba1ab Mon Sep 17 00:00:00
> > > 2001
> > > Message-ID:
> > > <fc9690dda01f001c6cd11665701394da8ebba1ab.1755355810.git.trond.mykl
> > > ebust@hammerspace.com>
> > > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > Date: Sat, 16 Aug 2025 07:25:20 -0700
> > > Subject: [PATCH] NFS: Fix a race when updating an existing write
> > >=20
> > > After nfs_lock_and_join_requests() tests for whether the request is
> > > still attached to the mapping, nothing prevents a call to
> > > nfs_inode_remove_request() from succeeding until we actually lock
> > > the
> > > page group.
> > > The reason is that whoever called nfs_inode_remove_request()
> > > doesn't
> > > necessarily have a lock on the page group head.
> > >=20
> > > So in order to avoid races, let's take the page group lock earlier
> > > in
> > > nfs_lock_and_join_requests(), and hold it across the removal of the
> > > request in nfs_inode_remove_request().
> > >=20
> > > Reported-by: Jeff Layton <jlayton@kernel.org>
> > > Fixes: c3f2235782c3 ("nfs: fold nfs_folio_find_and_lock_request
> > > into nfs_lock_and_join_requests")
> > > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > ---
> > > =C2=A0fs/nfs/pagelist.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 9 +++++----
> > > =C2=A0fs/nfs/write.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 29 ++++++++++-------------------
> > > =C2=A0include/linux/nfs_page.h |=C2=A0 1 +
> > > =C2=A03 files changed, 16 insertions(+), 23 deletions(-)
> > >=20
> > > diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
> > > index 11968dcb7243..6e69ce43a13f 100644
> > > --- a/fs/nfs/pagelist.c
> > > +++ b/fs/nfs/pagelist.c
> > > @@ -253,13 +253,14 @@ nfs_page_group_unlock(struct nfs_page *req)
> > > =C2=A0	nfs_page_clear_headlock(req);
> > > =C2=A0}
> > > =C2=A0
> > > -/*
> > > - * nfs_page_group_sync_on_bit_locked
> > > +/**
> > > + * nfs_page_group_sync_on_bit_locked - Test if all requests have
> > > @bit set
> > > + * @req: request in page group
> > > + * @bit: PG_* bit that is used to sync page group
> > > =C2=A0 *
> > > =C2=A0 * must be called with page group lock held
> > > =C2=A0 */
> > > -static bool
> > > -nfs_page_group_sync_on_bit_locked(struct nfs_page *req, unsigned
> > > int bit)
> > > +bool nfs_page_group_sync_on_bit_locked(struct nfs_page *req,
> > > unsigned int bit)
> > > =C2=A0{
> > > =C2=A0	struct nfs_page *head =3D req->wb_head;
> > > =C2=A0	struct nfs_page *tmp;
> > > diff --git a/fs/nfs/write.c b/fs/nfs/write.c
> > > index fa5c41d0989a..8b7c04737967 100644
> > > --- a/fs/nfs/write.c
> > > +++ b/fs/nfs/write.c
> > > @@ -153,20 +153,10 @@ nfs_page_set_inode_ref(struct nfs_page *req,
> > > struct inode *inode)
> > > =C2=A0	}
> > > =C2=A0}
> > > =C2=A0
> > > -static int
> > > -nfs_cancel_remove_inode(struct nfs_page *req, struct inode *inode)
> > > +static void nfs_cancel_remove_inode(struct nfs_page *req, struct
> > > inode *inode)
> > > =C2=A0{
> > > -	int ret;
> > > -
> > > -	if (!test_bit(PG_REMOVE, &req->wb_flags))
> > > -		return 0;
> > > -	ret =3D nfs_page_group_lock(req);
> > > -	if (ret)
> > > -		return ret;
> > > =C2=A0	if (test_and_clear_bit(PG_REMOVE, &req->wb_flags))
> > > =C2=A0		nfs_page_set_inode_ref(req, inode);
> > > -	nfs_page_group_unlock(req);
> > > -	return 0;
> > > =C2=A0}
> > > =C2=A0
> > > =C2=A0/**
> > > @@ -585,19 +575,18 @@ static struct nfs_page
> > > *nfs_lock_and_join_requests(struct folio *folio)
> > > =C2=A0		}
> > > =C2=A0	}
> > > =C2=A0
> > > +	ret =3D nfs_page_group_lock(head);
> > > +	if (ret < 0)
> > > +		goto out_unlock;
> > > +
> > > =C2=A0	/* Ensure that nobody removed the request before we locked
> > > it */
> > > =C2=A0	if (head !=3D folio->private) {
> > > +		nfs_page_group_unlock(head);
> > > =C2=A0		nfs_unlock_and_release_request(head);
> > > =C2=A0		goto retry;
> > > =C2=A0	}
> > > =C2=A0
> > > -	ret =3D nfs_cancel_remove_inode(head, inode);
> > > -	if (ret < 0)
> > > -		goto out_unlock;
> > > -
> > > -	ret =3D nfs_page_group_lock(head);
> > > -	if (ret < 0)
> > > -		goto out_unlock;
> > > +	nfs_cancel_remove_inode(head, inode);
> > > =C2=A0
> > > =C2=A0	/* lock each request in the page group */
> > > =C2=A0	for (subreq =3D head->wb_this_page;
> > > @@ -786,7 +775,8 @@ static void nfs_inode_remove_request(struct
> > > nfs_page *req)
> > > =C2=A0{
> > > =C2=A0	struct nfs_inode *nfsi =3D NFS_I(nfs_page_to_inode(req));
> > > =C2=A0
> > > -	if (nfs_page_group_sync_on_bit(req, PG_REMOVE)) {
> > > +	nfs_page_group_lock(req);
> > > +	if (nfs_page_group_sync_on_bit_locked(req, PG_REMOVE)) {
> > > =C2=A0		struct folio *folio =3D nfs_page_to_folio(req-
> > > > wb_head);
> > > =C2=A0		struct address_space *mapping =3D folio->mapping;
> > > =C2=A0
> > > @@ -798,6 +788,7 @@ static void nfs_inode_remove_request(struct
> > > nfs_page *req)
> > > =C2=A0		}
> > > =C2=A0		spin_unlock(&mapping->i_private_lock);
> > > =C2=A0	}
> > > +	nfs_page_group_unlock(req);
> > > =C2=A0
> > > =C2=A0	if (test_and_clear_bit(PG_INODE_REF, &req->wb_flags)) {
> > > =C2=A0		atomic_long_dec(&nfsi->nrequests);
> > > diff --git a/include/linux/nfs_page.h b/include/linux/nfs_page.h
> > > index 169b4ae30ff4..9aed39abc94b 100644
> > > --- a/include/linux/nfs_page.h
> > > +++ b/include/linux/nfs_page.h
> > > @@ -160,6 +160,7 @@ extern void nfs_join_page_group(struct nfs_page
> > > *head,
> > > =C2=A0extern int nfs_page_group_lock(struct nfs_page *);
> > > =C2=A0extern void nfs_page_group_unlock(struct nfs_page *);
> > > =C2=A0extern bool nfs_page_group_sync_on_bit(struct nfs_page *, unsig=
ned
> > > int);
> > > +extern bool nfs_page_group_sync_on_bit_locked(struct nfs_page *,
> > > unsigned int);
> > > =C2=A0extern	int nfs_page_set_headlock(struct nfs_page *req);
> > > =C2=A0extern void nfs_page_clear_headlock(struct nfs_page *req);
> > > =C2=A0extern bool nfs_async_iocounter_wait(struct rpc_task *, struct
> > > nfs_lock_context *);
> >=20
> > I backported this patch to the kernel we've been using to reproduce
> > this and have had the test running for almost 24 hours now. The
> > longest
> > it's taken to reproduce on this test rig is about 12 hours. So, the
> > initial signs are good.
> >=20
> > The patch also looks good to me. This one took a while to track down,
> > and I needed a lot of help to set up the test rig. Can you add these?
> >=20
> > Tested-by: Joe Quanaim <jdq@meta.com>
> > Tested-by: Andrew Steffen <aksteffen@meta.com>
> > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> >=20
> > Joe and Andrew spent a lot of time getting us a reproducer.
> >=20
> > I assume we also want to send this to stable? I'm pretty sure the
> > Fixes: tag is wrong. The kernel we were using didn't have that patch.
> > I
> > took a look at some earlier releases, and AFAICT, this bug has been
> > present for a long time -- at least since v6.0 and probably well
> > before.
> >=20
>=20
> I've set
> Fixes: bd37d6fce184 ("NFSv4: Convert nfs_lock_and_join_requests() to use =
nfs_page_find_head_request()")
>=20
> on the very latest commit tags. That's about as far back as I can trace
> it before going cross-eyed.

Thanks. Looks like that went into v4.14. That's probably far enough. :)
--=20
Jeff Layton <jlayton@kernel.org>

