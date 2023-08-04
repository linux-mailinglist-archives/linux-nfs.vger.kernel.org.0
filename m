Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437407706F1
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Aug 2023 19:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbjHDRTp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Aug 2023 13:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbjHDRTo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Aug 2023 13:19:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1AC4698
        for <linux-nfs@vger.kernel.org>; Fri,  4 Aug 2023 10:19:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FD81620C9
        for <linux-nfs@vger.kernel.org>; Fri,  4 Aug 2023 17:19:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 063F5C433C8;
        Fri,  4 Aug 2023 17:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691169581;
        bh=x6pSgRNTgbcBoIHjFfgBXTYWBqy0Y9kWdX1cWYZykl4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o26imEPuJiQqeaWB8g4U/L8BWISJ4VsTwfndQTZoXmjgqSe33wcI/FReIjk2JOHH4
         rlf2y62c1Bn+f/0K/b1ubLF9weO2VZ4ch7ntwZtCwMieGDZ48V/cBIjgj3EuWfGWEg
         2DodnhUIObTFtxbnR1xZPJonX9hPVR8cKcA+DkLM1IEKqg+NB64Qa77mZEP/gaN5n5
         q8UkmhHFdsvQkHxbLCu93W8MI0+asJuJorvDDIEUg7KhO4xDZxVxwWTiU80fa8939Q
         xTGxQYLvoE+t2p0nPWpsTl0ltw5thonZvWeLnKKRyD6Kbn7tN+YYUlwMRXWfIleBa6
         1Dnw+RGUMEqAw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     lorenzo.bianconi@redhat.com, chuck.lever@oracle.com,
        jlayton@kernel.org, neilb@suse.de
Subject: [PATCH v5 2/2] NFSD: add rpc_status entry in nfsd debug filesystem
Date:   Fri,  4 Aug 2023 19:16:08 +0200
Message-ID: <d0b6183a4fda5b333711caee73cbb06ba0147057.1691169103.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1691169103.git.lorenzo@kernel.org>
References: <cover.1691169103.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Introduce rpc_status entry in nfsd debug filesystem in order to dump
pending RPC requests debugging information.

Link: https://bugzilla.linux-nfs.org/show_bug.cgi?id=366
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 fs/nfsd/nfs4proc.c         |   4 +-
 fs/nfsd/nfsctl.c           |   9 +++
 fs/nfsd/nfsd.h             |   7 ++
 fs/nfsd/nfssvc.c           | 140 +++++++++++++++++++++++++++++++++++++
 include/linux/sunrpc/svc.h |   1 +
 net/sunrpc/svc.c           |   2 +-
 6 files changed, 159 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index f0f318e78630..b7ad3081bc36 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2497,8 +2497,6 @@ static inline void nfsd4_increment_op_stats(u32 opnum)
 
 static const struct nfsd4_operation nfsd4_ops[];
 
-static const char *nfsd4_op_name(unsigned opnum);
-
 /*
  * Enforce NFSv4.1 COMPOUND ordering rules:
  *
@@ -3628,7 +3626,7 @@ void warn_on_nonidempotent_op(struct nfsd4_op *op)
 	}
 }
 
-static const char *nfsd4_op_name(unsigned opnum)
+const char *nfsd4_op_name(unsigned opnum)
 {
 	if (opnum < ARRAY_SIZE(nfsd4_ops))
 		return nfsd4_ops[opnum].op_name;
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 35d2e2cde1eb..d47b98bad96e 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -47,6 +47,7 @@ enum {
 	NFSD_MaxBlkSize,
 	NFSD_MaxConnections,
 	NFSD_Filecache,
+	NFSD_Rpc_Status,
 	/*
 	 * The below MUST come last.  Otherwise we leave a hole in nfsd_files[]
 	 * with !CONFIG_NFSD_V4 and simple_fill_super() goes oops
@@ -195,6 +196,13 @@ static inline struct net *netns(struct file *file)
 	return file_inode(file)->i_sb->s_fs_info;
 }
 
+static const struct file_operations nfsd_rpc_status_operations = {
+	.open		= nfsd_rpc_status_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= nfsd_pool_stats_release,
+};
+
 /*
  * write_unlock_ip - Release all locks used by a client
  *
@@ -1400,6 +1408,7 @@ static int nfsd_fill_super(struct super_block *sb, struct fs_context *fc)
 		[NFSD_RecoveryDir] = {"nfsv4recoverydir", &transaction_ops, S_IWUSR|S_IRUSR},
 		[NFSD_V4EndGrace] = {"v4_end_grace", &transaction_ops, S_IWUSR|S_IRUGO},
 #endif
+		[NFSD_Rpc_Status] = {"rpc_status", &nfsd_rpc_status_operations, S_IRUGO},
 		/* last one */ {""}
 	};
 
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index d88498f8b275..50c82bb42e88 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -94,6 +94,7 @@ int		nfsd_get_nrthreads(int n, int *, struct net *);
 int		nfsd_set_nrthreads(int n, int *, struct net *);
 int		nfsd_pool_stats_open(struct inode *, struct file *);
 int		nfsd_pool_stats_release(struct inode *, struct file *);
