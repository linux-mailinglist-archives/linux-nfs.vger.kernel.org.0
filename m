Return-Path: <linux-nfs+bounces-6967-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F34995B3D
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Oct 2024 00:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71B8AB257AF
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Oct 2024 22:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BC714A82;
	Tue,  8 Oct 2024 22:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gcDh6DcS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FB0215003
	for <linux-nfs@vger.kernel.org>; Tue,  8 Oct 2024 22:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728428311; cv=none; b=geIR+b5u91jaQF/iRKpt3bc1sei9+D9D4VJesdzWWb2kgY3x/hVkNz41KKA6+lBV0xpypu00Tj9Phi92mYRJ6JwHI3hIHPrD5uB4/XlPleSmXPIp017f9kThKwD5rBVVM0Tu8dXPCoNyCuYO6f7/6DhlPXY0FF2COhztJFMeY88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728428311; c=relaxed/simple;
	bh=ibAvb6BG70dsAozytr6mmFE1avFLfCJHLRtoPeUN8uI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=SAck1d7JZ6tT/9D8SJMc6JuQz+xAzqiZznnkrL/bzvWMkQtjZ2UwVk1yz3HehhFquIKe3cqA1ck9YxHRilUG9XwCw1y4X7gYU3Sbx2zmlRiztl0JACNHtNPjsYqucMoXeh2ZuoQvm6x3JO9Yk5+VFXSynDGuU2W6RNfh8LKufrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gcDh6DcS; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498Jtd3S015063;
	Tue, 8 Oct 2024 22:58:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:date:from:message-id:subject:to; s=corp-2023-11-20; bh=EaGFQfDo
	lktpXagTKbJvu5Kh/B2rHfMSa3HPrbwEOcE=; b=gcDh6DcStm/Uavc7WAdIjzlp
	ShOWeif9P3x8lgECGqkZpPwf9HHyEhJrKeF0cifWiU9283xeCAf8uZSWJIRDNWNf
	H4vDl2LJe1+bxpU2Om8AmtRNSW6LdI6dqytq/t+e/EOhPZflVmiY+vfU0XRZAk6b
	9Rene8IjsF8o50brvc94q4YTQCebPsaWVPa4GUQBwLc+mDWFC8Dxj3K6v3QKOoF0
	Ov5CKln3g95NH200H4txWbm9s9vaca62c1ZemgUjARHnPpda1noDCOxDhZIgpJue
	LkjHNRc1OjoRfkg3SaSkgp9QnoiX1ZkB+46xPmfaexPQhq3qv16niaovfPXrZg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42308dq06e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Oct 2024 22:58:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 498KsmER022856;
	Tue, 8 Oct 2024 22:58:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uw7trd1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Oct 2024 22:58:26 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 498MuH8F020795;
	Tue, 8 Oct 2024 22:58:26 GMT
Received: from ca-common-sca.us.oracle.com (ca-common-sca.us.oracle.com [10.132.20.202])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 422uw7trct-1;
	Tue, 08 Oct 2024 22:58:26 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: anna.schumaker@oracle.com, trondmy@hammerspace.com
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/1] NFS: remove revoked delegation from server's delegation list
Date: Tue,  8 Oct 2024 15:58:07 -0700
Message-Id: <1728428287-2031-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-08_22,2024-10-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410080149
X-Proofpoint-ORIG-GUID: 9qPhr1nfb8wNwEogAVuWPEolaIZZX9zb
X-Proofpoint-GUID: 9qPhr1nfb8wNwEogAVuWPEolaIZZX9zb
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

After the delegation is returned to the NFS server remove it
from the server's delegations list to reduce the time it takes
to scan this list.

Network trace captured while running the below script shows the
time taken to service the CB_RECALL increases gradually due to
the overhead of traversing the delegation list in
nfs_delegation_find_inode_server.

The NFS server in this test is a Solaris server which issues
CB_RECALL when receiving the all-zero stateid in the SETATTR.

mount=/mnt/data
for i in $(seq 1 20)
do
   echo $i
   mkdir $mount/testtarfile$i
   time  tar -C $mount/testtarfile$i -xf 5000_files.tar
done

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfs/delegation.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 20cb2008f9e4..035ba52742a5 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -1001,6 +1001,11 @@ void nfs_delegation_mark_returned(struct inode *inode,
 	}
 
 	nfs_mark_delegation_revoked(delegation);
+	clear_bit(NFS_DELEGATION_RETURNING, &delegation->flags);
+	spin_unlock(&delegation->lock);
+	if (nfs_detach_delegation(NFS_I(inode), delegation, NFS_SERVER(inode)))
+		nfs_put_delegation(delegation);
+	goto out_rcu_unlock;
 
 out_clear_returning:
 	clear_bit(NFS_DELEGATION_RETURNING, &delegation->flags);
-- 
2.43.0


