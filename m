Return-Path: <linux-nfs+bounces-11617-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE91AB074F
	for <lists+linux-nfs@lfdr.de>; Fri,  9 May 2025 02:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 055403AFF68
	for <lists+linux-nfs@lfdr.de>; Fri,  9 May 2025 00:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFF5208AD;
	Fri,  9 May 2025 00:49:19 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC92F1F5FD
	for <linux-nfs@vger.kernel.org>; Fri,  9 May 2025 00:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746751759; cv=none; b=gf/tkAV6l5WRP8qtCvcIATHbmcl6zp1NDG3uTribmrn6q4YQ5EflQCc9hOhy8KCCXd8WKBVy94LtNYLd+RmEE3m7uxhLeEUhJT5O6FIEECKOLJ2SNU/1E7YMoOwHk70hlqn94vem7g5lekWiojrheisBUvPAjNJHDf5Ds0WUTcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746751759; c=relaxed/simple;
	bh=fl2BWqSOSi6CNyoqnDt0/w41u6dSgXlLgDUzCOUF4sM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B5vneoo9lg8OUXkv+5lKC7naCoS2ZovATVoLn7u4c967Y+FlHD4TfWUTXZngi8q8gPw03xRvI+uaR4fhUxWEzdTrUrPNuacd5EJzZCm+m/mYytFIWvww6kzcST6CCkHzuVlmYZRf6s99oG2bSuUXQleAZN5m3C203vzOhpKo5/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uDBvJ-00HQUy-E7;
	Fri, 09 May 2025 00:49:09 +0000
From: NeilBrown <neil@brown.name>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Mike Snitzer <snitzer@kernel.org>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 6/6] nfs_localio: change nfsd_file_put_local() to take a pointer to __rcu pointer
Date: Fri,  9 May 2025 10:46:43 +1000
Message-ID: <20250509004852.3272120-7-neil@brown.name>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250509004852.3272120-1-neil@brown.name>
References: <20250509004852.3272120-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Instead of calling xchg() and unrcu_pointer() before
nfsd_file_put_local(), we now pass pointer to the __rcu pointer and call
xchg() and unrcu_pointer() inside that function.

Where unrcu_pointer() is currently called the internals of "struct
nfsd_file" are not known and that causes older compilers such as gcc-8
to complain.

In some cases we have a __kernel (aka normal) pointer not an __rcu
pointer so we need to cast it to __rcu first.  This is strictly a
weakening so no information is lost.  Somewhat surprisingly, this cast
is accepted by gcc-8.

This has the pleasing result that the cmpxchg() which sets ro_file and
rw_file, and also the xchg() which clears them, are both now in the nfsd
code.

Reported-by: Pali Rohár <pali@kernel.org>
Reported-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Fixes: 86e00412254a ("nfs: cache all open LOCALIO nfsd_file(s) in client")
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfs/localio.c           | 11 +++++++++--
 fs/nfs_common/nfslocalio.c | 24 ++++++------------------
 fs/nfsd/filecache.c        | 11 ++++++++---
 fs/nfsd/filecache.h        |  2 +-
 include/linux/nfslocalio.h | 17 ++++++++++-------
 5 files changed, 34 insertions(+), 31 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 030a54c8c9d8..e6d36b3d3fc0 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -207,9 +207,16 @@ void nfs_local_probe_async(struct nfs_client *clp)
 }
 EXPORT_SYMBOL_GPL(nfs_local_probe_async);
 
-static inline void nfs_local_file_put(struct nfsd_file *nf)
+static inline void nfs_local_file_put(struct nfsd_file *localio)
 {
-	nfs_to_nfsd_file_put_local(nf);
+	/* nfs_to_nfsd_file_put_local() expects an __rcu pointer
+	 * but we have a __kernel pointer.  It is always safe
+	 * to cast a __kernel pointer to an __rcu pointer
+	 * because the cast only weakens what is known about the pointer.
+	 */
+	struct nfsd_file __rcu *nf = (struct nfsd_file __rcu*) localio;
+
+	nfs_to_nfsd_file_put_local(&nf);
 }
 
 /*
diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
index 1dd5a8cca064..05c7c16e37ab 100644
--- a/fs/nfs_common/nfslocalio.c
+++ b/fs/nfs_common/nfslocalio.c
@@ -170,9 +170,6 @@ static bool nfs_uuid_put(nfs_uuid_t *nfs_uuid)
 	while ((nfl = list_first_entry_or_null(&nfs_uuid->files,
 					       struct nfs_file_localio,
 					       list)) != NULL) {
-		struct nfsd_file *ro_nf;
-		struct nfsd_file *rw_nf;
-
 		/* If nfs_uuid is already NULL, nfs_close_local_fh is
 		 * closing and we must wait, else we unlink and close.
 		 */
@@ -189,17 +186,14 @@ static bool nfs_uuid_put(nfs_uuid_t *nfs_uuid)
 			continue;
 		}
 
-		ro_nf = unrcu_pointer(xchg(&nfl->ro_file, NULL));
-		rw_nf = unrcu_pointer(xchg(&nfl->rw_file, NULL));
-
 		/* Remove nfl from nfs_uuid->files list */
 		list_del_init(&nfl->list);
 		spin_unlock(&nfs_uuid->lock);
