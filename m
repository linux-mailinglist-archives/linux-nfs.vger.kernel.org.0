Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB6D79F596
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Sep 2023 01:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbjIMXij (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Sep 2023 19:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjIMXij (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 13 Sep 2023 19:38:39 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D84CE9
        for <linux-nfs@vger.kernel.org>; Wed, 13 Sep 2023 16:38:35 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38DN5hd0029760;
        Wed, 13 Sep 2023 23:38:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=2NK/D66/d4tkGmW2EtRGfyN4Zj3436uhSj6pH/HCtsU=;
 b=uqywQbtCLLXlLpWvApyJS+u+eNZhj/Z/in/HLHIHOK0nwtt771AsFW4onCysEtKKxwFU
 yIICVNLFKkCygmCSgjjXYpzWpSpTqJTefEPUi4TT0KxNmLj9TaDgHODcKE1JNA5ITIDV
 0KTsE+iRJzVJdiIk7SW0plx8uEV9YjJKTyRZKa3PuZgSZQdkepaVWvTuHqWq2BMRFu7U
 1b7uvDOk2/L4zuH+OIrkMsV18EQ/27GnLIRX4UAG/P2O/cN22VqO6StkC7IxlIhYn1wI
 61TUMwt9mbsTWzLdEm6IwCDgTWs1jWu/A2C/IX7IBQTRUnzyAEuxUDEmR97nY2M6D3qN Lw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7rbjff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Sep 2023 23:38:28 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38DLOgLo007710;
        Wed, 13 Sep 2023 23:38:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f57xtes-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Sep 2023 23:38:27 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38DNcQk6004827;
        Wed, 13 Sep 2023 23:38:26 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3t0f57xte9-3;
        Wed, 13 Sep 2023 23:38:26 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 2/2] NFSD: handle GETATTR conflict with write delegation
Date:   Wed, 13 Sep 2023 16:38:21 -0700
Message-Id: <1694648301-26746-3-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1694648301-26746-1-git-send-email-dai.ngo@oracle.com>
References: <1694648301-26746-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_18,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309130195
X-Proofpoint-ORIG-GUID: YWvVMDsbWVfU0FpSPvhs6MyMSp6XijQ4
X-Proofpoint-GUID: YWvVMDsbWVfU0FpSPvhs6MyMSp6XijQ4
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If the GETATTR request on a file that has write delegation in effect
and the request attributes include the change info and size attribute
then the request is handled as below:

Server sends CB_GETATTR to client to get the latest change info and file
size. If these values are the same as the server's cached values then
the GETATTR proceeds as normal.

If either the change info or file size is different from the server's
cached values, or the file was already marked as modified, then:

    . update time_modify and time_metadata into file's metadata
      with current time

    . encode GETATTR as normal except the file size is encoded with
      the value returned from CB_GETATTR

    . mark the file as modified

If the CB_GETATTR fails for any reasons, the delegation is recalled
and NFS4ERR_DELAY is returned for the GETATTR.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 108 ++++++++++++++++++++++++++++++++++++++++----
 fs/nfsd/nfs4xdr.c   |  10 +++-
 fs/nfsd/state.h     |  11 ++++-
 3 files changed, 117 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 8534693eb6a4..8eeea1041045 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -127,6 +127,7 @@ static void free_session(struct nfsd4_session *);
 
 static const struct nfsd4_callback_ops nfsd4_cb_recall_ops;
 static const struct nfsd4_callback_ops nfsd4_cb_notify_lock_ops;
+static const struct nfsd4_callback_ops nfsd4_cb_getattr_ops;
 
 static struct workqueue_struct *laundry_wq;
 
@@ -1187,6 +1188,10 @@ alloc_init_deleg(struct nfs4_client *clp, struct nfs4_file *fp,
 	dp->dl_recalled = false;
 	nfsd4_init_cb(&dp->dl_recall, dp->dl_stid.sc_client,
 		      &nfsd4_cb_recall_ops, NFSPROC4_CLNT_CB_RECALL);
+	nfsd4_init_cb(&dp->dl_cb_fattr.ncf_getattr, dp->dl_stid.sc_client,
+			&nfsd4_cb_getattr_ops, NFSPROC4_CLNT_CB_GETATTR);
+	dp->dl_cb_fattr.ncf_file_modified = false;
+	dp->dl_cb_fattr.ncf_cb_bmap[0] = FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE;
 	get_nfs4_file(fp);
 	dp->dl_stid.sc_file = fp;
 	return dp;
@@ -2894,11 +2899,56 @@ nfsd4_cb_recall_any_release(struct nfsd4_callback *cb)
 	spin_unlock(&nn->client_lock);
 }
 
+static int
+nfsd4_cb_getattr_done(struct nfsd4_callback *cb, struct rpc_task *task)
+{
+	struct nfs4_cb_fattr *ncf =
+			container_of(cb, struct nfs4_cb_fattr, ncf_getattr);
+
+	ncf->ncf_cb_status = task->tk_status;
+	switch (task->tk_status) {
+	case -NFS4ERR_DELAY:
+		rpc_delay(task, 2 * HZ);
+		return 0;
+	default:
+		return 1;
+	}
+}
+
+static void
+nfsd4_cb_getattr_release(struct nfsd4_callback *cb)
+{
+	struct nfs4_cb_fattr *ncf =
+			container_of(cb, struct nfs4_cb_fattr, ncf_getattr);
+	struct nfs4_delegation *dp =
+			container_of(ncf, struct nfs4_delegation, dl_cb_fattr);
+
+	nfs4_put_stid(&dp->dl_stid);
+	clear_bit(CB_GETATTR_BUSY, &ncf->ncf_cb_flags);
+	wake_up_bit(&ncf->ncf_cb_flags, CB_GETATTR_BUSY);
+}
+
 static const struct nfsd4_callback_ops nfsd4_cb_recall_any_ops = {
 	.done		= nfsd4_cb_recall_any_done,
 	.release	= nfsd4_cb_recall_any_release,
 };
 
+static const struct nfsd4_callback_ops nfsd4_cb_getattr_ops = {
+	.done		= nfsd4_cb_getattr_done,
+	.release	= nfsd4_cb_getattr_release,
+};
+
+void nfs4_cb_getattr(struct nfs4_cb_fattr *ncf)
+{
+	struct nfs4_delegation *dp =
+			container_of(ncf, struct nfs4_delegation, dl_cb_fattr);
+
+	if (test_and_set_bit(CB_GETATTR_BUSY, &ncf->ncf_cb_flags))
+		return;
+	refcount_inc(&dp->dl_stid.sc_count);
+	nfsd4_run_cb(&ncf->ncf_getattr);
+}
+
 static struct nfs4_client *create_client(struct xdr_netobj name,
 		struct svc_rqst *rqstp, nfs4_verifier *verf)
 {
@@ -5634,6 +5684,8 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	struct svc_fh *parent = NULL;
 	int cb_up;
 	int status = 0;
+	struct kstat stat;
+	struct path path;
 
 	cb_up = nfsd4_cb_channel_good(oo->oo_owner.so_client);
 	open->op_recall = 0;
@@ -5671,6 +5723,18 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
 		open->op_delegate_type = NFS4_OPEN_DELEGATE_WRITE;
 		trace_nfsd_deleg_write(&dp->dl_stid.sc_stateid);
+		path.mnt = currentfh->fh_export->ex_path.mnt;
+		path.dentry = currentfh->fh_dentry;
+		if (vfs_getattr(&path, &stat,
+				(STATX_SIZE | STATX_CTIME | STATX_CHANGE_COOKIE),
+				AT_STATX_SYNC_AS_STAT)) {
+			nfs4_put_stid(&dp->dl_stid);
+			destroy_delegation(dp);
+			goto out_no_deleg;
+		}
+		dp->dl_cb_fattr.ncf_cur_fsize = stat.size;
+		dp->dl_cb_fattr.ncf_initial_cinfo =
+			nfsd4_change_attribute(&stat, d_inode(currentfh->fh_dentry));
 	} else {
 		open->op_delegate_type = NFS4_OPEN_DELEGATE_READ;
 		trace_nfsd_deleg_read(&dp->dl_stid.sc_stateid);
@@ -8403,6 +8467,8 @@ nfsd4_get_writestateid(struct nfsd4_compound_state *cstate,
  * nfsd4_deleg_getattr_conflict - Recall if GETATTR causes conflict
  * @rqstp: RPC transaction context
  * @inode: file to be checked for a conflict
+ * @modified: return true if file was modified
+ * @size: new size of file if modified is true
  *
  * This function is called when there is a conflict between a write
  * delegation and a change/size GETATTR from another client. The server
@@ -8411,21 +8477,21 @@ nfsd4_get_writestateid(struct nfsd4_compound_state *cstate,
  * delegation before replying to the GETATTR. See RFC 8881 section
  * 18.7.4.
  *
- * The current implementation does not support CB_GETATTR yet. However
- * this can avoid recalling the delegation could be added in follow up
- * work.
- *
  * Returns 0 if there is no conflict; otherwise an nfs_stat
  * code is returned.
  */
 __be32
-nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode)
+nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode,
+				bool *modified, u64 *size)
 {
 	__be32 status;
 	struct file_lock_context *ctx;
 	struct file_lock *fl;
 	struct nfs4_delegation *dp;
+	struct iattr attrs;
+	struct nfs4_cb_fattr *ncf;
 
+	*modified = false;
 	ctx = locks_inode_context(inode);
 	if (!ctx)
 		return 0;
@@ -8452,10 +8518,34 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode)
 break_lease:
 			spin_unlock(&ctx->flc_lock);
 			nfsd_stats_wdeleg_getattr_inc();
-			status = nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
-			if (status != nfserr_jukebox ||
-					!nfsd_wait_for_delegreturn(rqstp, inode))
-				return status;
+
+			dp = fl->fl_owner;
+			ncf = &dp->dl_cb_fattr;
+			nfs4_cb_getattr(&dp->dl_cb_fattr);
+			wait_on_bit(&ncf->ncf_cb_flags, CB_GETATTR_BUSY, TASK_INTERRUPTIBLE);
+			if (ncf->ncf_cb_status) {
+				status = nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
+				if (status != nfserr_jukebox ||
+						!nfsd_wait_for_delegreturn(rqstp, inode))
+					return status;
+			}
+			if (!ncf->ncf_file_modified &&
+					(ncf->ncf_initial_cinfo != ncf->ncf_cb_change ||
+					ncf->ncf_cur_fsize != ncf->ncf_cb_fsize))
+				ncf->ncf_file_modified = true;
+			if (ncf->ncf_file_modified) {
+				/*
+				 * The server would not update the file's metadata
+				 * with the client's modified size.
+				 */
+				attrs.ia_mtime = attrs.ia_ctime = current_time(inode);
+				attrs.ia_valid = ATTR_MTIME | ATTR_CTIME;
+				setattr_copy(&nop_mnt_idmap, inode, &attrs);
+				mark_inode_dirty(inode);
+				ncf->ncf_cur_fsize = ncf->ncf_cb_fsize;
+				*size = ncf->ncf_cur_fsize;
+				*modified = true;
+			}
 			return 0;
 		}
 		break;
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 2e40c74d2f72..69504da6c4d4 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2975,6 +2975,8 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 		.dentry	= dentry,
 	};
 	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
