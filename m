Return-Path: <linux-nfs+bounces-7964-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A38049C81A3
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Nov 2024 05:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61F3A2842F9
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Nov 2024 04:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455401E8857;
	Thu, 14 Nov 2024 04:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxfUi5aa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FE11E8836
	for <linux-nfs@vger.kernel.org>; Thu, 14 Nov 2024 04:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731556811; cv=none; b=QRpUmjZjFuZ97+Q/2w3QHHHjWXkxbnHArNpWgFbxCge7zazVe82ueSJy4+iHOxYYAO34tvxpCvhLDIGCXdVEl6bTP1Uss1w908am8UuvDzLliIUooSrObRdULclcRwoXxDoGdL3V5U3Jlrx357Cggrk/LV/1QksFJ89FMyy+uLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731556811; c=relaxed/simple;
	bh=3C3Xq0hxZ36iLjeQuzA/kkrrmPX01XR3AlW+rrMmhbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WGOkxIRhngUKKf0st4xeWdxidNvr7/TfmkCnu4SmYXFM0VMvbO5OeH2vivpKpKxLUlzituUQm2aUnuES4v07o2M+TA+HwzFEYHdiXFl6Q6XDqX1eiBz9AgClbXvF9GBOjgLW+LLsx6Va+439LLRwM3LX88/VjJ6niJR9fQQADrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxfUi5aa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3A7AC4CED0;
	Thu, 14 Nov 2024 04:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731556811;
	bh=3C3Xq0hxZ36iLjeQuzA/kkrrmPX01XR3AlW+rrMmhbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bxfUi5aaDMkJzCyfz04WYk8gZZnF3iS9OQzksWoCf7nWcp/h4KkZxmIru8h4+6QsE
	 NP5utygvfoik4FVYKDFEyQRUe2Lne1gMNYByMbUUXYTE5jiw46xSBjlbSXTDx2fV4k
	 rFJrYftNarCfiwfWBR+CG3ulqHaR6UsmMG0JWMOS3355dV2buEjt5aMOTiVi4xjvYQ
	 AxnmJAM6DORQWN5ePzwfZxZaVtherVAK7M9fCyl4L+XDWPqhTiZWssDFA3gd81fRot
	 M6/5v/glNrOMAwnO9Md+E8giPnQHVZ5OkGonPIAX92dHA1RJ1Vsb39LuxsvMQEj2xt
	 4pPF3bZ15fnzQ==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@suse.de>
Subject: [for-6.13 PATCH v2 13/15] nfs/localio: remove redundant code and simplify LOCALIO enablement
Date: Wed, 13 Nov 2024 22:59:50 -0500
Message-ID: <20241114035952.13889-14-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241114035952.13889-1-snitzer@kernel.org>
References: <20241114035952.13889-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove nfs_local_enable and nfs_local_disable, instead use
nfs_localio_enable_client and nfs_localio_disable_client.

Discontinue use of the NFS_CS_LOCAL_IO bit in the nfs_client struct's
cl_flags to reflect that LOCALIO is enabled; instead just test if the
net member of the nfs_uuid_t struct is set.

Also remove trace_nfs_local_enable and trace_nfs_local_disable,
comparable traces are available from nfs_localio.ko.

