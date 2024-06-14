Return-Path: <linux-nfs+bounces-3810-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4DA908298
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2024 05:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 012D12841C5
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2024 03:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39D1262BE;
	Fri, 14 Jun 2024 03:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVUIXiod"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCC2ECC
	for <linux-nfs@vger.kernel.org>; Fri, 14 Jun 2024 03:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718336681; cv=none; b=CQt9MNn6Gn204aqucWqz7srivSgFyMLYh+lOW26BPhAT53bpiJJTD+opKZYLYcWiOKvFYIvUo0AQ5109YevwUy7ynJI9Rp/zgu2j/1Ao1YvZSd9b20sJ4qYdZMgT/Le5xjyfQD0z8PXELW4AOzm195frnwB1xrO1DciVOUeZzcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718336681; c=relaxed/simple;
	bh=MwJiLuLN5DLd1EUs+vDAWw+oUczIEBfH8nwIdbEReFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tW4KHm1v2l2IXrVseLYVJ+13GEYRHV+5+A7G+8jzMAq97u57bTel5lmsVFSdILIybBW4y2KWB6EsmL6WTFYEPscINUX+3/+/ZugY2cciuhwhCJ9Xo6e8aGDTRsQKI8E0jwDWqM9oQAKc68aRJbkR0ulX94Xkcum8CbETRZycO3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVUIXiod; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A22C2BBFC;
	Fri, 14 Jun 2024 03:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718336681;
	bh=MwJiLuLN5DLd1EUs+vDAWw+oUczIEBfH8nwIdbEReFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hVUIXiod0gacRE4W5GGwjziVobVpvlJCHhnwtYwH1U32hn6WCZ/ni3r7FwHpL8lAg
	 T5S4/R5nL2gHuxvKi+JT4/UFszunKC+iHvd1l4VDkkZpMN5l8SviL9MNfxlcXd2gQg
	 rxKdcpp8W0ju8bdYTxdOXQpUfyuJ/7pYMJN96LE7spM2GES11RUKZC6rMT/BjiqPR+
	 w264TJC6+ITQxYw2SVRG8/oYYDIu/ezdQS37IuVMQHMRoIvzK11jeBLJ76xDLY4pZq
	 vvH5Tv8CERcnea+b3rjqLTebMFULl/W0m3FuP0561jmUEqodm/vI9rt5xAhU3VuQn5
	 pvZKLy5FnDRXg==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [PATCH v3 10/18] nfs: implement v3 and v4 client support for NFS_LOCALIO_PROGRAM
Date: Thu, 13 Jun 2024 23:44:18 -0400
Message-ID: <20240614034426.31043-11-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240614034426.31043-1-snitzer@kernel.org>
References: <20240614034426.31043-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LOCALIOPROC_GETUUID allows client to discover server's uuid.

nfs_local_probe() will retrieve server's uuid via LOCALIO protocol and
verify the server with that uuid it is known to be local. This ensures
client and server 1: support localio 2: are local to each other.

While doing so, factor out nfs_init_localioclient() so it is used by
both nfs3client.c and nfs4client.c

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/client.c           |  8 ++--
 fs/nfs/internal.h         | 26 ++++++++++++
 fs/nfs/localio.c          | 87 +++++++++++++++++++++++++++++++++++----
 fs/nfs/nfs3_fs.h          |  1 +
 fs/nfs/nfs3client.c       | 25 +++++++++++
 fs/nfs/nfs3proc.c         |  3 ++
 fs/nfs/nfs3xdr.c          | 67 ++++++++++++++++++++++++++++++
 fs/nfs/nfs4_fs.h          |  2 +
 fs/nfs/nfs4client.c       | 23 +++++++++++
 fs/nfs/nfs4proc.c         |  3 ++
 fs/nfs/nfs4xdr.c          | 52 +++++++++++++++++++++++
 include/linux/nfs_fs_sb.h |  1 +
 include/linux/nfs_xdr.h   | 10 +++++
 include/uapi/linux/nfs.h  |  4 ++
 14 files changed, 300 insertions(+), 12 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 9170e6036fd2..7044b8b3b332 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -170,7 +170,7 @@ struct nfs_client *nfs_alloc_client(const struct nfs_client_initdata *cl_init)
 	}
 
 	INIT_LIST_HEAD(&clp->cl_superblocks);
-	clp->cl_rpcclient = ERR_PTR(-EINVAL);
+	clp->cl_rpcclient = clp->cl_rpcclient_localio = ERR_PTR(-EINVAL);
 
 	clp->cl_flags = cl_init->init_flags;
 	clp->cl_proto = cl_init->proto;
