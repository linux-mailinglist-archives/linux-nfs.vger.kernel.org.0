Return-Path: <linux-nfs+bounces-1977-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8707856FC8
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Feb 2024 23:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 419C11F23008
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Feb 2024 22:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D4D1420A8;
	Thu, 15 Feb 2024 22:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fQ+R37Op"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFB613EFFB
	for <linux-nfs@vger.kernel.org>; Thu, 15 Feb 2024 22:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708034745; cv=none; b=QPKgruoOaGwlZs5PDOpHOodWKqh/YywKKzvn6NA8em2Gw1fUIj/WJBDjxBD2BIxKSLfqit7L9UzeW3E9K2YfYzOWGdNZ71AMj+mqQrcKJWnBuxWkrAIaTwsKnOhpFehV6cdgpZuXocSaGcVOheVZ3JEZiqz9Jp2QRd49osbRp+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708034745; c=relaxed/simple;
	bh=Lr9NjaO5wUO2pGuCGEAcdUCG5SnrMkEvAVgp0Q69h20=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=eZ504fyZxYTbtJTt3Xppj8m8JsI0mhr32hSiBx/HPfBSnxBTFetmatqIcjxrwB41HQXnbNcjJ8im+vWIhCdgCLW3KlzRDDZBa5CX0tVwvivGvny6jHriohLV1qr/fAVSPphCUvTu6NTTnCKTwZVUr7qpkBcBpbaxWKWnXOWknT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fQ+R37Op; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41FLSTnG029426;
	Thu, 15 Feb 2024 22:05:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=G4SGYoilDgs4mQb7dCd84kNyU2OPmc3bzjPhIW9iCFw=;
 b=fQ+R37Ope7UgsE8Mlr1bNGsNBgFXW9PNyp8C3fQCatNVHc/rL8D9w0iB8SBxlEnpVsjQ
 xNefmYqFYgM20VuuUiag25ARglZMU/yUEjqWPM0So9Wi7uGPSTaW+5XHyL4N3aJveMSs
 0BumGLGb/CrhQs0E+QwNF6TaX5EQ9x/YnQ0o1FgbpTkVX/FmGtQNKqqTgii7WftGbCl1
 sqcPqB2+ubYXbdYFzS5jEjOT84fY8dNDHHR4RXDERYMsG82lp8IMiy1lvKVGDYu+Lx6+
 IGR3FGL9Kgigu1SLhRciAacAtyin0mSDCPVcOmeMsN9tJCt0+pS3WLUuDx0VB6hfZivI jw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w92db3ect-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 22:05:36 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41FM4cBj015051;
	Thu, 15 Feb 2024 22:05:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykb72sf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 22:05:35 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41FM5XEf007551;
	Thu, 15 Feb 2024 22:05:34 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3w5ykb72r7-3;
	Thu, 15 Feb 2024 22:05:34 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v3 2/2] NFSD: handle GETATTR conflict with write delegation
Date: Thu, 15 Feb 2024 14:05:22 -0800
Message-Id: <1708034722-15329-3-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1708034722-15329-1-git-send-email-dai.ngo@oracle.com>
References: <1708034722-15329-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_21,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402150172
X-Proofpoint-GUID: skI6CxPqcVRrUPygjtLNztXK9awXLm-A
X-Proofpoint-ORIG-GUID: skI6CxPqcVRrUPygjtLNztXK9awXLm-A
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

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
 fs/nfsd/nfs4state.c | 115 ++++++++++++++++++++++++++++++++++++++++----
 fs/nfsd/nfs4xdr.c   |  10 +++-
 fs/nfsd/nfsd.h      |   1 +
 fs/nfsd/state.h     |  10 +++-
 4 files changed, 123 insertions(+), 13 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index d9260e77ef2d..948148182cc5 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -127,6 +127,7 @@ static void free_session(struct nfsd4_session *);
 
 static const struct nfsd4_callback_ops nfsd4_cb_recall_ops;
 static const struct nfsd4_callback_ops nfsd4_cb_notify_lock_ops;
+static const struct nfsd4_callback_ops nfsd4_cb_getattr_ops;
 
 static struct workqueue_struct *laundry_wq;
 
