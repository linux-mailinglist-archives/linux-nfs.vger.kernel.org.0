Return-Path: <linux-nfs+bounces-11365-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC2BAA419F
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Apr 2025 06:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A53F9C3931
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Apr 2025 04:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAAC1D89E3;
	Wed, 30 Apr 2025 04:05:04 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF0012CDAE
	for <linux-nfs@vger.kernel.org>; Wed, 30 Apr 2025 04:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745985904; cv=none; b=IGeJHLRjAaN4FzYjUXmTB9S9rY4sSpJLDd3LsXYpi0nbyra4uwlb6INWRSEveUrbLNUHJ76mnkkoEbCtCy5+voDmYdpaCURueq1CBQRpGKrSUEAD9II8vsVp4y8EkMPu5X4QeEvO2JsJm9aUY+35DbFNZTbJw00q2Is61vqf9S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745985904; c=relaxed/simple;
	bh=TFA6FwLzXEXDm2Y3Q5lpcIDe2RYgp5hcJI3rrp4uipU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BIUTXAgY8A+Z40N2pkfHh501eS2RR6rHMh0BJLIfdKhTIreH4KvajZkNVwRWR5PiPeUvAapuMKGVCnXjLNFSi84NtXmQQ7QIkF0p6YNcELP1jDA/dHIoaUCkFjeSduH19zlr3hYsD6N9TwWGGz4Uwt0aAjYdbQPvgrTGoITBEmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1u9ygo-005EZ1-W9;
	Wed, 30 Apr 2025 04:04:55 +0000
From: NeilBrown <neil@brown.name>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Mike Snitzer <snitzer@kernel.org>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 4/6] nfs_localio: change nfsd_file_put_local() to take a pointer to __rcu struct
Date: Wed, 30 Apr 2025 14:01:14 +1000
Message-ID: <20250430040429.2743921-5-neil@brown.name>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250430040429.2743921-1-neil@brown.name>
References: <20250430040429.2743921-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Instead of calling rcu_dereference() before nfsd_file_put_local(), we
now pass a pointer to an __rcu value and call rcu_dereference() inside
that function.

Where rcu_dereference() is currently called the internals of "struct
nfsd_file" are not known and that causes older compilers such as gcc-8
to complain.

In some cases we have a __kernel (aka normal) pointer not an __rcu
pointer so we need to cast it to __rcu first.  This is strictly a
weakening so no information is lost.  Somewhat surprisingly, this cast
is accepted by gcc-8.

Also change nfs_to_nfsd_file_put_local() to handle receiving a NULL
pointer, as that makes some callers a bit simpler.

Reported-by: Pali Rohár <pali@kernel.org>
Reported-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Fixes: 86e00412254a ("nfs: cache all open LOCALIO nfsd_file(s) in client")
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfs/localio.c           |  9 ++++++++-
 fs/nfs_common/nfslocalio.c | 14 ++++++--------
 fs/nfsd/filecache.c        |  3 ++-
 fs/nfsd/filecache.h        |  2 +-
 include/linux/nfslocalio.h | 11 ++++++++---
 5 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 030a54c8c9d8..157f5dd0ab22 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -207,8 +207,15 @@ void nfs_local_probe_async(struct nfs_client *clp)
 }
 EXPORT_SYMBOL_GPL(nfs_local_probe_async);
 
-static inline void nfs_local_file_put(struct nfsd_file *nf)
+static inline void nfs_local_file_put(struct nfsd_file *localio)
 {
+	/* nfs_to_nfsd_file_put_local() expects an __rcu pointer
+	 * but we have a __kernel pointer.  It is always safe
+	 * to cast a __kernel pointer to an __rcu pointer
+	 * because the cast only weakens what is known about the pointer.
+	 */
+	struct nfsd_file __rcu *nf = (struct nfsd_file __rcu*) localio;
+
 	nfs_to_nfsd_file_put_local(nf);
 }
 
diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
index d9e2f65912ef..cbf3e38443f9 100644
--- a/fs/nfs_common/nfslocalio.c
+++ b/fs/nfs_common/nfslocalio.c
@@ -273,8 +273,8 @@ EXPORT_SYMBOL_GPL(nfs_open_local_fh);
 
 void nfs_close_local_fh(struct nfs_file_localio *nfl)
 {
-	struct nfsd_file *ro_nf = NULL;
-	struct nfsd_file *rw_nf = NULL;
+	struct nfsd_file __rcu *ro_nf;
+	struct nfsd_file __rcu *rw_nf;
 	nfs_uuid_t *nfs_uuid;
 
 	rcu_read_lock();
@@ -285,8 +285,8 @@ void nfs_close_local_fh(struct nfs_file_localio *nfl)
 		return;
 	}
 
