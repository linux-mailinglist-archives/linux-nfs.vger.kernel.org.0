Return-Path: <linux-nfs+bounces-13014-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAA0B034D5
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 05:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A8A418903E3
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 03:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0EA1E3762;
	Mon, 14 Jul 2025 03:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="COZNBpEz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179952E3713
	for <linux-nfs@vger.kernel.org>; Mon, 14 Jul 2025 03:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752462845; cv=none; b=BfhPxWiFuuGgMmhVfjE4FnhBo6ejNBWwXyosD36eHmEarNdemEod7uqrBRw5YYVIqgsaSBh7otKVoeFR4m95ouDbEIuYu6Zs3IDkbJREO645sRBolfUKj45xT5LAnLjFrR0pWdK2gYdR8qhIeqXVhwjpYA1Zx6USGWWb42DkxqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752462845; c=relaxed/simple;
	bh=+sMMtt3wbmsN8hc5kYJjvC6uV5j+RcCiBptcedQa8c4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JOPRuozPpTgN1ARTM1YZJejpeQwmdbije6tYIVTdAZvwjJ7ukD1TJuo84oUMQM2EPNsmUnBFRueq6k5sfDjLfqOt2L98pxB7pZYqnWBIyGWSzePH8yaf3koqED23XpFU+RKCrBCQJH38LY4FLQlGwt6G/6X3eCdmJX60ZKM3V/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=COZNBpEz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B55DDC4CEE3;
	Mon, 14 Jul 2025 03:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752462845;
	bh=+sMMtt3wbmsN8hc5kYJjvC6uV5j+RcCiBptcedQa8c4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=COZNBpEzEd6kBshQaKBpr9wSlw21ezZkHtTPSgPP97k7TSkD/scI7JTyEcR2Xxrfw
	 MdwVvZEy9TCwvWLLevYSfa9pFQUu3KF/BchZJkDVD6QGCfxFrOuESyHL+JVXmo4/JV
	 lAWV0nlobh2aceUGTBPHFsuKScP5A5NCYEcnwPhK08PMcUR8ORuvyy+oQKzdOf0SEg
	 SH1eQ8Ru5NGZQWSuTXqlVc1epT+eZ1e8oqVnwQCAo0byQief15yUpuM5Bcp8XujvX8
	 MZ9bGsUDutsVBphyaGuL5iJWpu9B85YsWI8d6q9rMfESZPvZJO4h0JP0RDoWcgbiu9
	 P5gIPgkjgXzLQ==
From: Mike Snitzer <snitzer@kernel.org>
To: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>
Cc: linux-nfs@vger.kernel.org
Subject: [for-6.16-final PATCH 3/9] Revert "nfs_localio: protect race between nfs_uuid_put() and nfs_close_local_fh()"
Date: Sun, 13 Jul 2025 23:13:53 -0400
Message-ID: <20250714031359.10192-4-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250714031359.10192-1-snitzer@kernel.org>
References: <20250714031359.10192-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit c17f0e92b492d51a339442d5e5626a4c0a1dd060.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs_common/nfslocalio.c | 85 ++++++++++++--------------------------
 1 file changed, 27 insertions(+), 58 deletions(-)

diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
index 1dd5a8cca064..49c59f0c78c6 100644
--- a/fs/nfs_common/nfslocalio.c
+++ b/fs/nfs_common/nfslocalio.c
@@ -151,7 +151,8 @@ EXPORT_SYMBOL_GPL(nfs_localio_enable_client);
  */
 static bool nfs_uuid_put(nfs_uuid_t *nfs_uuid)
 {
-	struct nfs_file_localio *nfl;
+	LIST_HEAD(local_files);
+	struct nfs_file_localio *nfl, *tmp;
 
 	spin_lock(&nfs_uuid->lock);
 	if (unlikely(!rcu_access_pointer(nfs_uuid->net))) {
@@ -165,49 +166,37 @@ static bool nfs_uuid_put(nfs_uuid_t *nfs_uuid)
 		nfs_uuid->dom = NULL;
 	}
 
+	list_splice_init(&nfs_uuid->files, &local_files);
+	spin_unlock(&nfs_uuid->lock);
+
 	/* Walk list of files and ensure their last references dropped */
-
-	while ((nfl = list_first_entry_or_null(&nfs_uuid->files,
-					       struct nfs_file_localio,
-					       list)) != NULL) {
+	list_for_each_entry_safe(nfl, tmp, &local_files, list) {
 		struct nfsd_file *ro_nf;
 		struct nfsd_file *rw_nf;
 
-		/* If nfs_uuid is already NULL, nfs_close_local_fh is
-		 * closing and we must wait, else we unlink and close.
-		 */
-		if (rcu_access_pointer(nfl->nfs_uuid) == NULL) {
-			/* nfs_close_local_fh() is doing the
-			 * close and we must wait. until it unlinks
-			 */
-			wait_var_event_spinlock(nfl,
-						list_first_entry_or_null(
-							&nfs_uuid->files,
-							struct nfs_file_localio,
-							list) != nfl,
-						&nfs_uuid->lock);
-			continue;
-		}
-
 		ro_nf = unrcu_pointer(xchg(&nfl->ro_file, NULL));
 		rw_nf = unrcu_pointer(xchg(&nfl->rw_file, NULL));
 
+		spin_lock(&nfs_uuid->lock);
 		/* Remove nfl from nfs_uuid->files list */
 		list_del_init(&nfl->list);
 		spin_unlock(&nfs_uuid->lock);
+		/* Now we can allow racing nfs_close_local_fh() to
+		 * skip the locking.
+		 */
+		RCU_INIT_POINTER(nfl->nfs_uuid, NULL);
+
 		if (ro_nf)
 			nfs_to_nfsd_file_put_local(ro_nf);
 		if (rw_nf)
 			nfs_to_nfsd_file_put_local(rw_nf);
+
 		cond_resched();
-		spin_lock(&nfs_uuid->lock);
-		/* Now we can allow racing nfs_close_local_fh() to
-		 * skip the locking.
-		 */
-		RCU_INIT_POINTER(nfl->nfs_uuid, NULL);
-		wake_up_var_locked(&nfl->nfs_uuid, &nfs_uuid->lock);
 	}
 
+	spin_lock(&nfs_uuid->lock);
+	BUG_ON(!list_empty(&nfs_uuid->files));
+
 	/* Remove client from nn->local_clients */
 	if (nfs_uuid->list_lock) {
 		spin_lock(nfs_uuid->list_lock);
@@ -315,43 +304,23 @@ void nfs_close_local_fh(struct nfs_file_localio *nfl)
 		return;
 	}
 
-	spin_lock(&nfs_uuid->lock);
-	if (!rcu_access_pointer(nfl->nfs_uuid)) {
-		/* nfs_uuid_put has finished here */
-		spin_unlock(&nfs_uuid->lock);
-		rcu_read_unlock();
-		return;
-	}
-	if (list_empty(&nfs_uuid->files)) {
-		/* nfs_uuid_put() has started closing files, wait for it
-		 * to finished
-		 */
-		spin_unlock(&nfs_uuid->lock);
-		rcu_read_unlock();
-		wait_var_event(&nfl->nfs_uuid,
-			       rcu_access_pointer(nfl->nfs_uuid) == NULL);
-		return;
-	}
-	/* tell nfs_uuid_put() to wait for us */
-	RCU_INIT_POINTER(nfl->nfs_uuid, NULL);
-	spin_unlock(&nfs_uuid->lock);
-	rcu_read_unlock();
-
 	ro_nf = unrcu_pointer(xchg(&nfl->ro_file, NULL));
 	rw_nf = unrcu_pointer(xchg(&nfl->rw_file, NULL));
+
+	spin_lock(&nfs_uuid->lock);
+	/* Remove nfl from nfs_uuid->files list */
+	list_del_init(&nfl->list);
+	spin_unlock(&nfs_uuid->lock);
+	rcu_read_unlock();
+	/* Now we can allow racing nfs_close_local_fh() to
+	 * skip the locking.
+	 */
+	RCU_INIT_POINTER(nfl->nfs_uuid, NULL);
+
 	if (ro_nf)
 		nfs_to_nfsd_file_put_local(ro_nf);
 	if (rw_nf)
 		nfs_to_nfsd_file_put_local(rw_nf);
-
-	/* Remove nfl from nfs_uuid->files list and signal nfs_uuid_put()
-	 * that we are done.  The moment we drop the spinlock the
-	 * nfs_uuid could be freed.
-	 */
-	spin_lock(&nfs_uuid->lock);
-	list_del_init(&nfl->list);
-	wake_up_var_locked(&nfl->nfs_uuid, &nfs_uuid->lock);
-	spin_unlock(&nfs_uuid->lock);
 }
 EXPORT_SYMBOL_GPL(nfs_close_local_fh);
 
-- 
2.44.0


