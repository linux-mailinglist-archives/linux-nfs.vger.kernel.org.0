Return-Path: <linux-nfs+bounces-655-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E02E8815217
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Dec 2023 22:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67456B2208F
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Dec 2023 21:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E7248784;
	Fri, 15 Dec 2023 21:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DNzK8yQ2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8704879B
	for <linux-nfs@vger.kernel.org>; Fri, 15 Dec 2023 21:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFK84LO018399;
	Fri, 15 Dec 2023 21:47:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=b/H5JPUH+b32MlkB1jZGr68PwhnJY7JoOoPE47bH6io=;
 b=DNzK8yQ2TGQaU4lVz9ZFaCCVV4MjAwkWqJXQwPgNyGZEI8uLl8Wns2eEfNZd9aWdqbfD
 ZjTzCNm8yVWtf0sq+97jh48C3j0NZRbhdn3bTm6NvfwTmEOD8j1l7Toiv1VD4su+LSj5
 Ce6Yj9HPlQuEoQBSRXaPHORpN8XrT7IyInXqOj9zHYdfF95abjeNe/K5rHVR4wDLL7Qv
 XX3QDib/UUcsEacnYZWMt1UlNC86i9qv9PKF67X5NakO59hi8vKjNuhfs9RL+vJ4j1XU
 vEjyCy2EiQCpk5VjbSfXp9RuPN7XgjwevqX1N3lHkc3L/1tgIY6KVio4GaM+VRE6aXqs yw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvf5ceed3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 21:47:31 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFKFH6f029913;
	Fri, 15 Dec 2023 21:47:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uvepchqny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 21:47:30 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BFLlSH6022773;
	Fri, 15 Dec 2023 21:47:30 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3uvepchqn0-4;
	Fri, 15 Dec 2023 21:47:30 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org, linux-nfs@stwm.de
Subject: [PATCH 3/3 v2] NFSD: Fix server reboot hang problem when callback workqueue is stuck
Date: Fri, 15 Dec 2023 13:47:17 -0800
Message-Id: <1702676837-31320-4-git-send-email-dai.ngo@oracle.com>
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
X-Proofpoint-ORIG-GUID: rr8Iz5UwdL6ZGA2ev0pma2OyGYd15Pxg
X-Proofpoint-GUID: rr8Iz5UwdL6ZGA2ev0pma2OyGYd15Pxg
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

If the callback workqueue is stuck, nfsd4_deleg_getattr_conflict will
also stuck waiting for the callback request to be executed. This causes
the client to hang waiting for the reply of the GETATTR and also causes
the reboot of the NFS server to hang due to the pending NFS request.

Fix by replacing wait_on_bit with wait_on_bit_timeout with 20 seconds
time out.

Reported-by: Wolfgang Walter <linux-nfs@stwm.de>
Fixes: 6c41d9a9bd02 ("NFSD: handle GETATTR conflict with write delegation")
Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 6 +++++-
 fs/nfsd/state.h     | 2 ++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 175f3e9f5822..0cc7d4953807 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2948,6 +2948,9 @@ void nfs4_cb_getattr(struct nfs4_cb_fattr *ncf)
 	if (test_and_set_bit(CB_GETATTR_BUSY, &ncf->ncf_cb_flags))
 		return;
 
+	/* set to proper status when nfsd4_cb_getattr_done runs */
+	ncf->ncf_cb_status = NFS4ERR_IO;
+
 	refcount_inc(&dp->dl_stid.sc_count);
 	if (!nfsd4_run_cb(&ncf->ncf_getattr)) {
 		refcount_dec(&dp->dl_stid.sc_count);
@@ -8558,7 +8561,8 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode,
 			nfs4_cb_getattr(&dp->dl_cb_fattr);
 			spin_unlock(&ctx->flc_lock);
 
-			wait_on_bit(&ncf->ncf_cb_flags, CB_GETATTR_BUSY, TASK_INTERRUPTIBLE);
+			wait_on_bit_timeout(&ncf->ncf_cb_flags, CB_GETATTR_BUSY,
+				TASK_INTERRUPTIBLE, NFSD_CB_GETATTR_TIMEOUT);
 			if (ncf->ncf_cb_status) {
 				status = nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
 				if (status != nfserr_jukebox ||
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index f96eaa8e9413..94563a6813a6 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -135,6 +135,8 @@ struct nfs4_cb_fattr {
 /* bits for ncf_cb_flags */
 #define	CB_GETATTR_BUSY		0
 
+#define	NFSD_CB_GETATTR_TIMEOUT	msecs_to_jiffies(20000) /* 20 secs */
+
 /*
  * Represents a delegation stateid. The nfs4_client holds references to these
  * and they are put when it is being destroyed or when the delegation is
-- 
2.39.3