+	bool file_modified;
+	u64 size = 0;
 
 	BUG_ON(bmval1 & NFSD_WRITEONLY_ATTRS_WORD1);
 	BUG_ON(!nfsd_attrs_supported(minorversion, bmval));
@@ -2985,7 +2987,8 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 			goto out;
 	}
 	if (bmval0 & (FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE)) {
-		status = nfsd4_deleg_getattr_conflict(rqstp, d_inode(dentry));
+		status = nfsd4_deleg_getattr_conflict(rqstp, d_inode(dentry),
+						&file_modified, &size);
 		if (status)
 			goto out;
 	}
@@ -3112,7 +3115,10 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 		p = xdr_reserve_space(xdr, 8);
 		if (!p)
 			goto out_resource;
-		p = xdr_encode_hyper(p, stat.size);
+		if (file_modified)
+			p = xdr_encode_hyper(p, size);
+		else
+			p = xdr_encode_hyper(p, stat.size);
 	}
 	if (bmval0 & FATTR4_WORD0_LINK_SUPPORT) {
 		p = xdr_reserve_space(xdr, 4);
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 82718d42f3b2..6bbb1d0276b4 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -125,8 +125,16 @@ struct nfs4_cb_fattr {
 	/* from CB_GETATTR reply */
 	u64 ncf_cb_change;
 	u64 ncf_cb_fsize;
+
+	unsigned long ncf_cb_flags;
+	bool ncf_file_modified;
+	u64 ncf_initial_cinfo;
+	u64 ncf_cur_fsize;
 };
 
+/* bits for ncf_cb_flags */
+#define	CB_GETATTR_BUSY		0
+
 /*
  * Represents a delegation stateid. The nfs4_client holds references to these
  * and they are put when it is being destroyed or when the delegation is
@@ -748,5 +756,6 @@ static inline bool try_to_expire_client(struct nfs4_client *clp)
 }
 
 extern __be32 nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp,
-				struct inode *inode);
+		struct inode *inode, bool *file_modified, u64 *size);
+extern void nfs4_cb_getattr(struct nfs4_cb_fattr *ncf);
 #endif   /* NFSD4_STATE_H */
-- 
2.39.3

