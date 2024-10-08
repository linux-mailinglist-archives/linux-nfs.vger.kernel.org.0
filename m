Return-Path: <linux-nfs+bounces-6947-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3816199552F
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Oct 2024 18:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E22A11F27A91
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Oct 2024 16:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7281E0DF2;
	Tue,  8 Oct 2024 16:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dv0IWDtN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD80653365
	for <linux-nfs@vger.kernel.org>; Tue,  8 Oct 2024 16:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728406721; cv=none; b=QZuf/a8Ql9u74101RdcMbiNbQvJqdRc7TfcYuYr0hKFeSZ6TDuoPFHFHwBdUvdw8E0MsN2xO4s2RwyXxwfer3z8a0HIMnG3vd+R2saW/NVfXLSvtmYw8Ocx98HvioDrRvbHftj4vBTx5TabEehMEGjYAiYh0UYIFiEq5Lxn+QAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728406721; c=relaxed/simple;
	bh=cuvI2mFrGpu/9IW5DNdMshEu05Hifels27/L06aLHlw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=UcvbN1/y2814b1Vza36hqnkzoR+AoqeTIC8tVKqHSfZ/krOobJbF0dzIre3oKWsXXWHA/C2P0UaAHFqAAiVG1F3917pa+D9b3eHV7Y17zIz51x+21o5ClBLSpiNweHNXnsD/mzlvWQKS4CPmW6zWKWuSJpkXruKnHaemVC673r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dv0IWDtN; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498Dtbi4011432;
	Tue, 8 Oct 2024 16:58:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:date:from:message-id:subject:to; s=corp-2023-11-20; bh=1ozWg0qF
	186P8KrXrhQjbpqQlOKV9IIZFUKTLrWoSGI=; b=dv0IWDtNAu5MrS1DUTyoRDlR
	AbXUhvNu1vo5ch7DcGfQa3VOq6n0klQlXmsVAvh637jugOrFUxDMW9P9iLCoshC8
	EC8rkFvdF4dQ/rTYN6+ndP0UAEovGetZL6Y31hXeo9m/FJb245tCoSZ08II0haPN
	tHb4NnXpKQXCS/bZo7ib4h0IWcFkl2QgEsxKaBp9Lm3dIzj+SzDQeJXUTWPI5yN1
	687IqNzNv8zQ02b6huFWRaiz9H4/qMaxkAyD2b/bRTdxSTm17qWL2jaITUcMC2JO
	LNHx00gay6wm1EQlBAhwz6+WCwK7wYuJOIFaqRQEx2Unq7m/21Vkyu5fi1Y8+g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 422yyv6cae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Oct 2024 16:58:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 498FfOMI022841;
	Tue, 8 Oct 2024 16:58:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uw7ephx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Oct 2024 16:58:35 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 498GwYLx015854;
	Tue, 8 Oct 2024 16:58:34 GMT
Received: from ca-common-sca.us.oracle.com (ca-common-sca.us.oracle.com [10.132.20.202])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 422uw7enrx-1;
	Tue, 08 Oct 2024 16:58:32 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: anna.schumaker@oracle.com, trondmy@hammerspace.com
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFS: remove revoked delegation from server's delegation list
Date: Tue,  8 Oct 2024 09:57:58 -0700
Message-Id: <1728406678-16857-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-08_14,2024-10-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410080108
X-Proofpoint-GUID: PX6WeBOFMruEZ5zQHMgwpimXK3oiDYfy
X-Proofpoint-ORIG-GUID: PX6WeBOFMruEZ5zQHMgwpimXK3oiDYfy
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

After the delegation is returned to the NFS server remove it
from the server's delegations list to reduce the time it takes
to scan this list.

Piggyback the state manager's run to return marked delegations
for this job.

Network trace captured while running the below script shows the
time taken to service the CB_RECALL increases gradually due to
the overhead of traversing the delegation list in
nfs_delegation_find_inode_server. 

The NFS server in this test is a Solaris server which issues
CB_RECALL when receiving the all-zero stateid in the SETATTR.

#!/bin/sh 

mount=/mnt/data
for i in $(seq 1 20)
do
   echo $i
   mkdir $mount/testtarfile$i
   time  tar -C $mount/testtarfile$i -xf 5000_files.tar
done

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfs/delegation.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 20cb2008f9e4..65b10f7ea232 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -642,6 +642,17 @@ static int nfs_server_return_marked_delegations(struct nfs_server *server,
 
 		if (test_bit(NFS_DELEGATION_INODE_FREEING, &delegation->flags))
 			continue;
+		if (test_bit(NFS_DELEGATION_REVOKED, &delegation->flags)) {
+			inode = nfs_delegation_grab_inode(delegation);
+			if (inode) {
+				rcu_read_unlock();
+				if (nfs_detach_delegation(NFS_I(inode), delegation, server))
+					nfs_put_delegation(delegation);
+				iput(inode);
+				cond_resched();
+				goto restart;
+			}
+		}
 		if (!nfs_delegation_need_return(delegation)) {
 			if (nfs4_is_valid_delegation(delegation, 0))
 				prev = delegation;
-- 
2.43.0