@@ -430,8 +430,10 @@ struct nfs_client *nfs_get_client(const struct nfs_client_initdata *cl_init)
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
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 29152dc4b11c..aed826cdb7a7 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -453,6 +453,32 @@ extern bool nfs_check_cache_invalid(struct inode *, unsigned long);
 extern int nfs_wait_bit_killable(struct wait_bit_key *key, int mode);
 
 #if IS_ENABLED(CONFIG_NFS_LOCALIO)
+/*
+ * Initialise an NFS localio client connection.
+ * Inlined here to allow nfs[34]client.c to share this code.
+ */
+static __always_inline void
+nfs_init_localioclient(struct nfs_client *clp,
+		       const struct rpc_program *program, u32 vers)
+{
+	bool supported = false;
+
+	if (unlikely(!IS_ERR(clp->cl_rpcclient_localio))) {
+		supported = true;
+		goto out;
+	}
+	clp->cl_rpcclient_localio = rpc_bind_new_program(clp->cl_rpcclient,
+							program, vers);
+	if (IS_ERR(clp->cl_rpcclient_localio))
+		goto out;
+	/* No errors! Assume that localio is supported */
+	supported = true;
+out:
+	dfprintk_rcu(CLIENT, "%s: server (%s) %s NFS v%u LOCALIO\n", __func__,
+		rpc_peeraddr2str(clp->cl_rpcclient_localio, RPC_DISPLAY_ADDR),
+		(supported ? "supports" : "does not support"), vers);
+}
+
 /* localio.c */
 extern void nfs_local_init(void);
 extern void nfs_local_disable(struct nfs_client *);
diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index d51bbdbece88..c6ad31afe6a1 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -15,6 +15,7 @@
 #include <linux/sunrpc/addr.h>
 #include <linux/inetdevice.h>
 #include <net/addrconf.h>
+#include <linux/nfslocalio.h>
 #include <linux/module.h>
 #include <linux/bvec.h>
 
@@ -145,10 +146,14 @@ static struct nfs_local_open_ctx __local_open_ctx __read_mostly;
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
 
@@ -225,19 +230,82 @@ nfs_local_disable(struct nfs_client *clp)
 	if (test_and_clear_bit(NFS_CS_LOCAL_IO, &clp->cl_flags)) {
 		trace_nfs_local_disable(clp);
 		nfs_local_put_lookup_ctx();
+		if (!IS_ERR(clp->cl_rpcclient_localio)) {
+			rpc_shutdown_client(clp->cl_rpcclient_localio);
+			clp->cl_rpcclient_localio = ERR_PTR(-EINVAL);
+		}
 	}
 }
 
+static bool nfs_local_server_getuuid(struct nfs_client *clp, uuid_t *nfsd_uuid)
+{
+	u8 uuid[UUID_SIZE];
+	struct nfs_getuuidres res = {
+		uuid,
+	};
+	struct rpc_message msg = {
+		.rpc_resp = &res,
+	};
+	int status;
+
+	clp->rpc_ops->init_localioclient(clp);
+	if (IS_ERR(clp->cl_rpcclient_localio))
+		return false;
+
+	dprintk("%s: NFS issuing getuuid\n", __func__);
+	msg.rpc_proc = &clp->cl_rpcclient_localio->cl_procinfo[LOCALIOPROC_GETUUID];
+	status = rpc_call_sync(clp->cl_rpcclient_localio, &msg, 0);
+	dprintk("%s: NFS reply getuuid: status=%d uuid=%pU\n",
+		__func__, status, res.uuid);
+	if (status)
+		return false;
+
+	import_uuid(nfsd_uuid, res.uuid);
+
+	return true;
+}
+
 /*
- * nfs_local_probe - probe local i/o support for an nfs_client
+ * nfs_local_probe - probe local i/o support for an nfs_server and nfs_client
+ * - called after alloc_client and init_client (so cl_rpcclient exists)
+ * - this function is idempotent, it can be called for old or new clients
  */
