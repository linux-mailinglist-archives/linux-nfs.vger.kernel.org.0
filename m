Return-Path: <linux-nfs+bounces-21538-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iP3uOrNkA2oq5gEAu9opvQ
	(envelope-from <linux-nfs+bounces-21538-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 19:34:43 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 030A9525E35
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 19:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 41F023002B48
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 17:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEE33D5C1B;
	Tue, 12 May 2026 17:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TgCz3ROh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8253CB909;
	Tue, 12 May 2026 17:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778606572; cv=none; b=n3OsA8X9lx0foPZh/j/qOq1qWXZvWuj2dNQ96i7mNe6PtvQVQNrC85pWDhRGo8ZyEMBoBOaCBFW50OA7MRb2+Ycj/t8MxTSUsGj/52vqs2MCGM2HnhgowDPuPjD17YospAz09aUOvtmg8PQlGTULzYed8q440Y6GrEGq0J3rkZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778606572; c=relaxed/simple;
	bh=tOMt4S1lBMABRMpYwGuvLSz94ZXSdLpDeDP/7np9mCk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gtS5HPbX4tl2NCM/+vp9RBRDIkodLtWeTFXDp44NYPYiEqWv68CzMiBPKkHQInH9QSBik417uUgcfykSgeCJVeOAd5jZL7PQFkEUI6eViyOcNfWTYwqmATjir4PiWiVWxxr0eGarLGlU7eUuqAhRAdOp+VgOtLSZV9dED4QiRwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TgCz3ROh; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CGfisM1690350;
	Tue, 12 May 2026 17:22:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=T8u3eSOob45S/9OU4eZe67dnsFsak
	em1iMK+h086W5k=; b=TgCz3ROh5ezQuYhIdrxttRu8hxMhiOQsEl2ZYXhjSx+3P
	o54EKK2DvWHxox7uSUgG/cbuYVnzFNe9PvIVWXFypJq23BjTB8X/uUYO0y2qFoD/
	hQyVxSc9TyoIRrKgG5UkvSN0q/y/ULXgTULRYdKje6kS4CjUzVYIvFembxwqbNDm
	RjLbTO6vqwKroOuyyCIuHJLCgtKSOeAJR3AEV35JDOA0AuuVuNAGCnQoS9xCnXwo
	TaCFBhsHRIaIvWM4KIvcvSebeuyBfITpfTH+lElQryArDu7hTXuSKxeq5pp7lVVF
	tIRmSJ2fls7jT0Fp88Cbd90xMHwA7nHU7QNjcaugg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e3nv1hnsn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 May 2026 17:22:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64CHLOvo040671;
	Tue, 12 May 2026 17:22:40 GMT
Received: from labops-common-sca-01.us.oracle.com (labops-common-sca-01.us.oracle.com [10.132.26.161])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4e3neb9g9q-1;
	Tue, 12 May 2026 17:22:40 +0000 (GMT)
From: Dai Ngo <dai.ngo@oracle.com>
To: cem@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] xfs: fix overlapping extents returned for pNFS LAYOUTGET
Date: Tue, 12 May 2026 10:21:53 -0700
Message-ID: <20260512172238.2495085-1-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605050000 definitions=main-2605120181
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE4MSBTYWx0ZWRfXy0eo0ROwo0a9
 NTF09D0GRHe3oCgijV1tgcUoxn6ZSWJF46lNVqgs7BSzAJipuSPKzbXNpMFilXR+E7SUlo2RCt0
 K9Q+JMkpVkMdqUX5b2dlG7ONN+VWtR8OR7dudf6s2iotXJOtduL90owcqhqmoHgkM1IkhjgFpso
 LX4T5QofQ0CWyvnPqO2OxVYkX45up9pDUe0WKI3OhAPPKLuLZcztWffQAuYCJlEXb7hAx5GUehQ
 boICci2J0ZWe1yDp3ag9YOKXD5ZKkuOTzAQrc12ZNTgA0wJrshVMuhN+ONL8mIFJGi2hPZxKOHj
 DJlUZc1yeyp60HwirkpyKZvRpHbrUbCYWK1hZfZ51uRWYpVFML7EtRqDPOJDE9qLUq+cONbFzKa
 4u5/wX/PG+DZ1Jp+s4dzBN8huEbwGM+aLVZ72/9wMqeoTWeAUKXciVuAOp6GSaccPtlofZPcnfs
 0njUKudNWNAVC905VwE1bPcrXOz1BeXxnA7yreRw=
