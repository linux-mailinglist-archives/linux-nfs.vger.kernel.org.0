Return-Path: <linux-nfs+bounces-15531-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 63227BFE02F
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 21:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4E7BA4E8703
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 19:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52762F3620;
	Wed, 22 Oct 2025 19:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MnD1csbJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8506A2D6E7A
	for <linux-nfs@vger.kernel.org>; Wed, 22 Oct 2025 19:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761160937; cv=none; b=jdmwyhwkOI7ZTetKz3S+r7Ni8tjmfTnua68Vla8tYYF2Kc4JxxxP4MgMfRWxBB5emv2lsW57z8kzaH2XQjHMUPtFBcmkZHwty1JE2ZUGRW+zU3TBKWSblFyedtht7Zg9A0EUJHNoKhDW1xIlgOmLFFy3jbbCDZiOL8Qkr176xrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761160937; c=relaxed/simple;
	bh=Y2I8h8FlzRE490DnW11fq7h4lmVfYSxxOeLwfP0nUtM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TmE5DdUUJ6w+fXoIzlr06XVmAejQ36RxFk2JjQtLVPvMgTFWtlLxOHkmud978oScfbzyYY6xYXMm34qsivdu6TpVFy3SotteRWGT6FifC3hi1WCUDGAqJTBCYjo/f3Wc/XtxQKgzUbrGcpKujC3N1lm1FovCRhiTpn8II/Q0vAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MnD1csbJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611FFC4CEE7;
	Wed, 22 Oct 2025 19:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761160936;
	bh=Y2I8h8FlzRE490DnW11fq7h4lmVfYSxxOeLwfP0nUtM=;
	h=From:To:Cc:Subject:Date:From;
	b=MnD1csbJoe6zuzH/GNFz7apZY2l6sR1T5oXzQSJ7CkU6wF27BHKaJMQJdTa40qNuP
	 BDNHvUHLqt9Zmdd3/wUJgFQ04VHm6xrn+M1tGLfFxJjTFxtI/l+kVquhxFY6gkKLmb
	 w3sa9xqM+yfRI1PjYOyiLtXvS8EMIvsAmY09DGc8M/ahBa7yUKZDcr9StTWwX7S0Ac
	 T4fdcfFYw1cbN3PJVkhnEaUJhg/UgdnVqlrPLhSq8Xf97S0tESdCNd/bJnzwkCHoWb
	 1ql9yFTAfxLs1lCe6sl4HzfwzhAQzyfXaA3aiKl+8N0I1+tNtM/vKRs6TweMMx1v8T
	 w0OYkiWGxfcnw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v6 0/5] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
Date: Wed, 22 Oct 2025 15:22:03 -0400
Message-ID: <20251022192208.1682-1-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Following on https://lore.kernel.org/linux-nfs/aPAci7O_XK1ljaum@kernel.org/
this series includes the patches needed to make NFSD Direct WRITE
work.

The "large" piece of work left to do:
> > > Wouldn't it make sense to track the alignment when building the bio_vec
> > > array instead of doing another walk here touching all cache lines?
> > 
> > Yes, that is the conventional wisdom that justified Keith removing
> > iov_iter_aligned.  But for NFSD's WRITE payload the bio_vec is built
> > outside of the fs/nfsd/vfs.c code.  Could be there is a natural way to
> > clean this up (to make the sunrpc layer to conditionally care about
> > alignment) but I didn't confront that yet.
> 
> Well, for the block code it's also build outside the layer consuming it.
> But Keith showed that you can easily communicate that information and
> avoid extra loops touching the cache lines.

Changes since v5:
* Add a patch to make FILE_SYNC WRITEs persist timestamps
* Address some of Christoph's review comments

Changes since v4:
* Split out refactoring nfsd_buffered_write() into a separate patch
* Expand patch description of 1/4
* Don't set IOCB_SYNC flag

Changes since v3:
* Address checkpatch.pl nits in 2/3
* Add an untested patch to mark ingress RDMA Read chunks

Chuck Lever (3):
  NFSD: Make FILE_SYNC WRITEs comply with spec
  NFSD: Enable return of an updated stable_how to NFS clients
  svcrdma: Mark Read chunks

Mike Snitzer (2):
  NFSD: Refactor nfsd_vfs_write()
  NFSD: Implement NFSD_IO_DIRECT for NFS WRITE

 fs/nfsd/debugfs.c                       |   1 +
 fs/nfsd/nfs3proc.c                      |   2 +-
 fs/nfsd/nfs4proc.c                      |   2 +-
 fs/nfsd/nfsproc.c                       |   3 +-
 fs/nfsd/trace.h                         |   1 +
 fs/nfsd/vfs.c                           | 219 ++++++++++++++++++++++--
 fs/nfsd/vfs.h                           |   6 +-
 fs/nfsd/xdr3.h                          |   2 +-
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |   5 +
 9 files changed, 224 insertions(+), 17 deletions(-)

-- 
2.51.0


