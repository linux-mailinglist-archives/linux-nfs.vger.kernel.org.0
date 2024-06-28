Return-Path: <linux-nfs+bounces-4395-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B4391C7DF
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Jun 2024 23:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BCDE28719F
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Jun 2024 21:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF17D7FBA8;
	Fri, 28 Jun 2024 21:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxG89rfr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF487FBA2
	for <linux-nfs@vger.kernel.org>; Fri, 28 Jun 2024 21:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719609084; cv=none; b=oq0L/mFeuZ6nGjans0/CdA/WQiD1C6dU07d8WEB7goEla6K72yJRzqs/OzBImQYAcsgf95iXFk98+Ilc+mUKzcW0d6ZWaHg8vgcAc3ctUZBl7z6Dz2BDmSo4hUDOwhTrUMS3wPbrsrX66VPNMTdOEnyTpAElIyxGpZajPoo3iKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719609084; c=relaxed/simple;
	bh=uQxzvgXWV9QyPzza7L6vAGGY4JCn4v665HoYQ0VQc6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YSpr9j7S8QSwvLI12t1aDKy4Wgg3t56oEn+R3gqBIOC/vMlt++DsBwXelhUkk14H3G/pKFcffQB57Mfdq8h8Wea4XBPZdJorLfFmbxErtigIY3KYruySrQNnIlxE2667aIUxikQaq+5pfsraU0AvhiaR7fHSg8xJGPgMElxWtYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxG89rfr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2B63C116B1;
	Fri, 28 Jun 2024 21:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719609084;
	bh=uQxzvgXWV9QyPzza7L6vAGGY4JCn4v665HoYQ0VQc6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bxG89rfrVYOz8f6E1ArAEayiutBbUgoPHakqBOx3/O9Zjo122P+DyrB8vqHJLytPR
	 SC3UUbZC5nxHp+QbKnr43Lz5kne6CESbs/xOdJ5OnMBLSlOJLPyzEkA9D2LB6T/rnk
	 W2HF8xG6lvMOKnOh45Q+VxNrmPKTTzH+7sA5DBoz6Eru2ltjVZrhSzXHOKkBZj+E1+
	 PeFXpHBLoHOlsCgdxpPlFJZkQ8A3H7NedxS8pUEOzIHWfZB3f6B3reC0pZyr9dOl3L
	 CKqZxCFXDv8O1eDiDMn1Lwyv2aDjpO+dC9HaeBhRELLNj+Q6QwfUjZ8a1Hk2ORyi+I
	 e1qWrbluAkQtw==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [PATCH v9 12/19] nfs: implement client support for NFS_LOCALIO_PROGRAM
Date: Fri, 28 Jun 2024 17:10:58 -0400
Message-ID: <20240628211105.54736-13-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240628211105.54736-1-snitzer@kernel.org>
References: <20240628211105.54736-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LOCALIOPROC_GETUUID allows a client to discover the server's uuid.

nfs_local_probe() will retrieve server's uuid via LOCALIO protocol and
verify the server with that uuid it is known to be local. This ensures
client and server 1: support localio 2: are local to each other.

All the knowledge of the LOCALIO RPC protocol is in fs/nfs/localio.c
which implements just a single version (1) that is used independently
of what NFS version is used.

Get nfsd_open_local_fh and store it in rpc_client during client
creation, put the symbol during nfs_local_disable -- which is also
called during client destruction.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
[neilb: factored out and simplified single localio protocol]
Co-developed-by: NeilBrown <neil@brown.name>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfs/client.c     |   6 +-
 fs/nfs/localio.c    | 153 ++++++++++++++++++++++++++++++++++++++++++--
 include/linux/nfs.h |   7 ++
 3 files changed, 159 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 1300c388f971..6faa9fdc444d 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -434,8 +434,10 @@ struct nfs_client *nfs_get_client(const struct nfs_client_initdata *cl_init)
 			list_add_tail(&new->cl_share_link,
 					&nn->nfs_client_list);
 			spin_unlock(&nn->nfs_client_lock);
-			nfs_local_probe(new);
-			return rpc_ops->init_client(new, cl_init);
+			new = rpc_ops->init_client(new, cl_init);
+			if (!IS_ERR(new))
+				 nfs_local_probe(new);
+			return new;
 		}
 
 		spin_unlock(&nn->nfs_client_lock);
diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index fe96f05ba8ca..1f583891f92b 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -15,6 +15,7 @@
 #include <linux/sunrpc/addr.h>
 #include <linux/inetdevice.h>
 #include <net/addrconf.h>
+#include <linux/nfslocalio.h>
 #include <linux/module.h>
 #include <linux/bvec.h>
 
@@ -117,18 +118,76 @@ nfs4errno(int errno)
 static bool localio_enabled __read_mostly = true;
 module_param(localio_enabled, bool, 0644);
 
+static inline bool nfs_client_is_local(const struct nfs_client *clp)
+{
+	return !!test_bit(NFS_CS_LOCAL_IO, &clp->cl_flags);
+}
+
 bool nfs_server_is_local(const struct nfs_client *clp)
 {
-	return test_bit(NFS_CS_LOCAL_IO, &clp->cl_flags) != 0 &&
-		localio_enabled;
+	return nfs_client_is_local(clp) && localio_enabled;
 }
 EXPORT_SYMBOL_GPL(nfs_server_is_local);
 
+/*
+ * GETUUID XDR functions
+ */
+
+static void localio_xdr_enc_getuuidargs(struct rpc_rqst *req,
+					struct xdr_stream *xdr,
+					const void *data)
+{
+	/* void function */
+}
+
+static int localio_xdr_dec_getuuidres(struct rpc_rqst *req,
+				      struct xdr_stream *xdr,
+				      void *result)
+{
+	u8 *uuid = result;
+
+	return decode_opaque_fixed(xdr, uuid, UUID_SIZE);
+}
+
+static const struct rpc_procinfo nfs_localio_procedures[] = {
+	[LOCALIOPROC_GETUUID] = {
+		.p_proc = LOCALIOPROC_GETUUID,
+		.p_encode = localio_xdr_enc_getuuidargs,
+		.p_decode = localio_xdr_dec_getuuidres,
+		.p_arglen = 0,
+		.p_replen = XDR_QUADLEN(UUID_SIZE),
+		.p_statidx = LOCALIOPROC_GETUUID,
+		.p_name = "GETUUID",
+	},
+};
+
+static unsigned int nfs_localio_counts[ARRAY_SIZE(nfs_localio_procedures)];
+const struct rpc_version nfslocalio_version1 = {
+	.number			= 1,
+	.nrprocs		= ARRAY_SIZE(nfs_localio_procedures),
+	.procs			= nfs_localio_procedures,
+	.counts			= nfs_localio_counts,
+};
+
+static const struct rpc_version *nfslocalio_version[] = {
+       [1]			= &nfslocalio_version1,
+};
+
+extern const struct rpc_program nfslocalio_program;
+static struct rpc_stat		nfslocalio_rpcstat = { &nfslocalio_program };
+
+const struct rpc_program nfslocalio_program = {
+	.name			= "nfslocalio",
+	.number			= NFS_LOCALIO_PROGRAM,
+	.nrvers			= ARRAY_SIZE(nfslocalio_version),
+	.version		= nfslocalio_version,
+	.stats			= &nfslocalio_rpcstat,
+};
+
 /*
  * nfs_local_enable - enable local i/o for an nfs_client
  */
