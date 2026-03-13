Return-Path: <linux-nfs+bounces-20152-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBj3K7U8tGmDjQAAu9opvQ
	(envelope-from <linux-nfs+bounces-20152-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 17:35:01 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3913E287180
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 17:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DA9B31CEF10
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 16:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BB33C278E;
	Fri, 13 Mar 2026 16:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmApedj8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DFD39BFEC
	for <linux-nfs@vger.kernel.org>; Fri, 13 Mar 2026 16:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773419512; cv=none; b=c17y3qgqSRf3WhCHXJIUUY9hxTCTktEYtBkD8zCDP5LQXRcDmqybxEByDl2FHyoeN4xOz4+R+dZO9FwfJYqgbJvC/ZFxt3SkPlDYSzcgHl6Pd/Q096tWJ0G+AMwwrWIIlHJ5rkSFjxA2+JKfK0AnSbr5mEiPb+zeYqFtpuwC4Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773419512; c=relaxed/simple;
	bh=/2Ng1d8pwCanw97xTn3UFZdED6Fes+L5BXQ1TZ0pIvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QYlYDfIP2DheLWwPU1/Zuolq8Csumli2VQKUfHpLt6sOKM67YoO7nl1xkNKMFNm7p+qnh6QRPTk6E3Zh0fQpwLKY/K5PofmNY1DILAA0aSF2uUjfi/TQ2dtOY9BOUN4Rga8/qugE0RayziIfET+uSH/Q2cis93d1meXNga1vtgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmApedj8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17DC5C19425;
	Fri, 13 Mar 2026 16:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773419512;
	bh=/2Ng1d8pwCanw97xTn3UFZdED6Fes+L5BXQ1TZ0pIvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bmApedj8/B4QCii73XevDC0S4TpP56XYV6uOEyjzOxpd4oOOUgYbOsira2p7lroi8
	 dLnTpC3A3KO2w5rYx2Pnx/iaYYMaAh4o+uMftKjo8CtxxhT6Vl2g7GwSjWeeijcq/y
	 HqrvHAkZRjuUxMfeQ/Z2XTg/BNGVabtxWzbJOiV7dk8lcI05dEmW9ujbETvs5lccEp
	 3ScwCbQKMahJ59pQXb8mf4l5y4yiQQ1Rc6A5okaZs9djF1hLKxIGVORmOhhi0JYAEp
	 V+pCb30vwKgRdSsh1163m1OleneHrbEGBmZQM6gtAkmkqQq0IDgwNaMjEGxTmk6390
	 i5z8ntp8An06g==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>
Subject: [PATCH v7 2/2] NFSD: convert callback RPC program to per-net namespace
Date: Fri, 13 Mar 2026 12:31:48 -0400
Message-ID: <20260313163148.281676-3-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313163148.281676-1-cel@kernel.org>
References: <20260313163148.281676-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20152-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3913E287180
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Dai Ngo <dai.ngo@oracle.com>

The callback channel's rpc_program, rpc_version, rpc_stat,
and per-procedure counts are declared as file-scope statics in
nfs4callback.c, shared across all network namespaces.
Forechannel RPC statistics are already maintained per-netns
(via nfsd_svcstats in struct nfsd_net); the backchannel
has no such separation. When backchannel statistics are
eventually surfaced to userspace, the global counters would
expose cross-namespace data.

Allocate per-netns copies of these structures through a new
opaque struct nfsd_net_cb, managed by nfsd_net_cb_init()
and nfsd_net_cb_shutdown(). The struct definition is private
to nfs4callback.c; struct nfsd_net holds only a pointer.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/netns.h        |   3 ++
 fs/nfsd/nfs4callback.c | 111 ++++++++++++++++++++++++++++-------------
 fs/nfsd/nfsctl.c       |   5 ++
 fs/nfsd/state.h        |   9 ++++
 4 files changed, 94 insertions(+), 34 deletions(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 6ad3fe5d7e12..27da1a3edacb 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -25,6 +25,7 @@
 #define SESSION_HASH_SIZE	512
 
 struct cld_net;
+struct nfsd_net_cb;
 struct nfsd4_client_tracking_ops;
 
 enum {
@@ -228,6 +229,8 @@ struct nfsd_net {
 	struct list_head	local_clients;
 #endif
 	siphash_key_t		*fh_key;
+
+	struct nfsd_net_cb	*nfsd_cb;
 };
 
 /* Simple check to find out if a given net was properly initialized */
diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 74effafdd0dc..50827405468d 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1032,39 +1032,14 @@ static const struct rpc_procinfo nfs4_cb_procedures[] = {
 	PROC(CB_GETATTR,	COMPOUND,	cb_getattr,	cb_getattr),
 };
 
-static unsigned int nfs4_cb_counts[ARRAY_SIZE(nfs4_cb_procedures)];
-static const struct rpc_version nfs_cb_version4 = {
-/*
- * Note on the callback rpc program version number: despite language in rfc
- * 5661 section 18.36.3 requiring servers to use 4 in this field, the
- * official xdr descriptions for both 4.0 and 4.1 specify version 1, and
- * in practice that appears to be what implementations use.  The section
- * 18.36.3 language is expected to be fixed in an erratum.
- */
-	.number			= 1,
-	.nrprocs		= ARRAY_SIZE(nfs4_cb_procedures),
-	.procs			= nfs4_cb_procedures,
-	.counts			= nfs4_cb_counts,
-};
+#define NFS4_CB_PROGRAM	0x40000000
+#define NFS4_CB_VERSION	1
 
-static const struct rpc_version *nfs_cb_version[2] = {
-	[1] = &nfs_cb_version4,
-};
-
-static const struct rpc_program cb_program;
-
-static struct rpc_stat cb_stats = {
-	.program		= &cb_program
-};
-
-#define NFS4_CALLBACK 0x40000000
-static const struct rpc_program cb_program = {
-	.name			= "nfs4_cb",
-	.number			= NFS4_CALLBACK,
-	.nrvers			= ARRAY_SIZE(nfs_cb_version),
-	.version		= nfs_cb_version,
-	.stats			= &cb_stats,
-	.pipe_dir_name		= "nfsd4_cb",
+struct nfsd_net_cb {
+	struct rpc_version	version4;
+	const struct rpc_version *versions[NFS4_CB_VERSION + 1];
+	struct rpc_program	program;
+	struct rpc_stat		stat;
 };
 
 static int max_cb_time(struct net *net)
@@ -1140,6 +1115,7 @@ static const struct cred *get_backchannel_cred(struct nfs4_client *clp, struct r
 
 static int setup_callback_client(struct nfs4_client *clp, struct nfs4_cb_conn *conn, struct nfsd4_session *ses)
 {
+	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
 	int maxtime = max_cb_time(clp->net);
 	struct rpc_timeout	timeparms = {
 		.to_initval	= maxtime,
@@ -1152,14 +1128,14 @@ static int setup_callback_client(struct nfs4_client *clp, struct nfs4_cb_conn *c
 		.addrsize	= conn->cb_addrlen,
 		.saddress	= (struct sockaddr *) &conn->cb_saddr,
 		.timeout	= &timeparms,
-		.program	= &cb_program,
-		.version	= 1,
+		.version	= NFS4_CB_VERSION,
 		.flags		= (RPC_CLNT_CREATE_NOPING | RPC_CLNT_CREATE_QUIET),
 		.cred		= current_cred(),
 	};
 	struct rpc_clnt *client;
 	const struct cred *cred;
 
+	args.program = &nn->nfsd_cb->program;
 	if (clp->cl_minorversion == 0) {
 		if (!clp->cl_cred.cr_principal &&
 		    (clp->cl_cred.cr_flavor >= RPC_AUTH_GSS_KRB5)) {
@@ -1786,3 +1762,70 @@ bool nfsd4_run_cb(struct nfsd4_callback *cb)
 		nfsd41_cb_inflight_end(clp);
 	return queued;
 }
+
+/**
+ * nfsd_net_cb_shutdown - release per-netns callback RPC program resources
+ * @nn: NFS server network namespace
+ *
+ * Frees resources allocated by nfsd_net_cb_init().
+ */
+void nfsd_net_cb_shutdown(struct nfsd_net *nn)
+{
+	struct nfsd_net_cb *cb = nn->nfsd_cb;
+
+	if (cb) {
+		kfree(cb->version4.counts);
+		kfree(cb);
+		nn->nfsd_cb = NULL;
+	}
+}
+
+/**
+ * nfsd_net_cb_init - initialize per-netns callback RPC program
+ * @nn: NFS server network namespace
+ *
+ * Sets up the callback RPC program, version table, procedure
+ * counts, and statistics structure for @nn. Caller must release
+ * these resources using nfsd_net_cb_shutdown().
+ *
+ * Return: 0 on success, or -ENOMEM if allocation fails.
+ */
+int nfsd_net_cb_init(struct nfsd_net *nn)
+{
+	struct nfsd_net_cb *cb;
+
+	cb = kzalloc(sizeof(*cb), GFP_KERNEL);
+	if (!cb)
+		return -ENOMEM;
+
+	cb->version4.counts = kzalloc_objs(unsigned int,
+			ARRAY_SIZE(nfs4_cb_procedures), GFP_KERNEL);
+	if (!cb->version4.counts) {
+		kfree(cb);
+		return -ENOMEM;
+	}
+	/*
+	 * Note on the callback rpc program version number: despite language
+	 * in rfc 5661 section 18.36.3 requiring servers to use 4 in this
+	 * field, the official xdr descriptions for both 4.0 and 4.1 specify
+	 * version 1, and in practice that appears to be what implementations
+	 * use. The section 18.36.3 language is expected to be fixed in an
+	 * erratum.
+	 */
+	cb->version4.number = NFS4_CB_VERSION;
+	cb->version4.nrprocs = ARRAY_SIZE(nfs4_cb_procedures);
+	cb->version4.procs = nfs4_cb_procedures;
+	cb->versions[NFS4_CB_VERSION] = &cb->version4;
+
+	cb->program.name = "nfs4_cb";
+	cb->program.number = NFS4_CB_PROGRAM;
+	cb->program.nrvers = ARRAY_SIZE(cb->versions);
+	cb->program.version = &cb->versions[0];
+	cb->program.pipe_dir_name = "nfsd4_cb";
+	cb->program.stats = &cb->stat;
+	cb->stat.program = &cb->program;
+
+	nn->nfsd_cb = cb;
+
+	return 0;
+}
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 14d9458aeff0..988a79ec4a79 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -2216,6 +2216,9 @@ static __net_init int nfsd_net_init(struct net *net)
 	int retval;
 	int i;
 
+	retval = nfsd_net_cb_init(nn);
+	if (retval)
+		return retval;
 	retval = nfsd_export_init(net);
 	if (retval)
 		goto out_export_error;
@@ -2256,6 +2259,7 @@ static __net_init int nfsd_net_init(struct net *net)
 out_idmap_error:
 	nfsd_export_shutdown(net);
 out_export_error:
+	nfsd_net_cb_shutdown(nn);
 	return retval;
 }
 
@@ -2286,6 +2290,7 @@ static __net_exit void nfsd_net_exit(struct net *net)
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
 	kfree_sensitive(nn->fh_key);
+	nfsd_net_cb_shutdown(nn);
 	nfsd_proc_stat_shutdown(net);
 	percpu_counter_destroy_many(nn->counter, NFSD_STATS_COUNTERS_NUM);
 	nfsd_idmap_shutdown(net);
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 9b05462da4cc..953675eba5c3 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -862,6 +862,8 @@ struct nfsd_file *find_any_file(struct nfs4_file *f);
 #ifdef CONFIG_NFSD_V4
 void nfsd4_revoke_states(struct nfsd_net *nn, struct super_block *sb);
 void nfsd4_cancel_copy_by_sb(struct net *net, struct super_block *sb);
+int nfsd_net_cb_init(struct nfsd_net *nn);
+void nfsd_net_cb_shutdown(struct nfsd_net *nn);
 #else
 static inline void nfsd4_revoke_states(struct nfsd_net *nn, struct super_block *sb)
 {
@@ -869,6 +871,13 @@ static inline void nfsd4_revoke_states(struct nfsd_net *nn, struct super_block *
 static inline void nfsd4_cancel_copy_by_sb(struct net *net, struct super_block *sb)
 {
 }
+static inline int nfsd_net_cb_init(struct nfsd_net *nn)
+{
+	return 0;
+}
+static inline void nfsd_net_cb_shutdown(struct nfsd_net *nn)
+{
+}
 #endif
 
 /* grace period management */
-- 
2.53.0


