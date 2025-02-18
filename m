Return-Path: <linux-nfs+bounces-10174-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB565A3A18A
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Feb 2025 16:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6910C3AF340
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Feb 2025 15:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2A526B968;
	Tue, 18 Feb 2025 15:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uhxmGDTm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E9226E14C
	for <linux-nfs@vger.kernel.org>; Tue, 18 Feb 2025 15:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739893186; cv=none; b=N1A+SF6CyR/q8q8JMsxxOtwevuycML6orZWTbFipeLrK1ObYqz4pZKKzdzaPQjbIjCbwKFEwqFqDzpZqWzbjA60nVTdC4WntoJsqRayqG58RpAsNkJ8/BtrcSEaowijNg/iVnfDrNG542GybN43mpcJnMwWFL7gRWOJQO2APJVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739893186; c=relaxed/simple;
	bh=KgD8olzpy3uRadg0WZIMzpp3j/wHnbKkAWaFarN6yuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TbV7Bfw70Wpe2F3R6PwmIdDgGp1+R5SrrkDqSZFmasSwdx/RZKIprZauBYY462EVnl0ZtTljknXpb+XwQ7gg/xq1svzxO25EIf9K2n/f2Jb66wlUyKSTiCm1crTpgvgMQ8M8t38QEitRvbMKKVJoqqmjpVUath2ynJEHsr3b3cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uhxmGDTm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95AEBC4CEEA;
	Tue, 18 Feb 2025 15:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739893186;
	bh=KgD8olzpy3uRadg0WZIMzpp3j/wHnbKkAWaFarN6yuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uhxmGDTmLDuFfzfVx11C9f2dK4XLJyz7Aiapjg2wRium4DUz1IYRWoh/lD1Bd/V09
	 aAHIKzVgsVGvcWfJeASbB9aY75h5tHK2rHoSyrYQaeJu4y5kh6J8q2uON4b4sLoS4x
	 fwjdKc4d+Kd0XKSb9Ey8AJjMU24UYKkCfivOhzTHvix6FWlNvV/cU5jtXvY1NdUobF
	 p1wN4962ccpEv8b9MGC/H9i06CUWh4lo6nhOWiqMr0lTwyaSg/oNiJy/0drHeSmVfh
	 oYGvtEsetznByongR0aGndib95GruQQbk5pTZBmry8FJUK0wADSvKUicGtvsF7G/yE
	 E9mVkyX80Hfmw==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Dave Chinner <david@fromorbit.com>
Subject: [PATCH v2 6/7] nfsd: filecache: don't repeatedly add/remove files on the lru list
Date: Tue, 18 Feb 2025 10:39:36 -0500
Message-ID: <20250218153937.6125-7-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250218153937.6125-1-cel@kernel.org>
References: <20250218153937.6125-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neilb@suse.de>

There is no need to remove a file from the lru every time we access it,
and then add it back.  It is sufficient to set the REFERENCED flag every
time we put the file.  The order in the lru of REFERENCED files is
largely irrelevant as they will all be moved to the end.

With this patch, files are added only when they are allocated (if
want_gc) and they are removed only by the list_lru_(shrink_)walk
callback or when forcibly removing a file.

This should reduce contention on the list_lru spinlock(s) and reduce
memory traffic a little.

Signed-off-by: NeilBrown <neilb@suse.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/filecache.c | 47 ++++++++++++++++-----------------------------
 1 file changed, 17 insertions(+), 30 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 0d621833a9f2..56935349f0e4 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -319,15 +319,14 @@ nfsd_file_check_writeback(struct nfsd_file *nf)
 		mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK);
 }
 
-static bool nfsd_file_lru_add(struct nfsd_file *nf)
+static void nfsd_file_lru_add(struct nfsd_file *nf)
 {
-	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
-	set_bit(NFSD_FILE_RECENT, &nf->nf_flags);
-	if (list_lru_add_obj(&nfsd_file_lru, &nf->nf_lru)) {
+	refcount_inc(&nf->nf_ref);
+	if (list_lru_add_obj(&nfsd_file_lru, &nf->nf_lru))
 		trace_nfsd_file_lru_add(nf);
-		return true;
-	}
-	return false;
+	else
+		WARN_ON(1);
+	nfsd_file_schedule_laundrette();
 }
 
 static bool nfsd_file_lru_remove(struct nfsd_file *nf)
@@ -363,16 +362,10 @@ nfsd_file_put(struct nfsd_file *nf)
 
 	if (test_bit(NFSD_FILE_GC, &nf->nf_flags) &&
 	    test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
-		/*
-		 * If this is the last reference (nf_ref == 1), then try to
-		 * transfer it to the LRU.
-		 */
-		if (refcount_dec_not_one(&nf->nf_ref))
-			return;
-
-		if (nfsd_file_lru_add(nf))
-			return;
+		set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
+		set_bit(NFSD_FILE_RECENT, &nf->nf_flags);
 	}
+
 	if (refcount_dec_and_test(&nf->nf_ref))
 		nfsd_file_free(nf);
 }
@@ -516,13 +509,12 @@ nfsd_file_lru_cb(struct list_head *item, struct list_lru_one *lru,
 	}
 
 	/*
-	 * Put the reference held on behalf of the LRU. If it wasn't the last
-	 * one, then just remove it from the LRU and ignore it.
+	 * Put the reference held on behalf of the LRU if it is the last
+	 * reference, else rotate.
 	 */
-	if (!refcount_dec_and_test(&nf->nf_ref)) {
+	if (!refcount_dec_if_one(&nf->nf_ref)) {
 		trace_nfsd_file_gc_in_use(nf);
-		list_lru_isolate(lru, &nf->nf_lru);
-		return LRU_REMOVED;
+		return LRU_ROTATE;
 	}
 
 	/* Refcount went to zero. Unhash it and queue it to the dispose list */
@@ -1062,16 +1054,8 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct net *net,
 	nf = nfsd_file_lookup_locked(net, current_cred(), inode, need, want_gc);
 	rcu_read_unlock();
 
-	if (nf) {
-		/*
-		 * If the nf is on the LRU then it holds an extra reference
-		 * that must be put if it's removed. It had better not be
-		 * the last one however, since we should hold another.
-		 */
-		if (nfsd_file_lru_remove(nf))
-			refcount_dec(&nf->nf_ref);
+	if (nf)
 		goto wait_for_construction;
-	}
 
 	new = nfsd_file_alloc(net, inode, need, want_gc);
 	if (!new) {
@@ -1165,6 +1149,9 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct net *net,
 	 */
 	if (status != nfs_ok || inode->i_nlink == 0)
 		nfsd_file_unhash(nf);
+	else if (want_gc)
+		nfsd_file_lru_add(nf);
+
 	clear_and_wake_up_bit(NFSD_FILE_PENDING, &nf->nf_flags);
 	if (status == nfs_ok)
 		goto out;
-- 
2.47.0


