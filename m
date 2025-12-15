Return-Path: <linux-nfs+bounces-17103-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F26CBCBF5E3
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Dec 2025 19:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 68DC23000B23
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Dec 2025 18:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE72322B86;
	Mon, 15 Dec 2025 18:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ffa+vr7e"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FA5322C73
	for <linux-nfs@vger.kernel.org>; Mon, 15 Dec 2025 18:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765822488; cv=none; b=FATuaS8sGyM2Ga7PXdeBEjX/ttHs8zEutxeUOZkD44LiJzuo/SYJ2GziES/FVCbvSiltikgwepSOXsiSAv4fqfGBiFLGfygzBeSFsckmaGdLF5B9hYs8cwv3eDbmwHKpIKTolmHAtfvA6dxwFYLKj63gPwoMopWApp+qZNr6pjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765822488; c=relaxed/simple;
	bh=n9R7xkhn5Ofg7OAe+gTQOA1VAazBPcRpiS+ECBjWFMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UdS4/PSKvFJbhqjVRID3W6hCTLb/95KRvTBCK9N1Iu6sMkPepN5nkhjSATOfIAMhmJseq7IzGudcra9s9BixTNBFZNs4ry8iJakSA7R5bmEGhUaVIbuzmxdsMsuGdzWGFcgq0utC7BeGhdIhwmHezPKjGoTukFU4vRy0w2FHylQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ffa+vr7e; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BFFNQ3r2467537;
	Mon, 15 Dec 2025 18:14:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=TVQ7dpw6+3U+hYs3fEcRbGoQSmGvHqL5Ip3YUvJS07w=; b=
	Ffa+vr7e9rpxO0w20pO+UIMUt5v7zF45MNuWuWc5vyRLPBiXjr/gRZTt4A9AjiHz
	+aUgdnhQXaLzC/fYkPnWfWoFuwN69RQs4yjQN49ET0AHVzFlh73SfNk7czw2SAAs
	3+VWQW9u59BCYE9m47RHTjLHYsSrJCNnf5+2ZtDC/KL/LvzTCy6B08lUP9+/X8xM
	c2L3URf9/u6SjVYXqOrHGtwJz4CAUlzwh5MCGqb/YlgFSzB6zU6CqO5+Sd7ezJbz
	0VFqIk2EgQqHGNMvvOwLcga4sJFUJsFVVAzeNY4QY2xh51Q/UDOhYwoctmkPrlPO
	/1fG32fB9W0j33b1nWX5aQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b0yrujgm6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 18:14:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BFI0cx8024739;
	Mon, 15 Dec 2025 18:14:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xk98b9k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 18:14:26 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BFIEOYM011653;
	Mon, 15 Dec 2025 18:14:26 GMT
Received: from labops-common-sca-01.us.oracle.com (labops-common-sca-01.us.oracle.com [10.132.26.161])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4b0xk98b7y-4;
	Mon, 15 Dec 2025 18:14:25 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neilb@ownmail.net,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 3/3] NFSD: Prevent redundant SCSI fencing operations
Date: Mon, 15 Dec 2025 10:13:35 -0800
Message-ID: <20251215181418.2201035-4-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251215181418.2201035-1-dai.ngo@oracle.com>
References: <20251215181418.2201035-1-dai.ngo@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-15_04,2025-12-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512150158
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDE1OCBTYWx0ZWRfX42kCzwuHzBr2
 FNC6p4f0VSbx+mTIwxhu6+GTp8j61gH6nfILn2YlWbLAXwYZSKW2LkOD9CpsTKam1KuAQMS0cg3
 XqOuyyBX2NoOTGw565WLoZzfVWPKqYf4ZpQXuizPqfDAATsqPdMu/aUtmo0pkPRgoO1zfqSCuQg
 1Z7/3ZfEe10MX/NjCdLgDIJ91/N67aVBnYJSXK82VP9I64U6SFVTxJFf/A9i2Bw6POu4n7F8p+J
 PzjD2D6te2hDH6GeYIceKS1QtpDRANcFHWT39TAJDQhxF6gbTlcBL2IiJvUSh7Vw8nAfL33ujyM
 Ga6HtcE2iTLtw/xrPLAmcb8LUTVyMhM0FrBjYeg32XUaEuid5d6je2/RaHpy63iL7BXQBLKJYZz
 IG+jnA4gO3HKY8jELWOdZkJPiNw/oQ==
