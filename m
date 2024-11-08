Return-Path: <linux-nfs+bounces-7801-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3D39C282D
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Nov 2024 00:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC4F7B21FE9
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Nov 2024 23:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34641E1C07;
	Fri,  8 Nov 2024 23:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SqRtlQIV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE2C1F26E0
	for <linux-nfs@vger.kernel.org>; Fri,  8 Nov 2024 23:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731109216; cv=none; b=S9anjoC2WYi64NkYY10/PgHyoUmStgN0HqkND56Qka19d2BBy3QRYs7QgLMZc0gHSpfPABKyNDM9OCzjXM/TtaMUzK130A25L2nHWEkEqxgThngUxe4Qvsov4Z8bRTHWhbe9Zkm13wRhmys12mGh+Aa14b5P6GVngfpYYhKbZTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731109216; c=relaxed/simple;
	bh=uiujbxYKPAJkwKdQoUJnHAuEOxEUTcAr2LazvNUwFO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U+v/tY+cRSEOYX/PwqjFYKpTLfg5zbZdVWUnGtySvNX0F8dkQqYaB8rqlxrpholFf4KjgqxT2q469LwpP6aJKwuwNkndEmm4V3mR03Pxejcmew9KUleZNFGJWgbs3KbrDDbYri5vlMekm7lOWpZAu6+s10kyHqBV+RgRCb5o8pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SqRtlQIV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B98AC4CECE;
	Fri,  8 Nov 2024 23:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731109216;
	bh=uiujbxYKPAJkwKdQoUJnHAuEOxEUTcAr2LazvNUwFO8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SqRtlQIVROzPeGG7a9hL88p11pNRaE3j2k2vjCd+w9CoAvOLJ1LPnKlK+UsE39rfy
	 6tx5JQ4WGY4IuX51nWNcddDzs9CJ/Rhd/NsjB+SpEiDvEynppTjQlDFN4oxqenEfKC
	 cvySNPlWDEy2q8sRkJahtghq2GIkOcHFqXHcidnUnJnMtebCC6/cJ81O7MrCZu1QTn
	 VJ8BSCgN7cjhbOd0ZHZdcVv4m45VSI6KwQsl0FJLQRQkin4cuA+NBvqslMqp5hidpL
	 5SdkilxTABqR+oD9ewXmE5JGdQF/utOq5akY63Oper9BznXO+WE+TVzhWX0sX6vrGn
	 +DHu9TqKU0ciQ==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@suse.de>
Subject: [for-6.13 PATCH 09/19] nfs_common: rename functions that invalidate LOCALIO nfs_clients
Date: Fri,  8 Nov 2024 18:39:52 -0500
Message-ID: <20241108234002.16392-10-snitzer@kernel.org>
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

Rename nfs_uuid_invalidate_one_client to nfs_localio_disable_client.
Rename nfs_uuid_invalidate_clients to nfs_localio_invalidate_clients.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/localio.c           | 2 +-
 fs/nfs_common/nfslocalio.c | 8 ++++----
 fs/nfsd/nfsctl.c           | 4 ++--
 include/linux/nfslocalio.h | 5 +++--
 4 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index de0dcd76d84d..cab2a8819259 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -139,7 +139,7 @@ void nfs_local_disable(struct nfs_client *clp)
 	spin_lock(&clp->cl_localio_lock);
 	if (test_and_clear_bit(NFS_CS_LOCAL_IO, &clp->cl_flags)) {
 		trace_nfs_local_disable(clp);
-		nfs_uuid_invalidate_one_client(&clp->cl_uuid);
+		nfs_localio_disable_client(&clp->cl_uuid);
 	}
 	spin_unlock(&clp->cl_localio_lock);
 }
diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
index a74ec08f6c96..904439e4bb85 100644
--- a/fs/nfs_common/nfslocalio.c
+++ b/fs/nfs_common/nfslocalio.c
@@ -107,7 +107,7 @@ static void nfs_uuid_put_locked(nfs_uuid_t *nfs_uuid)
 	list_del_init(&nfs_uuid->list);
 }
 
-void nfs_uuid_invalidate_clients(struct list_head *list)
+void nfs_localio_invalidate_clients(struct list_head *list)
 {
 	nfs_uuid_t *nfs_uuid, *tmp;
 
@@ -116,9 +116,9 @@ void nfs_uuid_invalidate_clients(struct list_head *list)
 		nfs_uuid_put_locked(nfs_uuid);
 	spin_unlock(&nfs_uuid_lock);
 }
-EXPORT_SYMBOL_GPL(nfs_uuid_invalidate_clients);
+EXPORT_SYMBOL_GPL(nfs_localio_invalidate_clients);
 
-void nfs_uuid_invalidate_one_client(nfs_uuid_t *nfs_uuid)
+void nfs_localio_disable_client(nfs_uuid_t *nfs_uuid)
 {
 	if (nfs_uuid->net) {
 		spin_lock(&nfs_uuid_lock);
@@ -126,7 +126,7 @@ void nfs_uuid_invalidate_one_client(nfs_uuid_t *nfs_uuid)
 		spin_unlock(&nfs_uuid_lock);
 	}
 }
-EXPORT_SYMBOL_GPL(nfs_uuid_invalidate_one_client);
+EXPORT_SYMBOL_GPL(nfs_localio_disable_client);
 
 struct nfsd_file *nfs_open_local_fh(nfs_uuid_t *uuid,
 		   struct rpc_clnt *rpc_clnt, const struct cred *cred,
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 3adbc05ebaac..727904d8a4d0 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -2276,14 +2276,14 @@ static __net_init int nfsd_net_init(struct net *net)
  * nfsd_net_pre_exit - Disconnect localio clients from net namespace
  * @net: a network namespace that is about to be destroyed
  *
- * This invalidated ->net pointers held by localio clients
+ * This invalidates ->net pointers held by localio clients
  * while they can still safely access nn->counter.
  */
 static __net_exit void nfsd_net_pre_exit(struct net *net)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
-	nfs_uuid_invalidate_clients(&nn->local_clients);
+	nfs_localio_invalidate_clients(&nn->local_clients);
 }
 #endif
 
diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
index ab6a2a53f505..a05d1043f2b0 100644
--- a/include/linux/nfslocalio.h
+++ b/include/linux/nfslocalio.h
@@ -37,8 +37,9 @@ bool nfs_uuid_begin(nfs_uuid_t *);
 void nfs_uuid_end(nfs_uuid_t *);
 void nfs_uuid_is_local(const uuid_t *, struct list_head *,
 		       struct net *, struct auth_domain *, struct module *);
-void nfs_uuid_invalidate_clients(struct list_head *list);
-void nfs_uuid_invalidate_one_client(nfs_uuid_t *nfs_uuid);
+
+void nfs_localio_disable_client(nfs_uuid_t *nfs_uuid);
+void nfs_localio_invalidate_clients(struct list_head *list);
 
 /* localio needs to map filehandle -> struct nfsd_file */
 extern struct nfsd_file *
-- 
2.44.0


