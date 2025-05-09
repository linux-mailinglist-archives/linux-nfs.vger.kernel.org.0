Return-Path: <linux-nfs+bounces-11616-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF1BAB074D
	for <lists+linux-nfs@lfdr.de>; Fri,  9 May 2025 02:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C2B53B1239
	for <lists+linux-nfs@lfdr.de>; Fri,  9 May 2025 00:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990AC1DFFC;
	Fri,  9 May 2025 00:49:18 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC970208AD
	for <linux-nfs@vger.kernel.org>; Fri,  9 May 2025 00:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746751758; cv=none; b=kLKbe+v/tq2zxeRDoWha6UNfyL3yrnbQPk84t3XAEUifGoKXMIZhjG6DChv652gSNOLWFAs7TM2eFYuMa9As8ZyopVLOudPYYX1d1vcaDtLGhGcbTDL1Ncz0/5wxMeXm3axEono3YJacLY+jnKg2mNM9UrPYvtczNDLotOIRffE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746751758; c=relaxed/simple;
	bh=CZFQP5HqirWpDNUi3Gsv2SAxiA+OTkQ4ZGJ6ldUWzPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DMTrd1cpRPxSel9tLEqYJBzuiLAVuo6syB4/mpAk4lc/SydiMJQkfZlPIpXnVdVOuZ2QSdakvYlyKcFcYEVG7/dVgDMValxctyuswwCSt/o68HZrZ5D41x/9J7IxZYWcYT+pilGJuTw5NBJFHyyeZWhIM2bJ7JD0DyWVzjiITuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uDBvI-00HQUu-SM;
	Fri, 09 May 2025 00:49:08 +0000
From: NeilBrown <neil@brown.name>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Mike Snitzer <snitzer@kernel.org>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 5/6] nfs_localio: protect race between nfs_uuid_put() and nfs_close_local_fh()
Date: Fri,  9 May 2025 10:46:42 +1000
Message-ID: <20250509004852.3272120-6-neil@brown.name>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250509004852.3272120-1-neil@brown.name>
References: <20250509004852.3272120-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nfs_uuid_put() and nfs_close_local_fh() can race if a "struct
nfs_file_localio" is released at the same time that nfsd calls
nfs_localio_invalidate_clients().

It is important that neither of these functions completes after the
other has started looking at a given nfs_file_localio and before it
finishes.

If nfs_uuid_put() exits while nfs_close_local_fh() is closing ro_file
and rw_file it could return to __nfd_file_cache_purge() while some files
are still referenced so the purge may not succeed.

If nfs_close_local_fh() exits while nfsd_uuid_put() is still closing the
files then the "struct nfs_file_localio" could be freed while
nfsd_uuid_put() is still looking at it.  This side is currently handled
by copying the pointers out of ro_file and rw_file before deleting from
the list in nfsd_uuid.  We need to preserve this while ensuring that
nfsd_uuid_put() does wait for nfs_close_local_fh().

This patch use nfl->uuid and nfl->list to provide the required
interlock.

nfs_uuid_put() removes the nfs_file_localio from the list, then drops
locks and puts the two files, then reclaims the spinlock and sets
->nfs_uuid to NULL.

nfs_close_local_fh() operates in the reverse order, setting ->nfs_uuid
to NULL, then closing the files, then unlinking from the list.

If nfs_uuid_put() finds that ->nfs_uuid is already NULL, it waits for
the nfs_file_localio to be removed from the list.  If
nfs_close_local_fh() find that it has already been unlinked it waits for
->nfs_uuid to become NULL.  This ensure that one of the two tries to
close the files, but they each waits for the other.

As nfs_uuid_put() is making the list empty, change from a
list_for_each_safe loop to a while that always takes the first entry.
This makes the intent more clear.
Also don't move the list to a temporary local list as this would defeat
the guarantees required for the interlock.

Fixes: 86e00412254a ("nfs: cache all open LOCALIO nfsd_file(s) in client")
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfs_common/nfslocalio.c | 81 ++++++++++++++++++++++++++------------
 1 file changed, 56 insertions(+), 25 deletions(-)

diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
index 49c59f0c78c6..1dd5a8cca064 100644
--- a/fs/nfs_common/nfslocalio.c
+++ b/fs/nfs_common/nfslocalio.c
@@ -151,8 +151,7 @@ EXPORT_SYMBOL_GPL(nfs_localio_enable_client);
  */
 static bool nfs_uuid_put(nfs_uuid_t *nfs_uuid)
 {
-	LIST_HEAD(local_files);
-	struct nfs_file_localio *nfl, *tmp;
+	struct nfs_file_localio *nfl;
 
 	spin_lock(&nfs_uuid->lock);
 	if (unlikely(!rcu_access_pointer(nfs_uuid->net))) {
@@ -166,37 +165,49 @@ static bool nfs_uuid_put(nfs_uuid_t *nfs_uuid)
 		nfs_uuid->dom = NULL;
 	}
 
-	list_splice_init(&nfs_uuid->files, &local_files);
-	spin_unlock(&nfs_uuid->lock);
-
 	/* Walk list of files and ensure their last references dropped */
-	list_for_each_entry_safe(nfl, tmp, &local_files, list) {
+
+	while ((nfl = list_first_entry_or_null(&nfs_uuid->files,
+					       struct nfs_file_localio,
+					       list)) != NULL) {
 		struct nfsd_file *ro_nf;
 		struct nfsd_file *rw_nf;
 
+		/* If nfs_uuid is already NULL, nfs_close_local_fh is
+		 * closing and we must wait, else we unlink and close.
+		 */
+		if (rcu_access_pointer(nfl->nfs_uuid) == NULL) {
+			/* nfs_close_local_fh() is doing the
+			 * close and we must wait. until it unlinks
+			 */
+			wait_var_event_spinlock(nfl,
+						list_first_entry_or_null(
+							&nfs_uuid->files,
+							struct nfs_file_localio,
+							list) != nfl,
+						&nfs_uuid->lock);
+			continue;
+		}
+
 		ro_nf = unrcu_pointer(xchg(&nfl->ro_file, NULL));
 		rw_nf = unrcu_pointer(xchg(&nfl->rw_file, NULL));
 
-		spin_lock(&nfs_uuid->lock);
 		/* Remove nfl from nfs_uuid->files list */
 		list_del_init(&nfl->list);
 		spin_unlock(&nfs_uuid->lock);
-		/* Now we can allow racing nfs_close_local_fh() to
-		 * skip the locking.
-		 */
-		RCU_INIT_POINTER(nfl->nfs_uuid, NULL);
-
 		if (ro_nf)
 			nfs_to_nfsd_file_put_local(ro_nf);
 		if (rw_nf)
 			nfs_to_nfsd_file_put_local(rw_nf);
-
 		cond_resched();
+		spin_lock(&nfs_uuid->lock);
+		/* Now we can allow racing nfs_close_local_fh() to
+		 * skip the locking.
+		 */
+		RCU_INIT_POINTER(nfl->nfs_uuid, NULL);
+		wake_up_var_locked(&nfl->nfs_uuid, &nfs_uuid->lock);
 	}
 
-	spin_lock(&nfs_uuid->lock);
-	BUG_ON(!list_empty(&nfs_uuid->files));
-
 	/* Remove client from nn->local_clients */
 	if (nfs_uuid->list_lock) {
 		spin_lock(nfs_uuid->list_lock);
@@ -304,23 +315,43 @@ void nfs_close_local_fh(struct nfs_file_localio *nfl)
 		return;
 	}
 
-	ro_nf = unrcu_pointer(xchg(&nfl->ro_file, NULL));
-	rw_nf = unrcu_pointer(xchg(&nfl->rw_file, NULL));
-
 	spin_lock(&nfs_uuid->lock);
-	/* Remove nfl from nfs_uuid->files list */
-	list_del_init(&nfl->list);
+	if (!rcu_access_pointer(nfl->nfs_uuid)) {
+		/* nfs_uuid_put has finished here */
+		spin_unlock(&nfs_uuid->lock);
+		rcu_read_unlock();
+		return;
+	}
+	if (list_empty(&nfs_uuid->files)) {
+		/* nfs_uuid_put() has started closing files, wait for it
+		 * to finished
+		 */
+		spin_unlock(&nfs_uuid->lock);
+		rcu_read_unlock();
+		wait_var_event(&nfl->nfs_uuid,
+			       rcu_access_pointer(nfl->nfs_uuid) == NULL);
+		return;
+	}
+	/* tell nfs_uuid_put() to wait for us */
+	RCU_INIT_POINTER(nfl->nfs_uuid, NULL);
 	spin_unlock(&nfs_uuid->lock);
 	rcu_read_unlock();
-	/* Now we can allow racing nfs_close_local_fh() to
-	 * skip the locking.
-	 */
-	RCU_INIT_POINTER(nfl->nfs_uuid, NULL);
 
+	ro_nf = unrcu_pointer(xchg(&nfl->ro_file, NULL));
+	rw_nf = unrcu_pointer(xchg(&nfl->rw_file, NULL));
 	if (ro_nf)
 		nfs_to_nfsd_file_put_local(ro_nf);
 	if (rw_nf)
 		nfs_to_nfsd_file_put_local(rw_nf);
+
+	/* Remove nfl from nfs_uuid->files list and signal nfs_uuid_put()
+	 * that we are done.  The moment we drop the spinlock the
+	 * nfs_uuid could be freed.
+	 */
+	spin_lock(&nfs_uuid->lock);
+	list_del_init(&nfl->list);
+	wake_up_var_locked(&nfl->nfs_uuid, &nfs_uuid->lock);
+	spin_unlock(&nfs_uuid->lock);
 }
 EXPORT_SYMBOL_GPL(nfs_close_local_fh);
 
-- 
2.49.0