-void
-nfs_local_probe(struct nfs_client *clp)
+void nfs_local_probe(struct nfs_client *clp)
 {
-	bool enable = false;
+	uuid_t uuid;
 
-	if (enable)
-		nfs_local_enable(clp);
+	if (!localio_enabled)
+		goto unsupported;
+
+	if (nfs_client_is_local(clp)) {
+		/* If already enabled, disable and re-enable */
+		nfs_local_disable(clp);
+	}
+
+	switch (clp->cl_rpcclient->cl_vers) {
+	case 3:
+	case 4:
+		/*
+		 * Retrieve server's uuid via LOCALIO protocol and verify the
+		 * server with that uuid it is known to be local. This ensures
+		 * client and server 1: support localio 2: are local to each other
+		 * by verifying client's nfsd, with specified uuid, is local.
+		 */
+		if (!nfs_local_server_getuuid(clp, &uuid) ||
+		    !nfsd_uuid_is_local(&uuid, &net))
+			goto unsupported;
+		break;
+	default:
+		goto unsupported;
+	}
+
+	dprintk("%s: detected local server.\n", __func__);
+	nfs_local_enable(clp);
+	return;
+
+unsupported:
+	/* localio not supported */
+	nfs_local_disable(clp);
 }
 EXPORT_SYMBOL_GPL(nfs_local_probe);
 
