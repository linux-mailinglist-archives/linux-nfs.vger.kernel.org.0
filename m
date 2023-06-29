Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3805741E55
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jun 2023 04:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjF2Cgj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 28 Jun 2023 22:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbjF2Cgi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 28 Jun 2023 22:36:38 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9152684
        for <linux-nfs@vger.kernel.org>; Wed, 28 Jun 2023 19:36:37 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35T1iGFn019783;
        Thu, 29 Jun 2023 02:36:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=FFAeYs9srtWrkA/Fw1Kly3+6AzEYRgHrE24rS4MrWpU=;
 b=yDW+01Wbrcs848YEyspysojDvgZTE61omXz8jGeHzq3heieNh1ThU6oLiOjP3l7H2tMa
 MVeN/X6WZz4tLL1TUhMWFqO50tycZtr5tM+Hjg8AlDMypib3sWhnFLYMLNZHDhVQxmr+
 rYD29uTrOrvkreN8Wu3ewDVqZGLwz8sPuMSM9c4GL6iqTf9Xd7XdJgBFA8y93+SMsOPM
 TE5SE5IEbJwd5NEC/51s4QmXi5ca2rplBNb9kt/8VhJj38Do6Y6oUrrKAL+59xJn8pWC
 0Mm7gqGoBiwN8sCDvV652LIhbWWV0kfoM8W/sgbEQlnai7JBqtgFNi2qft6i7GOels+N Qg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdq3128yf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 02:36:34 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35T2VCCf038194;
        Thu, 29 Jun 2023 02:36:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpxdc882-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 02:36:33 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35T2Zt7e011587;
        Thu, 29 Jun 2023 02:36:33 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3rdpxdc87d-3;
        Thu, 29 Jun 2023 02:36:33 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v6 2/5] NFSD: Enable write delegation support for NFSv4.1+ client
Date:   Wed, 28 Jun 2023 19:36:13 -0700
Message-Id: <1688006176-32597-3-git-send-email-dai.ngo@oracle.com>
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
X-Proofpoint-ORIG-GUID: f5pJhoPiW6pAM-A55KwnHyX52UsSsyUa
X-Proofpoint-GUID: f5pJhoPiW6pAM-A55KwnHyX52UsSsyUa
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This patch grants write delegations for OPEN with NFS4_SHARE_ACCESS_WRITE
if there is no conflict with other OPENs.

Write delegation conflicts with another OPEN, REMOVE, RENAME and SETATTR
are handled the same as read delegation using notify_change,
try_break_deleg.

The write delegation support is for NFSv4.1+ client only since the NFSv4.0
Linux client behavior is not compliant with RFC 7530 Section 16.7.5. It
expects the server to look ahead in the compound to find a stateid in order
to determine whether the client that sends the GETATTR is the same client
that holds the write delegation. RFC 7530 spec does not call for the server
to look ahead in order to service the GETATTR op.

