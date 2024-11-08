Return-Path: <linux-nfs+bounces-7807-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F6B9C2832
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Nov 2024 00:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0A78281AAF
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Nov 2024 23:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5EA1F26C7;
	Fri,  8 Nov 2024 23:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mt/qQDvs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE07A1FB8BF
	for <linux-nfs@vger.kernel.org>; Fri,  8 Nov 2024 23:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731109224; cv=none; b=MN0//NBu1fl3x+D3tb3cf8DT5ZogQQ+H3yyJ0aDGiKs0P56ZVJoSGGANSTv9IA7BCsN7j0lgKTpE5msreQ3W3ioeFInhUBLaameXqJ7cpHK1iQGQPDhuo0TLrLVhrQrGMZ+3zFP5vUgcV8jQj9VrRkxQcXGUWt1CFYOhmsHlDJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731109224; c=relaxed/simple;
	bh=QbDgsD4uB2iXNimXUYtxhG3wWClwrbP8GliwGEOJ7i0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HhL3wIWekgTkGAxAuRUtKfUOIag3/3t/MGTF3IrqEWBcEKZvGa3sumv7S4I2YWnXgjNCS4ZJ9f94hiba9nZwjb9S9+iIvpwpkanovY1qtnD/OpNBvX4Y9j/oaBJniriHcaC94s/uNEBFvGTvmTpqNJVZLukCZ+piRpAbr3cuonw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mt/qQDvs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36477C4CECE;
	Fri,  8 Nov 2024 23:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731109224;
	bh=QbDgsD4uB2iXNimXUYtxhG3wWClwrbP8GliwGEOJ7i0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mt/qQDvsNXpZgTsx12+5jqrjOAZZxiwhLQ7B6tmYY3OpaJR+xpgYIkXcXDMDOykhs
	 5t/CvHQWCXt012J+LIOi9aSoiX91WnoQ4WpfcY1UCGkw29EaC1HuJjccqr68ptcLoQ
	 zthuJKsez7HrkiV8faS6Ly3GE3Sm4ZFjt/JU+VoY5YPIhGQz/9mpXTPVvibXe6qAN8
	 CZuf19JL7QluL+Qw88vGPhyutomMiPCoJkf/Z/Mpow/cLDST7ZinL3iqo7xANj6hbP
	 KX8xkY3xSG9R+zba8Hz4+k6cZnxi6fyneclwQEZz9/zbqsxb3mYGIp9Zj7WuZSh8vo
	 fwUS9LUtxZ7ZQ==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@suse.de>
Subject: [for-6.13 PATCH 15/19] nfs_common: rename nfslocalio nfs_uuid_lock to nfs_uuids_lock
Date: Fri,  8 Nov 2024 18:39:58 -0500
Message-ID: <20241108234002.16392-16-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241108234002.16392-1-snitzer@kernel.org>
References: <20241108234002.16392-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This global spinlock protects all nfs_uuid_t relative to the global
nfs_uuids list.  A later commit will split this global spinlock so
prepare by renaming this lock to reflect its intended narrow scope.

Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 fs/nfs_common/nfslocalio.c | 34 +++++++++++++++++-----------------
 fs/nfsd/localio.c          |  2 +-
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
index 0935bdcaa940..e58b5b4b4c3a 100644
--- a/fs/nfs_common/nfslocalio.c
+++ b/fs/nfs_common/nfslocalio.c
@@ -15,11 +15,11 @@
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("NFS localio protocol bypass support");
 
-static DEFINE_SPINLOCK(nfs_uuid_lock);
+static DEFINE_SPINLOCK(nfs_uuids_lock);
 
 /*
  * Global list of nfs_uuid_t instances
- * that is protected by nfs_uuid_lock.
+ * that is protected by nfs_uuids_lock.
  */
 static LIST_HEAD(nfs_uuids);
 
@@ -34,15 +34,15 @@ EXPORT_SYMBOL_GPL(nfs_uuid_init);
 
 bool nfs_uuid_begin(nfs_uuid_t *nfs_uuid)
 {
-	spin_lock(&nfs_uuid_lock);
+	spin_lock(&nfs_uuids_lock);
 	/* Is this nfs_uuid already in use? */
 	if (!list_empty(&nfs_uuid->list)) {
-		spin_unlock(&nfs_uuid_lock);
+		spin_unlock(&nfs_uuids_lock);
 		return false;
 	}
 	uuid_gen(&nfs_uuid->uuid);
 	list_add_tail(&nfs_uuid->list, &nfs_uuids);
-	spin_unlock(&nfs_uuid_lock);
+	spin_unlock(&nfs_uuids_lock);
 
 	return true;
 }