+int		nfsd_rpc_status_open(struct inode *inode, struct file *file);
 void		nfsd_shutdown_threads(struct net *net);
 
 void		nfsd_put(struct net *net);
@@ -506,12 +507,18 @@ extern void nfsd4_ssc_init_umount_work(struct nfsd_net *nn);
 
 extern void nfsd4_init_leases_net(struct nfsd_net *nn);
 
+const char *nfsd4_op_name(unsigned opnum);
 #else /* CONFIG_NFSD_V4 */
 static inline int nfsd4_is_junction(struct dentry *dentry)
 {
 	return 0;
 }
 
+static inline const char *nfsd4_op_name(unsigned opnum)
+{
+	return "unknown_operation";
+}
+
 static inline void nfsd4_init_leases_net(struct nfsd_net *nn) { };
 
 #define register_cld_notifier() 0
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 97830e28c140..5e115dbbe9dc 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -1057,6 +1057,15 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
 	if (!proc->pc_decode(rqstp, &rqstp->rq_arg_stream))
 		goto out_decode_err;
 
+	/*
+	 * Release rq_status_counter setting it to an odd value after the rpc
+	 * request has been properly parsed. rq_status_counter is used to
+	 * notify the consumers if the rqstp fields are stable
+	 * (rq_status_counter is odd) or not meaningful (rq_status_counter
+	 * is even).
+	 */
+	smp_store_release(&rqstp->rq_status_counter, rqstp->rq_status_counter | 1);
+
 	rp = NULL;
 	switch (nfsd_cache_lookup(rqstp, &rp)) {
 	case RC_DOIT:
@@ -1074,6 +1083,12 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
 	if (!proc->pc_encode(rqstp, &rqstp->rq_res_stream))
 		goto out_encode_err;
 
+	/*
+	 * Release rq_status_counter setting it to an even value after the rpc
+	 * request has been properly processed.
+	 */
+	smp_store_release(&rqstp->rq_status_counter, rqstp->rq_status_counter + 1);
+
 	nfsd_cache_update(rqstp, rp, rqstp->rq_cachetype, statp + 1);
 out_cached_reply:
 	return 1;
@@ -1149,3 +1164,128 @@ int nfsd_pool_stats_release(struct inode *inode, struct file *file)
 	mutex_unlock(&nfsd_mutex);
 	return ret;
 }