Suggested-by: NeilBrown <neilb@suse.de>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/client.c            |  2 +-
 fs/nfs/internal.h          |  2 --
 fs/nfs/localio.c           | 28 +++++-----------------------
 fs/nfs/nfstrace.h          | 32 --------------------------------
 fs/nfs_common/nfslocalio.c | 34 +++++++++++-----------------------
 5 files changed, 17 insertions(+), 81 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index e83e1ce046130..a657318fede46 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -243,7 +243,7 @@ static void pnfs_init_server(struct nfs_server *server)
  */
 void nfs_free_client(struct nfs_client *clp)
 {
-	nfs_local_disable(clp);
+	nfs_localio_disable_client(clp);
 
 	/* -EIO all pending I/O */
 	if (!IS_ERR(clp->cl_rpcclient))
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 57af3ab3adbe5..a252191b9335c 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -454,7 +454,6 @@ extern int nfs_wait_bit_killable(struct wait_bit_key *key, int mode);
 
 #if IS_ENABLED(CONFIG_NFS_LOCALIO)
 /* localio.c */
-extern void nfs_local_disable(struct nfs_client *);
 extern void nfs_local_probe(struct nfs_client *);
 extern struct nfsd_file *nfs_local_open_fh(struct nfs_client *,
 					   const struct cred *,
@@ -471,7 +470,6 @@ extern int nfs_local_commit(struct nfsd_file *,
 extern bool nfs_server_is_local(const struct nfs_client *clp);
 
 #else /* CONFIG_NFS_LOCALIO */
-static inline void nfs_local_disable(struct nfs_client *clp) {}
 static inline void nfs_local_probe(struct nfs_client *clp) {}
 static inline struct nfsd_file *
 nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 7e432057c3a1f..4b6bf4ea7d7fc 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -56,7 +56,7 @@ MODULE_PARM_DESC(localio_O_DIRECT_semantics,
 
 static inline bool nfs_client_is_local(const struct nfs_client *clp)
 {
-	return !!test_bit(NFS_CS_LOCAL_IO, &clp->cl_flags);
+	return !!rcu_access_pointer(clp->cl_uuid.net);
 }
 
 bool nfs_server_is_local(const struct nfs_client *clp)
@@ -121,24 +121,6 @@ const struct rpc_program nfslocalio_program = {
 	.stats			= &nfslocalio_rpcstat,
 };
 
-/*
- * nfs_local_enable - enable local i/o for an nfs_client
- */
-static void nfs_local_enable(struct nfs_client *clp)
-{
-	trace_nfs_local_enable(clp);
-	nfs_localio_enable_client(clp);
-}
-
-/*
- * nfs_local_disable - disable local i/o for an nfs_client
- */
-void nfs_local_disable(struct nfs_client *clp)
-{
-	trace_nfs_local_disable(clp);
-	nfs_localio_disable_client(clp);
-}
-
 /*
  * nfs_init_localioclient - Initialise an NFS localio client connection
  */
@@ -194,19 +176,19 @@ void nfs_local_probe(struct nfs_client *clp)
 	/* Disallow localio if disabled via sysfs or AUTH_SYS isn't used */
 	if (!localio_enabled ||
 	    clp->cl_rpcclient->cl_auth->au_flavor != RPC_AUTH_UNIX) {
-		nfs_local_disable(clp);
+		nfs_localio_disable_client(clp);
 		return;
 	}
 
 	if (nfs_client_is_local(clp)) {
 		/* If already enabled, disable and re-enable */
-		nfs_local_disable(clp);
+		nfs_localio_disable_client(clp);
 	}
 
 	if (!nfs_uuid_begin(&clp->cl_uuid))
 		return;
 	if (nfs_server_uuid_is_local(clp))
-		nfs_local_enable(clp);
+		nfs_localio_enable_client(clp);
 	nfs_uuid_end(&clp->cl_uuid);
 }
 EXPORT_SYMBOL_GPL(nfs_local_probe);
@@ -748,7 +730,7 @@ int nfs_local_doio(struct nfs_client *clp, struct nfsd_file *localio,
 
 	if (status != 0) {
 		if (status == -EAGAIN)
-			nfs_local_disable(clp);
+			nfs_localio_disable_client(clp);
 		nfs_local_file_put(localio);
 		hdr->task.tk_status = status;
 		nfs_local_hdr_release(hdr, call_ops);
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 1eab98c277fab..7a058bd8c566e 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -1714,38 +1714,6 @@ TRACE_EVENT(nfs_local_open_fh,
 		)
 );
 
-DECLARE_EVENT_CLASS(nfs_local_client_event,
-		TP_PROTO(
-			const struct nfs_client *clp
-		),
-
-		TP_ARGS(clp),
-
-		TP_STRUCT__entry(
-			__field(unsigned int, protocol)
-			__string(server, clp->cl_hostname)
-		),
-
-		TP_fast_assign(
-			__entry->protocol = clp->rpc_ops->version;
-			__assign_str(server);
-		),
-
-		TP_printk(
-			"server=%s NFSv%u", __get_str(server), __entry->protocol
-		)
-);
-
-#define DEFINE_NFS_LOCAL_CLIENT_EVENT(name) \
-	DEFINE_EVENT(nfs_local_client_event, name, \
-			TP_PROTO( \
-				const struct nfs_client *clp \
-			), \
-			TP_ARGS(clp))
-
-DEFINE_NFS_LOCAL_CLIENT_EVENT(nfs_local_enable);
-DEFINE_NFS_LOCAL_CLIENT_EVENT(nfs_local_disable);
-
 DECLARE_EVENT_CLASS(nfs_xdr_event,
 		TP_PROTO(
 			const struct xdr_stream *xdr,
diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
index 4e4991e059413..0a26c0ca99c21 100644
--- a/fs/nfs_common/nfslocalio.c
+++ b/fs/nfs_common/nfslocalio.c
@@ -37,7 +37,7 @@ static LIST_HEAD(nfs_uuids);
 
 void nfs_uuid_init(nfs_uuid_t *nfs_uuid)
 {
-	nfs_uuid->net = NULL;
+	RCU_INIT_POINTER(nfs_uuid->net, NULL);
 	nfs_uuid->dom = NULL;
 	nfs_uuid->list_lock = NULL;
 	INIT_LIST_HEAD(&nfs_uuid->list);
@@ -49,7 +49,7 @@ EXPORT_SYMBOL_GPL(nfs_uuid_init);
 bool nfs_uuid_begin(nfs_uuid_t *nfs_uuid)
 {
 	spin_lock(&nfs_uuid->lock);
-	if (nfs_uuid->net) {
+	if (rcu_access_pointer(nfs_uuid->net)) {
 		/* This nfs_uuid is already in use */
 		spin_unlock(&nfs_uuid->lock);
 		return false;
@@ -74,9 +74,9 @@ EXPORT_SYMBOL_GPL(nfs_uuid_begin);
 
 void nfs_uuid_end(nfs_uuid_t *nfs_uuid)
 {
-	if (nfs_uuid->net == NULL) {
+	if (!rcu_access_pointer(nfs_uuid->net)) {
 		spin_lock(&nfs_uuid->lock);
-		if (nfs_uuid->net == NULL) {
+		if (!rcu_access_pointer(nfs_uuid->net)) {
 			/* Not local, remove from nfs_uuids */
 			spin_lock(&nfs_uuids_lock);
 			list_del_init(&nfs_uuid->list);
@@ -139,12 +139,8 @@ EXPORT_SYMBOL_GPL(nfs_uuid_is_local);
 
 void nfs_localio_enable_client(struct nfs_client *clp)
 {
-	nfs_uuid_t *nfs_uuid = &clp->cl_uuid;
-
-	spin_lock(&nfs_uuid->lock);
-	set_bit(NFS_CS_LOCAL_IO, &clp->cl_flags);
+	/* nfs_uuid_is_local() does the actual enablement */
 	trace_nfs_localio_enable_client(clp);
-	spin_unlock(&nfs_uuid->lock);
 }
 EXPORT_SYMBOL_GPL(nfs_localio_enable_client);
 
@@ -152,15 +148,15 @@ EXPORT_SYMBOL_GPL(nfs_localio_enable_client);
  * Cleanup the nfs_uuid_t embedded in an nfs_client.
  * This is the long-form of nfs_uuid_init().
  */
-static void nfs_uuid_put(nfs_uuid_t *nfs_uuid)
+static bool nfs_uuid_put(nfs_uuid_t *nfs_uuid)
 {
 	LIST_HEAD(local_files);
 	struct nfs_file_localio *nfl, *tmp;
 
 	spin_lock(&nfs_uuid->lock);
-	if (unlikely(!nfs_uuid->net)) {
+	if (unlikely(!rcu_access_pointer(nfs_uuid->net))) {
 		spin_unlock(&nfs_uuid->lock);
-		return;
+		return false;
 	}
 	RCU_INIT_POINTER(nfs_uuid->net, NULL);
 
@@ -192,22 +188,14 @@ static void nfs_uuid_put(nfs_uuid_t *nfs_uuid)
 
 	module_put(nfsd_mod);
 	spin_unlock(&nfs_uuid->lock);
+
+	return true;
 }
 
 void nfs_localio_disable_client(struct nfs_client *clp)
 {
-	nfs_uuid_t *nfs_uuid = NULL;
-
-	spin_lock(&clp->cl_uuid.lock); /* aka &nfs_uuid->lock */
-	if (test_and_clear_bit(NFS_CS_LOCAL_IO, &clp->cl_flags)) {
-		/* &clp->cl_uuid is always not NULL, using as bool here */
-		nfs_uuid = &clp->cl_uuid;
+	if (nfs_uuid_put(&clp->cl_uuid))
 		trace_nfs_localio_disable_client(clp);
-	}
-	spin_unlock(&clp->cl_uuid.lock);
-
-	if (nfs_uuid)
-		nfs_uuid_put(nfs_uuid);
 }
 EXPORT_SYMBOL_GPL(nfs_localio_disable_client);
 
-- 
2.44.0