-		if (ro_nf)
-			nfs_to_nfsd_file_put_local(ro_nf);
-		if (rw_nf)
-			nfs_to_nfsd_file_put_local(rw_nf);
+
+		nfs_to_nfsd_file_put_local(&nfl->ro_file);
+		nfs_to_nfsd_file_put_local(&nfl->rw_file);
 		cond_resched();
+
 		spin_lock(&nfs_uuid->lock);
 		/* Now we can allow racing nfs_close_local_fh() to
 		 * skip the locking.
@@ -303,8 +297,6 @@ EXPORT_SYMBOL_GPL(nfs_open_local_fh);
 
 void nfs_close_local_fh(struct nfs_file_localio *nfl)
 {
-	struct nfsd_file *ro_nf;
-	struct nfsd_file *rw_nf;
 	nfs_uuid_t *nfs_uuid;
 
 	rcu_read_lock();
@@ -337,12 +329,8 @@ void nfs_close_local_fh(struct nfs_file_localio *nfl)
 	spin_unlock(&nfs_uuid->lock);
 	rcu_read_unlock();
 
-	ro_nf = unrcu_pointer(xchg(&nfl->ro_file, NULL));
-	rw_nf = unrcu_pointer(xchg(&nfl->rw_file, NULL));
-	if (ro_nf)
-		nfs_to_nfsd_file_put_local(ro_nf);
-	if (rw_nf)
-		nfs_to_nfsd_file_put_local(rw_nf);
+	nfs_to_nfsd_file_put_local(&nfl->ro_file);
+	nfs_to_nfsd_file_put_local(&nfl->rw_file);
 
 	/* Remove nfl from nfs_uuid->files list and signal nfs_uuid_put()
 	 * that we are done.  The moment we drop the spinlock the
diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index eedf2af8ee6e..e108b6c705b4 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -378,11 +378,16 @@ nfsd_file_put(struct nfsd_file *nf)
  * the reference of the nfsd_file.
  */
 struct net *
-nfsd_file_put_local(struct nfsd_file *nf)
+nfsd_file_put_local(struct nfsd_file __rcu **pnf)
 {
-	struct net *net = nf->nf_net;
+	struct nfsd_file *nf;
+	struct net *net = NULL;
 
-	nfsd_file_put(nf);
+	nf = unrcu_pointer(xchg(pnf, NULL));
+	if (nf) {
+		net = nf->nf_net;
+		nfsd_file_put(nf);
+	}
 	return net;
 }
 
diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
index cd02f91aaef1..722b26c71e45 100644
--- a/fs/nfsd/filecache.h
+++ b/fs/nfsd/filecache.h
@@ -62,7 +62,7 @@ void nfsd_file_cache_shutdown(void);
 int nfsd_file_cache_start_net(struct net *net);
 void nfsd_file_cache_shutdown_net(struct net *net);
 void nfsd_file_put(struct nfsd_file *nf);
-struct net *nfsd_file_put_local(struct nfsd_file *nf);
+struct net *nfsd_file_put_local(struct nfsd_file __rcu **nf);
 struct nfsd_file *nfsd_file_get_local(struct nfsd_file *nf);
 struct nfsd_file *nfsd_file_get(struct nfsd_file *nf);
 struct file *nfsd_file_file(struct nfsd_file *nf);
diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
index e6cd6ec447f5..5c7c92659e73 100644
--- a/include/linux/nfslocalio.h
+++ b/include/linux/nfslocalio.h
@@ -62,7 +62,7 @@ struct nfsd_localio_operations {
 						const struct nfs_fh *,
 						struct nfsd_file __rcu **pnf,
 						const fmode_t);
-	struct net *(*nfsd_file_put_local)(struct nfsd_file *);
+	struct net *(*nfsd_file_put_local)(struct nfsd_file __rcu **);
 	struct nfsd_file *(*nfsd_file_get_local)(struct nfsd_file *);
 	struct file *(*nfsd_file_file)(struct nfsd_file *);
 } ____cacheline_aligned;
@@ -88,16 +88,19 @@ static inline void nfs_to_nfsd_net_put(struct net *net)
 	rcu_read_unlock();
 }
 
-static inline void nfs_to_nfsd_file_put_local(struct nfsd_file *localio)
+static inline void nfs_to_nfsd_file_put_local(struct nfsd_file __rcu **localio)
 {
 	/*
-	 * Must not hold RCU otherwise nfsd_file_put() can easily trigger:
-	 * "Voluntary context switch within RCU read-side critical section!"
-	 * by scheduling deep in underlying filesystem (e.g. XFS).
+	 * Either *localio must be guaranteed to be non-NULL, or caller
+	 * must prevent nfsd shutdown from completing as nfs_close_local_fh()
+	 * does by blocking the nfs_uuid from being finally put.
 	 */
-	struct net *net = nfs_to->nfsd_file_put_local(localio);
+	struct net *net;
 
-	nfs_to_nfsd_net_put(net);
+	net = nfs_to->nfsd_file_put_local(localio);
+
+	if (net)
+		nfs_to_nfsd_net_put(net);
 }
 
 #else   /* CONFIG_NFS_LOCALIO */
-- 
2.49.0


