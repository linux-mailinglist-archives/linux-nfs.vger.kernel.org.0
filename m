Return-Path: <linux-nfs+bounces-7298-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C7C9A48CC
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Oct 2024 23:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A63CA283F80
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Oct 2024 21:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4118518DF7C;
	Fri, 18 Oct 2024 21:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSk9pXnI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A2118C93C
	for <linux-nfs@vger.kernel.org>; Fri, 18 Oct 2024 21:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729286143; cv=none; b=je6wdP85sDOAmftcm927nkhih7H187KPNFaiSJzGY6x5jGtkv8O71+6axd1uuaNMLAqXmqUjHQeVvQ6FmLX3+IwfkNJheccQBmEN0TKNaWm5oRwZpXtAzcddiPjPPuCKbmcjL2MzLrugASfQLR2rpC0h6PW05wijYvfRfB+nsRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729286143; c=relaxed/simple;
	bh=V2P6KZACM+Z173UP/iIvUsoi5pr6+5fBzwkMKECWDFo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bPLptD6W4S2iLYVT/pp1yf7+B2gHP5RbLTofcz8OdCRH8D5BRPKkEEpWytB+yIfyEo6kELMi8zUidm2u5/gn3gynyV5ecBF8Cx9yl0DXoBkkt3axRYIBpdkvWW0H53wVX/4QKwlA370dYKdhAFXOq3R73l/8HlQTkADPt7msnuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSk9pXnI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7372EC4CEC5;
	Fri, 18 Oct 2024 21:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729286142;
	bh=V2P6KZACM+Z173UP/iIvUsoi5pr6+5fBzwkMKECWDFo=;
	h=From:To:Cc:Subject:Date:From;
	b=OSk9pXnIM0PELYbGGFDeVydsd+/3V3rCD3IKmc7uijsM5E1aRVWs0gXaVqInuW3kF
	 bcuMKHbZr1A6xtyMxj57XXJumjODLhuzX7FzAmfzk+82oGf1abJCFZq0hWU6Q+hmRm
	 2/a0Tn5dLgGnwLqpOqgb++p+n0G6aynKrt8No/qonJBj2p4yEeEjPXzTNKv0cGblc7
	 XSSVl45MMaMyF/8JSw/R05gcBnUQQm7FKmw5Pwdr5Ciy8kCkxympBvTF7dI18vcqOH
	 dzw1HMIgdhE3pia+YaJeVbu6R8Z64g08B0IT+QhkYnvOepFkNn5BJZgLjAdWktOK9J
	 lAdF+U4x5W3pA==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v2] nfs: avoid i_lock contention in nfs_clear_invalid_mapping
Date: Fri, 18 Oct 2024 17:15:41 -0400
Message-ID: <20241018211541.42705-1-snitzer@kernel.org>
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
 fs/nfs/inode.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

v2: fix issue Jeff Layton raised, need: flags |= nfsi->cache_validity;

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 542c7d97b235..cc7a32b32676 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -205,12 +205,15 @@ void nfs_set_cache_invalid(struct inode *inode, unsigned long flags)
 		nfs_fscache_invalidate(inode, 0);
 	flags &= ~NFS_INO_REVAL_FORCED;
 
-	nfsi->cache_validity |= flags;
+	flags |= nfsi->cache_validity;
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
@@ -1408,6 +1411,13 @@ int nfs_clear_invalid_mapping(struct address_space *mapping)
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