+
+static int nfsd_rpc_status_show(struct seq_file *m, void *v)
+{
+	struct inode *inode = file_inode(m->file);
+	struct nfsd_net *nn = net_generic(inode->i_sb->s_fs_info, nfsd_net_id);
+	int i;
+
+	rcu_read_lock();
+
+	for (i = 0; i < nn->nfsd_serv->sv_nrpools; i++) {
+		struct svc_rqst *rqstp;
+
+		list_for_each_entry_rcu(rqstp,
+				&nn->nfsd_serv->sv_pools[i].sp_all_threads,
+				rq_all) {
+			struct {
+				struct sockaddr daddr;
+				struct sockaddr saddr;
+				unsigned long rq_flags;
+				const char *pc_name;
+				ktime_t rq_stime;
+				__be32 rq_xid;
+				u32 rq_prog;
+				u32 rq_vers;
+				/* NFSv4 compund */
+				u32 opnum[NFSD_MAX_OPS_PER_COMPOUND];
+				u8 opcnt;
+			} rqstp_info;
+			unsigned int status_counter;
+			char buf[RPC_MAX_ADDRBUFLEN];
+			int j;
+
+			/*
+			 * Acquire rq_status_counter before parsing the rqst
+			 * fields. rq_status_counter is set to an odd value in
+			 * order to notify the consumers the rqstp fields are
+			 * meaningful.
+			 */
+			status_counter = smp_load_acquire(&rqstp->rq_status_counter);
+			if (!(status_counter & 1))
+				continue;
+
+			rqstp_info.rq_xid = rqstp->rq_xid;
+			rqstp_info.rq_flags = rqstp->rq_flags;
+			rqstp_info.rq_prog = rqstp->rq_prog;
+			rqstp_info.rq_vers = rqstp->rq_vers;
+			rqstp_info.pc_name = svc_proc_name(rqstp);
+			rqstp_info.rq_stime = rqstp->rq_stime;
+			rqstp_info.opcnt = 0;
+			memcpy(&rqstp_info.daddr, svc_daddr(rqstp),
+			       sizeof(struct sockaddr));
+			memcpy(&rqstp_info.saddr, svc_addr(rqstp),
+			       sizeof(struct sockaddr));
+
+#ifdef CONFIG_NFSD_V4
+			if (rqstp->rq_vers == NFS4_VERSION &&
+			    rqstp->rq_proc == NFSPROC4_COMPOUND) {
+				/* NFSv4 compund */
+				struct nfsd4_compoundargs *args = rqstp->rq_argp;
+
+				rqstp_info.opcnt = args->opcnt;
+				for (j = 0; j < rqstp_info.opcnt; j++) {
+					struct nfsd4_op *op = &args->ops[j];
+
+					rqstp_info.opnum[j] = op->opnum;
+				}
+			}
+#endif /* CONFIG_NFSD_V4 */
+
+			/*
+			 * Acquire rq_status_counter before reporting the rqst
+			 * fields to the user.
+			 */
+			if (smp_load_acquire(&rqstp->rq_status_counter) != status_counter)
+				continue;
+
+			seq_printf(m,
+				   "0x%08x 0x%08lx 0x%08x NFSv%d %s %016lld",
+				   be32_to_cpu(rqstp_info.rq_xid),
+				   rqstp_info.rq_flags,
+				   rqstp_info.rq_prog,
+				   rqstp_info.rq_vers,
+				   rqstp_info.pc_name,
+				   ktime_to_us(rqstp_info.rq_stime));
+			seq_printf(m, " %s",
+				   __svc_print_addr(&rqstp_info.saddr, buf,
+						    sizeof(buf), false));
+			seq_printf(m, " %s",
+				   __svc_print_addr(&rqstp_info.daddr, buf,
+						    sizeof(buf), false));
+			for (j = 0; j < rqstp_info.opcnt; j++)
+				seq_printf(m, " %s",
+					   nfsd4_op_name(rqstp_info.opnum[j]));
+			seq_puts(m, "\n");
+		}
+	}
+
+	rcu_read_unlock();
+
+	return 0;
+}
+
+/**
+ * nfsd_rpc_status_open - open routine for nfsd_rpc_status handler
+ * @inode: entry inode pointer.
+ * @file: entry file pointer.
+ *
+ * nfsd_rpc_status_open is the open routine for nfsd_rpc_status procfs handler.
+ * nfsd_rpc_status dumps pending RPC requests info queued into nfs server.
+ */
+int nfsd_rpc_status_open(struct inode *inode, struct file *file)
+{
+	struct nfsd_net *nn = net_generic(inode->i_sb->s_fs_info, nfsd_net_id);
+
+	mutex_lock(&nfsd_mutex);
+	if (!nn->nfsd_serv) {
+		mutex_unlock(&nfsd_mutex);
+		return -ENODEV;
+	}
+
+	svc_get(nn->nfsd_serv);
+	mutex_unlock(&nfsd_mutex);
+
+	return single_open(file, nfsd_rpc_status_show, inode->i_private);
+}
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index fe1394cc1371..542a60b78bab 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -270,6 +270,7 @@ struct svc_rqst {
 						 * net namespace
 						 */
 	void **			rq_lease_breaker; /* The v4 client breaking a lease */
+	unsigned int		rq_status_counter; /* RPC processing counter */
 };
 
 #define SVC_NET(rqst) (rqst->rq_xprt ? rqst->rq_xprt->xpt_net : rqst->rq_bc_net)
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 587811a002c9..44eac83b35a1 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1629,7 +1629,7 @@ const char *svc_proc_name(const struct svc_rqst *rqstp)
 		return rqstp->rq_procinfo->pc_name;
 	return "unknown";
 }
-
+EXPORT_SYMBOL_GPL(svc_proc_name);
 
 /**
  * svc_encode_result_payload - mark a range of bytes as a result payload
-- 
2.41.0

