Return-Path: <linux-nfs+bounces-4556-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F328924399
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 18:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 874C8B25B9E
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 16:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA431BD503;
	Tue,  2 Jul 2024 16:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fqYi3tm0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E501BD4E0
	for <linux-nfs@vger.kernel.org>; Tue,  2 Jul 2024 16:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719937738; cv=none; b=ElNL/A3jvGbzR5XPEKrKvAXyntlc63c8h0/fKxLHGfezKTFBlt3M1TtlYPlMxyPTq9sdJ15LM3GjxycOLQIGO1gUiC4ODVGusIOynup8/Lf0cxTVbELjD+OAn6z6NUVr1fhtli/roLrx78aZugMIPSgJYP0clpkI8z7QuOrF0nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719937738; c=relaxed/simple;
	bh=Yo/3GGBy1+3TBEEiYho6yJdr64seyxSJ8HnlnAy7PX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pVAnL1YpP2ANe5kieo9E2kivI4q9g8jsnL7LwtPJWKieFFcYWN5mPG6XA02W8O0XOXLKhIMMY/CvOIgtvO6SONbxjVMurBNTCo6Cpxb4+zciKL+OW/+kHZybPs2NXNSlCo98ZYz6hbjAsWDD/80w4E97NK79hRWFN8WuF3FBNVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fqYi3tm0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC47BC116B1;
	Tue,  2 Jul 2024 16:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719937737;
	bh=Yo/3GGBy1+3TBEEiYho6yJdr64seyxSJ8HnlnAy7PX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fqYi3tm0LgbbKs6YZk8EEWwe5v1zRDGxzwDbBM4H4FMQNjTuReUQHlEJo8pyRnjyn
	 gyEkXN1LEj12QhlKTt7uxBW6P4O9JzjPp/Kg8ghQGgg0rKSCQ3Fna3h0Xi8UvKto7A
	 EZSsy5S7slyzmuFjvv7wgcvD8Px4KMvlEBpVqwIiBAFHP9qAfy1HmDL56UwwEQM01o
	 b5j8x1+4Jc0ROvVg/0viBjT4DTnT3Wzw3SuI8imJy7HCFwavtBY5kiNBjUfHMSJ6tJ
	 oak0N2N9bk8Gg6RN+iIcu8DeYBfswYwWnHvn++7e43nnu4JIU9q2CpQ1F4HSncpKCt
	 byCkgnM1rXSsQ==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [PATCH v11 19/20] nfs: implement client support for NFS_LOCALIO_PROGRAM
Date: Tue,  2 Jul 2024 12:28:30 -0400
Message-ID: <20240702162831.91604-20-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240702162831.91604-1-snitzer@kernel.org>
References: <20240702162831.91604-1-snitzer@kernel.org>
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
 fs/nfs/client.c  |   6 +-
 fs/nfs/localio.c | 153 +++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 152 insertions(+), 7 deletions(-)

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
index 7039a181ff89..08d8f661ebe9 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -15,6 +15,7 @@
 #include <linux/sunrpc/addr.h>
 #include <linux/inetdevice.h>
 #include <net/addrconf.h>
+#include <linux/nfslocalio.h>
 #include <linux/module.h>
 #include <linux/bvec.h>
 
@@ -124,18 +125,76 @@ nfs4errno(int errno)
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
@@ -151,15 +210,98 @@ void nfs_local_disable(struct nfs_client *clp)
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
 
@@ -184,7 +326,8 @@ nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
 		trace_nfs_local_open_fh(fh, mode, status);
 		switch (status) {
 		case -ENXIO:
-			nfs_local_disable(clp);
+			/* Revalidate localio, will disable if unsupported */
+			nfs_local_probe(clp);
 			fallthrough;
 		case -ETIMEDOUT:
 			status = -EAGAIN;
-- 
2.44.0


