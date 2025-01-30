Return-Path: <linux-nfs+bounces-9801-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02947A23449
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jan 2025 20:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 219847A2B8F
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jan 2025 19:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4104B1F0E4F;
	Thu, 30 Jan 2025 19:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DLHJCLME"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842451F0E35
	for <linux-nfs@vger.kernel.org>; Thu, 30 Jan 2025 19:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738263797; cv=none; b=iuHzg7m9rCYft/Nvc3Z1usQww5zg9RNj7NMeNRQk/s0BGVkoumksg5P/lsoulC2CsOZ36DY+dVKiA0YwHHeoIlhPXTDo9XRQpsYJmilFSsKel9QPIZeXlGMDECqMgW7TGOivKThQiYCBN2u+0SqN4nGQnzw/i2FK1cJ+XhVRzOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738263797; c=relaxed/simple;
	bh=Ki0IPfKzIuwlQhF3qGtSb/lmg4DVZaXB56vw9sXj2iQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=h+31K70CyEUS1jw18xbzpiEt5iilgkhUagT/RUpv1E5s7S8HL/c5fkB+3Yu6ZehUiw/oom0+JdRitRp9pYbTgXoduiwXpnrmoGtdDlg1VDwV8sej/8KwWInUMvqnMzCLKaBkpB7v8KatTq+WTmBR4mT7xOMX78rY/YS5NnNi8FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DLHJCLME; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50UJ321a006346;
	Thu, 30 Jan 2025 19:03:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:date:from:message-id:subject:to; s=corp-2023-11-20; bh=FVHHMBDm
	byohfrYepSztx7Rx6VpTVqfpzW9e3mz0e4I=; b=DLHJCLME3BjHPKSIZkpmDkNN
	uAbKAxnqSYY4NNKwRPChKsB9ZMHr8g5S4oD5X/32BrmS8HFxdxjMcchpaIjDvZQV
	DQMIroXiW6b4BDVQutV7c30/vhZTF0nmoAKSM8BIgyHW82PImkDQHVhr9lJXlHH5
	JGZpl7TM+vvXAB8p5J+hhxHuu+cgcz9/K0Dms1xHLek5MWL3L9CSXM49U/SZSRON
	5ZgqoeEEGW3i3EkQXYqi4QQCC2/kN81mnsKlYrgirBokXRoZaHGtzFBWeyMKh7GV
	urZC3MH9sm+2++BZPW59WjPN3pwP2uY6SoQZF0rmu3PxQC0w2Ck92d1fAaAd1g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44gf7mg011-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jan 2025 19:03:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50UHUdEM038650;
	Thu, 30 Jan 2025 19:01:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44cpdbgs5r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jan 2025 19:01:42 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50UJ0nt2018634;
	Thu, 30 Jan 2025 19:01:41 GMT
Received: from ca-common-sca.us.oracle.com (ca-common-sca.us.oracle.com [10.132.20.202])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 44cpdbgs5d-1;
	Thu, 30 Jan 2025 19:01:41 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/1] NFSD: fix hang in nfsd4_shutdown_callback
Date: Thu, 30 Jan 2025 11:01:27 -0800
Message-Id: <1738263687-28256-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_08,2025-01-30_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501300145
X-Proofpoint-GUID: MuvPAr_vnm9f_MHQ9WNyCMnAQIF_6tcf
X-Proofpoint-ORIG-GUID: MuvPAr_vnm9f_MHQ9WNyCMnAQIF_6tcf
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

If nfs4_client is in courtesy state then there is no point to retry
the callback. This causes nfsd4_shutdown_callback to hang since
cl_cb_inflight is not 0. This hang lasts about 15 minutes until TCP
notifies NFSD that the connection was dropped.

This patch modifies nnfsd4_run_cb_work to skip the RPC call if
nfs4_client is in courtesy state.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4callback.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 50e468bdb8d4..cf6d29828f4e 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1583,8 +1583,11 @@ nfsd4_run_cb_work(struct work_struct *work)
 		nfsd4_process_cb_update(cb);
 
 	clnt = clp->cl_cb_client;
-	if (!clnt) {
-		/* Callback channel broken, or client killed; give up: */
+	if (!clnt || clp->cl_state == NFSD4_COURTESY) {
+		/*
+		 * Callback channel broken, client killed or
+		 * nfs4_client in courtesy state; give up.
+		 */
 		nfsd41_destroy_cb(cb);
 		return;
 	}
-- 
2.43.5


