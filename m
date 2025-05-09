Return-Path: <linux-nfs+bounces-11613-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E811AB074B
	for <lists+linux-nfs@lfdr.de>; Fri,  9 May 2025 02:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A511C1C23E1D
	for <lists+linux-nfs@lfdr.de>; Fri,  9 May 2025 00:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF59B35942;
	Fri,  9 May 2025 00:49:17 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F293C17BA9
	for <linux-nfs@vger.kernel.org>; Fri,  9 May 2025 00:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746751757; cv=none; b=i45S7b2rnozOrMyQ8n4Eg1GEX4eQBHpwz70iaZgyGAQMca+DisLCQYqKdFLOemloN3FDX0TTd6j8C3NNDKJdGvctNvD4hWNg+bOPmAtYCSGXQvjmbYz2UdaHTTJ2SWzQXTygsi5LVXtqz2LdUZrWR3uwDGcXqxVo81myse4Hx7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746751757; c=relaxed/simple;
	bh=HIx1iFs3x6ijbg7c09dB35UoCEUZO05sAe+14aNJ+NI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qo8oPbomk9UEOJYtSsKLBYVuLvRhrSXh8Dy2nCExXhjqrX8Pw9bWEIBC5D5KUu6yMuSEgCMhXAl2TwRqlgr/m7uJpFm3cKSx3QEKh07YEQDKEAuWMNDFQuBCxpjuh7MjhyVHKt21bb3O27rX2CMHzCLNknOWI9Yegd59KSv0UY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uDBvG-00HQUb-PA;
	Fri, 09 May 2025 00:49:06 +0000
From: NeilBrown <neil@brown.name>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Mike Snitzer <snitzer@kernel.org>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 1/6] nfs_localio: use cmpxchg() to install new nfs_file_localio
Date: Fri,  9 May 2025 10:46:38 +1000
Message-ID: <20250509004852.3272120-2-neil@brown.name>
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

Rather than using nfs_uuid.lock to protect installing
a new ro_file or rw_file, change to use cmpxchg().
Removing the file already uses xchg() so this improves symmetry
and also makes the code a little simpler.

Also remove the optimisation of not taking the lock, and not removing
the nfs_file_localio from the linked list, when both ->ro_file and
->rw_file are already NULL.  Given that ->nfs_uuid was not NULL, it is
extremely unlikely that neither ->ro_file or ->rw_file is NULL so
this optimisation can be of little value and it complicates
understanding of the code - why can the list_del_init() be skipped?

Finally, move the assignment of NULL to ->nfs_uuid until after
the last action on the nfs_file_localio (the list_del_init).  As soon as
this is NULL a racing nfs_close_local_fh() can bypass all the locking
and go on to free the nfs_file_localio, so we must be certain to be
finished with it first.

Fixes: 86e00412254a ("nfs: cache all open LOCALIO nfsd_file(s) in client")
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfs/localio.c           | 11 +++--------
 fs/nfs_common/nfslocalio.c | 39 +++++++++++++++++---------------------
 2 files changed, 20 insertions(+), 30 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 5c21caeae075..3674dd86f095 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -279,14 +279,9 @@ nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
 		if (IS_ERR(new))
 			return NULL;
 		/* try to swap in the pointer */
-		spin_lock(&clp->cl_uuid.lock);
-		nf = rcu_dereference_protected(*pnf, 1);
-		if (!nf) {
-			nf = new;
-			new = NULL;
-			rcu_assign_pointer(*pnf, nf);
-		}
-		spin_unlock(&clp->cl_uuid.lock);
+		nf = unrcu_pointer(cmpxchg(pnf, NULL, RCU_INITIALIZER(new)));
+		if (!nf)
+			swap(nf, new);
 		rcu_read_lock();
 	}
 	nf = nfs_local_file_get(nf);
diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
index 6a0bdea6d644..bdf251332b6b 100644
--- a/fs/nfs_common/nfslocalio.c
+++ b/fs/nfs_common/nfslocalio.c
@@ -273,8 +273,8 @@ EXPORT_SYMBOL_GPL(nfs_open_local_fh);
 
 void nfs_close_local_fh(struct nfs_file_localio *nfl)
 {
-	struct nfsd_file *ro_nf = NULL;
-	struct nfsd_file *rw_nf = NULL;
+	struct nfsd_file *ro_nf;
+	struct nfsd_file *rw_nf;
 	nfs_uuid_t *nfs_uuid;
 
 	rcu_read_lock();
@@ -285,28 +285,23 @@ void nfs_close_local_fh(struct nfs_file_localio *nfl)
 		return;
 	}
 
-	ro_nf = rcu_access_pointer(nfl->ro_file);
-	rw_nf = rcu_access_pointer(nfl->rw_file);
-	if (ro_nf || rw_nf) {
-		spin_lock(&nfs_uuid->lock);
-		if (ro_nf)
-			ro_nf = rcu_dereference_protected(xchg(&nfl->ro_file, NULL), 1);
-		if (rw_nf)
-			rw_nf = rcu_dereference_protected(xchg(&nfl->rw_file, NULL), 1);
-
-		/* Remove nfl from nfs_uuid->files list */
-		RCU_INIT_POINTER(nfl->nfs_uuid, NULL);
-		list_del_init(&nfl->list);
-		spin_unlock(&nfs_uuid->lock);
-		rcu_read_unlock();
+	ro_nf = unrcu_pointer(xchg(&nfl->ro_file, NULL));
+	rw_nf = unrcu_pointer(xchg(&nfl->rw_file, NULL));
 
-		if (ro_nf)
-			nfs_to_nfsd_file_put_local(ro_nf);
-		if (rw_nf)
-			nfs_to_nfsd_file_put_local(rw_nf);
-		return;
-	}
+	spin_lock(&nfs_uuid->lock);
+	/* Remove nfl from nfs_uuid->files list */
+	list_del_init(&nfl->list);
+	spin_unlock(&nfs_uuid->lock);
 	rcu_read_unlock();
+	/* Now we can allow racing nfs_close_local_fh() to
+	 * skip the locking.
+	 */
+	RCU_INIT_POINTER(nfl->nfs_uuid, NULL);
+
+	if (ro_nf)
+		nfs_to_nfsd_file_put_local(ro_nf);
+	if (rw_nf)
+		nfs_to_nfsd_file_put_local(rw_nf);
 }
 EXPORT_SYMBOL_GPL(nfs_close_local_fh);
 
-- 
2.49.0


