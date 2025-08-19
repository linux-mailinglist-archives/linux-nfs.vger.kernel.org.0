Return-Path: <linux-nfs+bounces-13791-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CA0B2CEB4
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Aug 2025 23:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AE842A4C71
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Aug 2025 21:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32C325A2DA;
	Tue, 19 Aug 2025 21:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNSXIrhE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0C27FBAC
	for <linux-nfs@vger.kernel.org>; Tue, 19 Aug 2025 21:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755640203; cv=none; b=sdBwQAe8dTv+Z88ZaJ6hV0Lt9mwCE2repIwreA6lnfQRGLIT2FuQKChwGlzHvqjo0tS3ZloO0bZKwcjNWrYxiB4d5qv/jdlKIhspH/PrnKVrJaLVy05EQ5jVA51JBSXVlcTxBDEVmGcoAAkBq166++o0bZS58C/R9N7mPa+jUs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755640203; c=relaxed/simple;
	bh=Z+gi1PDqcCWlvfjh83bX8r8Qby5mcaZwFMZi5z75ac0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UOmpTEiD75lU51b0q6ICoJcJydTmahBzMU97lYGRt0jFLoRW4lnjEN54AP3DTswcTi3dK0RmwcaFN5uq7U/SIQ6Sh1TUsyCKtUoAU02cPheX29Zz2Q0fsGFd2CfQgNzSlBOkBll9rT/Qyu4+WNRqfVH5jdt4nv5ucpWLuZs6gNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNSXIrhE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BB6BC4CEF1;
	Tue, 19 Aug 2025 21:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755640202;
	bh=Z+gi1PDqcCWlvfjh83bX8r8Qby5mcaZwFMZi5z75ac0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=iNSXIrhEGq+efwnvJ8hZhRHtgmi6nL6B4VY55rIsmQSAZskKyl8Ib7H6Jq8ISsivb
	 EKhpeNU9MRR7hmh5uRptZJPaeDrrz4CB0MaiW7D1ayb/uOn9fwQKkYWUficas2UkZ2
	 k22JCxqdmMGHGSfUGRuBDcYQo+Z879Kfd7OrwbwBFB4hoGyrIEXruFkhg6TEhXhPjV
	 xfTQVYcFg4CeIIXIX6je547W/DmToICIdHWjHWmB9tuKhWYXyNGwvTfizAxUbVd6xl
	 gf8ns9MTIfoZEZCNAcaZ3gAIUXgNpsCX+RzgsGPfUg/lnJlj3CVqx9sFX52L6qa2Y8
	 ed0pDBkaFte5w==
Message-ID: <666a5c90fa13775a15e53c67bf38f0db60b8f6f9.camel@kernel.org>
Subject: Re: seeing CRC mismatch with NFS DIRECT WRITE when
 localio_O_DIRECT_align_misaligned_IO=Y
From: Jeff Layton <jlayton@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
 jonathan.flynn@hammerspace.com
Date: Tue, 19 Aug 2025 17:50:01 -0400
In-Reply-To: <aKTuvJiJdnchV38f@kernel.org>
References: <1c42a7fd9677ad1aa9a3a53eda738b3a6da3728e.camel@kernel.org>
	 <752db17aff35a92b79e4c7bd3003ed890fe91403.camel@kernel.org>
	 <be7114cedde5867041dda00562beebded4cdce9e.camel@kernel.org>
	 <e583450b5d0ccc5d82fc383f58fc4f02495f5c2c.camel@kernel.org>
	 <972c7790fa69cc64a591b71fcc7a40b2cd477beb.camel@kernel.org>
	 <ce7e7d92581a2d447f7c5e70b280431528d289aa.camel@kernel.org>
	 <aKD3SFcyCnb8snst@kernel.org> <aKTEsmOAXsHEGEEz@kernel.org>
	 <06e0e537326414677386eab40a27d5cf1b3ea3c1.camel@kernel.org>
	 <aKTuvJiJdnchV38f@kernel.org>
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

On Tue, 2025-08-19 at 17:38 -0400, Mike Snitzer wrote:
> On Tue, Aug 19, 2025 at 04:13:16PM -0400, Jeff Layton wrote:
> > On Tue, 2025-08-19 at 14:38 -0400, Mike Snitzer wrote:
> > > On Sat, Aug 16, 2025 at 05:25:28PM -0400, Mike Snitzer wrote:
> > > > On Sat, Aug 16, 2025 at 07:51:17AM -0700, Trond Myklebust wrote:
> > > > >=20
> > > > > That's not sufficient AFAICS. Does the following patch work?
> > > > >=20
> > > > > 8<------------------------------------------------------------
> > > > > From fc9690dda01f001c6cd11665701394da8ebba1ab Mon Sep 17 00:00:00=
 2001