-static __maybe_unused void nfs_local_enable(struct nfs_client *clp,
-					    struct net *net)
+static void nfs_local_enable(struct nfs_client *clp, struct net *net)
 {
 	if (READ_ONCE(clp->nfsd_open_local_fh)) {
 		set_bit(NFS_CS_LOCAL_IO, &clp->cl_flags);
@@ -144,15 +203,98 @@ void nfs_local_disable(struct nfs_client *clp)
 {
 	if (test_and_clear_bit(NFS_CS_LOCAL_IO, &clp->cl_flags)) {
 		trace_nfs_local_disable(clp);
+		put_nfsd_open_local_fh();
+		clp->nfsd_open_local_fh = NULL;
+		if (!IS_ERR(clp->cl_rpcclient_localio)) {
+			rpc_shutdown_client(clp->cl_rpcclient_localio);
+			clp->cl_rpcclient_localio = ERR_PTR(-EINVAL);
+		}
 		clp->cl_nfssvc_net = NULL;
 	}
 }
 
+/*
+ * nfs_init_localioclient - Initialise an NFS localio client connection
+ */
+static void nfs_init_localioclient(struct nfs_client *clp)
+{
+	if (unlikely(!IS_ERR(clp->cl_rpcclient_localio)))
+		goto out;
+	clp->cl_rpcclient_localio = rpc_bind_new_program(clp->cl_rpcclient,
+							 &nfslocalio_program, 1);
+	if (IS_ERR(clp->cl_rpcclient_localio))
+		goto out;
+	/* No errors! Assume that localio is supported */
+	clp->nfsd_open_local_fh = get_nfsd_open_local_fh();
+	if (!clp->nfsd_open_local_fh) {
+		rpc_shutdown_client(clp->cl_rpcclient_localio);
+		clp->cl_rpcclient_localio = ERR_PTR(-EINVAL);
+	}
+out:
+	dprintk_rcu("%s: server (%s) %s NFS LOCALIO, nfsd_open_local_fh is %s.\n",
+		__func__, rpc_peeraddr2str(clp->cl_rpcclient, RPC_DISPLAY_ADDR),
+		(IS_ERR(clp->cl_rpcclient_localio) ? "does not support" : "supports"),
+		(clp->nfsd_open_local_fh ? "set" : "not set"));
+}
+
+static bool nfs_local_server_getuuid(struct nfs_client *clp, uuid_t *nfsd_uuid)
+{
+	u8 uuid[UUID_SIZE];
+	struct rpc_message msg = {
+		.rpc_resp = &uuid,
+	};
+	int status;
+
+	nfs_init_localioclient(clp);
+	if (IS_ERR(clp->cl_rpcclient_localio))
+		return false;
+
+	msg.rpc_proc = &nfs_localio_procedures[LOCALIOPROC_GETUUID];
+	status = rpc_call_sync(clp->cl_rpcclient_localio, &msg, 0);
+	dprintk("%s: NFS reply getuuid: status=%d uuid=%pU\n",
+		__func__, status, uuid);
+	if (status)
+		return false;
+
+	import_uuid(nfsd_uuid, uuid);
+
+	return true;
+}
+
 /*
  * nfs_local_probe - probe local i/o support for an nfs_server and nfs_client
+ * - called after alloc_client and init_client (so cl_rpcclient exists)
+ * - this function is idempotent, it can be called for old or new clients
  */
 void nfs_local_probe(struct nfs_client *clp)
 {
+	uuid_t uuid;
+	struct net *net = NULL;
+
+	if (!localio_enabled || clp->cl_rpcclient->cl_vers == 2)
+		goto unsupported;
+
+	if (nfs_client_is_local(clp)) {
+		/* If already enabled, disable and re-enable */
+		nfs_local_disable(clp);
+	}
+
+	/*
+	 * Retrieve server's uuid via LOCALIO protocol and verify the
+	 * server with that uuid is known to be local. This ensures
+	 * client and server 1: support localio 2: are local to each other
+	 * by verifying client's nfsd, with specified uuid, is local.
+	 */
+	if (!nfs_local_server_getuuid(clp, &uuid) ||
+	    !nfsd_uuid_is_local(&uuid, &net))
+		goto unsupported;
+
+	nfs_local_enable(clp, net);
+	return;
+
+unsupported:
+	/* localio not supported */
+	nfs_local_disable(clp);
 }
 EXPORT_SYMBOL_GPL(nfs_local_probe);
 
@@ -177,7 +319,8 @@ nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
 		trace_nfs_local_open_fh(fh, mode, status);
 		switch (status) {
 		case -ENXIO:
-			nfs_local_disable(clp);
+			/* Revalidate localio, will disable if unsupported */
+			nfs_local_probe(clp);
 			fallthrough;
 		case -ETIMEDOUT:
 			status = -EAGAIN;
diff --git a/include/linux/nfs.h b/include/linux/nfs.h
index 64ed672a0b34..036f6b0ed94d 100644
--- a/include/linux/nfs.h
+++ b/include/linux/nfs.h
@@ -15,6 +15,13 @@
 #include <linux/crc32.h>
 #include <uapi/linux/nfs.h>
 
+/* The localio program is entirely private to Linux and is
+ * NOT part of the uapi.
+ */
+#define NFS_LOCALIO_PROGRAM	400122
+#define LOCALIOPROC_NULL	0
+#define LOCALIOPROC_GETUUID	1
+
 /*
  * This is the kernel NFS client file handle representation
  */
-- 
2.44.0


