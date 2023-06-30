Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC26D743266
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Jun 2023 03:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjF3BxC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 29 Jun 2023 21:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjF3BxA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 29 Jun 2023 21:53:00 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311391FE7
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jun 2023 18:52:59 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35TNYYXc006152;
        Fri, 30 Jun 2023 01:52:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=2La85BUQOxbap43h9JW0pIZ/IYr+a7OPmhQIJysPW9w=;
 b=EJVrgyLz6A1wIehVGrPGHtBbna0Ur4h+1p2JqCyoCeNf9izTOShtqk9eZI8a6IN9Q4QM
 bhdT2vGUwzD4YUVs00SXJFhTrPo6iMQuort+O0NPot+Y2ufQCBO7rTusDgQ/0tklCTlx
 WLxwHfWC0eLJ3DXyC6g/EoWmHsXNOoAm+pLDcziX0QCInqVRVAZy7SD7dx4j0gxi2X+w
 O9FFpMSf0DnaBi2sEIGlpn2VO8YZNRtWFYyV1zTUBuSIJk294Ll8Jxbzhu0g9QjZsvGl
 mJG5gCWKDZdzkd5VHoffovImGnayYHg7VLu1qnR+HvRIjhR9/8fnaM9O7pLFJtY+evut 2Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdq3172qr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Jun 2023 01:52:56 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35U0H1Tk020127;
        Fri, 30 Jun 2023 01:52:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpxdyq0q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Jun 2023 01:52:55 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35U1qpex034790;
        Fri, 30 Jun 2023 01:52:54 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3rdpxdypy9-5;
        Fri, 30 Jun 2023 01:52:54 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v7 4/4] NFSD: Enable write delegation support for NFSv4.1+ client
Date:   Thu, 29 Jun 2023 18:52:40 -0700
Message-Id: <1688089960-24568-5-git-send-email-dai.ngo@oracle.com>
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
X-Proofpoint-ORIG-GUID: ZmAc_GH18ZPH3umHp3i5nQWkNDMPV6ra
X-Proofpoint-GUID: ZmAc_GH18ZPH3umHp3i5nQWkNDMPV6ra
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

The NFSv4.0 protocol does not enable a server to determine that a
conflicting GETATTR originated from the client holding the
delegation versus coming from some other client. With NFSv4.1 and
later, the SEQUENCE operation that begins each COMPOUND contains a
client ID, so delegation recall can be safely squelched in this case.

With NFSv4.0, therefore, the server must recall or send a CB_GETATTR
(per RFC 7530 Section 16.7.5) even when the GETATTR originates from
the client holding that delegation.

An NFSv4.0 client can trigger a pathological situation if it always
sends a DELEGRETURN preceded by a conflicting GETATTR in the same
COMPOUND. COMPOUND execution will always stop at the GETATTR and the
DELEGRETURN will never get executed. The server eventually revokes
the delegation, which can result in loss of open or lock state.

Tracepoint added to track whether read or write delegation is granted.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 40 +++++++++++++++++++++++++++++-----------
 fs/nfsd/trace.h     |  1 +
 2 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 4c96cfe19531..15b5043eeca5 100644
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

