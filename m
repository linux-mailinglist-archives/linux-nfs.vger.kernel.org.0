Return-Path: <linux-nfs+bounces-16693-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C90C7E506
	for <lists+linux-nfs@lfdr.de>; Sun, 23 Nov 2025 18:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62D243A1A5E
	for <lists+linux-nfs@lfdr.de>; Sun, 23 Nov 2025 17:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F241B424F;
	Sun, 23 Nov 2025 17:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aEy9QmRT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6FA1D6BB;
	Sun, 23 Nov 2025 17:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763918146; cv=none; b=IRhEuYPLI52R3N6nzkfJbp/KA8DhAyuqxNlB455aFZlLjFhExPMoYPCzgznOa5O8FKs3XQl98pm7gkl0YdMgBgT9mK9d/gG8vPror8RZBSSB2VZhkiG80444bQeOHO1BJE09vR2xUmyCaa/Co9nTInsQ+Hmn7wQz7uyFd3e0/S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763918146; c=relaxed/simple;
	bh=en5XlPOt5Fn6JIpamDzZdtMKDSeJvHnddqMRDgzQBh0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tg0qy/7lsfztfwMfwsnFmiJfra3leodVL36lbx38GSPd168r1+mBeBoaRE9aLplf28GKdYhLZRBcFWTc9QMA0AoUo4ovTmSZjZ1tgBMGEb9pNmXGzO5BUrGk/hpORR7jFgQE/fk3OPkToV82hP3CVOic31bJgkyHmgtypAKEJqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aEy9QmRT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D933AC113D0;
	Sun, 23 Nov 2025 17:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763918145;
	bh=en5XlPOt5Fn6JIpamDzZdtMKDSeJvHnddqMRDgzQBh0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=aEy9QmRTqiJnR9heZiH/94ObXbky2oMmnzw6cae4durgJaBGBKq5FqhiTmRLNSh1U
	 7/zbVOfJOu8ozy+4gGboTIoWfxWOuwxZZV4e5aGW1wuJTrKD/nIeg4bYwl9klMaHna
	 vuHl7wy5CpBkmEbFnCz+D7uLXkmj2cOTGUMF0CGo4q6C+mLm8nXyaBd81X470RXEMe
	 KXIE3wbtVMIrQhvLUjYpfn+grqKaDrnAX53xuAT6AN2/rw4T9+C41GYdmdyVlWSUfI
	 MWlG/b5hupTnWTeczLUFYE+90yPo/m+afNKshjGrEB5BhExdhEwtDYrzxd9cw28kXi
	 pmfNysfu7OOTA==
Message-ID: <f0df03aecc33bb7541b251c6411b83e3148d3eb0.camel@kernel.org>
Subject: Re: [REGRESSION] nfs: Large amounts of GETATTR calls after file
 renaming on v5.10.241
From: Trond Myklebust <trondmy@kernel.org>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: "Ahmed, Aaron" <aarnahmd@amazon.com>, "stable@vger.kernel.org"
	 <stable@vger.kernel.org>, "regressions@lists.linux.dev"
	 <regressions@lists.linux.dev>, "linux-nfs@vger.kernel.org"
	 <linux-nfs@vger.kernel.org>, "sashal@kernel.org" <sashal@kernel.org>
Date: Sun, 23 Nov 2025 12:15:43 -0500
In-Reply-To: <2025112346-overbuilt-upscale-b43a@gregkh>
References: <F84F6626-B709-4083-9512-5F48FE370977@amazon.com>
	 <2025112203-paddle-unweave-c0a2@gregkh>
	 <8090316eab1a1b973ab81a8f3c088caa7052d89d.camel@kernel.org>
	 <2025112346-overbuilt-upscale-b43a@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-11-23 at 07:23 +0100, gregkh@linuxfoundation.org wrote:
