Return-Path: <linux-nfs+bounces-11363-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D69EAA419D
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Apr 2025 06:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F8C11B6778B
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Apr 2025 04:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31C71CDFD4;
	Wed, 30 Apr 2025 04:05:03 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66372DC761
	for <linux-nfs@vger.kernel.org>; Wed, 30 Apr 2025 04:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745985903; cv=none; b=brQr+IDv1K9BRvqvygA/KKFTHTEuo8meihXZTOIvRjGIRXuqI3PvKOR8UoVgK6pKtZPNO2GuAXSSV82Fq2irhVAHelkE9foBRvBb4SDhIf7Abv80WXoXhJnm6VKY7uzcT08jiajDIn/WXTxE+1bAg2l/MWmlcYNdgmMIQc5nPYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745985903; c=relaxed/simple;
	bh=kR1hRb9xbzlIFgc45wvPBLBUbqZAfGjtLUT0nUGj5g0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ke9J61sVUgXBONcMmESxF9bkxvfICclnqivlcm6Dka1KMKmOUYEg/t8rjyFRbnL5YpIai+r7YZYNcN+5grFmYAY2/2lWTMIH+v1e10rnFolkH7V5xRlt26mI4gQfSs4YEarRx5L5RUB5miZTiMZ8YOKPHCalIEaeaRGD1zTrf0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1u9ygn-005EYL-38;
	Wed, 30 Apr 2025 04:04:53 +0000
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
Date: Wed, 30 Apr 2025 14:01:11 +1000
Message-ID: <20250430040429.2743921-2-neil@brown.name>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250430040429.2743921-1-neil@brown.name>
References: <20250430040429.2743921-1-neil@brown.name>
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
 fs/nfs_common/nfslocalio.c | 36 ++++++++++++++++--------------------
 2 files changed, 19 insertions(+), 28 deletions(-)

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
index 6a0bdea6d644..d72eecb85ea9 100644
--- a/fs/nfs_common/nfslocalio.c
+++ b/fs/nfs_common/nfslocalio.c
@@ -285,28 +285,24 @@ void nfs_close_local_fh(struct nfs_file_localio *nfl)
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
+	return;
 }
 EXPORT_SYMBOL_GPL(nfs_close_local_fh);
 
-- 
2.49.0