@@ -1189,6 +1190,10 @@ alloc_init_deleg(struct nfs4_client *clp, struct nfs4_file *fp,
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
@@ -3044,11 +3049,59 @@ nfsd4_cb_recall_any_release(struct nfsd4_callback *cb)
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
+static void nfs4_cb_getattr(struct nfs4_cb_fattr *ncf)
+{
+	struct nfs4_delegation *dp =
+			container_of(ncf, struct nfs4_delegation, dl_cb_fattr);
+
+	if (test_and_set_bit(CB_GETATTR_BUSY, &ncf->ncf_cb_flags))
+		return;
+	/* set to proper status when nfsd4_cb_getattr_done runs */
+	ncf->ncf_cb_status = NFS4ERR_IO;
+
+	refcount_inc(&dp->dl_stid.sc_count);
+	nfsd4_run_cb(&ncf->ncf_getattr);
+}
+
 static struct nfs4_client *create_client(struct xdr_netobj name,
 		struct svc_rqst *rqstp, nfs4_verifier *verf)
 {
@@ -5854,6 +5907,8 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	struct svc_fh *parent = NULL;
 	int cb_up;
 	int status = 0;
+	struct kstat stat;
+	struct path path;
 
 	cb_up = nfsd4_cb_channel_good(oo->oo_owner.so_client);
 	open->op_recall = false;
@@ -5891,6 +5946,18 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
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
@@ -8720,6 +8787,8 @@ nfsd4_get_writestateid(struct nfsd4_compound_state *cstate,
  * nfsd4_deleg_getattr_conflict - Recall if GETATTR causes conflict
  * @rqstp: RPC transaction context
  * @inode: file to be checked for a conflict
+ * @modified: return true if file was modified
+ * @size: new size of file if modified is true
  *
  * This function is called when there is a conflict between a write
  * delegation and a change/size GETATTR from another client. The server
@@ -8728,22 +8797,22 @@ nfsd4_get_writestateid(struct nfsd4_compound_state *cstate,
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
 	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 	struct file_lock_context *ctx;
 	struct file_lock *fl;
 	struct nfs4_delegation *dp;
+	struct iattr attrs;
+	struct nfs4_cb_fattr *ncf;
 
+	*modified = false;
 	ctx = locks_inode_context(inode);
 	if (!ctx)
 		return 0;
@@ -8768,12 +8837,38 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode)
 				return 0;
 			}
 break_lease:
-			spin_unlock(&ctx->flc_lock);
 			nfsd_stats_wdeleg_getattr_inc(nn);
-			status = nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
-			if (status != nfserr_jukebox ||
-					!nfsd_wait_for_delegreturn(rqstp, inode))
-				return status;
+			dp = fl->fl_owner;
+			ncf = &dp->dl_cb_fattr;
+			nfs4_cb_getattr(&dp->dl_cb_fattr);
+			spin_unlock(&ctx->flc_lock);
+			wait_on_bit_timeout(&ncf->ncf_cb_flags, CB_GETATTR_BUSY,
+					TASK_INTERRUPTIBLE, NFSD_CB_GETATTR_TIMEOUT);
+			if (ncf->ncf_cb_status) {
+				/* Recall delegation only if client didn't respond */
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
+				 * Per section 10.4.3 of RFC 8881, the server would
+				 * not update the file's metadata with the client's
+				 * modified size
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
index e3f761cd5ee7..9e8f230fc96e 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3507,6 +3507,8 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 		unsigned long	mask[2];
 	} u;
 	unsigned long bit;
+	bool file_modified = false;
+	u64 size = 0;
 
 	WARN_ON_ONCE(bmval[1] & NFSD_WRITEONLY_ATTRS_WORD1);
 	WARN_ON_ONCE(!nfsd_attrs_supported(minorversion, bmval));
@@ -3533,7 +3535,8 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 	}
 	args.size = 0;
 	if (u.attrmask[0] & (FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE)) {
-		status = nfsd4_deleg_getattr_conflict(rqstp, d_inode(dentry));
+		status = nfsd4_deleg_getattr_conflict(rqstp, d_inode(dentry),
+					&file_modified, &size);
 		if (status)
 			goto out;
 	}
@@ -3543,7 +3546,10 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 			  AT_STATX_SYNC_AS_STAT);
 	if (err)
 		goto out_nfserr;
-	args.size = args.stat.size;
+	if (file_modified)
+		args.size = size;
+	else
+		args.size = args.stat.size;
 
 	if (!(args.stat.result_mask & STATX_BTIME))
 		/* underlying FS does not offer btime so we can't share it */
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 8daf22d766c6..16c5a05f340e 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -367,6 +367,7 @@ void		nfsd_lockd_shutdown(void);
 #define	NFSD_CLIENT_MAX_TRIM_PER_RUN	128
 #define	NFS4_CLIENTS_PER_GB		1024
 #define NFSD_DELEGRETURN_TIMEOUT	(HZ / 34)	/* 30ms */
+#define	NFSD_CB_GETATTR_TIMEOUT		NFSD_DELEGRETURN_TIMEOUT
 
 /*
  * The following attributes are currently not supported by the NFSv4 server:
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 3bf418ee6c97..01c6f3445646 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -142,8 +142,16 @@ struct nfs4_cb_fattr {
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
@@ -773,5 +781,5 @@ static inline bool try_to_expire_client(struct nfs4_client *clp)
 }
 
 extern __be32 nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp,
-				struct inode *inode);
+		struct inode *inode, bool *file_modified, u64 *size);
 #endif   /* NFSD4_STATE_H */
-- 
2.39.3


