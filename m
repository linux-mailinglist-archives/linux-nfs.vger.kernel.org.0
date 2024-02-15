Return-Path: <linux-nfs+bounces-1967-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D606F856CA7
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Feb 2024 19:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74D1FB2222F
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Feb 2024 18:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670BC1386B3;
	Thu, 15 Feb 2024 18:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="frNnFSZe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665E21386B8
	for <linux-nfs@vger.kernel.org>; Thu, 15 Feb 2024 18:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708021623; cv=none; b=Wa97G8I+wY46wLLlkt+EZ1UT8z2U8cY7Yw8gfG0Q39XszV+5p8l5jIKZ2k+IG/3r6oPlRKK1c96oMVjJtxjBQ20G3/bRk/RAFBM+N6hBeqL+HkYnCgpMUujjcZrfRxPQfIwtQLGAciskxyTsaCVhBTQ0JHTm0+t7y9FTOndGBGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708021623; c=relaxed/simple;
	bh=dZNJnYbp/dwwXznXNtSh9imIbTObrZ3akm2Zc+q2WN0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=lCX8dg/l1XlcrdeFKjTZL96FtnRIqrG04wnPFgNHI3EWBktnsoEsPxiya/GP3oout5IFHjhm++2SeViAP+RbQMsFcKSSfSL80Y0Q6CByEuLGWF2qJWdpZFNS95f2QllYZAVvcJp8a/O5v3mhmfp3yn+4KNr+rRgqANPStudRSsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=frNnFSZe; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41FFStk1031013;
	Thu, 15 Feb 2024 18:26:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=zzAhjvOMtpL/2Qk0+LYKvVdLolbEduXOMHfQjbBaGuQ=;
 b=frNnFSZe43u2sxsFO9w0MMnAn4t4ZpafaaA06vcob8WabVeuFcvISQQnbFIAnlMhzydH
 go0cU+Ol87RVhptfKQ+sk+hZFuyGwZt69mckK2evXasDk179vvsEJ10BKwXfzDbh1M3z
 8s4P6jXgKHq/mDTaEUXoR+dq7bxqaWmNEtVvYh3Z1Ttf726kAns5nFtuI1C8LY9xI3aN
 yh6Nad/PfO2cCc4LTZw3VY+du7l7x6poNGfVk0hUUEyhqfBFbQYYqx8Rf6m+hSDMUEIK
 cLtpNA9CC8Ml4piJ9bvrXnkkXJwEpC6NI6my+39cgBAwbpmifIGpSYv1ezWZpyP6odqI dg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w9301jwwg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 18:26:57 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41FI8qam000682;
	Thu, 15 Feb 2024 18:26:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykay7k8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 18:26:56 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41FIQsmU032173;
	Thu, 15 Feb 2024 18:26:56 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3w5ykay7gf-3;
	Thu, 15 Feb 2024 18:26:56 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v2 2/2] NFSD: handle GETATTR conflict with write delegation
Date: Thu, 15 Feb 2024 10:26:44 -0800
Message-Id: <1708021604-28321-3-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1708021604-28321-1-git-send-email-dai.ngo@oracle.com>
References: <1708021604-28321-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_17,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0 mlxscore=0
 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402150149
X-Proofpoint-GUID: Nah-1hjWnoCyvBtiyr-oyyW30RHlF4Iq
X-Proofpoint-ORIG-GUID: Nah-1hjWnoCyvBtiyr-oyyW30RHlF4Iq
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
 fs/nfsd/nfs4state.c | 116 ++++++++++++++++++++++++++++++++++++++++----
 fs/nfsd/nfs4xdr.c   |  10 +++-
 fs/nfsd/nfsd.h      |   1 +
 fs/nfsd/state.h     |  10 +++-
 4 files changed, 124 insertions(+), 13 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 2fa54cfd4882..a1ce38f9b936 100644
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
@@ -2896,11 +2901,59 @@ nfsd4_cb_recall_any_release(struct nfsd4_callback *cb)
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
@@ -5635,6 +5688,8 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	struct svc_fh *parent = NULL;
 	int cb_up;
 	int status = 0;
+	struct kstat stat;
+	struct path path;
 
 	cb_up = nfsd4_cb_channel_good(oo->oo_owner.so_client);
 	open->op_recall = false;
@@ -5672,6 +5727,18 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
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
@@ -8428,6 +8495,8 @@ nfsd4_get_writestateid(struct nfsd4_compound_state *cstate,
  * nfsd4_deleg_getattr_conflict - Recall if GETATTR causes conflict
  * @rqstp: RPC transaction context
  * @inode: file to be checked for a conflict
+ * @modified: return true if file was modified
+ * @size: new size of file if modified is true
  *
  * This function is called when there is a conflict between a write
  * delegation and a change/size GETATTR from another client. The server
@@ -8436,21 +8505,21 @@ nfsd4_get_writestateid(struct nfsd4_compound_state *cstate,
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
@@ -8475,12 +8544,39 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode)
 				return 0;
 			}
 break_lease:
-			spin_unlock(&ctx->flc_lock);
 			nfsd_stats_wdeleg_getattr_inc();
-			status = nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
-			if (status != nfserr_jukebox ||
-					!nfsd_wait_for_delegreturn(rqstp, inode))
-				return status;
+
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
index c719c475a068..7f68277fbfa5 100644
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
index 304e9728b929..908eb7e47842 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -365,6 +365,7 @@ void		nfsd_lockd_shutdown(void);
 #define	NFSD_CLIENT_MAX_TRIM_PER_RUN	128
 #define	NFS4_CLIENTS_PER_GB		1024
 #define NFSD_DELEGRETURN_TIMEOUT	(HZ / 34)	/* 30ms */
+#define	NFSD_CB_GETATTR_TIMEOUT		NFSD_DELEGRETURN_TIMEOUT
 
 /*
  * The following attributes are currently not supported by the NFSv4 server:
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 0bbbe57e027d..f894ba6c9a69 100644
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
@@ -746,5 +754,5 @@ static inline bool try_to_expire_client(struct nfs4_client *clp)
 }
 
 extern __be32 nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp,
-				struct inode *inode);
+		struct inode *inode, bool *file_modified, u64 *size);
 #endif   /* NFSD4_STATE_H */
-- 
2.39.3


