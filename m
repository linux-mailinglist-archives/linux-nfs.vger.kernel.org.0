Return-Path: <linux-nfs+bounces-14826-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B77DEBAE728
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Sep 2025 21:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77A6A4A1D92
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Sep 2025 19:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F8F19F40B;
	Tue, 30 Sep 2025 19:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HPDHpxa5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6AC1C862D
	for <linux-nfs@vger.kernel.org>; Tue, 30 Sep 2025 19:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759260732; cv=none; b=s1IL5Lb5iPMgSUgBLy2QVNMpbWaaOAaEt9OwdxBKYIX3LbC+TFpzmj78WpcHJouqCcK7qcN4RLCg9uk37QBVfbFqbZxnGpsbLC0W3k1j1tEobOTm06HZBwledcM7Xvbq9B4zgTRsyQMj8AnTP/TNnM+7EF5Rzp+DWC9O6YLHILw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759260732; c=relaxed/simple;
	bh=K+kBbMWpq3LbNmdjHSGVR/1f4ihwHikgcIzyRgG9/N0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qfzhgKHnDLdfq5yiV1LZe0BowJpyjyE2uQQZoQyAqytnlAeKR2cDXvoutEleoFkV5fmX0JwhhSBBNhKzXQsEVONA3wgFJYJRWdP0hYgz+5vA/ZohwrqG26+bLnulsF30CKe3skZ3vDywzoUxxk/tf7WN7Y9guqC3qpl/1bs3A5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HPDHpxa5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55110C4CEF0;
	Tue, 30 Sep 2025 19:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759260731;
	bh=K+kBbMWpq3LbNmdjHSGVR/1f4ihwHikgcIzyRgG9/N0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HPDHpxa5iHOcmVj75ezh1W1BVT/iNsLEWUz+rQUfe86Ogx404LObcgeaGImMFo/G0
	 Ji5g54D0DXIB9NO3fQgrsn9Jo5KMsS5mr6+qL+2dQAU522InJHpcWuxEcUG+LB3pbi
	 HBZQ7ytZYxADindNsryyiRwW+amqDUceCJD42STgX5iS59A3Cn4K/Akwsg7GaUdn6A
	 A9hjIKR+/XoZGEKzwysJAzk1azkl+MELSM4JOOlXal1IhHLLfXLz2mBqoHte1TA+pf
	 9z+5X2ZUWMODPu/BG017rBn+mWCIRReWQQr4kl+HhY/9m6hlg/9qn54g/GXY8xGu3s
	 9AM6LkD6s5crg==
Date: Tue, 30 Sep 2025 15:32:10 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Anna Schumaker <anna@kernel.org>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: [GIT PULL v2] NFS LOCALIO O_DIRECT changes for Linux 6.18
Message-ID: <aNwwOvAZh5VAliWW@kernel.org>
References: <20250915154115.19579-1-snitzer@kernel.org>
 <aMiMpYAcHV8bYU4W@kernel.org>
 <aNLfroQ8Ti1Vh5wh@kernel.org>
 <aNQqUprZ3DuJhMe4@kernel.org>
 <aNgSOM9EzMS_Q6bR@kernel.org>
 <aNwEo7wOMrwcmq9b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNwEo7wOMrwcmq9b@kernel.org>

Hi Anna,

Given that my NFS LOCALIO O_DIRECT changes depend on NFSD changes
which will be included in the NFSD pull request for 6.18, I figured it
worth proposing a post-NFSD-merge pull request for your consideration
as the best way forward logistically (to ensure linux-next coverage,
you could pull this in _before_ Chuck sends his pull to Linus).

If you were to pull this into your NFS tree it'd bring with it Chuck's
nfsd-next (commit db155b7c7c85b5 as of now) followed by my dependant
NFS LOCALIO O_DIRECT changes.

The following changes since commit db155b7c7c85b5f14edec21e164001a168581ffb:

  NFSD: Disallow layoutget during grace period (2025-09-25 10:01:24 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git tags/for-6.18/NFS-LOCALIO-DIO-post-NFSD-merge

for you to fetch changes up to cd784fe2704a1c90ef3a1a116aacdb08a9d594e3:

  NFS: add basic STATX_DIOALIGN and STATX_DIO_READ_ALIGN support (2025-09-30 15:23:35 -0400)

Please pull if you think this makes sense, thanks.
Mike

ps. I know you've been looking at all this, but it is late, 6.18 merge 
window is open, etc. Just being pragmatic by acknowledging the awkward
sequence needed to get these NFS LOCALIO changes to land. If you'd
like to skin the cat a different way, that's fine.

v2: dropped Chuck's 2 "Fixes" that I had folded into the NFSD patch

----------------------------------------------------------------
NFS LOCALIO O_DIRECT changes that depend on various 6.18 NFSD changes,
culminating with: "NFSD: filecache: add STATX_DIOALIGN and
STATX_DIO_READ_ALIGN support".

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEJfWUX4UqZ4x1O2wixSPxCi2dA1oFAmjcLkYACgkQxSPxCi2d
A1o0BwgAnOhyvsON+TFdIL8opb2IYIsFxKQ9pakKUm38NSMe4fm4DRl7V6+Co0AZ
kYWWSQEkq7CSLgJ99L8DDhcDo32L5AJyGpCp1zydhipGLu5lJ04ANfTsPOQjVYrQ
jA+a5mCaLxx3X2Je8LgVo3PelalmpsRsAwwOjAFg6wpay+VtiDYtR/jQqeT89l4K
euUC8aKSjM1XPIA84vjN0m+yrs6RTvzLFUS7dpE3JibL9L2eunS2m2d4wTlLky34
vxqRHwe3FaSqO1r/JdS6jMqTrlrPJsEgyri+DGBwPzeBH4Lu/lAp9NXp2LE57Eyr
tMOmTnmi4OMVlC6YAVwFq+RuiuSpOg==
=5fHh
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
 fs/nfsd/filecache.c        |  34 ++++
 fs/nfsd/filecache.h        |   4 +
 fs/nfsd/localio.c          |  11 ++
 fs/nfsd/nfsfh.c            |   4 +
 fs/nfsd/trace.h            |  27 +++
 include/linux/nfslocalio.h |   2 +
 include/trace/misc/fs.h    |  22 +++
 13 files changed, 514 insertions(+), 99 deletions(-)