-	ro_nf = unrcu_pointer(xchg(&nfl->ro_file, NULL));
-	rw_nf = unrcu_pointer(xchg(&nfl->rw_file, NULL));
+	ro_nf = xchg(&nfl->ro_file, RCU_INITIALIZER(NULL));
+	rw_nf = xchg(&nfl->rw_file, RCU_INITIALIZER(NULL));
 
 	spin_lock(&nfs_uuid->lock);
 	/* Remove nfl from nfs_uuid->files list */
@@ -298,10 +298,8 @@ void nfs_close_local_fh(struct nfs_file_localio *nfl)
 	 */
 	RCU_INIT_POINTER(nfl->nfs_uuid, NULL);
 
-	if (ro_nf)
-		nfs_to_nfsd_file_put_local(ro_nf);
-	if (rw_nf)
-		nfs_to_nfsd_file_put_local(rw_nf);
+	nfs_to_nfsd_file_put_local(ro_nf);
+	nfs_to_nfsd_file_put_local(rw_nf);
 	return;
 }
 EXPORT_SYMBOL_GPL(nfs_close_local_fh);
diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 473697278d8f..e1fdc8e2740f 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -378,8 +378,9 @@ nfsd_file_put(struct nfsd_file *nf)
  * the reference of the nfsd_file.
  */
 struct net *
-nfsd_file_put_local(struct nfsd_file *nf)
+nfsd_file_put_local(struct nfsd_file __rcu *nf_rcu)
 {
+	struct nfsd_file *nf = rcu_dereference(nf_rcu);
 	struct net *net = nf->nf_net;
 
 	nfsd_file_put(nf);
diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
index cd02f91aaef1..e433ccbc31dc 100644
--- a/fs/nfsd/filecache.h
+++ b/fs/nfsd/filecache.h
@@ -62,7 +62,7 @@ void nfsd_file_cache_shutdown(void);
 int nfsd_file_cache_start_net(struct net *net);
 void nfsd_file_cache_shutdown_net(struct net *net);
 void nfsd_file_put(struct nfsd_file *nf);
-struct net *nfsd_file_put_local(struct nfsd_file *nf);
+struct net *nfsd_file_put_local(struct nfsd_file __rcu *nf);
 struct nfsd_file *nfsd_file_get_local(struct nfsd_file *nf);
 struct nfsd_file *nfsd_file_get(struct nfsd_file *nf);
 struct file *nfsd_file_file(struct nfsd_file *nf);
diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
index e6cd6ec447f5..e53fd61d0f8b 100644
--- a/include/linux/nfslocalio.h
+++ b/include/linux/nfslocalio.h
@@ -62,7 +62,7 @@ struct nfsd_localio_operations {
 						const struct nfs_fh *,
 						struct nfsd_file __rcu **pnf,
 						const fmode_t);
-	struct net *(*nfsd_file_put_local)(struct nfsd_file *);
+	struct net *(*nfsd_file_put_local)(struct nfsd_file __rcu *);
 	struct nfsd_file *(*nfsd_file_get_local)(struct nfsd_file *);
 	struct file *(*nfsd_file_file)(struct nfsd_file *);
 } ____cacheline_aligned;
@@ -88,14 +88,19 @@ static inline void nfs_to_nfsd_net_put(struct net *net)
 	rcu_read_unlock();
 }
 
-static inline void nfs_to_nfsd_file_put_local(struct nfsd_file *localio)
+static inline void nfs_to_nfsd_file_put_local(struct nfsd_file __rcu *localio)
 {
 	/*
 	 * Must not hold RCU otherwise nfsd_file_put() can easily trigger:
 	 * "Voluntary context switch within RCU read-side critical section!"
 	 * by scheduling deep in underlying filesystem (e.g. XFS).
 	 */
-	struct net *net = nfs_to->nfsd_file_put_local(localio);
+	struct net *net;
+
+	if (!localio)
+		return;
+
+	net = nfs_to->nfsd_file_put_local(localio);
 
 	nfs_to_nfsd_net_put(net);
 }
-- 
2.49.0


