Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD92741E58
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jun 2023 04:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjF2Cgl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 28 Jun 2023 22:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbjF2Cgj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 28 Jun 2023 22:36:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0911C2684
        for <linux-nfs@vger.kernel.org>; Wed, 28 Jun 2023 19:36:39 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35T1ikcQ019779;
        Thu, 29 Jun 2023 02:36:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=2pxqBjzBXfDSAEn7n32ikTE7i+SoeQIQ8KBRrR5rfiw=;
 b=YlEs22yBHpv8NyxclQmFpD+TkgLVvXtOB2HdR+sU+9aJXYr/krvHoE5Nteu3dy9BP+7b
 whi3akyVSjm87i+0MjCzUhkiX7iPQTnMLcAwHLzbcmZxBJb5ncB3aR/S/hcTz7o7BSl9
 1IkjshIKlEBTq625jrKRpzXycZ9kM96MGNHjxcuab1GD+XbzZ7blgNlxjAa6vIEu+ADP
 hWbPU/DJvWzjQOhdcM/7BP3rlA6oYtL/eRYxuKFZYUVa0i/BOiaeNieqHIveTD2yPyvv
 c9Lg0uS8aUgAKuokqMOXE2wLPpMa++Y2GC08Nv8lbCXfYZQy/Suz0AUgoy7VxPQSfTGy Kg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdq3128yh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 02:36:37 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35SNwXwv038255;
        Thu, 29 Jun 2023 02:36:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpxdc88p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 02:36:35 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35T2Zt7k011587;
        Thu, 29 Jun 2023 02:36:35 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3rdpxdc87d-6;
        Thu, 29 Jun 2023 02:36:35 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v6 5/5] NFSD: add counter for write delegation recall due to conflict GETATTR
Date:   Wed, 28 Jun 2023 19:36:16 -0700
Message-Id: <1688006176-32597-6-git-send-email-dai.ngo@oracle.com>
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
X-Proofpoint-ORIG-GUID: NiCf10hhsJ-QQlkSZosHYsKc4KJqKnUC
X-Proofpoint-GUID: NiCf10hhsJ-QQlkSZosHYsKc4KJqKnUC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add counter to keep track of how many times write delegations are
recalled due to conflict with GETATTR.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 1 +
 fs/nfsd/stats.c     | 2 ++
 fs/nfsd/stats.h     | 7 +++++++
 3 files changed, 10 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 2d2656c41ffb..6ce95e738359 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -8410,6 +8410,7 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode)
 			}
 break_lease:
 			spin_unlock(&ctx->flc_lock);
+			nfsd_stats_wdeleg_getattr_inc();
 			status = nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
 			if (status != nfserr_jukebox ||
 					!nfsd_wait_for_delegreturn(rqstp, inode))
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

