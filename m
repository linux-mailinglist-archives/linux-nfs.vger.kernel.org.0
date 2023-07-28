Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0EA77675C1
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Jul 2023 20:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjG1Soe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Jul 2023 14:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234738AbjG1So1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Jul 2023 14:44:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FDF4495
        for <linux-nfs@vger.kernel.org>; Fri, 28 Jul 2023 11:44:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9ADD621B1
        for <linux-nfs@vger.kernel.org>; Fri, 28 Jul 2023 18:44:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA63FC433C7;
        Fri, 28 Jul 2023 18:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690569864;
        bh=rpIUgxXf35LPJCBP3VYCRXfeZKtJhlfwwNnO6t6PuC4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dkdd6ro1IW8i6dX1BRoKjKCK4YaEk+h6oi6OZTZgYSHhkW2DItvy+90+K8E883wwe
         C/cvvBxlWkXh1MyqOShekTcI1dshCNDZOwhwP935+S7K9HDDZp5S9AiFkpgplpR9+N
         BsHZnLt/OMhbXfVEXxdpDhy+6gmGMTUjiWcZBLQ6mxrOKIg+I3AZObd5zQ0FyRDYJK
         YEB5fyIvMDKqdlocLgbiQz7gH6FJCqvPIp8rMwdBDuTUeP+IAXM4QNbGwnH3qv7ZgN
         k597n4v/H5v8zqB25MWqW0+JJkcqxI++63hlVsqmTiBpJx32Kns9VkH/FlMYobJK40
         L7874FRdJ5MDA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     lorenzo.bianconi@redhat.com, chuck.lever@oracle.com,
        jlayton@kernel.org, neilb@suse.de
Subject: [PATCH v4 2/2] NFSD: add rpc_status entry in nfsd debug filesystem
Date:   Fri, 28 Jul 2023 20:44:04 +0200
Message-ID: <a23a0482a465299ac06d07d191e0c9377a11a4d1.1690569488.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690569488.git.lorenzo@kernel.org>
References: <cover.1690569488.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
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
 fs/nfsd/nfsctl.c           |  10 +++
 fs/nfsd/nfsd.h             |   2 +
 fs/nfsd/nfssvc.c           | 122 +++++++++++++++++++++++++++++++++++++
 include/linux/sunrpc/svc.h |   1 +
 net/sunrpc/svc.c           |   2 +-
 6 files changed, 137 insertions(+), 4 deletions(-)

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
index 35d2e2cde1eb..f2e4f4b1e4d1 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -57,6 +57,8 @@ enum {
 	NFSD_RecoveryDir,
 	NFSD_V4EndGrace,
 #endif
+	NFSD_Rpc_Status,
+
 	NFSD_MaxReserved
 };
 
@@ -195,6 +197,13 @@ static inline struct net *netns(struct file *file)
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
@@ -1400,6 +1409,7 @@ static int nfsd_fill_super(struct super_block *sb, struct fs_context *fc)
 		[NFSD_RecoveryDir] = {"nfsv4recoverydir", &transaction_ops, S_IWUSR|S_IRUSR},
 		[NFSD_V4EndGrace] = {"v4_end_grace", &transaction_ops, S_IWUSR|S_IRUGO},
 #endif
+		[NFSD_Rpc_Status] = {"rpc_status", &nfsd_rpc_status_operations, S_IRUGO},
 		/* last one */ {""}
 	};
 
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index d88498f8b275..75a3e1d55bc8 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -94,6 +94,7 @@ int		nfsd_get_nrthreads(int n, int *, struct net *);
 int		nfsd_set_nrthreads(int n, int *, struct net *);
 int		nfsd_pool_stats_open(struct inode *, struct file *);
 int		nfsd_pool_stats_release(struct inode *, struct file *);
+int		nfsd_rpc_status_open(struct inode *inode, struct file *file);
 void		nfsd_shutdown_threads(struct net *net);
 
 void		nfsd_put(struct net *net);
@@ -506,6 +507,7 @@ extern void nfsd4_ssc_init_umount_work(struct nfsd_net *nn);
 
 extern void nfsd4_init_leases_net(struct nfsd_net *nn);
 
