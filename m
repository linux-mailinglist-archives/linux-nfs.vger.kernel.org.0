Return-Path: <linux-nfs+bounces-13018-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D83B034D8
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 05:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3BD5188C5BE
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 03:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E0C1E1DF1;
	Mon, 14 Jul 2025 03:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oiaf/HJV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A3A18C332
	for <linux-nfs@vger.kernel.org>; Mon, 14 Jul 2025 03:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752462851; cv=none; b=mxqieiL5bt6Mj6ST4sdja96k+I4TU6ZF2s3w/OXr5579TbL3HWvgxXnRgf5/3bJhNxUZ1tRHMQZIkNLeISQ25C8a1Z58P3nOwrPwIhTV2jNQgY16JmL/462FFHTosiEw549oyDvRREk2tF2M7O5KEp3GXp5uKmyVu7y+T8eFTuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752462851; c=relaxed/simple;
	bh=Tnp5Ezq9yFz7QNSj8Bd+/9rAyvJt1FlRvhdMtDEXImQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YKghH3utWiHgTytyV76aewgWqkfVuW9G9CFl8Q4S1BbKPXWPnl4EuhDV/b1gFAc7KPxxY1Pu5MnbXLn2wAMxd8ts7pQPLiVvmWTEelwsLxQ0Je87NS8PJJEHhl9ZKLFEvAL3rSg1yDnOVbBhBznrOE2eUlHH7T+EYS8UoTbyZxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oiaf/HJV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD9FC4CEE3;
	Mon, 14 Jul 2025 03:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752462851;
	bh=Tnp5Ezq9yFz7QNSj8Bd+/9rAyvJt1FlRvhdMtDEXImQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oiaf/HJVEVo+ql6W4utehUIiftU0MZIWvuMzM0g+oXYaL9BL0AhZUrYA59ZhIdOoj
	 pqhYEPhJQbw87asfVObJkQfrAdYw6NyPRdiT5J3AoaujdSVQtljhyfuDTpTHR4gz4i
	 9JSQ86PJDmQuWOgOoReSrvMeEP9PAs+rG1tOPxgOUg10I1nPIQryhiZw+C5BVUz95L
	 R5y8XWYodekEbk2he7kbFGextEBycJt1yuYJ7POuuhfFGWirUkcOdNWNWHqXozZx5C
	 sRxk7Z/mHFR9bGsqe1K7mmdoc6xHFkkvUE1RyBjGtw/7oaPD+W3PaL4dEmmRaK0BWr
	 xVFmmZuDFk5eQ==
From: Mike Snitzer <snitzer@kernel.org>
To: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>
Cc: linux-nfs@vger.kernel.org
Subject: [for-6.16-final PATCH 7/9] Revert "nfs_localio: use cmpxchg() to install new nfs_file_localio"
Date: Sun, 13 Jul 2025 23:13:57 -0400
Message-ID: <20250714031359.10192-8-snitzer@kernel.org>
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

This reverts commit 9fccbbec13a73ae0e75448a00e20dadc8c511c8c.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/localio.c           | 11 ++++++++---
 fs/nfs_common/nfslocalio.c | 39 +++++++++++++++++++++-----------------
 2 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 7a33da477da3..a4bacd9a5052 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -282,9 +282,14 @@ nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
 			return NULL;
 		rcu_read_lock();
 		/* try to swap in the pointer */
-		nf = unrcu_pointer(cmpxchg(pnf, NULL, RCU_INITIALIZER(new)));
-		if (!nf)
-			swap(nf, new);
+		spin_lock(&clp->cl_uuid.lock);
+		nf = rcu_dereference_protected(*pnf, 1);
+		if (!nf) {
+			nf = new;
+			new = NULL;
+			rcu_assign_pointer(*pnf, nf);
+		}
+		spin_unlock(&clp->cl_uuid.lock);
 	}
 	nf = nfs_local_file_get(nf);
 	rcu_read_unlock();
diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
index bdf251332b6b..6a0bdea6d644 100644
--- a/fs/nfs_common/nfslocalio.c
+++ b/fs/nfs_common/nfslocalio.c
@@ -273,8 +273,8 @@ EXPORT_SYMBOL_GPL(nfs_open_local_fh);
 
 void nfs_close_local_fh(struct nfs_file_localio *nfl)
 {
-	struct nfsd_file *ro_nf;
-	struct nfsd_file *rw_nf;
+	struct nfsd_file *ro_nf = NULL;
+	struct nfsd_file *rw_nf = NULL;
 	nfs_uuid_t *nfs_uuid;
 
 	rcu_read_lock();
@@ -285,23 +285,28 @@ void nfs_close_local_fh(struct nfs_file_localio *nfl)
 		return;
 	}
 
-	ro_nf = unrcu_pointer(xchg(&nfl->ro_file, NULL));
-	rw_nf = unrcu_pointer(xchg(&nfl->rw_file, NULL));
+	ro_nf = rcu_access_pointer(nfl->ro_file);
+	rw_nf = rcu_access_pointer(nfl->rw_file);
+	if (ro_nf || rw_nf) {
+		spin_lock(&nfs_uuid->lock);
+		if (ro_nf)
+			ro_nf = rcu_dereference_protected(xchg(&nfl->ro_file, NULL), 1);
+		if (rw_nf)
+			rw_nf = rcu_dereference_protected(xchg(&nfl->rw_file, NULL), 1);
 
-	spin_lock(&nfs_uuid->lock);
-	/* Remove nfl from nfs_uuid->files list */
-	list_del_init(&nfl->list);
-	spin_unlock(&nfs_uuid->lock);
+		/* Remove nfl from nfs_uuid->files list */
+		RCU_INIT_POINTER(nfl->nfs_uuid, NULL);
+		list_del_init(&nfl->list);
+		spin_unlock(&nfs_uuid->lock);
+		rcu_read_unlock();
+
+		if (ro_nf)
+			nfs_to_nfsd_file_put_local(ro_nf);
+		if (rw_nf)
+			nfs_to_nfsd_file_put_local(rw_nf);
+		return;
+	}
 	rcu_read_unlock();
-	/* Now we can allow racing nfs_close_local_fh() to
-	 * skip the locking.
-	 */
-	RCU_INIT_POINTER(nfl->nfs_uuid, NULL);
-
-	if (ro_nf)
-		nfs_to_nfsd_file_put_local(ro_nf);
-	if (rw_nf)
-		nfs_to_nfsd_file_put_local(rw_nf);
 }
 EXPORT_SYMBOL_GPL(nfs_close_local_fh);
 
-- 
2.44.0