> > > > > Message-ID: <fc9690dda01f001c6cd11665701394da8ebba1ab.1755355810.=
git.trond.myklebust@hammerspace.com>
> > > > > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > > > Date: Sat, 16 Aug 2025 07:25:20 -0700
> > > > > Subject: [PATCH] NFS: Fix a race when updating an existing write
> > > > >=20
> > > > > After nfs_lock_and_join_requests() tests for whether the request =
is
> > > > > still attached to the mapping, nothing prevents a call to
> > > > > nfs_inode_remove_request() from succeeding until we actually lock=
 the
> > > > > page group.
> > > > > The reason is that whoever called nfs_inode_remove_request() does=
n't
> > > > > necessarily have a lock on the page group head.
> > > > >=20
> > > > > So in order to avoid races, let's take the page group lock earlie=
r in
> > > > > nfs_lock_and_join_requests(), and hold it across the removal of t=
he
> > > > > request in nfs_inode_remove_request().
> > > > >=20
> > > > > Reported-by: Jeff Layton <jlayton@kernel.org>
> > > > > Fixes: c3f2235782c3 ("nfs: fold nfs_folio_find_and_lock_request i=
nto nfs_lock_and_join_requests")
> > > > > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > > > ---
> > > > >  fs/nfs/pagelist.c        |  9 +++++----
> > > > >  fs/nfs/write.c           | 29 ++++++++++-------------------
> > > > >  include/linux/nfs_page.h |  1 +
> > > > >  3 files changed, 16 insertions(+), 23 deletions(-)
> > > > >=20
> > > > > diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
> > > > > index 11968dcb7243..6e69ce43a13f 100644
> > > > > --- a/fs/nfs/pagelist.c
> > > > > +++ b/fs/nfs/pagelist.c
> > > > > @@ -253,13 +253,14 @@ nfs_page_group_unlock(struct nfs_page *req)
> > > > >  	nfs_page_clear_headlock(req);
> > > > >  }
> > > > > =20
> > > > > -/*
> > > > > - * nfs_page_group_sync_on_bit_locked
> > > > > +/**
> > > > > + * nfs_page_group_sync_on_bit_locked - Test if all requests have=
 @bit set
> > > > > + * @req: request in page group
> > > > > + * @bit: PG_* bit that is used to sync page group
> > > > >   *
> > > > >   * must be called with page group lock held
> > > > >   */
> > > > > -static bool
> > > > > -nfs_page_group_sync_on_bit_locked(struct nfs_page *req, unsigned=
 int bit)
> > > > > +bool nfs_page_group_sync_on_bit_locked(struct nfs_page *req, uns=
igned int bit)
> > > > >  {
> > > > >  	struct nfs_page *head =3D req->wb_head;
> > > > >  	struct nfs_page *tmp;
> > > > > diff --git a/fs/nfs/write.c b/fs/nfs/write.c
> > > > > index fa5c41d0989a..8b7c04737967 100644
> > > > > --- a/fs/nfs/write.c
> > > > > +++ b/fs/nfs/write.c
> > > > > @@ -153,20 +153,10 @@ nfs_page_set_inode_ref(struct nfs_page *req=
, struct inode *inode)
> > > > >  	}
> > > > >  }
> > > > > =20
> > > > > -static int
> > > > > -nfs_cancel_remove_inode(struct nfs_page *req, struct inode *inod=
e)
> > > > > +static void nfs_cancel_remove_inode(struct nfs_page *req, struct=
 inode *inode)