X-Authority-Analysis: v=2.4 cv=TL9Iilla c=1 sm=1 tr=0 ts=69405003 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=4ijojFApOgc32bb5rJ8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: U6OITMTeOt0EobKPlpFWxW2zcp2uNc7N
X-Proofpoint-ORIG-GUID: U6OITMTeOt0EobKPlpFWxW2zcp2uNc7N

Update the server’s handling of SCSI persistent registration fencing
by leveraging the per-namespace SCSI client registration hash table
to record and check fencing state for each client-device pair.

Implementation details:

When the server issues a persistent registration key to a client, it
creates a new record containing the client ID, associated SCSI block
device (dev_t), and initializes the fenced flag to false. This record
is inserted into the hash table for fast lookups.

When the server needs to fence a client via nfsd4_scsi_fence_client,
it first looks up the corresponding record using the client ID and
device identifier. If the fenced flag in the record is already set,
the server skips issuing another fence operation and simply returns.
If the flag is not set, it is updated to true and the fencing operation
proceeds.

By tracking fencing state in the hash table, the server avoids issuing
redundant fencing operations for the same client and device, improving
efficiency and ensuring proper SCSI reservation management.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/blocklayout.c | 16 +++++++++++++++-
 fs/nfsd/nfsd.h        |  2 --
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index f2ab264af88e..73961e394311 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -17,7 +17,8 @@
 
 #define NFSDDBG_FACILITY	NFSDDBG_PNFS
 
-
+static int nfsd4_scsi_pr_add_client(struct nfs4_client *clp,
+		struct block_device *blkdev);
 /*
  * Get an extent from the file system that starts at offset or below
  * and may be shorter than the requested length.
@@ -357,6 +358,10 @@ nfsd4_block_get_device_info_scsi(struct super_block *sb,
 		goto out_free_dev;
 	}
 
+	ret = nfsd4_scsi_pr_add_client(clp, sb->s_bdev);
+	if (ret)
+		goto out_free_dev;
+
 	return 0;
 
 out_free_dev:
@@ -399,11 +404,20 @@ nfsd4_scsi_fence_client(struct nfs4_layout_stateid *ls, struct nfsd_file *file)
 {
 	struct nfs4_client *clp = ls->ls_stid.sc_client;
 	struct block_device *bdev = file->nf_file->f_path.mnt->mnt_sb->s_bdev;
+	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
 	int status;
 
+	spin_lock(&nn->client_pr_record_hashtbl_lock);
+	if (!nfsd4_scsi_pr_fence(clp, bdev)) {
+		spin_unlock(&nn->client_pr_record_hashtbl_lock);
+		return;
+	}
+	spin_unlock(&nn->client_pr_record_hashtbl_lock);
 	status = bdev->bd_disk->fops->pr_ops->pr_preempt(bdev, NFSD_MDS_PR_KEY,
 			nfsd4_scsi_pr_key(clp),
 			PR_EXCLUSIVE_ACCESS_REG_ONLY, true);
+	if (status)
+		nfsd4_scsi_pr_add_client(clp, bdev);
 	trace_nfsd_pnfs_fence(clp, bdev->bd_disk->disk_name, status);
 }
 
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 4572daa94a79..5a60419395b2 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -574,8 +574,6 @@ extern int nfsd4_scsi_pr_init_hashtbl(struct nfsd_net *net);
 extern void nfsd4_scsi_pr_shutdown(struct nfsd_net *net);
 struct nfs4_client;
 extern void nfsd4_scsi_pr_del_client(struct nfs4_client *clp);
-extern int nfsd4_scsi_pr_add_client(struct nfs4_client *clp,
-		struct block_device *blkdev);
 extern bool nfsd4_scsi_pr_fence(struct nfs4_client *clp,
 		struct block_device *blkdev);
 
-- 
2.47.3