@@ -264,7 +332,8 @@ nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
 		trace_nfs_local_open_fh(fh, mode, status);
 		switch (status) {
 		case -ENXIO:
-			nfs_local_disable(clp);
+			/* Revalidate localio, will disable if unsupported */
+			nfs_local_probe(clp);
 			fallthrough;
 		case -ETIMEDOUT:
 			status = -EAGAIN;
diff --git a/fs/nfs/nfs3_fs.h b/fs/nfs/nfs3_fs.h
index b333ea119ef5..efdf2b6519e9 100644
--- a/fs/nfs/nfs3_fs.h
+++ b/fs/nfs/nfs3_fs.h
@@ -30,6 +30,7 @@ static inline int nfs3_proc_setacls(struct inode *inode, struct posix_acl *acl,
 struct nfs_server *nfs3_create_server(struct fs_context *);
 struct nfs_server *nfs3_clone_server(struct nfs_server *, struct nfs_fh *,
 				     struct nfs_fattr *, rpc_authflavor_t);
+void nfs3_init_localioclient(struct nfs_client *);
 
 /* nfs3super.c */
 extern struct nfs_subversion nfs_v3;
diff --git a/fs/nfs/nfs3client.c b/fs/nfs/nfs3client.c
index b0c8a39c2bbd..123e7c1fd339 100644
--- a/fs/nfs/nfs3client.c
+++ b/fs/nfs/nfs3client.c
@@ -7,6 +7,8 @@
 #include "netns.h"
 #include "sysfs.h"
 
+#define NFSDBG_FACILITY		NFSDBG_CLIENT
+
 #ifdef CONFIG_NFS_V3_ACL
 static struct rpc_stat		nfsacl_rpcstat = { &nfsacl_program };
 static const struct rpc_version *nfsacl_version[] = {
@@ -130,3 +132,26 @@ struct nfs_client *nfs3_set_ds_client(struct nfs_server *mds_srv,
 	return clp;
 }
 EXPORT_SYMBOL_GPL(nfs3_set_ds_client);
+
+#if defined(CONFIG_NFS_V3_LOCALIO)
+static struct rpc_stat		nfslocalio_rpcstat = { &nfslocalio_program3 };
+static const struct rpc_version *nfslocalio_version[] = {
+	[3]			= &nfslocalio_version3,
+};
+
+const struct rpc_program nfslocalio_program3 = {
+	.name			= "nfslocalio",
+	.number			= NFS_LOCALIO_PROGRAM,
+	.nrvers			= ARRAY_SIZE(nfslocalio_version),
+	.version		= nfslocalio_version,
+	.stats			= &nfslocalio_rpcstat,
+};
+
+/*
+ * Initialise an NFSv3 localio client connection
+ */
+void nfs3_init_localioclient(struct nfs_client *clp)
+{
+	nfs_init_localioclient(clp, &nfslocalio_program3, 3);
+}
+#endif /* CONFIG_NFS_V3_LOCALIO */
diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index 74bda639a7cf..40b6e4d1e7be 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -1067,4 +1067,7 @@ const struct nfs_rpc_ops nfs_v3_clientops = {
 	.free_client	= nfs_free_client,
 	.create_server	= nfs3_create_server,
 	.clone_server	= nfs3_clone_server,
+#if defined(CONFIG_NFS_V3_LOCALIO)
+	.init_localioclient = nfs3_init_localioclient,
+#endif
 };
diff --git a/fs/nfs/nfs3xdr.c b/fs/nfs/nfs3xdr.c
index 60f032be805a..d2a17ecd12b8 100644
--- a/fs/nfs/nfs3xdr.c
+++ b/fs/nfs/nfs3xdr.c
@@ -2579,3 +2579,70 @@ const struct rpc_version nfsacl_version3 = {
 	.counts			= nfs3_acl_counts,
 };
 #endif  /* CONFIG_NFS_V3_ACL */
+
+#if defined(CONFIG_NFS_V3_LOCALIO)
+
+#define LOCALIO3_getuuidres_sz	(1+XDR_QUADLEN(UUID_SIZE))
+
+static void nfs3_xdr_enc_getuuidargs(struct rpc_rqst *req,
+				struct xdr_stream *xdr,
+				const void *data)
+{
+	/* void function */
+}
+
+// FIXME: factor out from fs/nfs/nfs4xdr.c
+static int decode_opaque_fixed(struct xdr_stream *xdr, void *buf, size_t len)
+{
+	ssize_t ret = xdr_stream_decode_opaque_fixed(xdr, buf, len);
+	if (unlikely(ret < 0))
+		return -EIO;
+	return 0;
+}
+
+static inline int nfs3_decode_getuuidresok(struct xdr_stream *xdr,
+					struct nfs_getuuidres *result)
+{
+	return decode_opaque_fixed(xdr, result->uuid, UUID_SIZE);
+}
+
+static int nfs3_xdr_dec_getuuidres(struct rpc_rqst *req,
+				struct xdr_stream *xdr,
+				void *result)
+{
+	enum nfs_stat status;
+	int error;
+
+	error = decode_nfsstat3(xdr, &status);
+	if (unlikely(error))
+		goto out;
+	if (status != NFS3_OK)
+		goto out_default;
+	error = nfs3_decode_getuuidresok(xdr, result);
+out:
+	return error;
+out_default:
+	return nfs3_stat_to_errno(status);
+}
+
+static const struct rpc_procinfo nfs3_localio_procedures[] = {
+	[LOCALIOPROC_GETUUID] = {
+		.p_proc = LOCALIOPROC_GETUUID,
+		.p_encode = nfs3_xdr_enc_getuuidargs,
+		.p_decode = nfs3_xdr_dec_getuuidres,
+		.p_arglen = 1,
+		.p_replen = LOCALIO3_getuuidres_sz,
+		.p_timer = 0,
+		.p_name = "GETUUID",
+	},
+};
+
+static unsigned int nfs3_localio_counts[ARRAY_SIZE(nfs3_localio_procedures)];
+const struct rpc_version nfslocalio_version3 = {
+	.number			= 3,
+	.nrprocs		= ARRAY_SIZE(nfs3_localio_procedures),
+	.procs			= nfs3_localio_procedures,
+	.counts			= nfs3_localio_counts,
+};
+
+#endif  /* CONFIG_NFS_V3_LOCALIO */
diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 7024230f0d1d..a0a41917dec2 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -538,6 +538,8 @@ extern int nfs4_proc_commit(struct file *dst, __u64 offset, __u32 count, struct
 extern const nfs4_stateid zero_stateid;
 extern const nfs4_stateid invalid_stateid;
 
+extern void nfs4_init_localioclient(struct nfs_client *);
+
 /* nfs4super.c */
 struct nfs_mount_info;
 extern struct nfs_subversion nfs_v4;
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 84573df5cf5a..d2f634aa1e1b 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -1384,3 +1384,26 @@ int nfs4_update_server(struct nfs_server *server, const char *hostname,
 
 	return nfs_probe_server(server, NFS_FH(d_inode(server->super->s_root)));
 }
+
+#if defined(CONFIG_NFS_V4_LOCALIO)
+static struct rpc_stat		nfslocalio_rpcstat = { &nfslocalio_program4 };
+static const struct rpc_version *nfslocalio_version[] = {
+	[4]			= &nfslocalio_version4,
+};
+
+const struct rpc_program nfslocalio_program4 = {
+	.name			= "nfslocalio",
+	.number			= NFS_LOCALIO_PROGRAM,
+	.nrvers			= ARRAY_SIZE(nfslocalio_version),
+	.version		= nfslocalio_version,
+	.stats			= &nfslocalio_rpcstat,
+};
+
+/*
+ * Initialise an NFSv4 localio client connection
+ */
+void nfs4_init_localioclient(struct nfs_client *clp)
+{
+	nfs_init_localioclient(clp, &nfslocalio_program4, 4);
+}
+#endif /* CONFIG_NFS_V4_LOCALIO */
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index c93c12063b3a..060bc8dbee61 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -10745,6 +10745,9 @@ const struct nfs_rpc_ops nfs_v4_clientops = {
 	.discover_trunking = nfs4_discover_trunking,
 	.enable_swap	= nfs4_enable_swap,
 	.disable_swap	= nfs4_disable_swap,
+#if defined(CONFIG_NFS_V4_LOCALIO)
+	.init_localioclient = nfs4_init_localioclient,
+#endif
 };
 
 static const struct xattr_handler nfs4_xattr_nfs4_acl_handler = {
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 1416099dfcd1..d3b4fa3245f0 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -7728,3 +7728,55 @@ const struct rpc_version nfs_version4 = {
 	.procs			= nfs4_procedures,
 	.counts			= nfs_version4_counts,
 };
+
+#if defined(CONFIG_NFS_V4_LOCALIO)
+
+#define LOCALIO4_getuuidres_sz	(op_decode_hdr_maxsz+XDR_QUADLEN(UUID_SIZE))
+
+static void nfs4_xdr_enc_getuuidargs(struct rpc_rqst *req,
+				struct xdr_stream *xdr,
+				const void *data)
+{
+	/* void function */
+}
+
+static inline int nfs4_decode_getuuidresok(struct xdr_stream *xdr,
+					struct nfs_getuuidres *result)
+{
+	return decode_opaque_fixed(xdr, result->uuid, UUID_SIZE);
+}
+
+static int nfs4_xdr_dec_getuuidres(struct rpc_rqst *req,
+				struct xdr_stream *xdr,
+				void *result)
+{
+	// FIXME: need proper handling that isn't abusing nfs_opnum4
+	int error = decode_op_hdr(xdr, LOCALIOPROC_GETUUID);
+	if (unlikely(error))
+		goto out;
+	error = nfs4_decode_getuuidresok(xdr, result);
+out:
+	return error;
+}
+
+static const struct rpc_procinfo nfs4_localio_procedures[] = {
+	[LOCALIOPROC_GETUUID] = {
+		.p_proc = LOCALIOPROC_GETUUID,
+		.p_encode = nfs4_xdr_enc_getuuidargs,
+		.p_decode = nfs4_xdr_dec_getuuidres,
+		.p_arglen = 1,
+		.p_replen = LOCALIO4_getuuidres_sz,
+		.p_statidx = LOCALIOPROC_GETUUID,
+		.p_name = "GETUUID",
+	},
+};
+
+static unsigned int nfs4_localio_counts[ARRAY_SIZE(nfs4_localio_procedures)];
+const struct rpc_version nfslocalio_version4 = {
+	.number			= 4,
+	.nrprocs		= ARRAY_SIZE(nfs4_localio_procedures),
+	.procs			= nfs4_localio_procedures,
+	.counts			= nfs4_localio_counts,
+};
+
+#endif  /* CONFIG_NFS_V4_LOCALIO */
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 00fe469bc72e..efcdb4d8e9de 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -130,6 +130,7 @@ struct nfs_client {
 	/* localio */
 	struct timespec64	cl_nfssvc_boot;
 	seqlock_t		cl_boot_lock;
+	struct rpc_clnt *	cl_rpcclient_localio;	/* localio RPC client handle */
 };
 
 /*
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 764513a61601..2a438f4c2d6d 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1002,6 +1002,10 @@ struct nfs3_getaclres {
 	struct posix_acl *	acl_default;
 };
 
+struct nfs_getuuidres {
+	__u8 *			uuid;
+};
+
 #if IS_ENABLED(CONFIG_NFS_V4)
 
 typedef u64 clientid4;
@@ -1819,6 +1823,7 @@ struct nfs_rpc_ops {
 	int	(*discover_trunking)(struct nfs_server *, struct nfs_fh *);
 	void	(*enable_swap)(struct inode *inode);
 	void	(*disable_swap)(struct inode *inode);
+	void	(*init_localioclient)(struct nfs_client *);
 };
 
 /*
@@ -1834,4 +1839,9 @@ extern const struct rpc_version nfs_version4;
 extern const struct rpc_version nfsacl_version3;
 extern const struct rpc_program nfsacl_program;
 
+extern const struct rpc_version nfslocalio_version3;
+extern const struct rpc_program nfslocalio_program3;
+extern const struct rpc_version nfslocalio_version4;
+extern const struct rpc_program nfslocalio_program4;
+
 #endif
diff --git a/include/uapi/linux/nfs.h b/include/uapi/linux/nfs.h
index f356f2ba3814..e72f5564bdc0 100644
--- a/include/uapi/linux/nfs.h
+++ b/include/uapi/linux/nfs.h
@@ -33,6 +33,10 @@
 #define NFS_MNT_VERSION		1
 #define NFS_MNT3_VERSION	3
 
+#define NFS_LOCALIO_PROGRAM	100229
+#define LOCALIOPROC_NULL	0
+#define LOCALIOPROC_GETUUID	1
+
 #define NFS_PIPE_DIRNAME "nfs"
 
 /*
-- 
2.44.0


