Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8CB7568BA
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jul 2023 18:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjGQQKz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Jul 2023 12:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjGQQKy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Jul 2023 12:10:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD19C130
        for <linux-nfs@vger.kernel.org>; Mon, 17 Jul 2023 09:10:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4185F6114F
        for <linux-nfs@vger.kernel.org>; Mon, 17 Jul 2023 16:10:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25292C433C7;
        Mon, 17 Jul 2023 16:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689610252;
        bh=FmJyA8PygVguRoeSHxR9ufSoQDdGzxge3Q8XLl8oLHE=;
        h=From:To:Cc:Subject:Date:From;
        b=PnDXpfEWLS8Fw+MEWbx7kehYyA74Wf8/4cebUxrja7mpXRnenOlM1+2oYEj7NgAoY
         02uBbtzYq2mXgeC1BHtHcFFhGn77x7R+Vi8nYRi/FzQ+QitW+P9z6dSgN2ongKuD9J
         PkUwjzo9I0sDjN5D8em3hWPyydEHA99vv2uRLAgumu6AeAo/aFReS2x30UZxiWKLy2
         P4mIje5F/9i4T8mUb1KH2JOZEPW+hg8nuIAOCKk9cRY9ojmDXb+Iev7ygt7YQiVxIL
         IUIa7MC629caNcb9efmaOgotd1zJRu7rAtaPtGqepe4zHaDyk5APAquKjDP1ZdxTCt
         W+mA7vjtuUNmQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     lorenzo.bianconi@redhat.com, chuck.lever@oracle.com,
        jlayton@kernel.org
Subject: [PATCH v3] NFSD: add rpc_status entry in nfsd debug filesystem
Date:   Mon, 17 Jul 2023 18:10:37 +0200
Message-ID: <4aa3c87872031ca42d411ed60169c6daa951620b.1689610081.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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
Changes since v2:
- minor changes in nfsd_rpc_status_show output

Changes since v1:
- rework nfsd_rpc_status_show output

Changes since RFCv1:
- riduce time holding nfsd_mutex bumping svc_serv refcoung in
  nfsd_rpc_status_open()
- dump rqstp->rq_stime
- add missing kdoc for nfsd_rpc_status_open()
---
 fs/nfsd/nfs4proc.c |  4 +--
 fs/nfsd/nfsctl.c   | 10 ++++++
 fs/nfsd/nfsd.h     |  2 ++
 fs/nfsd/nfssvc.c   | 83 ++++++++++++++++++++++++++++++++++++++++++++++
 net/sunrpc/svc.c   |  2 +-
 5 files changed, 97 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index d8e7a533f9d2..a7f522390a66 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2463,8 +2463,6 @@ static inline void nfsd4_increment_op_stats(u32 opnum)
 
 static const struct nfsd4_operation nfsd4_ops[];
 
-static const char *nfsd4_op_name(unsigned opnum);
-
 /*
  * Enforce NFSv4.1 COMPOUND ordering rules:
  *
@@ -3594,7 +3592,7 @@ void warn_on_nonidempotent_op(struct nfsd4_op *op)
 	}
 }
 
-static const char *nfsd4_op_name(unsigned opnum)
+const char *nfsd4_op_name(unsigned opnum)
 {
 	if (opnum < ARRAY_SIZE(nfsd4_ops))
 		return nfsd4_ops[opnum].op_name;
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 1b8b1aab9a15..629b4296e7c6 100644
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
index 97830e28c140..3f6d53e5f579 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -1149,3 +1149,86 @@ int nfsd_pool_stats_release(struct inode *inode, struct file *file)
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
+			if (!test_bit(RQ_BUSY, &rqstp->rq_flags))
+				continue;
+
+			seq_printf(m,
+				   "0x%08x 0x%08lx 0x%08x NFSv%d %s %016lld",
+				   be32_to_cpu(rqstp->rq_xid), rqstp->rq_flags,
+				   rqstp->rq_prog, rqstp->rq_vers,
+				   svc_proc_name(rqstp),
+				   ktime_to_us(rqstp->rq_stime));
+
+			if (rqstp->rq_addr.ss_family == AF_INET)
+				seq_printf(m, " %pI4 %pI4",
+					   &((struct sockaddr_in *)&rqstp->rq_addr)->sin_addr,
+					   &((struct sockaddr_in *)&rqstp->rq_daddr)->sin_addr);
+			else if (rqstp->rq_addr.ss_family == AF_INET6)
+				seq_printf(m, " %pI6 %pI6",
+					   &((struct sockaddr_in6 *)&rqstp->rq_addr)->sin6_addr,
+					   &((struct sockaddr_in6 *)&rqstp->rq_daddr)->sin6_addr);
+			else
+				seq_printf(m, " unknown:%hu unknown:%hu",
+					   rqstp->rq_addr.ss_family,
+					   rqstp->rq_daddr.ss_family);
+#ifdef CONFIG_NFSD_V4
+			if (rqstp->rq_vers == NFS4_VERSION &&
+			    rqstp->rq_proc == NFSPROC4_COMPOUND) {
+				/* NFSv4 compund */
+				struct nfsd4_compoundargs *args = rqstp->rq_argp;
+				struct nfsd4_compoundres *resp = rqstp->rq_resp;
+
+				while (resp->opcnt < args->opcnt) {
+					struct nfsd4_op *op = &args->ops[resp->opcnt++];
+
+					seq_printf(m, " %s%s", nfsd4_op_name(op->opnum),
+						   resp->opcnt < args->opcnt ? ":" : "");
+				}
+			}
+#endif /* CONFIG_NFSD_V4 */
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

