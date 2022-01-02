Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 441DB482C69
	for <lists+linux-nfs@lfdr.de>; Sun,  2 Jan 2022 18:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiABRgM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 2 Jan 2022 12:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiABRgM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 2 Jan 2022 12:36:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06284C061761
        for <linux-nfs@vger.kernel.org>; Sun,  2 Jan 2022 09:36:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7012B80B4A
        for <linux-nfs@vger.kernel.org>; Sun,  2 Jan 2022 17:36:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4447DC36AE7;
        Sun,  2 Jan 2022 17:36:09 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     trondmy@kernel.org
Subject: [PATCH 09/10] NFSD: Rename boot verifier functions
Date:   Sun,  2 Jan 2022 12:36:08 -0500
Message-Id:  <164114496812.7344.5315813381496609958.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.34.0
In-Reply-To:  <164114486506.7344.16096063573748374893.stgit@bazille.1015granger.net>
References:  <164114486506.7344.16096063573748374893.stgit@bazille.1015granger.net>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=6075; h=from:subject:message-id; bh=leUUIzQY15Ms1Cr/pwOg7QhGLs0LfOlgojXcY4V/lp0=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBh0eKIMul01DGRQGHS2HkqgnP1yEguWKesp6CdCBOD w5myQuqJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYdHiiAAKCRAzarMzb2Z/l4IKD/ 9J1lWHdEYjml/guS/mK11nIDarmEwvoptFCt4X8iZjU/eYvmoE32HHmUAtfHn6Ai3d3JMfUVhIEXkN r/o67mnGLRRiKSp2Z3W0qqGbFdYCkX1urbBsdltoE6RAxkfiDlVqqSYBSNzeJ7WQZ5ov7rIubNo+KN B1veRPkMkgkZxEtfvW9aOpW9VqFYeMDD0ZNe6of1hLc0twgXyGcjq4NE22NOnXlOPg1V+75d584D+2 nGdiVEqAA9gabQ0fBlTPKWLRmdJi0T4A5F3RhNy8ZdFi2rLGnon6G7IaNPEtH86GHQ+tXbL26824FN nyBM7cz/zgq7rdHlQpO+8iccBmv0Ih5fwlQZJwWQcPAKQgeoE+PaUcU+UTQiElpDfqo/r77iax+xlu bDSc6jZVoxMbiBeq8JMZjLtwN9JLQ0dMQ60RISDqSeqJXxWobAZ8xLA1x02gLCbK8bY/LrhEtLJLaH AENNerRqTqZkKOXhKzj3jzeBZ+pQ8EceYANgclXbPiNvT2Yvz4IQx/f7jcmVk3/praeNEiJ0ZLbWkd AC1Q9OspRk5ECC7eMa6h1ivg2Qcg6m+5knXjD4e5rXc1lCjqNJcAfjjfO1QDJh4QPtT6HGlRfgU1FF GejngBeSzrDpSK0MPSOVAXAwp41J36w77znlbfP5zbiLgFFXAAQnsVO+sHhw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: These functions handle what the specs call a write
verifier, which in the Linux NFS server implementation is now
divorced from the server's boot instance

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/filecache.c |    2 +-
 fs/nfsd/netns.h     |    4 ++--
 fs/nfsd/nfs4proc.c  |    2 +-
 fs/nfsd/nfssvc.c    |   16 ++++++++--------
 fs/nfsd/vfs.c       |   16 ++++++++--------
 5 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index e2904540e463..8bc807c5fea4 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -243,7 +243,7 @@ nfsd_file_do_unhash(struct nfsd_file *nf)
 	trace_nfsd_file_unhash(nf);
 
 	if (nfsd_file_check_write_error(nf))
-		nfsd_reset_boot_verifier(net_generic(nf->nf_net, nfsd_net_id));
+		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
 	--nfsd_file_hashtbl[nf->nf_hashval].nfb_count;
 	hlist_del_rcu(&nf->nf_node);
 	atomic_long_dec(&nfsd_filecache_count);
diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index c879d80d5449..82ef4d77c592 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -197,6 +197,6 @@ extern void nfsd_netns_free_versions(struct nfsd_net *nn);
 
 extern unsigned int nfsd_net_id;
 
-void nfsd_copy_boot_verifier(__be32 verf[2], struct nfsd_net *nn);
-void nfsd_reset_boot_verifier(struct nfsd_net *nn);
+void nfsd_copy_write_verifier(__be32 verf[2], struct nfsd_net *nn);
+void nfsd_reset_write_verifier(struct nfsd_net *nn);
 #endif /* __NFSD_NETNS_H__ */
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 43057080d2aa..6f53eb90c6b4 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -598,7 +598,7 @@ static void gen_boot_verifier(nfs4_verifier *verifier, struct net *net)
 
 	BUILD_BUG_ON(2*sizeof(*verf) != sizeof(verifier->data));
 