+const char *nfsd4_op_name(unsigned opnum);
 #else /* CONFIG_NFSD_V4 */
 static inline int nfsd4_is_junction(struct dentry *dentry)
 {
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 97830e28c140..e9e954b5ae47 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -1057,6 +1057,8 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
 	if (!proc->pc_decode(rqstp, &rqstp->rq_arg_stream))
 		goto out_decode_err;
 
+	atomic_inc(&rqstp->rq_status_counter);
+
 	rp = NULL;
 	switch (nfsd_cache_lookup(rqstp, &rp)) {
 	case RC_DOIT:
@@ -1074,6 +1076,8 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
 	if (!proc->pc_encode(rqstp, &rqstp->rq_res_stream))
 		goto out_encode_err;
 
+	atomic_inc(&rqstp->rq_status_counter);
+
 	nfsd_cache_update(rqstp, rp, rqstp->rq_cachetype, statp + 1);
 out_cached_reply:
 	return 1;
@@ -1149,3 +1153,121 @@ int nfsd_pool_stats_release(struct inode *inode, struct file *file)
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
+			struct nfsd_rpc_status_info {
+				struct sockaddr daddr;
+				struct sockaddr saddr;
+				unsigned long rq_flags;
+				__be32 rq_xid;
+				u32 rq_prog;
+				u32 rq_vers;
+				const char *pc_name;
+				ktime_t rq_stime;
+				u32 opnum[NFSD_MAX_OPS_PER_COMPOUND]; /* NFSv4 compund */
+			} rqstp_info;
+			unsigned int status_counter;
+			char buf[RPC_MAX_ADDRBUFLEN];
+			int j, opcnt = 0;
+
+			if (!test_bit(RQ_BUSY, &rqstp->rq_flags))
+				continue;
+
+			status_counter = atomic_read(&rqstp->rq_status_counter);
+
+			rqstp_info.rq_xid = rqstp->rq_xid;
+			rqstp_info.rq_flags = rqstp->rq_flags;
+			rqstp_info.rq_prog = rqstp->rq_prog;
+			rqstp_info.rq_vers = rqstp->rq_vers;
+			rqstp_info.pc_name = svc_proc_name(rqstp);
+			rqstp_info.rq_stime = rqstp->rq_stime;
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
+				opcnt = args->opcnt;
+				for (j = 0; j < opcnt; j++) {
+					struct nfsd4_op *op = &args->ops[j];
+
+					rqstp_info.opnum[j] = op->opnum;
+				}
+			}
+#endif /* CONFIG_NFSD_V4 */
+
+			/* In order to detect if the RPC request is pending and
+			 * RPC info are stable we check if rq_status_counter
+			 * has been incremented during the handler processing.
+			 */
+			if (status_counter != atomic_read(&rqstp->rq_status_counter))
+				continue;
+
+			seq_printf(m,
+				   "0x%08x, 0x%08lx, 0x%08x, NFSv%d, %s, %016lld,",
+				   be32_to_cpu(rqstp_info.rq_xid),
+				   rqstp_info.rq_flags,
+				   rqstp_info.rq_prog,
+				   rqstp_info.rq_vers,
+				   rqstp_info.pc_name,
+				   ktime_to_us(rqstp_info.rq_stime));
+
+			seq_printf(m, " %s,",
+				   __svc_print_addr(&rqstp_info.saddr, buf,
+						    sizeof(buf), false));
+			seq_printf(m, " %s,",
+				   __svc_print_addr(&rqstp_info.daddr, buf,
+						    sizeof(buf), false));
+			for (j = 0; j < opcnt; j++)
+				seq_printf(m, " %s%s",
+					   nfsd4_op_name(rqstp_info.opnum[j]),
+					   j == opcnt - 1 ? "," : "");
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
+ * nfsd_rpc_status_open - Atomically copy a write verifier
+ * @inode: entry inode pointer.
+ * @file: entry file pointer.
+ *
+ * This routine dumps pending RPC requests info queued into nfs server.
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
index fe1394cc1371..cb516da9e270 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -270,6 +270,7 @@ struct svc_rqst {
 						 * net namespace
 						 */
 	void **			rq_lease_breaker; /* The v4 client breaking a lease */
+	atomic_t		rq_status_counter; /* RPC processing counter */
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

