Return-Path: <linux-nfs+bounces-635-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2685B815013
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Dec 2023 20:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF87B1F24B81
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Dec 2023 19:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC2C3FE3F;
	Fri, 15 Dec 2023 19:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mZJ+Vzbp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933A43FE2C
	for <linux-nfs@vger.kernel.org>; Fri, 15 Dec 2023 19:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFI49iE022609;
	Fri, 15 Dec 2023 19:15:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=n4ujrx9voqvIVS/sjBPNAir6ur/tgh0jeTvzuCmTNo4=;
 b=mZJ+VzbpfbgiWt8dZD/Ky2rB+LYPxB7nJSsSprzfJjhxx4yQHiRMz5Fpzn8cLnd6C313
 dcc6Io9TSJJBdu8chhe6y7VgDEQ87lCCup3riS7AhCV/2LUF68UDXdLjDl0b57bdijxL
 D0CSETfsAm4NAkrJnXPjKmOTTfZSzPeVwUumfMwURQnXTpKuPqp295EZAunlYyTZOrO2
 dfawFfOt4dmEgMLQJXVS4T63tFLfzuncKA6E72Z5Rb1JPhTyWfVSaJt7aj8bbh7+tuz0
 jPaRaNjktOEYo1GOfc1woGhDifshjkaGIHrx/vHZ6eVdNBQ5fcPIfF1Lw6zd2WfrmNkm kw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvg9de7xr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 19:15:25 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFIJI7O016695;
	Fri, 15 Dec 2023 19:15:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uvepcfqnu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 19:15:24 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BFJEAbU013855;
	Fri, 15 Dec 2023 19:15:24 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3uvepcfqmh-3;
	Fri, 15 Dec 2023 19:15:24 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org, linux-nfs@stwm.de
Subject: [PATCH 2/3] NFSD: restore delegation's sc_count if nfsd4_run_cb fails
Date: Fri, 15 Dec 2023 11:15:02 -0800
Message-Id: <1702667703-17978-3-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1702667703-17978-1-git-send-email-dai.ngo@oracle.com>
References: <1702667703-17978-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-15_10,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312150135
X-Proofpoint-GUID: 5RL8H_Rni1u-eSEmEczIdcd_isvvHk3Y
X-Proofpoint-ORIG-GUID: 5RL8H_Rni1u-eSEmEczIdcd_isvvHk3Y
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

Under some load conditions the callback work request can not be queued
and nfsd4_run_cb returns 0 to caller. When this happens, the sc_count
of the delegation state was left with an extra reference count preventing
the state to be freed later.

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