-	nfsd_copy_boot_verifier(verf, net_generic(net, nfsd_net_id));
+	nfsd_copy_write_verifier(verf, net_generic(net, nfsd_net_id));
 }
 
 static __be32
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 81d47049588f..07193595b8e0 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -346,14 +346,14 @@ static bool nfsd_needs_lockd(struct nfsd_net *nn)
 }
 
 /**
- * nfsd_copy_boot_verifier - Atomically copy a write verifier
+ * nfsd_copy_write_verifier - Atomically copy a write verifier
  * @verf: buffer in which to receive the verifier cookie
  * @nn: NFS net namespace
  *
  * This function provides a wait-free mechanism for copying the
- * namespace's boot verifier without tearing it.
+ * namespace's write verifier without tearing it.
  */
-void nfsd_copy_boot_verifier(__be32 verf[2], struct nfsd_net *nn)
+void nfsd_copy_write_verifier(__be32 verf[2], struct nfsd_net *nn)
 {
 	int seq = 0;
 
@@ -364,7 +364,7 @@ void nfsd_copy_boot_verifier(__be32 verf[2], struct nfsd_net *nn)
 	done_seqretry(&nn->writeverf_lock, seq);
 }
 
-static void nfsd_reset_boot_verifier_locked(struct nfsd_net *nn)
+static void nfsd_reset_write_verifier_locked(struct nfsd_net *nn)
 {
 	struct timespec64 now;
 	u64 verf;
@@ -379,7 +379,7 @@ static void nfsd_reset_boot_verifier_locked(struct nfsd_net *nn)
 }
 
 /**
- * nfsd_reset_boot_verifier - Generate a new boot verifier
+ * nfsd_reset_write_verifier - Generate a new write verifier
  * @nn: NFS net namespace
  *
  * This function updates the ->writeverf field of @nn. This field
@@ -391,10 +391,10 @@ static void nfsd_reset_boot_verifier_locked(struct nfsd_net *nn)
  * server and MUST be unique between instances of the NFSv4.1
  * server."
  */
-void nfsd_reset_boot_verifier(struct nfsd_net *nn)
+void nfsd_reset_write_verifier(struct nfsd_net *nn)
 {
 	write_seqlock(&nn->writeverf_lock);
-	nfsd_reset_boot_verifier_locked(nn);
+	nfsd_reset_write_verifier_locked(nn);
 	write_sequnlock(&nn->writeverf_lock);
 }
 
@@ -683,7 +683,7 @@ int nfsd_create_serv(struct net *net)
 		register_inet6addr_notifier(&nfsd_inet6addr_notifier);
 #endif
 	}
-	nfsd_reset_boot_verifier(nn);
+	nfsd_reset_write_verifier(nn);
 	return 0;
 }
 
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 70ea7e0aae07..49564457bd3d 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -559,8 +559,8 @@ __be32 nfsd4_clone_file_range(struct svc_rqst *rqstp,
 					&nfsd4_get_cstate(rqstp)->current_fh,
 					dst_pos,
 					count, status);
-			nfsd_reset_boot_verifier(net_generic(nf_dst->nf_net,
-						 nfsd_net_id));
+			nfsd_reset_write_verifier(net_generic(nf_dst->nf_net,
+						  nfsd_net_id));
 			ret = nfserrno(status);
 		}
 	}
@@ -1013,10 +1013,10 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 	iov_iter_kvec(&iter, WRITE, vec, vlen, *cnt);
 	since = READ_ONCE(file->f_wb_err);
 	if (verf)
-		nfsd_copy_boot_verifier(verf, nn);
+		nfsd_copy_write_verifier(verf, nn);
 	host_err = vfs_iter_write(file, &iter, &pos, flags);
 	if (host_err < 0) {
-		nfsd_reset_boot_verifier(nn);
+		nfsd_reset_write_verifier(nn);
 		goto out_nfserr;
 	}
 	*cnt = host_err;
@@ -1029,7 +1029,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 	if (stable && use_wgather) {
 		host_err = wait_for_concurrent_writes(file);
 		if (host_err < 0)
-			nfsd_reset_boot_verifier(nn);
+			nfsd_reset_write_verifier(nn);
 	}
 
 out_nfserr:
@@ -1142,7 +1142,7 @@ nfsd_commit(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		err2 = vfs_fsync_range(nf->nf_file, offset, end, 0);
 		switch (err2) {
 		case 0:
-			nfsd_copy_boot_verifier(verf, nn);
+			nfsd_copy_write_verifier(verf, nn);
 			err2 = filemap_check_wb_err(nf->nf_file->f_mapping,
 						    since);
 			break;
@@ -1150,11 +1150,11 @@ nfsd_commit(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			err = nfserr_notsupp;
 			break;
 		default:
-			nfsd_reset_boot_verifier(nn);
+			nfsd_reset_write_verifier(nn);
 		}
 		err = nfserrno(err2);
 	} else
-		nfsd_copy_boot_verifier(verf, nn);
+		nfsd_copy_write_verifier(verf, nn);
 
 	nfsd_file_put(nf);
 out:

