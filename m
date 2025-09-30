Return-Path: <linux-nfs+bounces-14818-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3EDBAE09C
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Sep 2025 18:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CB60B4E242F
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Sep 2025 16:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7296023507C;
	Tue, 30 Sep 2025 16:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Az90OMdP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77301E260D
	for <linux-nfs@vger.kernel.org>; Tue, 30 Sep 2025 16:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759249754; cv=none; b=B+/CSxAQ6S9gopr1B3UqM4VO0uFqpEh/XSbvjO91MCs0JDMjKlxQk5NClx3yvKynjv9yOubQGMo8rV5Lf6sx3CsMHG+GMMuDaAaWPT16v/a6vS+ojSW1IqQOiu0P3jZWuR5lHysURyXamTT7CEHQ7Y4ntE5Jtl6chEdiCAVaT68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759249754; c=relaxed/simple;
	bh=/D67AvB8KjbOgBubXCRJ+2njQOk9pA8V6ENa4kDT9ng=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Ep+HNx9iKHd4757W9Q2/tRBbTWmT8NsdXtBqPcq8W0xiYHJHYxbDnQmUn/JXOcZ726WlNDBWvpUaZiObDU1jYfijOb8mRIrvL9CYvUs8JyGX1zsMevdGJgLgQvzbXxY9sq5ki3Hspo8od1j5Y4m13UeWUpSaZwwD4N5t6pNIuVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Az90OMdP; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UFojWr028210;
	Tue, 30 Sep 2025 16:28:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:date:from:message-id:subject:to; s=corp-2025-04-25; bh=5ka12VUF
	KST2IDT6ZDGStV5xwADwlwGzosn/8oxhqjU=; b=Az90OMdPLtmKazJO+LTCTutg
	7iDCuvtI6Q5PxxV+B6QTEJgHuDdycJv5JhjWTpVbC8ST282K/jVTds8z4ujXZ9Uz
	IIMo+QoTae4Aaap1vneFh9ot58iRvnLU9D+Y0Bejj8cO2WWr8n8zXkDaPiz7EKoM
	Hl/MDt1PcjDJcyDVyyNH6eNdrdq8e+NNroUDHtqDwUyzInl6Am0USNITM9fVJpYv
	FgRckl9mLNCUoluBnSP91AVEaK1ikcxSE/flZFK+FSZhq3vPS4Y47VVh/ZUzRCT/
	gxlabzXubCMY/fCy7+oUysyH+gGvIwu+aq8vniPRbE4pJnQ6/ZYbVM471jniaQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49gj6dg33s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Sep 2025 16:28:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58UFdTvo040680;
	Tue, 30 Sep 2025 16:28:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49e6c835hk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Sep 2025 16:28:52 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58UGSqYK000842;
	Tue, 30 Sep 2025 16:28:52 GMT
Received: from ca-common-sca.us.oracle.com (ca-common-sca.us.oracle.com [10.132.20.202])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 49e6c835gx-1;
	Tue, 30 Sep 2025 16:28:52 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        okorniev@redhat.com, tom@talpey.com
Cc: hch@infradead.org, linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSD: Fix SCSI reservation conflict causing pNFS client to revert I/O to MDS
Date: Tue, 30 Sep 2025 09:28:48 -0700
Message-Id: <1759249728-29182-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_03,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2509300148
X-Proofpoint-GUID: M3L6xIkIsS1Cx0yV7Sj_aIkruNTyUn7o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDE0MiBTYWx0ZWRfXxN6n4k+lJkM+
 93S4tnjOBcNhi5uSX6b17LDkmyP4Q/pos4BwLV823CMDM2FWA3z/p2ExuKhdCdaQnVwgzjNNBkK
 ZXnQIP/SVXAvkfra8TWJkoOPIbVjUExbO6MqY67gLwSBRf85NW59VcjNwwYDzZPBqlHfSOBKTBc
 0/eDx9o/xAxJkvdDagUO6o8B/UnM/ck69S9W40pqrndg9bM7a/57I7BXBfEJsy5jfcmn4QhWR/B
 IWzNGtAJ2GmTSSoD+1eAHtwdRmdBVsnGFBYO3zp89nbDgRlPep8U5QsMZHyFoZb3NdvGcAC3ugH
 tMGzkE85gBRLnDuSubz6tMZGFoFztj6wbEx9idArX2YhYCOb1XrrettFTTzm0TAkU7g3w8Nrr/S
 lcLxtA+XebpiYe1CJBKpDF5HndT5ofb/xkKYk/idX9KcfkeNEFk=
X-Authority-Analysis: v=2.4 cv=SOVPlevH c=1 sm=1 tr=0 ts=68dc054b b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=85KOeztYMzgPb6AhWCUA:9 cc=ntf
 awl=host:12090
X-Proofpoint-ORIG-GUID: M3L6xIkIsS1Cx0yV7Sj_aIkruNTyUn7o
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

When servicing the GETDEVICEINFO call from an NFS client, the NFS server
creates a SCSI persistent reservation on the target device using the
reservation type PR_EXCLUSIVE_ACCESS_REG_ONLY. This setting restricts
device access so that only hosts registered with a reservation key can
perform read or write operations. Any unregistered initiator is completely
blocked, including standard SCSI commands such as READCAPACITY.

As a result, if an NFS client reboots or a new client attempts to
access the device, its SCSI driver issues a READCAPACITY command before
registering a key. This command fails with a Reservation Conflict error
since the initiator is not yet registered. Consequently, the client
detects the SCSI device size as zero.

When it subsequently receives a LAYOUTGET reply, it finds the device
openable but with a size of zero, so it falls back to performing I/O
through the MDS instead of directly accessing the block device.

To resolve this, the patch changes the persistent reservation type from
PR_EXCLUSIVE_ACCESS_REG_ONLY to PR_WRITE_EXCLUSIVE_REG_ONLY. With this
reservation type, registered initiators retain full read and write access,
but unregistered initiators are now permitted to issue read commands
(including READCAPACITY) while still being blocked from write operations.

Allowing unregistered reads prevents reservation conflicts on READCAPACITY,
ensuring the device size can be properly discovered by clients. This
enables direct I/O to the SCSI block device after client reboot or new
client addition, rather than unnecessarily reverting to the MDS.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/blocklayout.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index fde5539cf6a6..ab7903d584a6 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -291,7 +291,7 @@ nfsd4_block_get_device_info_scsi(struct super_block *sb,
 	}
 
 	ret = ops->pr_reserve(sb->s_bdev, NFSD_MDS_PR_KEY,
-			PR_EXCLUSIVE_ACCESS_REG_ONLY, 0);
+			PR_WRITE_EXCLUSIVE_REG_ONLY, 0);
 	if (ret) {
 		pr_err("pNFS: failed to reserve device %s.\n",
 			sb->s_id);
-- 
2.47.3


