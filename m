Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 838BD743265
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Jun 2023 03:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjF3BxB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 29 Jun 2023 21:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbjF3BxA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 29 Jun 2023 21:53:00 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E940D10C3
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jun 2023 18:52:58 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35U06bDG020444;
        Fri, 30 Jun 2023 01:52:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=JJktJTQTP4NjFIwSW1dVc/XIAa4oj1njIVj965QNAek=;
 b=3wGeDve2ewrZ6zQ6Iy2ZH89gDQ+FHI/rh7RYxUhNvbL6Sy63YrMvdLloMpyvbNvbtJkB
 gjdY+CQdIhLkuBzg3YEYeN8qaA+ILGhyBnNZZGZm8aQc1yzX1xLs/Dm5ZoeXG0omehUd
 g1vPgpeA+d5a/bFfqDq0p44/2Nc269MSkZaDAwlPBP9XSIQye35qTSdjWfw0KPyrs0w0
 S/xiWemI0GSKLmdMm6v/+JLBymYmiOsGzUEBLhTOPDCGa98UvQiT8XvV6N7kznadCo25
 t/iGlNxQwjykdkPbJRdPQ2OaZqyTWtdukBephwNKYL+moHv5z63bYy82WTj8TIX2tfmy 2Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdq93etcw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Jun 2023 01:52:55 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35U1VsUF019930;
        Fri, 30 Jun 2023 01:52:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpxdyq0f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Jun 2023 01:52:54 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35U1qpev034790;
        Fri, 30 Jun 2023 01:52:53 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3rdpxdypy9-4;
        Fri, 30 Jun 2023 01:52:53 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v7 3/4] NFSD: handle GETATTR conflict with write delegation
Date:   Thu, 29 Jun 2023 18:52:39 -0700
Message-Id: <1688089960-24568-4-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1688089960-24568-1-git-send-email-dai.ngo@oracle.com>
References: <1688089960-24568-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-29_10,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306300014
X-Proofpoint-ORIG-GUID: 3629fbSkQ_f-3GybVIt0BSw0qY55hYC-
X-Proofpoint-GUID: 3629fbSkQ_f-3GybVIt0BSw0qY55hYC-
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

Add counter for write delegation recall due to conflict GETATTR. This is
used to evaluate the need to implement CB_GETATTR to adoid recalling the
delegation with conflit GETATTR.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 66 +++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/nfs4xdr.c   |  5 ++++
 fs/nfsd/state.h     |  3 +++
 fs/nfsd/stats.c     |  2 ++
 fs/nfsd/stats.h     |  7 +++++
 5 files changed, 83 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 6e61fa3acaf1..4c96cfe19531 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -8343,3 +8343,69 @@ nfsd4_get_writestateid(struct nfsd4_compound_state *cstate,
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
+ * delegation and a change/size GETATTR from another client. The server
+ * must either use the CB_GETATTR to get the current values of the
+ * attributes from the client that hold the delegation or recall the
+ * delegation before replying to the GETATTR. See RFC 8881 section
+ * 18.7.4.
+ *
+ * The current implementation does not support CB_GETATTR yet. However
+ * this feature is considered useful for avoid recalling the delegation
+ * in the case of GETATTR conflict and should be added in the follow up
+ * work.
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
+			nfsd_stats_wdeleg_getattr_inc();
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
index e0640b31d041..833634cdc761 100644
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
diff --git a/fs/nfsd/stats.c b/fs/nfsd/stats.c
index 777e24e5da33..63797635e1c3 100644
--- a/fs/nfsd/stats.c
+++ b/fs/nfsd/stats.c
@@ -65,6 +65,8 @@ static int nfsd_show(struct seq_file *seq, void *v)
 		seq_printf(seq, " %lld",
 			   percpu_counter_sum_positive(&nfsdstats.counter[NFSD_STATS_NFS4_OP(i)]));
 	}
+	seq_printf(seq, "\nwdeleg_getattr %lld",
+		percpu_counter_sum_positive(&nfsdstats.counter[NFSD_STATS_WDELEG_GETATTR]));
 
 	seq_putc(seq, '\n');
 #endif
diff --git a/fs/nfsd/stats.h b/fs/nfsd/stats.h
index 9b43dc3d9991..cf5524e7ca06 100644
--- a/fs/nfsd/stats.h
+++ b/fs/nfsd/stats.h
@@ -22,6 +22,7 @@ enum {
 	NFSD_STATS_FIRST_NFS4_OP,	/* count of individual nfsv4 operations */
 	NFSD_STATS_LAST_NFS4_OP = NFSD_STATS_FIRST_NFS4_OP + LAST_NFS4_OP,
 #define NFSD_STATS_NFS4_OP(op)	(NFSD_STATS_FIRST_NFS4_OP + (op))
+	NFSD_STATS_WDELEG_GETATTR,	/* count of getattr conflict with wdeleg */
 #endif
 	NFSD_STATS_COUNTERS_NUM
 };
@@ -93,4 +94,10 @@ static inline void nfsd_stats_drc_mem_usage_sub(struct nfsd_net *nn, s64 amount)
 	percpu_counter_sub(&nn->counter[NFSD_NET_DRC_MEM_USAGE], amount);
 }
 
+#ifdef CONFIG_NFSD_V4
+static inline void nfsd_stats_wdeleg_getattr_inc(void)
+{
+	percpu_counter_inc(&nfsdstats.counter[NFSD_STATS_WDELEG_GETATTR]);
+}
+#endif
 #endif /* _NFSD_STATS_H */
-- 
2.39.3

