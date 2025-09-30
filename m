Return-Path: <linux-nfs+bounces-14817-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A20BAE090
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Sep 2025 18:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22D78327235
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Sep 2025 16:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD43522A817;
	Tue, 30 Sep 2025 16:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7rtXK3S"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BBB1E868
	for <linux-nfs@vger.kernel.org>; Tue, 30 Sep 2025 16:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759249573; cv=none; b=qvVPolq7KGQ9wZTI/5cvwYW5T8fNvpM1VfB20s1n3kOJje+PLTrQA97Rar8azdlxpDrQzUm0xbvZw76GaJ6YYwtDcIRb1ATs7DajvDNNftwLyBO6x15DFuYd1QU4SUg60+le7/BN6XZKNb5zzOQGYmo1y+djXAvhRaZWHNdIbt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759249573; c=relaxed/simple;
	bh=Yb6yhlCEqSVKgN9GzHNYiyA+Vf6NqV6HVdMKKq1toBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CwMpvU2AfKzrDMxL+FmZXKesx9xEnEAMDbehU1ZypS2yddF9NdynD8JKcuyoXNtX+sRmWa2ZX7c3z4wB0QcifaeXcZLKSR1CeOns6OUVPMZEMuqiFckSyofKPodDTxaj00hbHs5xV4sxdqMfk1KbsFnLeAQQFWmEIpb83Hj4jnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c7rtXK3S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D89DAC113D0;
	Tue, 30 Sep 2025 16:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759249573;
	bh=Yb6yhlCEqSVKgN9GzHNYiyA+Vf6NqV6HVdMKKq1toBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c7rtXK3SVNGU+R2i9miu7IpypVYRHT2nx3Ex482BM2DqunN8lB2dn9GQQ/mSHXwNB
	 JDxOXE+5Uh3/oMbuICjEW5f8Xo18rYfVP0YSo6BXDNtvNGNwQbdLGaINTMfCT2lTAl
	 ltvvwAzWV/1TVLFGG6HHeRB0NbQ4Tr3zl4xb30DLCQlk1YGBPP7D+1iSofYJEtB8M7
	 nIxHKo3ECMkagnRXLAMea6drTFjLF3rUJJQMk9rcaLxJV/c8H8AqkucIbfEYMWXQuN
	 boglahzCrjvJ77eeZd/pXvX864TZ3upkOB1fin+gJSpiNif7yZYgcvUQ8+KnyRmuy/
	 fZwI1gE9P1Mfw==
Date: Tue, 30 Sep 2025 12:26:11 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Anna Schumaker <anna@kernel.org>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: [GIT PULL] NFS LOCALIO O_DIRECT changes for Linux 6.18
Message-ID: <aNwEo7wOMrwcmq9b@kernel.org>
References: <20250915154115.19579-1-snitzer@kernel.org>
 <aMiMpYAcHV8bYU4W@kernel.org>
 <aNLfroQ8Ti1Vh5wh@kernel.org>
 <aNQqUprZ3DuJhMe4@kernel.org>
 <aNgSOM9EzMS_Q6bR@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNgSOM9EzMS_Q6bR@kernel.org>

Hi Anna,

Given that my NFS LOCALIO O_DIRECT changes depend on NFSD changes
which will be included in the NFSD pull request for 6.18, I figured it
worth proposing a post-NFSD-merge pull request for your consideration
as the best way forward logistically (to ensure linux-next coverage,
you could pull this in _before_ Chuck sends his pull to Linus).

If you were to pull this into your NFS tree it'd bring with it Chuck's
nfsd-next (commit db155b7c7c85b5 as of now) followed by my dependant
NFS LOCALIO O_DIRECT changes.

You'll note that I folded 3 commits from Chuck's current nfsd-testing
branch into a single "NFSD: filecache: add STATX_DIOALIGN and
STATX_DIO_READ_ALIGN support", the commits from cel/nfsd-testing are:

 9cc8512712b11 NFSD: filecache: add STATX_DIOALIGN and STATX_DIO_READ_ALIGN support
 e5107ff95c56d NFSD: Prevent a NULL pointer dereference in fh_getattr()
 ed7edd1976c04 NFSD: Ignore vfs_getattr() failure in nfsd_file_get_dio_attrs()

