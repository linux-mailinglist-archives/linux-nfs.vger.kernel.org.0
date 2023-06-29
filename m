Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473FA741E56
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jun 2023 04:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjF2Cgk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 28 Jun 2023 22:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjF2Cgj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 28 Jun 2023 22:36:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED4F213D
        for <linux-nfs@vger.kernel.org>; Wed, 28 Jun 2023 19:36:37 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35T1iGFo019783;
        Thu, 29 Jun 2023 02:36:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=PqwnBOzYgcHaioRAm9U+Jt354aHNA8alWxdvz/jsXiA=;
 b=ikWV4A7yHP5Lbi9YqovBJFyyMHPN9jaIQv+yHSce6lHO4GN26p5K8XVnhcOcaveBP38b
 yvaZVyqYUqWB3LmA4THW4VjBgvr80qmXtT/JN8cXvt7nBXVseDEVq+r5w6UOESzoX+tm
 Tul8mC1MOcggcW/1DJR2eQURYeseYSM9pbKJ//lLBqKKLDQZwcOwpPWzJbGHWEno37Cp
 gZICulk6IZzPz3L8uSraTclgkRJM7i485TDdnJqAGaZNCt+/IRHXhOZIJVAejI+tHn2O
 Xy1PBCvG8PYg6sGo3bbMzAp6WYxyFVh66WOUxIElKS9q6pkZlXBKTn0o77b96GOhrzoB eg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdq3128yg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 02:36:35 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35T0HVcf038205;
        Thu, 29 Jun 2023 02:36:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpxdc88a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 02:36:34 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35T2Zt7g011587;
        Thu, 29 Jun 2023 02:36:33 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3rdpxdc87d-4;
        Thu, 29 Jun 2023 02:36:33 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v6 3/5] NFSD: handle GETATTR conflict with write delegation
Date:   Wed, 28 Jun 2023 19:36:14 -0700
Message-Id: <1688006176-32597-4-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1688006176-32597-1-git-send-email-dai.ngo@oracle.com>
References: <1688006176-32597-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_14,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306290021
X-Proofpoint-ORIG-GUID: mIycTOCFAUoITEBuvt4OVHarVMawksZ3
X-Proofpoint-GUID: mIycTOCFAUoITEBuvt4OVHarVMawksZ3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If the GETATTR request on a file that has write delegation in effect and
the request attributes include the change info and size attribute then
the write delegation is recalled. If the delegation is returned within
30ms then the GETATTR is serviced as normal otherwise the NFS4ERR_DELAY
error is returned for the GETATTR.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 60 +++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/nfs4xdr.c   |  5 ++++
 fs/nfsd/state.h     |  3 +++
 3 files changed, 68 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index f971919b04c7..2d2656c41ffb 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -8361,3 +8361,63 @@ nfsd4_get_writestateid(struct nfsd4_compound_state *cstate,
 {
 	get_stateid(cstate, &u->write.wr_stateid);
 }
+
+/**
+ * nfsd4_deleg_getattr_conflict - Trigger recall if GETATTR causes conflict
+ * @rqstp: RPC transaction context
+ * @inode: file to be checked for a conflict
+ *
+ * This function is called when there is a conflict between a write
+ * delegation and a change/size GETATR from another client. The server
+ * must either use the CB_GETATTR to get the current values of the
+ * attributes from the client that hold the delegation or recall the
+ * delegation before replying to the GETATTR. See RFC 8881 section
+ * 18.7.4.
+ *
+ * Returns 0 if there is no conflict; otherwise an nfs_stat
+ * code is returned.
+ */
+__be32
+nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode)
+{
+	__be32 status;
+	struct file_lock_context *ctx;
+	struct file_lock *fl;
+	struct nfs4_delegation *dp;
+
+	ctx = locks_inode_context(inode);
+	if (!ctx)
+		return 0;
+	spin_lock(&ctx->flc_lock);
+	list_for_each_entry(fl, &ctx->flc_lease, fl_list) {
+		if (fl->fl_flags == FL_LAYOUT)
+			continue;
+		if (fl->fl_lmops != &nfsd_lease_mng_ops) {
+			/*
+			 * non-nfs lease, if it's a lease with F_RDLCK then
+			 * we are done; there isn't any write delegation
+			 * on this inode
+			 */
+			if (fl->fl_type == F_RDLCK)
+				break;
+			goto break_lease;
+		}
+		if (fl->fl_type == F_WRLCK) {
+			dp = fl->fl_owner;
+			if (dp->dl_recall.cb_clp == *(rqstp->rq_lease_breaker)) {
+				spin_unlock(&ctx->flc_lock);
+				return 0;
+			}
+break_lease:
+			spin_unlock(&ctx->flc_lock);
+			status = nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
+			if (status != nfserr_jukebox ||
+					!nfsd_wait_for_delegreturn(rqstp, inode))
+				return status;
+			return 0;
+		}
+		break;
+	}
+	spin_unlock(&ctx->flc_lock);
+	return 0;
+}
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 76db2fe29624..b35855c8beb6 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2966,6 +2966,11 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 		if (status)
 			goto out;
 	}
+	if (bmval0 & (FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE)) {
+		status = nfsd4_deleg_getattr_conflict(rqstp, d_inode(dentry));
+		if (status)
+			goto out;
+	}
 
 	err = vfs_getattr(&path, &stat,
 			  STATX_BASIC_STATS | STATX_BTIME | STATX_CHANGE_COOKIE,
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index d49d3060ed4f..cbddcf484dba 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -732,4 +732,7 @@ static inline bool try_to_expire_client(struct nfs4_client *clp)
 	cmpxchg(&clp->cl_state, NFSD4_COURTESY, NFSD4_EXPIRABLE);
 	return clp->cl_state == NFSD4_EXPIRABLE;
 }
+
+extern __be32 nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp,
+				struct inode *inode);
 #endif   /* NFSD4_STATE_H */
-- 
2.39.3