Tracepoint added to track whether read or write delegation is granted.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 40 +++++++++++++++++++++++++++++-----------
 fs/nfsd/trace.h     |  1 +
 2 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 6e61fa3acaf1..f971919b04c7 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1144,7 +1144,7 @@ static void block_delegations(struct knfsd_fh *fh)
 
 static struct nfs4_delegation *
 alloc_init_deleg(struct nfs4_client *clp, struct nfs4_file *fp,
-		 struct nfs4_clnt_odstate *odstate)
+		struct nfs4_clnt_odstate *odstate, u32 dl_type)
 {
 	struct nfs4_delegation *dp;
 	long n;
@@ -1170,7 +1170,7 @@ alloc_init_deleg(struct nfs4_client *clp, struct nfs4_file *fp,
 	INIT_LIST_HEAD(&dp->dl_recall_lru);
 	dp->dl_clnt_odstate = odstate;
 	get_clnt_odstate(odstate);
-	dp->dl_type = NFS4_OPEN_DELEGATE_READ;
+	dp->dl_type = dl_type;
 	dp->dl_retries = 1;
 	dp->dl_recalled = false;
 	nfsd4_init_cb(&dp->dl_recall, dp->dl_stid.sc_client,
@@ -5451,6 +5451,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	struct nfs4_delegation *dp;
 	struct nfsd_file *nf;
 	struct file_lock *fl;
+	u32 dl_type;
 
 	/*
 	 * The fi_had_conflict and nfs_get_existing_delegation checks
@@ -5460,7 +5461,13 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	if (fp->fi_had_conflict)
 		return ERR_PTR(-EAGAIN);
 
-	nf = find_readable_file(fp);
+	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
+		nf = find_writeable_file(fp);
+		dl_type = NFS4_OPEN_DELEGATE_WRITE;
+	} else {
+		nf = find_readable_file(fp);
+		dl_type = NFS4_OPEN_DELEGATE_READ;
+	}
 	if (!nf) {
 		/*
 		 * We probably could attempt another open and get a read
@@ -5491,11 +5498,11 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 		return ERR_PTR(status);
 
 	status = -ENOMEM;
-	dp = alloc_init_deleg(clp, fp, odstate);
+	dp = alloc_init_deleg(clp, fp, odstate, dl_type);
 	if (!dp)
 		goto out_delegees;
 
-	fl = nfs4_alloc_init_lease(dp, NFS4_OPEN_DELEGATE_READ);
+	fl = nfs4_alloc_init_lease(dp, dl_type);
 	if (!fl)
 		goto out_clnt_odstate;
 
@@ -5570,8 +5577,13 @@ static void nfsd4_open_deleg_none_ext(struct nfsd4_open *open, int status)
 /*
  * Attempt to hand out a delegation.
  *
- * Note we don't support write delegations, and won't until the vfs has
- * proper support for them.
+ * Note we don't support write delegations for NFSv4.0 client since the Linux
+ * client behavior is not compliant with RFC 7530 Section 16.7.5 with regard
+ * to handle the conflict GETATTR. It expects the server to look ahead in the
+ * compound (PUTFH, GETATTR, DELEGRETURN) to find a stateid in order to
+ * determine whether the client that sends the GETATTR is the same with the
+ * client that holds the write delegation. RFC 7530 spec does not call for
+ * the server to look ahead in order to service the conflict GETATTR op.
  */
 static void
 nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
@@ -5590,8 +5602,6 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 		case NFS4_OPEN_CLAIM_PREVIOUS:
 			if (!cb_up)
 				open->op_recall = 1;
-			if (open->op_delegate_type != NFS4_OPEN_DELEGATE_READ)
-				goto out_no_deleg;
 			break;
 		case NFS4_OPEN_CLAIM_NULL:
 			parent = currentfh;
@@ -5606,6 +5616,9 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 				goto out_no_deleg;
 			if (!cb_up || !(oo->oo_flags & NFS4_OO_CONFIRMED))
 				goto out_no_deleg;
+			if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE &&
+					!clp->cl_minorversion)
+				goto out_no_deleg;
 			break;
 		default:
 			goto out_no_deleg;
@@ -5616,8 +5629,13 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 
 	memcpy(&open->op_delegate_stateid, &dp->dl_stid.sc_stateid, sizeof(dp->dl_stid.sc_stateid));
 
-	trace_nfsd_deleg_read(&dp->dl_stid.sc_stateid);
-	open->op_delegate_type = NFS4_OPEN_DELEGATE_READ;
+	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
+		open->op_delegate_type = NFS4_OPEN_DELEGATE_WRITE;
+		trace_nfsd_deleg_write(&dp->dl_stid.sc_stateid);
+	} else {
+		open->op_delegate_type = NFS4_OPEN_DELEGATE_READ;
+		trace_nfsd_deleg_read(&dp->dl_stid.sc_stateid);
+	}
 	nfs4_put_stid(&dp->dl_stid);
 	return;
 out_no_deleg:
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 72a906a053dc..56f28364cc6b 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -607,6 +607,7 @@ DEFINE_STATEID_EVENT(layout_recall_release);
 
 DEFINE_STATEID_EVENT(open);
 DEFINE_STATEID_EVENT(deleg_read);
+DEFINE_STATEID_EVENT(deleg_write);
 DEFINE_STATEID_EVENT(deleg_return);
 DEFINE_STATEID_EVENT(deleg_recall);
 
-- 
2.39.3