> On Sat, Nov 22, 2025 at 10:43:29AM -0500, Trond Myklebust wrote:
> > On Sat, 2025-11-22 at 07:56 +0100,
> > gregkh@linuxfoundation.org=C2=A0wrote:
> > > On Fri, Nov 21, 2025 at 06:56:31PM +0000, Ahmed, Aaron wrote:
> > > > Hi,
> > > >=20
> > > > We have had customers report a regression on kernels versions
> > > > 5.10.241 and above in which file renaming causes large amounts
> > > > of
> > > > GETATTR calls to made due to inode revalidation. This
> > > > regression
> > > > was pinpointed via bisected to commit 7378c7adf31d ("NFS: Don't
> > > > set
> > > > NFS_INO_REVAL_PAGECACHE in the inode cache validity") which is
> > > > a
> > > > backport of 36a9346c2252 (=E2=80=9CNFS: Don't set
> > > > NFS_INO_REVAL_PAGECACHE
> > > > in the inode cache validity=E2=80=9D).=20
> > > >=20
> > > > We were able to reproduce It with this script:
> > > > REPRO_PATH=3D/mnt/efs/repro
> > > > do_read()
> > > > {
> > > > =C2=A0=C2=A0=C2=A0 for x in {1..50}
> > > > =C2=A0=C2=A0=C2=A0 do
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cat $1 > /dev/null
> > > > =C2=A0=C2=A0=C2=A0 done
> > > > =C2=A0=C2=A0=C2=A0 grep GETATTR /proc/self/mountstats
> > > > }
> > > >=20
> > > > echo foo > $REPRO_PATH/bar
> > > > echo "After create, before read:"
> > > > grep GETATTR /proc/self/mountstats
> > > >=20
> > > > echo "First read:"
> > > > do_read $REPRO_PATH/bar
> > > >=20
> > > > echo "Sleeping 5s, reading again (should look the same):"
> > > > sleep 5
> > > > do_read $REPRO_PATH/bar
> > > >=20
> > > > mv $REPRO_PATH/bar $REPRO_PATH/baz
> > > > echo "Moved file, reading again:"
> > > > do_read $REPRO_PATH/baz
> > > >=20
> > > > echo "Immediately performing another set of reads:"
> > > > do_read $REPRO_PATH/baz
> > > >=20
> > > > echo "Cleanup, removing test file"
> > > > rm $REPRO_PATH/baz
> > > > which performs a few read/writes. On kernels without the
> > > > regression
> > > > the number of GETATTR calls remains the same while on affected
> > > > kernels the amount increases after reading renamed file.=20
> > > >=20
> > > > This original commit comes from a series of patches providing
> > > > attribute revalidation updates [1]. =C2=A0However, many of these
> > > > patches
> > > > are missing in v.5.10.241+. Specifically, 13c0b082b6a9 (=E2=80=9CNF=
S:
> > > > Replace use of NFS_INO_REVAL_PAGECACHE when checking cache
> > > > validity=E2=80=9D) seems like a prerequisite patch and would help
> > > > remedy
> > > > the regression.
> > >=20
> > > Can you please send the needed backports to resolve this issue as
> > > you
> > > can test and verify that this resolves the problem?
> > >=20
> > > thanks,
> > >=20
> > > greg k-h
> >=20
> > Ah... If I'm correctly reading the changelog
> > in=C2=A0
> > https://nam10.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fc
> > dn.kernel.org%2Fpub%2Flinux%2Fkernel%2Fv5.x%2FChangeLog-
> > 5.10.241&data=3D05%7C02%7Ctrondmy%40hammerspace.com%7Cd99de46ea1054d1
> > a48c408de2a58f676%7C0d4fed5c3a7046fe9430ece41741f59e%7C0%7C0%7C6389
> > 94758780825772%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYi
> > OiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C
> > 0%7C%7C%7C&sdata=3DEbT6VZycJOQ7ktWkCq5jDYG9NdhP7vlkiK%2FuK9nIp9k%3D&r
> > eserved=3D0, it
> > looks as if commit 36a9346c2252 got pulled in by the stable patch
> > automation as a dependency for commit b01f21cacde9 ("NFS: Fix the
> > setting of capabilities when automounting a new filesystem").
> >=20
> > I do agree with Aaron's assessment that patch does depend on the
> > rest
> > of the series that was merged into Linux 5.13. It cannot be cherry-
> > picked on its own.
> >=20
> > However what exactly was the dependency that caused it to be pulled
> > into 5.10.241 in the first place? Was that logged anywhere?
> > I just checked out v5.10.241 and applied "git revert --signoff
> > 36a9346c2252", and that appears to work just fine, and I don't see
> > any
> > other obvious code dependency there, so I'm curious about what
> > happened.
>=20
> As the commit says:
> 	Stable-dep-of: b01f21cacde9 ("NFS: Fix the setting of
> capabilities when automounting a new filesystem")
>=20
>=20
If that's all we have, then I suggest just applying the following
revert.

8<------------------------------------------------------------------
From 3ae48f4eccfe9dcfeb9b3ff3670cadaed7b35c9e Mon Sep 17 00:00:00 2001
Message-ID: <3ae48f4eccfe9dcfeb9b3ff3670cadaed7b35c9e.1763918082.git.trond.=
myklebust@hammerspace.com>
From: Trond Myklebust <trond.myklebust@hammerspace.com>
Date: Sat, 22 Nov 2025 10:28:09 -0500
Subject: [PATCH] Revert "NFS: Don't set NFS_INO_REVAL_PAGECACHE in the inod=
e
 cache validity"

This reverts commit 36a9346c225270262d9f34e66c91aa1723fa903f.

The above commit was incorrectly labelled as a dependency for commit
b01f21cacde9 ("NFS: Fix the setting of capabilities when automounting a
new filesystem")
A revert is needed, since the incorrectly applied commit depends upon a
series of other patches that were merged into Linux 5.13, but have not
been applied to the 5.10 stable series.

Reported-by: "Ahmed, Aaron" <aarnahmd@amazon.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/inode.c    | 6 ++++--
 fs/nfs/nfs4proc.c | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index da8d727eb09d..3e3114a9d193 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -217,12 +217,11 @@ static void nfs_set_cache_invalid(struct inode *inode=
, unsigned long flags)
 			flags &=3D ~NFS_INO_INVALID_OTHER;
 		flags &=3D ~(NFS_INO_INVALID_CHANGE
 				| NFS_INO_INVALID_SIZE
+				| NFS_INO_REVAL_PAGECACHE
 				| NFS_INO_INVALID_XATTR);
 	} else if (flags & NFS_INO_REVAL_PAGECACHE)
 		flags |=3D NFS_INO_INVALID_CHANGE | NFS_INO_INVALID_SIZE;
=20
-	flags &=3D ~NFS_INO_REVAL_PAGECACHE;
-
 	if (!nfs_has_xattr_cache(nfsi))
 		flags &=3D ~NFS_INO_INVALID_XATTR;
 	if (inode->i_mapping->nrpages =3D=3D 0)
@@ -1901,6 +1900,7 @@ static int nfs_update_inode(struct inode *inode, stru=
ct nfs_fattr *fattr)
 	nfsi->cache_validity &=3D ~(NFS_INO_INVALID_ATTR
 			| NFS_INO_INVALID_ATIME
 			| NFS_INO_REVAL_FORCED
+			| NFS_INO_REVAL_PAGECACHE
 			| NFS_INO_INVALID_BLOCKS);
=20
 	/* Do atomic weak cache consistency updates */
@@ -1942,6 +1942,7 @@ static int nfs_update_inode(struct inode *inode, stru=
ct nfs_fattr *fattr)
 	} else {
 		nfsi->cache_validity |=3D save_cache_validity &
 				(NFS_INO_INVALID_CHANGE
+				| NFS_INO_REVAL_PAGECACHE
 				| NFS_INO_REVAL_FORCED);
 		cache_revalidated =3D false;
 	}
@@ -1987,6 +1988,7 @@ static int nfs_update_inode(struct inode *inode, stru=
ct nfs_fattr *fattr)
 	} else {
 		nfsi->cache_validity |=3D save_cache_validity &
 				(NFS_INO_INVALID_SIZE
+				| NFS_INO_REVAL_PAGECACHE
 				| NFS_INO_REVAL_FORCED);
 		cache_revalidated =3D false;
 	}
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 973b708ff332..2c33436bb27e 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1210,6 +1210,7 @@ nfs4_update_changeattr_locked(struct inode *inode,
 		| cache_validity;
=20
 	if (cinfo->atomic && cinfo->before =3D=3D inode_peek_iversion_raw(inode))=
 {
+		nfsi->cache_validity &=3D ~NFS_INO_REVAL_PAGECACHE;
 		nfsi->attrtimeo_timestamp =3D jiffies;
 	} else {
 		if (S_ISDIR(inode->i_mode)) {
--=20
2.51.1