The header for "NFSD: filecache: add STATX_DIOALIGN and
STATX_DIO_READ_ALIGN support" was updated to combine all headers. A
bit overkill but I opted for preserving full context on the evolution
of the code while folding Chuck's helpful fixes to my original commit.

The following changes since commit db155b7c7c85b5f14edec21e164001a168581ffb:

  NFSD: Disallow layoutget during grace period (2025-09-25 10:01:24 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git tags/for-6.18/NFS-LOCALIO-DIO-post-NFSD-merge

for you to fetch changes up to 40cdfedf0aabf3b96c4cb337fdd316b4a2332905:

  NFS: add basic STATX_DIOALIGN and STATX_DIO_READ_ALIGN support (2025-09-30 11:42:36 -0400)

Please pull if you agree this works best, thanks.
Mike

ps. I know you've been looking at all this, but it is late, 6.18 merge
window is open, etc.  Just being pragmatic by acknowledging the
awkward sequence needed to get these NFS LOCALIO changes to land. If
you'd like to skin the cat a different way, that's fine.

----------------------------------------------------------------
NFS LOCALIO O_DIRECT changes that depend on various 6.18 NFSD changes,
culminating with: "NFSD: filecache: add STATX_DIOALIGN and
STATX_DIO_READ_ALIGN support".

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEJfWUX4UqZ4x1O2wixSPxCi2dA1oFAmjb/FEACgkQxSPxCi2d
A1oYwwf9G+hp5c2KlxBMBei0z1RwxDg2sUMK1YjQrlQYhEW7cyWbImtZcyPSoK1u
vFUoqTGy6KsyzlRq//CFPVdg3g7zoAfXGk/58id30Vqn6FRUguLIWc/KjZSuJADw
JUfEPiVr6Ap+8DN8ny6ZVuP8GCT0N/zq3X8dV1KzUOUvDh0R87N415EddSNe6W97
Yo5ZTk4SGG+iRgf+e0m+rkTNmqe/VOzADFolTfV1Cs5l7h6k+bUNPxB8j0gqcZvZ
P7ojTHeUkmqFdmFbsKSG7QK/O/wYxAZezndFxONxqsvWQcKqFooj/AmqMUtsRBri
03OxDeHBj31iS+LG2ByIxnG/8yEmpQ==
=/qUg
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Mike Snitzer (8):
      NFSD: filecache: add STATX_DIOALIGN and STATX_DIO_READ_ALIGN support
      nfs/localio: make trace_nfs_local_open_fh more useful
      nfs/localio: avoid issuing misaligned IO using O_DIRECT
      nfs/localio: refactor iocb and iov_iter_bvec initialization
      nfs/localio: refactor iocb initialization
      nfs/localio: add proper O_DIRECT support for READ and WRITE
      nfs/localio: add tracepoints for misaligned DIO READ and WRITE support
      NFS: add basic STATX_DIOALIGN and STATX_DIO_READ_ALIGN support

 fs/nfs/inode.c             |  15 ++
 fs/nfs/internal.h          |  10 ++
 fs/nfs/localio.c           | 404 ++++++++++++++++++++++++++++++++++-----------
 fs/nfs/nfs2xdr.c           |   2 +-
 fs/nfs/nfs3xdr.c           |   2 +-
 fs/nfs/nfstrace.h          |  76 ++++++++-
 fs/nfsd/filecache.c        |  33 ++++
 fs/nfsd/filecache.h        |   4 +
 fs/nfsd/localio.c          |  11 ++
 fs/nfsd/nfsfh.c            |   3 +
 fs/nfsd/trace.h            |  27 +++
 include/linux/nfslocalio.h |   2 +
 include/trace/misc/fs.h    |  22 +++
 13 files changed, 512 insertions(+), 99 deletions(-)