@@ -51,10 +51,10 @@ EXPORT_SYMBOL_GPL(nfs_uuid_begin);
 void nfs_uuid_end(nfs_uuid_t *nfs_uuid)
 {
 	if (nfs_uuid->net == NULL) {
-		spin_lock(&nfs_uuid_lock);
+		spin_lock(&nfs_uuids_lock);
 		if (nfs_uuid->net == NULL)
 			list_del_init(&nfs_uuid->list);
-		spin_unlock(&nfs_uuid_lock);
+		spin_unlock(&nfs_uuids_lock);
 	}
 }
 EXPORT_SYMBOL_GPL(nfs_uuid_end);
@@ -78,7 +78,7 @@ void nfs_uuid_is_local(const uuid_t *uuid, struct list_head *list,
 {
 	nfs_uuid_t *nfs_uuid;
 
-	spin_lock(&nfs_uuid_lock);
+	spin_lock(&nfs_uuids_lock);
 	nfs_uuid = nfs_uuid_lookup_locked(uuid);
 	if (nfs_uuid) {
 		kref_get(&dom->ref);
@@ -94,7 +94,7 @@ void nfs_uuid_is_local(const uuid_t *uuid, struct list_head *list,
 		__module_get(mod);
 		nfsd_mod = mod;
 	}
-	spin_unlock(&nfs_uuid_lock);
+	spin_unlock(&nfs_uuids_lock);
 }
 EXPORT_SYMBOL_GPL(nfs_uuid_is_local);
 
@@ -128,9 +128,9 @@ void nfs_localio_disable_client(struct nfs_client *clp)
 
 	spin_lock(&nfs_uuid->lock);
 	if (test_and_clear_bit(NFS_CS_LOCAL_IO, &clp->cl_flags)) {
-		spin_lock(&nfs_uuid_lock);
+		spin_lock(&nfs_uuids_lock);
 		nfs_uuid_put_locked(nfs_uuid);
-		spin_unlock(&nfs_uuid_lock);
+		spin_unlock(&nfs_uuids_lock);
 	}
 	spin_unlock(&nfs_uuid->lock);
 }
@@ -140,23 +140,23 @@ void nfs_localio_invalidate_clients(struct list_head *cl_uuid_list)
 {
 	nfs_uuid_t *nfs_uuid, *tmp;
 
-	spin_lock(&nfs_uuid_lock);
+	spin_lock(&nfs_uuids_lock);
 	list_for_each_entry_safe(nfs_uuid, tmp, cl_uuid_list, list) {
 		struct nfs_client *clp =
 			container_of(nfs_uuid, struct nfs_client, cl_uuid);
 
 		nfs_localio_disable_client(clp);
 	}
-	spin_unlock(&nfs_uuid_lock);
+	spin_unlock(&nfs_uuids_lock);
 }
 EXPORT_SYMBOL_GPL(nfs_localio_invalidate_clients);
 
 static void nfs_uuid_add_file(nfs_uuid_t *nfs_uuid, struct nfs_file_localio *nfl)
 {
-	spin_lock(&nfs_uuid_lock);
+	spin_lock(&nfs_uuids_lock);
 	if (!nfl->nfs_uuid)
 		rcu_assign_pointer(nfl->nfs_uuid, nfs_uuid);
-	spin_unlock(&nfs_uuid_lock);
+	spin_unlock(&nfs_uuids_lock);
 }
 
 /*
@@ -217,14 +217,14 @@ void nfs_close_local_fh(struct nfs_file_localio *nfl)
 	ro_nf = rcu_access_pointer(nfl->ro_file);
 	rw_nf = rcu_access_pointer(nfl->rw_file);
 	if (ro_nf || rw_nf) {
-		spin_lock(&nfs_uuid_lock);
+		spin_lock(&nfs_uuids_lock);
 		if (ro_nf)
 			ro_nf = rcu_dereference_protected(xchg(&nfl->ro_file, NULL), 1);
 		if (rw_nf)
 			rw_nf = rcu_dereference_protected(xchg(&nfl->rw_file, NULL), 1);
 
 		rcu_assign_pointer(nfl->nfs_uuid, NULL);
-		spin_unlock(&nfs_uuid_lock);
+		spin_unlock(&nfs_uuids_lock);
 		rcu_read_unlock();
 
 		if (ro_nf)
diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
index f9a91cd3b5ec..2ae07161b919 100644
--- a/fs/nfsd/localio.c
+++ b/fs/nfsd/localio.c
@@ -54,7 +54,7 @@ void nfsd_localio_ops_init(void)
  * avoid all the NFS overhead with reads, writes and commits.
  *
  * On successful return, returned nfsd_file will have its nf_net member
- * set. Caller (NFS client) is responsible for calling nfsd_serv_put and
+ * set. Caller (NFS client) is responsible for calling nfsd_net_put and
  * nfsd_file_put (via nfs_to_nfsd_file_put_local).
  */
 struct nfsd_file *
-- 
2.44.0


