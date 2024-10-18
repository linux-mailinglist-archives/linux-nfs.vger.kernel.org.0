Return-Path: <linux-nfs+bounces-7285-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 375879A443E
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Oct 2024 19:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCB30B2120B
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Oct 2024 17:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00614168488;
	Fri, 18 Oct 2024 17:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kIsqIuGp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7D820E312
	for <linux-nfs@vger.kernel.org>; Fri, 18 Oct 2024 17:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729271016; cv=none; b=a9/Vh1swnp/0wR8OsOqTjEakwTpMxEwrDtHn52+1qtPZlzOHJqf6w+IhGo3QG5BF2SZOe7JNKP/y8tD+xI/plWxIqVU0s7WB2buj0SohdfXpxchcc7FJvKAC4QfB1CUG+CKg6gcpbNOqEa+34QwTXgs0gmpAZ8D+IFYDcRWfa3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729271016; c=relaxed/simple;
	bh=ECH6MK9vEPwksqCRj4rZL2L4XFlriaEwZDKupY6j39s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jSQpEDIUm1GvrGS0F3cgEfKgXV8x0M4V2aHQAPeJdFskvUZU+wxH/2k4aKrsoXx+gbjT6kv9DwTNIpISHc/z+YfJdkHz1R74LyUZth86/B3KIZZg2c5y+jUPuzw6Uqbw7XEv60ImWzNkqRevyXqdU2Pvr0ZMOMi1KHO2o7Bt1/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kIsqIuGp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 356FCC4CEC3;
	Fri, 18 Oct 2024 17:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729271016;
	bh=ECH6MK9vEPwksqCRj4rZL2L4XFlriaEwZDKupY6j39s=;
	h=From:To:Cc:Subject:Date:From;
	b=kIsqIuGpo/b+GKnVws5jvtLZe7zPmRWFcEq5c913nIuYr41cNZJVGUg10KHZNfmmj
	 v0s0YuVrXlX4LonQIYL3MjnRaFLIkCwKvNhmYXgf0We9dAmysFMPgedV8Q6aZ3AG+P
	 Re2Do45qU3nt2c5o3jfujpOB84U+E32JcCSeNgoCd67dFgQFzMaiTKCJgj5F5Syc62
	 nfmlEyXJqoR+Vf23tKQMGi4bo/ucRNh5c2yXoGxJ8bMAGPpLZvAdvenl/r9VR4MFqe
	 MQNF8y3wzR27OxhXmBxL1sU6PBmFzkYzyBhU/kEqE4y6ebX2XE2iHQuFeRcNlF8aUx
	 ydoT/eMzY2UDw==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH] nfs: avoid i_lock contention in nfs_clear_invalid_mapping
Date: Fri, 18 Oct 2024 13:03:35 -0400
Message-ID: <20241018170335.41427-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Multi-threaded buffered reads to the same file exposed significant
inode spinlock contention in nfs_clear_invalid_mapping().

Eliminate this spinlock contention by checking flags without locking,
instead using smp_rmb and smp_load_acquire accordingly, but then take
spinlock and double-check these inode flags.

Also refactor nfs_set_cache_invalid() slightly to use
smp_store_release() to pair with nfs_clear_invalid_mapping()'s
smp_load_acquire().

While this fix is beneficial for all multi-threaded buffered reads
issued by an NFS client, this issue was identified in the context of
surprisingly low LOCALIO performance with 4K multi-threaded buffered
read IO.  This fix dramatically speeds up LOCALIO performance:

before: read: IOPS=1583k, BW=6182MiB/s (6482MB/s)(121GiB/20002msec)
after:  read: IOPS=3046k, BW=11.6GiB/s (12.5GB/s)(232GiB/20001msec)

Fixes: 17dfeb911339 ("NFS: Fix races in nfs_revalidate_mapping")
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/inode.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 542c7d97b235..130d7226b12a 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -205,12 +205,14 @@ void nfs_set_cache_invalid(struct inode *inode, unsigned long flags)
 		nfs_fscache_invalidate(inode, 0);
 	flags &= ~NFS_INO_REVAL_FORCED;
 
-	nfsi->cache_validity |= flags;
+	if (inode->i_mapping->nrpages == 0)
+		flags &= ~NFS_INO_INVALID_DATA;
 
-	if (inode->i_mapping->nrpages == 0) {
-		nfsi->cache_validity &= ~NFS_INO_INVALID_DATA;
-		nfs_ooo_clear(nfsi);
-	} else if (nfsi->cache_validity & NFS_INO_INVALID_DATA) {
+	/* pairs with nfs_clear_invalid_mapping()'s smp_load_acquire() */
+	smp_store_release(&nfsi->cache_validity, flags);
+
+	if (inode->i_mapping->nrpages == 0 ||
+	    nfsi->cache_validity & NFS_INO_INVALID_DATA) {
 		nfs_ooo_clear(nfsi);
 	}
 	trace_nfs_set_cache_invalid(inode, 0);
@@ -1408,6 +1410,13 @@ int nfs_clear_invalid_mapping(struct address_space *mapping)
 					 TASK_KILLABLE|TASK_FREEZABLE_UNSAFE);
 		if (ret)
 			goto out;
+		smp_rmb(); /* pairs with smp_wmb() below */
+		if (test_bit(NFS_INO_INVALIDATING, bitlock))
+			continue;
+		/* pairs with nfs_set_cache_invalid()'s smp_store_release() */
+		if (!(smp_load_acquire(&nfsi->cache_validity) & NFS_INO_INVALID_DATA))
+			goto out;
+		/* Slow-path that double-checks with spinlock held */
 		spin_lock(&inode->i_lock);
 		if (test_bit(NFS_INO_INVALIDATING, bitlock)) {
 			spin_unlock(&inode->i_lock);
-- 
2.44.0