> > > > >  {
> > > > > -	int ret;
> > > > > -
> > > > > -	if (!test_bit(PG_REMOVE, &req->wb_flags))
> > > > > -		return 0;
> > > > > -	ret =3D nfs_page_group_lock(req);
> > > > > -	if (ret)
> > > > > -		return ret;
> > > > >  	if (test_and_clear_bit(PG_REMOVE, &req->wb_flags))
> > > > >  		nfs_page_set_inode_ref(req, inode);
> > > > > -	nfs_page_group_unlock(req);
> > > > > -	return 0;
> > > > >  }
> > > > > =20
> > > > >  /**
> > > > > @@ -585,19 +575,18 @@ static struct nfs_page *nfs_lock_and_join_r=
equests(struct folio *folio)
> > > > >  		}
> > > > >  	}
> > > > > =20
> > > > > +	ret =3D nfs_page_group_lock(head);
> > > > > +	if (ret < 0)
> > > > > +		goto out_unlock;
> > > > > +
> > > > >  	/* Ensure that nobody removed the request before we locked it *=
/
> > > > >  	if (head !=3D folio->private) {
> > > > > +		nfs_page_group_unlock(head);
> > > > >  		nfs_unlock_and_release_request(head);
> > > > >  		goto retry;
> > > > >  	}
> > > > > =20
> > > > > -	ret =3D nfs_cancel_remove_inode(head, inode);
> > > > > -	if (ret < 0)
> > > > > -		goto out_unlock;
> > > > > -
> > > > > -	ret =3D nfs_page_group_lock(head);
> > > > > -	if (ret < 0)
> > > > > -		goto out_unlock;
> > > > > +	nfs_cancel_remove_inode(head, inode);
> > > > > =20
> > > > >  	/* lock each request in the page group */
> > > > >  	for (subreq =3D head->wb_this_page;
> > > > > @@ -786,7 +775,8 @@ static void nfs_inode_remove_request(struct n=
fs_page *req)
> > > > >  {
> > > > >  	struct nfs_inode *nfsi =3D NFS_I(nfs_page_to_inode(req));
> > > > > =20
> > > > > -	if (nfs_page_group_sync_on_bit(req, PG_REMOVE)) {
> > > > > +	nfs_page_group_lock(req);
> > > > > +	if (nfs_page_group_sync_on_bit_locked(req, PG_REMOVE)) {
> > > > >  		struct folio *folio =3D nfs_page_to_folio(req->wb_head);
> > > > >  		struct address_space *mapping =3D folio->mapping;
> > > > > =20
> > > > > @@ -798,6 +788,7 @@ static void nfs_inode_remove_request(struct n=
fs_page *req)
> > > > >  		}
> > > > >  		spin_unlock(&mapping->i_private_lock);
> > > > >  	}
> > > > > +	nfs_page_group_unlock(req);
> > > > > =20
> > > > >  	if (test_and_clear_bit(PG_INODE_REF, &req->wb_flags)) {
> > > > >  		atomic_long_dec(&nfsi->nrequests);
> > > > > diff --git a/include/linux/nfs_page.h b/include/linux/nfs_page.h
> > > > > index 169b4ae30ff4..9aed39abc94b 100644
> > > > > --- a/include/linux/nfs_page.h
> > > > > +++ b/include/linux/nfs_page.h
> > > > > @@ -160,6 +160,7 @@ extern void nfs_join_page_group(struct nfs_pa=
ge *head,
> > > > >  extern int nfs_page_group_lock(struct nfs_page *);
> > > > >  extern void nfs_page_group_unlock(struct nfs_page *);
> > > > >  extern bool nfs_page_group_sync_on_bit(struct nfs_page *, unsign=
ed int);
> > > > > +extern bool nfs_page_group_sync_on_bit_locked(struct nfs_page *,=
 unsigned int);
> > > > >  extern	int nfs_page_set_headlock(struct nfs_page *req);
> > > > >  extern void nfs_page_clear_headlock(struct nfs_page *req);
> > > > >  extern bool nfs_async_iocounter_wait(struct rpc_task *, struct n=
fs_lock_context *);
> > > > > --=20
> > > > > 2.50.1
> > > > >=20
> > > > >=20
> > > >=20
> > > >=20
> > > > Trond,
> > > >=20
> > > > You're the best! ;)
> > > >=20
> > > > Your patch fixes corruption I've been chasing for the past week
> > > > relative to NFS DIRECT, specifically with:
> > > > echo Y > /sys/module/nfs/parameters/localio_O_DIRECT_align_misalign=
ed_IO
> > > >=20
> > > > So you need my latest NFS DIRECT patchset:
> > > > https://lore.kernel.org/linux-nfs/20250815233003.55071-1-snitzer@ke=
rnel.org/
> > > >=20
> > > > With it, writes would be corrupted when using the attached reproduc=
er
> > > > (from Jon Flynn, with the assistance of ChatGPT) that pulls out the
> > > > subset of MLperf unet3d test (when ran in buffered IO mode, so
> > > > entirely misaligned relative to DIO-alignment requirements) that we=
've
> > > > seen npz CRC compare failure with.
> > > >=20
> > > > I tested my patchset with your patch applied and it all "just works=
".
> > > >=20
> > > > Ship it all!
> > > >=20
> > > > Thanks,
> > > > Mike
> > > >=20
> > > > ps. running the attached reproducer is as simple as:
> > > > ./mlperf_npz_tool.py --npz-path /mnt/share1/sample_a.npz
> > >=20
> > > So even with this patch there is something still causing data
> > > corruption on much faster systems.  This mlperf_npz_tool.py reproduce=
r
> > > works fine on a slower VMware based testbed, but once I load the same
> > > kernel (with Trond's fix applied) on a very fast baremetal system I
> > > still see CRC mismatch due to write corruption if
> > > localio_O_DIRECT_align_misaligned_IO=3DY (from my NFS DIRECT patchset=
).
> > >=20
> > > Again, both of my latest NFSD DIRECT and NFS DIRECT patchsets are
> > > applied:
> > > https://lore.kernel.org/linux-nfs/20250815144607.50967-1-snitzer@kern=
el.org/
> > > https://lore.kernel.org/linux-nfs/20250815233003.55071-1-snitzer@kern=
el.org/
> > >=20
> > > And I'm hacking nfs4 to impose O_DIRECT on buffered IO (reproducer
> > > doesn't open its files with O_DIRECT but NFS client acts like it did)=
.
> > > I can dig out the patch to achieve that if others are interested.
> > >=20
> > > Mike
> >=20
> > Can you compare a corrupt file with the expected output? That might
> > give us a clue about the nature of this bug.
>=20
> While it _is_ interesting that "speed kills" my particular lithmus
> test: I've changed the $SUBJECT because this issue could easily be
> unique to my new NFS DIRECT code or the test itself.  So best to
> divorce my issue from the original issue you reported that was the
> catalyst for Trond's fix (that did seem to help my testcase).
>=20
> To be clear, this may well be some bug in the python application (that
> happens to be part of the MLperf "industry benchmark")...
>=20
> Using other tools to verify data integrity have all passed.  In
> particular, dt isn't able to see any issues (but dt is more of an open
> secret in the utility belt of companies like NetApp, Red Hat, now
> Hammerspace, etc): https://github.com/RobinTMiller/dt.git
> This patch header in the NFSD DIRECT series shows how dt proved very
> useful:
> https://lore.kernel.org/linux-nfs/20250815144607.50967-6-snitzer@kernel.o=
rg/
>=20
> But back to the mlperf_npz_tool.py, I can easily generate good vs bad
> files, any words of wisdom for useful tools to analyze the
> differences?  ChatGPT?  Other AIs?
>
> hexdump isn't showing useful or approachable differences, basically
> the entire good vs bad file is different:
>=20
> # hexdump /tmp/good.npz > /root/analyze_this/good.hd
> # hexdump /tmp/bad.npz > /root/analyze_this/bad.hd
> # diff -Naur /root/analyze_this/good.hd /root/analyze_this/bad.hd > hd.di=
ff
>=20
> # ls -alh
> total 1.7G
> drwxr-xr-x   2 root root   50 Aug 19 20:53 .
> dr-xr-x---. 25 root root 4.0K Aug 19 20:56 ..
> -rw-r--r--   1 root root 421M Aug 19 20:52 bad.hd
> -rw-r--r--   1 root root 421M Aug 19 20:51 good.hd
> -rw-r--r--   1 root root 803M Aug 19 20:54 hd.diff
>=20
> # less hd.diff
> --- /root/analyze_this/good.hd  2025-08-19 20:51:55.797022245 +0000
> +++ /root/analyze_this/bad.hd   2025-08-19 20:52:14.868669416 +0000
> @@ -254,983046 +254,983046 @@
>  0000fd0 a73d eae0 f2b0 df27 6098 16be b990 f5b0
>  0000fe0 e2d1 857f 1843 6b2f 079b f319 5386 b6f7
>  0000ff0 e5ac ec09 29cd 17e9 1341 8a18 e54b 5057
> -0001000 7711 ef46 982e fe27 a0b5 0d2f 0f05 0130
> -0001010 d6e2 4a4c 74be f4cc a1ed cd98 fe09 0ba0
> -0001020 65b5 05a1 426f 7658 c9d9 0381 8ed5 b4ad
> ...
> +0001000 2325 8099 b007 9fd9 8596 01fe ae93 d384
> +0001010 422e 7685 abab 0d9b 0a05 b4e9 b774 f619
> +0001020 10fc 37d0 9e72 795c 82cd c9c8 9cac 4665
> ...
>  8b01000 ce50 6a33 b82d f7ce 0699 5948 1a7e 4e33
>  8b01010 ed0c f087 853e 952b 77c4 6e51 2790 26af
>  8b01020 d588 4bc7 313e d729 c20f 4412 8844 8fa6
>=20

2 interesting things there:

1/ the corruption doesn't appear to be zeroes, so this is definitely a
different bug than the one we saw before.

2/ It looks like the corruption starts on a page boundary. How far does
it extend? If it's all page aligned, then that's probably an important
clue.

--=20
Jeff Layton <jlayton@kernel.org>

