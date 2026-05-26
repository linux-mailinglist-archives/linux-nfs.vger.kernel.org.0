Return-Path: <linux-nfs+bounces-21993-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id A/sZMx8tFmoUiwcAu9opvQ
	(envelope-from <linux-nfs+bounces-21993-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 01:30:39 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A89A5DD8DE
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 01:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCBB7303F29B
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 23:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BFC35CB6A;
	Tue, 26 May 2026 23:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Tpm6Ann+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827A3194AE6
	for <linux-nfs@vger.kernel.org>; Tue, 26 May 2026 23:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779838237; cv=none; b=G8rRQGsv+SxXRh0FbjeHeFM7zu41vp1gH0anmM3ac4hWXXm9SqJptLJQfybodSqU7NLdUXAfSZm4OWqrbHy4hiUvl/U9fMsycL9HYQeuwy43E6EOt/EDx/wA5E6bDRv5zeiuGsvkUwaokCFRZ4pk4dLyXNH4Vru47hWVJ53vcMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779838237; c=relaxed/simple;
	bh=J3bULiw5Fk1kRFEqoApnSwKRIhMM7lBO2xG1FPswz84=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kx74z9XiZ81bNu2Y2ZryO10CBNZPOXqCtqzn1UwewxkTFefGvrSyOLd6xCEw0Mni6+4khNvvBEn22wEyAyoZJQrKZ2AG856oYgNPSQHHNnFeZOdU/mlCgc8Ovld6spESvn0xhbWnOvzKKoSCquWYHn2lVsqbVzPZIZBs+485M9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Tpm6Ann+; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QN0x431250740;
	Tue, 26 May 2026 23:30:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=XbwCvi0epUQftQFV7DPzTte4zracF
	JEfQwyVoYIw8lQ=; b=Tpm6Ann+rRYPNJUVng0tUJLnDCYh5ltC5wBA4I2h1vdPB
	mASZCN3CGMQB3t9TpmG6qOrDQdMVps5YhMpMpg2sNctD/57u9bJ8HdXIaqFBPiXY
	li9D24Ov7EFWTbfJaMZWfIn9h5f4BoatoQ16BW2lmeUsuuz9JgkTVmFwJpTU2xuR
	qIpVyMsixSIrJqJ4N5SQGBvXSB0LTe+6+45QSt8bryQWPEW1HwtUVHoPgfwCsFrN
	BaL9Sr0yd4ssIeev0q24NybfrPfLiHqfgV+IkhGWkSyhXdhSyuBAIlzruUhvWzq2
	4VKi61IdrRCn9bu1p0mKQicnaOFnVF3Y2WwAbmbNQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4eb4sq4n6f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 May 2026 23:30:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64QNOtoN012111;
	Tue, 26 May 2026 23:30:32 GMT
Received: from labops-common-sca-01.us.oracle.com (labops-common-sca-01.us.oracle.com [10.132.26.161])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4edjs147he-1;
	Tue, 26 May 2026 23:30:32 +0000 (GMT)
From: Dai Ngo <dai.ngo@oracle.com>
To: trondmy@kernel.org, anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSv4/pnfs: defer return_range callbacks until after inode unlock
Date: Tue, 26 May 2026 16:29:53 -0700
Message-ID: <20260526233031.2316425-1-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_05,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999 phishscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 spamscore=0 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605130000 definitions=main-2605260208
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDIwOCBTYWx0ZWRfX50v26kfICw8z
 NvuzW3mb33f1ZUMtFg78hSquyOpmts18xxkNrGOAIMsHNp0171ucO797BSv3gOQjx+ECt/Eoqpu
 d1s0fmoy2m9vAcW+otm4T85mUJV0VkpUwUommX8DEtOqzvYBxcIVGvR5oZVHmC1VMEWkPyT8Jel
 KI/1izJBdzrM2US6xyfquVJWPkNRl3QXkX3M+1CgSLzw+qjCIuOuJjut/yKdCWrJBSfVlebHlhI
 269C5DIqzyPFyK0EvPhGxppKGWXRcUw3rO9WoUpX7oL40KGhQqQ7K1neErFlqvhG2Q/ySzDjt2M
 +7YL2SiMnFWABAK0CxqNFC/q6z4sjvpXNtsTASMwww6JYvaGxfG8L9HbS/0VfZKX+SZ2sVb7IAB
 lt8Nd2fRWCN0Sdqq4I27DxBHYy40JKUvLKXGvDurzqDWBZ+Ic9M3Hhs//AK7xzsXH4TYi7q5Xbr
 XVCgUCtSoO3LN55Ca6A==
X-Authority-Analysis: v=2.4 cv=eNYjSnp1 c=1 sm=1 tr=0 ts=6a162d19 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8 a=YqP6bgQmNMiuDC7_5rUA:9
X-Proofpoint-ORIG-GUID: ob0plYHCGN593ssHYSh7sMnsnTuOs1YJ
X-Proofpoint-GUID: ob0plYHCGN593ssHYSh7sMnsnTuOs1YJ
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21993-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dai.ngo@oracle.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[oracle.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2A89A5DD8DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sometimes unmounting an NFS filesystem mounted with pNFS SCSI
layouts triggers the following warning:

     BUG: scheduling while atomic: umount.nfs4/...

    __schedule_bug+0xbd/0x100
     schedule_debug.constprop.0+0x19f/0x220
     __schedule+0x10d/0x10a0
     schedule+0x74/0x190
     schedule_timeout+0xf5/0x220
     io_schedule_timeout+0xd5/0x160
     __wait_for_common+0x186/0x4b0
     blk_execute_rq+0x2ef/0x3a0
     scsi_execute_cmd+0x1ff/0x700
     sd_pr_out_command.isra.0+0x242/0x380 [sd_mod]
     bl_unregister_scsi.constprop.0+0x109/0x3c0 [blocklayoutdriver]
     bl_unregister_dev+0x175/0x1c0 [blocklayoutdriver]
     bl_free_device+0x1f/0x1b0 [blocklayoutdriver]
     bl_free_deviceid_node+0x12/0x30 [blocklayoutdriver]
     nfs4_put_deviceid_node+0x171/0x360 [nfsv4]
     ext_tree_remove+0x11c/0x1d0 [blocklayoutdriver]
     _pnfs_return_layout+0x416/0x900 [nfsv4]
     nfs4_evict_inode+0x108/0x130 [nfsv4]
     evict+0x316/0x750
     dispose_list+0xf1/0x1a0
     evict_inodes+0x33f/0x440
     generic_shutdown_super+0xc9/0x4e0
     kill_anon_super+0x3a/0x90
     nfs_kill_super+0x44/0x60 [nfs]
     deactivate_locked_super+0xb8/0x1b0
     cleanup_mnt+0x25a/0x380
     task_work_run+0x13e/0x210
     exit_to_user_mode_loop+0x169/0x400
     do_syscall_64+0x467/0x1550
     entry_SYSCALL_64_after_hwframe+0x76/0x7e

The warning occurs because the block layout driver unregisters the SCSI
device while the inode lock is still held. Device unregistration issues
a SCSI PR command, which may sleep, resulting in a "scheduling while
atomic" warning.

During layout return, ext_tree_remove() invokes the layout driver's
return_range callback while holding the inode lock. For block layouts,
this callback eventually calls bl_unregister_scsi(), which may block in
scsi_execute_cmd() while issuing PR commands to the device.

Fix this by deferring the return_range callbacks until after the inode
lock has been released. The layout header reference count is incremented
before invoking return_range(), ensuring that the layout header remains
valid while the layout driver removes extents from the extent tree.

Fixes: c88953d87f5c8 ("pnfs: add return_range method")
Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfs/callback_proc.c | 9 +++++----
 fs/nfs/pnfs.c          | 4 ++--
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/callback_proc.c b/fs/nfs/callback_proc.c
index 4ea9221ded42..10f2354ba304 100644
--- a/fs/nfs/callback_proc.c
+++ b/fs/nfs/callback_proc.c
@@ -257,6 +257,7 @@ static u32 initiate_file_draining(struct nfs_client *clp,
 	struct pnfs_layout_hdr *lo;
 	u32 rv = NFS4ERR_NOMATCHING_LAYOUT;
 	LIST_HEAD(free_me_list);
+	bool return_range = false;
 
 	ino = nfs_layout_find_inode(clp, &args->cbl_fh, &args->cbl_stateid);
 	if (IS_ERR(ino)) {
@@ -301,13 +302,13 @@ static u32 initiate_file_draining(struct nfs_client *clp,
 		/* Embrace your forgetfulness! */
 		rv = NFS4ERR_NOMATCHING_LAYOUT;
 
-		if (NFS_SERVER(ino)->pnfs_curr_ld->return_range) {
-			NFS_SERVER(ino)->pnfs_curr_ld->return_range(lo,
-				&args->cbl_range);
-		}
+		return_range = true;
 	}
 unlock:
 	spin_unlock(&ino->i_lock);
+	if (return_range && NFS_SERVER(ino)->pnfs_curr_ld->return_range)
+		NFS_SERVER(ino)->pnfs_curr_ld->return_range(lo,
+			&args->cbl_range);
 	pnfs_free_lseg_list(&free_me_list);
 	/* Free all lsegs that are attached to commit buckets */
 	nfs_commit_inode(ino, 0);
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 743467e9ba20..38ed7d05d2d6 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -1463,8 +1463,6 @@ _pnfs_return_layout(struct inode *ino)
 	pnfs_clear_layoutcommit(ino, &tmp_list);
 	pnfs_mark_matching_lsegs_return(lo, &tmp_list, &range, 0);
 
-	if (NFS_SERVER(ino)->pnfs_curr_ld->return_range)
-		NFS_SERVER(ino)->pnfs_curr_ld->return_range(lo, &range);
 
 	/* Don't send a LAYOUTRETURN if list was initially empty */
 	if (!test_bit(NFS_LAYOUT_RETURN_REQUESTED, &lo->plh_flags) ||
@@ -1476,6 +1474,8 @@ _pnfs_return_layout(struct inode *ino)
 
 	send = pnfs_prepare_layoutreturn(lo, &stateid, &cred, NULL);
 	spin_unlock(&ino->i_lock);
+	if (NFS_SERVER(ino)->pnfs_curr_ld->return_range)
+		NFS_SERVER(ino)->pnfs_curr_ld->return_range(lo, &range);
 	if (send)
 		status = pnfs_send_layoutreturn(lo, &stateid, &cred, IOMODE_ANY,
 						0);
-- 
2.47.3


