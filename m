Return-Path: <linux-nfs+bounces-21363-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CDbASA+9mksTQIAu9opvQ
	(envelope-from <linux-nfs+bounces-21363-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 02 May 2026 20:10:40 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 900E24B3248
	for <lists+linux-nfs@lfdr.de>; Sat, 02 May 2026 20:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7843F300A516
	for <lists+linux-nfs@lfdr.de>; Sat,  2 May 2026 18:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE2329994B;
	Sat,  2 May 2026 18:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HyBDwtWi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB69D35F612;
	Sat,  2 May 2026 18:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777745438; cv=none; b=uCHXpz9cOSdmvmoJU9PgV+BrauqlSD+n11LmCESa5J04fXX6HR3esg4/cKBsK1jGduvJClsnIdF9thZwFrLxcSrto0NfxYCARcvc7YseLgwrJbIaFLF0ah8/ZossExWuJW7E6DBYKcXOOqL48LHBQ6auOc1JKDDmRoMsniLks3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777745438; c=relaxed/simple;
	bh=pEsZfqQCoL8N1tCTjWCJ9p1pajvIKs7ZVPlQmHBntJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rg+8CRsf/BYuKvaNrxrPmUh4IPM9a+OcG6ZgJe1VM/sZmWteWPfu2vcMm/if05osdfgMxlH9m6awU43sqTfsbPHAmcLMAtlLUWaERZxcALIuMoV6NXlI7qVC2fl132Cjay1uSsMpPQCNGW4AHvvuU5cWzw3XukUtwWZ+qDV/ERI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HyBDwtWi; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 642Hj3GW605772;
	Sat, 2 May 2026 18:10:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=jsgnZOaOFkHPrLr6mVMZIKRvTliee
	fVtKSHTwfY/2is=; b=HyBDwtWibnVnVNToB8zdAdfsH/s3IKEmF++mpc6LMyOUD
	6XcS4lrwTNr4AyOvyVx+pQnE6rMg66EZaS8DfjBW5eSVCiBpZZ6btqexcynTIEWD
	pTvw0zo0P91VD4SmpGJ87ByneYHsdvsWHUBXhCyiv10u27Ik0U21PC1+3AbUfppK
	pR+y8/M1gtFhKBhdaW2MIOvlMtCP1ggeoPeiOOaWWIMJPNHWOAP2BP2aAiAn4nGN
	m0nqax3et+KuihKFR27W7oW+/RzaPddDhtrKUnkHMjT5tsfPv3S5UeHAM+TEQv76
	TmkKNrAxqnS2OhUeDK1sxaZOS6v00/xKkhZQcEQMg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dw9tqregb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 02 May 2026 18:10:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 642I8TPZ037806;
	Sat, 2 May 2026 18:10:33 GMT
Received: from labops-common-sca-01.us.oracle.com (labops-common-sca-01.us.oracle.com [10.132.26.161])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4dw7q7ghmj-1;
	Sat, 02 May 2026 18:10:33 +0000 (GMT)
From: Dai Ngo <dai.ngo@oracle.com>
To: cem@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] xfs: fix use of uninitialized imap in xfs_fs_map_blocks error path
Date: Sat,  2 May 2026 11:10:09 -0700
Message-ID: <20260502181031.32441-1-dai.ngo@oracle.com>
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
 definitions=2026-05-02_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604200000 definitions=main-2605020180
X-Proofpoint-GUID: cX0tdj55rRgyvoJe-xszZYZkDPdWNrpF
X-Proofpoint-ORIG-GUID: cX0tdj55rRgyvoJe-xszZYZkDPdWNrpF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAyMDE4MSBTYWx0ZWRfX0V+rSN4qXzVf
 +QMVgBOYYbLAyxhIRmTk/wTwFv6bM+4H9TmjJJLGHyv6l/PqJKxT7RZo5ihQCVa1cjIyAw/pIFP
 +gkus12clLrfi7m9lnf+Ife7SMl7xsMEwXUBoYJ8VBBMg1mgvotNtgYbR5zzFbCt3s3vaM7bIpQ
 zoFS4Lt1qhQC9b9PIAXdHVFbbqZ7oNTuZtDIMI15tTuhrDazGghBTinzN+kn3wF8E81OCY/HEee
 NkIunlehntj2bw8Pzjmm7HLPw7kCR6+blkxFrLV3v63Gw7a2NJJK3ZhbVJmBjHGODelPveAU9RZ
 Hhh0SBhbbKptpLUXSbDlmFG1EkEgEl5RoJxih3cz212s6UAV08SKpV7vFY22mBY3eAH7rvs+N8p
 t7LepI60kPOIM12f8eZbBhvgizN58dEbgURrDObxfMNO6M5yy5IyqMNTGUE+nK0Jd3/uAmgSz4w
 UqXrxrl1RdDTbmPX1tA==
X-Authority-Analysis: v=2.4 cv=Os9/DS/t c=1 sm=1 tr=0 ts=69f63e1a cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8 a=NnFJWWH6Egn-NMX9bF4A:9
X-Rspamd-Queue-Id: 900E24B3248
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-21363-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dai.ngo@oracle.com,linux-nfs@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:email,oracle.com:dkim,oracle.com:mid];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]

xfs_fs_map_blocks() acquires the data map lock and then calls
xfs_bmapi_read(). If xfs_bmapi_read() fails, the function currently
still falls through to xfs_bmbt_to_iomap(), which consumes an
uninitialized imap record and may return invalid data to the caller.

Fix this by releasing the data map lock and returning immediately when
xfs_bmapi_read() reports an error. This prevents xfs_bmbt_to_iomap()
from being called with an uninitialized xfs_bmbt_irec.

Fixes: 527851124d10f ("xfs: implement pNFS export operations")
Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/xfs/xfs_pnfs.c | 4 ++++
 1 file changed, 4 insertions(+)

Correct the Subject line.

diff --git a/fs/xfs/xfs_pnfs.c b/fs/xfs/xfs_pnfs.c
index 221e55887a2a..f7c6dba3d21e 100644
--- a/fs/xfs/xfs_pnfs.c
+++ b/fs/xfs/xfs_pnfs.c
@@ -174,6 +174,10 @@ xfs_fs_map_blocks(
 	lock_flags = xfs_ilock_data_map_shared(ip);
 	error = xfs_bmapi_read(ip, offset_fsb, end_fsb - offset_fsb,
 				&imap, &nimaps, bmapi_flags);
+	if (error) {
+		xfs_iunlock(ip, lock_flags);
+		goto out_unlock;
+	}
 	seq = xfs_iomap_inode_sequence(ip, 0);
 
 	ASSERT(!nimaps || imap.br_startblock != DELAYSTARTBLOCK);
-- 
2.47.3


