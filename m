Return-Path: <linux-nfs+bounces-8026-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 821BE9CFC42
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Nov 2024 02:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DF171F244D0
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Nov 2024 01:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9893E19048F;
	Sat, 16 Nov 2024 01:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RR3RpDXf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FB6190067
	for <linux-nfs@vger.kernel.org>; Sat, 16 Nov 2024 01:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731721280; cv=none; b=SNkahrWHuCIWksdFYW96/VQv5muTgBoSFOLilulFT99vODQO4F3Q0l9/wf3bH1yhAJou9xunOvJFprfIR/islZxP60n3I/XbwA1PMCY6RVWcOSPQQ5RmyJiCZcrAW5ZABPnbNxNufpnFCekIejTC9dQXSX0wFDNB29JKKm+O7UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731721280; c=relaxed/simple;
	bh=Rg44joD30DU58lNMqd9vzqalbE/nDnh5v3G/nwCffaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tKMgRDLFPJtH4YXszK27tcGM7BBA/UvgzkTH9ATJhYRALsFIxym5elgE1Ew3Qd1faaW5wDdZGJmw+V6sguiWEseAIktLSQ+B8PElf5oca62j9ap1TDxaq97O967oUXHlv7bg5EWr40aBgrKsRDc6Ko8PMYJ6C6bo181fBw/k6ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RR3RpDXf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E3D0C4CECF;
	Sat, 16 Nov 2024 01:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731721280;
	bh=Rg44joD30DU58lNMqd9vzqalbE/nDnh5v3G/nwCffaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RR3RpDXfvHVeFlVvz5Iv3wR3rs/8C5vXaER0lMQBix4PRsiQ+nGzXbA7PsNN/+QaQ
	 o498WVDF7uPX7FWX/yMolGaLPjiolTjjueFIz8Mpr2uTm5OSReuIHagzwwcoxWQt2x
	 QTpNVq4Rxeyain7D78nadHSyopb8B2S1KEJfm/UclwJPGc07NaF37bnQK4xAt3hW6D
	 /CngW9O4Svl5MW4LJtEOGE0mtvstfie+/VYtnHX6ZzkYbTGPR3p+Fa9EdGpinlN19J
	 //UUpEoST9QQi7gfatAC2s+FyySeBhKSk0J2F0roeaegS3Ud4A12fhBY6wfOE5tXaQ
	 gZsUoZ65NPdzg==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@suse.de>
Subject: [for-6.13 PATCH v3 09/14] nfs_common: rename nfslocalio nfs_uuid_lock to nfs_uuids_lock
Date: Fri, 15 Nov 2024 20:41:01 -0500
Message-ID: <20241116014106.25456-10-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241116014106.25456-1-snitzer@kernel.org>
References: <20241116014106.25456-1-snitzer@kernel.org>
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
index e75cd21f4c8bc..5fa3f47b442e9 100644
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
index f9a91cd3b5ec7..2ae07161b9195 100644
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