X-Proofpoint-GUID: Gon1UpFH8Op6lYQbGYjbhJ4WKn8JVMGk
X-Authority-Analysis: v=2.4 cv=JvbBas4C c=1 sm=1 tr=0 ts=6a0361e1 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=yPCof4ZbAAAA:8 a=gD0DZGIp7gYZHjF65LMA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12298
X-Proofpoint-ORIG-GUID: Gon1UpFH8Op6lYQbGYjbhJ4WKn8JVMGk
X-Rspamd-Queue-Id: 030A9525E35
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21538-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dai.ngo@oracle.com,linux-nfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.com:email,oracle.com:mid,oracle.com:dkim];
	DKIM_TRACE(0.00)[oracle.com:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

xfs_fs_map_blocks() currently passes XFS_BMAPI_ENTIRE to xfs_bmapi_read(),
which causes the bmap code to expand the mapping to cover the entire
extent rather than the requested range.

A single LAYOUTGET request from the client can cause the server to
issue multiple calls to xfs_fs_map_blocks() for different offsets
within the same extent. Because the use of XFS_BMAPI_ENTIRE flag,
these calls can produce overlapping mappings.

As a result, the LAYOUTGET reply sent to the NFS client may contain
overlapping extents. This creates ambiguity in extent selection for a
given file range, which can lead to incorrect device selection,
inconsistent handling of datastate, and ultimately data corruption or
protocol violations on the client side.

Problem discovered with xfstest generic/075 test using NFSv4.2 mount
with SCSI layout.

Fix this by replacing the XFS_BMAPI_ENTIRE flag with '0' so that
xfs_bmapi_read() returns only the mapping for the requested range.

Also drop the check for (!error) since it was checked after call to
xfs_bmapi_read().

Fixes: cc6c40e09d7b1 ("NFSD/blocklayout: Support multiple extents per LAYOUTGET").
Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/xfs/xfs_pnfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

- This patch is based on top of the patch:
  xfs: fix use of uninitialized imap in xfs_fs_map_blocks error path

diff --git a/fs/xfs/xfs_pnfs.c b/fs/xfs/xfs_pnfs.c
index f7c6dba3d21e..697bf3e4ad7e 100644
--- a/fs/xfs/xfs_pnfs.c
+++ b/fs/xfs/xfs_pnfs.c
@@ -118,7 +118,7 @@ xfs_fs_map_blocks(
 	struct xfs_bmbt_irec	imap;
 	xfs_fileoff_t		offset_fsb, end_fsb;
 	loff_t			limit;
-	int			bmapi_flags = XFS_BMAPI_ENTIRE;
+	int			bmapi_flags;
 	int			nimaps = 1;
 	uint			lock_flags;
 	int			error = 0;
@@ -172,6 +172,7 @@ xfs_fs_map_blocks(
 	offset_fsb = XFS_B_TO_FSBT(mp, offset);
 
 	lock_flags = xfs_ilock_data_map_shared(ip);
+	bmapi_flags = 0;	/* return map for requested range only */
 	error = xfs_bmapi_read(ip, offset_fsb, end_fsb - offset_fsb,
 				&imap, &nimaps, bmapi_flags);
 	if (error) {
@@ -182,8 +183,7 @@ xfs_fs_map_blocks(
 
 	ASSERT(!nimaps || imap.br_startblock != DELAYSTARTBLOCK);
 
-	if (!error && write &&
-	    (!nimaps || imap.br_startblock == HOLESTARTBLOCK)) {
+	if (write && (!nimaps || imap.br_startblock == HOLESTARTBLOCK)) {
 		if (offset + length > XFS_ISIZE(ip))
 			end_fsb = xfs_iomap_eof_align_last_fsb(ip, end_fsb);
 		else if (nimaps && imap.br_startblock == HOLESTARTBLOCK)
-- 
2.47.3


