Return-Path: <linux-nfs+bounces-21723-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iI+QKs8BDWrorwUAu9opvQ
	(envelope-from <linux-nfs+bounces-21723-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 02:35:27 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DDE5864E1
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 02:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D0D6F304F409
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 00:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA34922301;
	Wed, 20 May 2026 00:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d2vlXCYB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F44518FC97;
	Wed, 20 May 2026 00:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779237313; cv=none; b=q2T7kEW/7l4BCHEiveh2rBHGManO9qJwdGm3FpsY24W0at+IlMH5/Esa0zelTLkeCAd/uk/1jxkH4MrssX4kJ62J6s+camcsadzqKfV5WIkK4QSnh5gUTjuggwX09rg7UHRy6mwsRE81OaQjUbv4gYVafWU8g1s40IxGeFFRulI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779237313; c=relaxed/simple;
	bh=PNoO9y/ZcBHK4htM/mvEgNKFJUK0T7x5sobpk/gxzRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A58BCrayerDIo64xodJWumtK0y0BbimE3J5wTyAZhEOdmMITb+3I7ZFAIJohTtlsvvhyEd2KwQZdB8XwM1OGxjctmcsX/qDHdeDO7osVZSxSy5RcqWXj94u6y7gu2sSKSEuJSZR7bmDCHX1KobYg4ECSdsyGFcRw59iidEouT/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=d2vlXCYB; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JNfqNT100895;
	Wed, 20 May 2026 00:35:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=k7C33
	TcGWDi1Ou3bPN94FMIs10lMP+nZaEcern6EJJE=; b=d2vlXCYBaGXazDAc0rKmb
	MKZ9TRdUwwIRdx2y13ZU0zBOMzPXj/nCz5wc+zDUIOsQZLSLQAvfQ6gP3+T9JJ6+
	yGrpisA25Lr3G8vdwUV99rGhJk0IpoUcSCZ62NphiMsSqDBhCYFfLl4XvLt7Mdrf
	iBVeqBiweQW4iOFCyIv8dxJ6Onlnywh7OIPszChr20oeXa4wOS1/IY0D91gfVMtl
	ELR/kFiBg5EtJV27upONs5hu/Xag32S+IesPjYWSsL33X82TqorTBOIFoQJ6O86G
	mK4xXtZBzXfazAH0tQisVRlMyqm2vTmz2beSUIKytd0TZGONzLWFYjuggwINaLOL
	w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e6h2cp28n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 May 2026 00:35:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64K0OsT1006236;
	Wed, 20 May 2026 00:35:09 GMT
Received: from labops-common-sca-01.us.oracle.com (labops-common-sca-01.us.oracle.com [10.132.26.161])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4e84ecyhhb-3;
	Wed, 20 May 2026 00:35:09 +0000 (GMT)
From: Dai Ngo <dai.ngo@oracle.com>
To: cem@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] xfs: fix overlapping extents returned for pNFS LAYOUTGET
Date: Tue, 19 May 2026 17:32:59 -0700
Message-ID: <20260520003503.2399326-3-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260520003503.2399326-1-dai.ngo@oracle.com>
References: <20260520003503.2399326-1-dai.ngo@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605130000 definitions=main-2605200002
X-Proofpoint-ORIG-GUID: J7tFo7mOv_7oUMUqr2m-XXmJT9qarifp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDAwMyBTYWx0ZWRfX/7X7xP5abrxA
 s581++f8ih4/yRQs9m8PVhObrRgGQKKLUAL4gaKh8B8n0MMq8fa4oJw02xvTnsSWX4+QDoVpsPI
 rtJ30iOEyBk/2M5r0QYzbR06ih+q0abdmunxLX3gR+5/5IR38zoCvf41eXKHTHx4qFr1RQQaQh1
 zHCcbyBt2hO4SfCpa5nuDvsB2cc3yGjBT3SXP/fA0DX0gDCGdCvMFgD1xjvkvNjdvdfkrV4iM8L
 nW8fKWkaT+g4MOSmvdEZMfj2VOewk0S75tPYuKWS8G+42zrPX5yuWhPXiERxptOzI3w/nreXfpG
 BFe85kUY2xcKr1FIo6jq3ookBv098F4KZwmrnOGwIcHaTPqaTM1dEk19rGnIedRLo6sFDNWJQVS
 v5GLhqMUqiAa5r13EOYVJ27J33XGRCmVIwyk8zBx7Z37VmAZ9Wkp7O9QtI3ZNIhgW0vjsGyRv2L
 aKdp95wFvXlzF09uX0RqoJalFWp6xAj5SNspQDPw=
X-Authority-Analysis: v=2.4 cv=Ws4b99fv c=1 sm=1 tr=0 ts=6a0d01be b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=yPCof4ZbAAAA:8 a=j2Z_DofEzOnLPWMZ71IA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13839
X-Proofpoint-GUID: J7tFo7mOv_7oUMUqr2m-XXmJT9qarifp
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21723-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dai.ngo@oracle.com,linux-nfs@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:mid,oracle.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 47DDE5864E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

Fixes: cc6c40e09d7b1 ("NFSD/blocklayout: Support multiple extents per LAYOUTGET").
Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/xfs/xfs_pnfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_pnfs.c b/fs/xfs/xfs_pnfs.c
index b792e066b403..d92993367ab6 100644
--- a/fs/xfs/xfs_pnfs.c
+++ b/fs/xfs/xfs_pnfs.c
@@ -118,7 +118,6 @@ xfs_fs_map_blocks(
 	struct xfs_bmbt_irec	imap;
 	xfs_fileoff_t		offset_fsb, end_fsb;
 	loff_t			limit;
-	int			bmapi_flags = XFS_BMAPI_ENTIRE;
 	int			nimaps = 1;
 	uint			lock_flags;
 	int			error = 0;
@@ -172,8 +171,9 @@ xfs_fs_map_blocks(
 	offset_fsb = XFS_B_TO_FSBT(mp, offset);
 
 	lock_flags = xfs_ilock_data_map_shared(ip);
+	/* request mappings for the specified range only */
 	error = xfs_bmapi_read(ip, offset_fsb, end_fsb - offset_fsb,
-				&imap, &nimaps, bmapi_flags);
+				&imap, &nimaps, 0);
 	if (error) {
 		xfs_iunlock(ip, lock_flags);
 		goto out_unlock;
-- 
2.47.3


