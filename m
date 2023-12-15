Return-Path: <linux-nfs+bounces-654-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFF2815214
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Dec 2023 22:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E17491C23D7E
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Dec 2023 21:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6450847F7E;
	Fri, 15 Dec 2023 21:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cnQo9Vjp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8C8487A4
	for <linux-nfs@vger.kernel.org>; Fri, 15 Dec 2023 21:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFK7soB020259;
	Fri, 15 Dec 2023 21:47:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=clqfrKp2EzJrU/yEImyYsR6EHCLrihWIHJ63NgZAmyA=;
 b=cnQo9VjpP8DCowT72xQkOfHrqHWRUpIpURJs6aSb6AqpI/HPgfnPgdoVGECWlnyge5bg
 xMsnfnEkgoHOrPK+lBwtLb06en55qa88rUCmuLE1xWB0kjQkSJMBb/BI2ad1WzH+JAoH
 q/A7CevST8L3Nc0FgNnbb9QxnjUosw7t7GjZC81WUa9RjSa5HKhcFmKbcAx2FMP/sCMy
 JXsj3g/1a3fTtrFMfgzSZOIbbfc9Z9Q+ctmiMV4VQcNKVyvXQ62mrek5lJpHwp25i6TC
 NFNKKngbnwug2l/t5Ob7eWUfN7pWDejUHCaWbgu66h5cBkf/GGC5WSuIPXCf6Qs82G0T nQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uveu2eb6f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 21:47:30 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFKEb7w029929;
	Fri, 15 Dec 2023 21:47:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uvepchqns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 21:47:30 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BFLlSH4022773;
	Fri, 15 Dec 2023 21:47:29 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3uvepchqn0-3;
	Fri, 15 Dec 2023 21:47:29 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org, linux-nfs@stwm.de
Subject: [PATCH 2/3 v2] NFSD: restore delegation's sc_count if nfsd4_run_cb fails
Date: Fri, 15 Dec 2023 13:47:16 -0800
Message-Id: <1702676837-31320-3-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1702676837-31320-1-git-send-email-dai.ngo@oracle.com>
References: <1702676837-31320-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-15_10,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312150152
X-Proofpoint-ORIG-GUID: 4a6MPWhX6dEuplH6-4Qjjk_hXgU4tAXG
X-Proofpoint-GUID: 4a6MPWhX6dEuplH6-4Qjjk_hXgU4tAXG
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

Under some load conditions the callback work request can not be queued
and nfsd4_run_cb returns 0 to caller. When this happens, the sc_count
of the delegation state was left with an extra reference count preventing
the state to be freed later.

We need to hold the flc_lock to prevent the lease to be removed which
allows the delegation state to be released. We need to do this since
we just do the refcount_dec if nfsd4_run_cb fails, instead of doing
nfs4_put_stid to free the state if this is the last refcount. 

Fixes: 6c41d9a9bd02 ("NFSD: handle GETATTR conflict with write delegation")
Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 40415929e2ae..175f3e9f5822 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2947,8 +2947,14 @@ void nfs4_cb_getattr(struct nfs4_cb_fattr *ncf)
 
 	if (test_and_set_bit(CB_GETATTR_BUSY, &ncf->ncf_cb_flags))
 		return;
+
 	refcount_inc(&dp->dl_stid.sc_count);
-	nfsd4_run_cb(&ncf->ncf_getattr);
+	if (!nfsd4_run_cb(&ncf->ncf_getattr)) {
+		refcount_dec(&dp->dl_stid.sc_count);
+		clear_bit(CB_GETATTR_BUSY, &ncf->ncf_cb_flags);
+		wake_up_bit(&ncf->ncf_cb_flags, CB_GETATTR_BUSY);
+		WARN_ON_ONCE(1);
+	}
 }
 
 static struct nfs4_client *create_client(struct xdr_netobj name,
@@ -4967,7 +4973,10 @@ static void nfsd_break_one_deleg(struct nfs4_delegation *dp)
 	 * we know it's safe to take a reference.
 	 */
 	refcount_inc(&dp->dl_stid.sc_count);
-	WARN_ON_ONCE(!nfsd4_run_cb(&dp->dl_recall));
+	if (!nfsd4_run_cb(&dp->dl_recall)) {
+		refcount_dec(&dp->dl_stid.sc_count);
+		WARN_ON_ONCE(1);
+	}
 }
 
 /* Called from break_lease() with flc_lock held. */
@@ -8543,12 +8552,12 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode,
 				return 0;
 			}
 break_lease:
-			spin_unlock(&ctx->flc_lock);
 			nfsd_stats_wdeleg_getattr_inc();
-
 			dp = fl->fl_owner;
 			ncf = &dp->dl_cb_fattr;
 			nfs4_cb_getattr(&dp->dl_cb_fattr);
+			spin_unlock(&ctx->flc_lock);
+
 			wait_on_bit(&ncf->ncf_cb_flags, CB_GETATTR_BUSY, TASK_INTERRUPTIBLE);
 			if (ncf->ncf_cb_status) {
 				status = nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
-- 
2.39.3


