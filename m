Return-Path: <linux-nfs+bounces-21364-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGNTANRd9mmSUQIAu9opvQ
	(envelope-from <linux-nfs+bounces-21364-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 02 May 2026 22:25:56 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 561684B36D8
	for <lists+linux-nfs@lfdr.de>; Sat, 02 May 2026 22:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0ED74300C588
	for <lists+linux-nfs@lfdr.de>; Sat,  2 May 2026 20:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FEE33A9F5;
	Sat,  2 May 2026 20:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fm+6y78x"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A098A34E745;
	Sat,  2 May 2026 20:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777753553; cv=none; b=b168cl8TbsaHtBroN7Dqnq9voj3qQD42bEidgud+/NcS0znVYcF5KUcXCdX94I4CBqRa4oGsstLbSxaeTN91ipgEGa1pLSie0pxkfLfoMklESDou/45LXmw1CnfzHAzax2Y31xuBrWEPb/dZxLm8308FzzMgDpNPe35mXvb3Tw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777753553; c=relaxed/simple;
	bh=GT0yq8d3NqHK5mxHuW9g66rPPr0GkxUpyBi/tS7sVyo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pDExRrzyWVEwN3KCEPADDZGbaL+AwEYCmj8zfB9rS0Xgb2Erboui//8QgKsXeOfY8Bka6qwbsnzsdLoOGcmAk/t3d5ZhoY2vZ1vuCBQobVb2qmSQD15DI/9xf696MD0C28Dnh4fdVoDAf0UtEU1tm7Fwg/lZgA4Ye+bR5PzjGzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fm+6y78x; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 642JubRw2737788;
	Sat, 2 May 2026 20:25:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=1ycDBLJUPnHQUXJts2En+Xb+HIXxd
	DgfPJSjiN+CVEE=; b=fm+6y78xIq8fQWZuI42lIhXXWICNurdHM0noA9zFSojHg
	j1/vM07VSwqDrlg3dy/nVOeTsXHYopouFRYWfH6Fy/uMXheaxQ9GPOorLQcYkifI
	/mNkGAGHFss1f0b2RunrZfwGreW6VE/tGsNS+6xYNkv3IPwNU9owuNjI9b8406FR
	uM11vEOmCh2grjAkvIX7jjXz79OTcVS0Q2dkt2GHmsP7FhlkjfSkidlwV1regUfR
	EQTVHm5D+wwoX2NiGj14/XGqbrQ8O23Jyg82Lggxw6vVFQafL/dWQlxO/XQHWHZE
	tNWc8Z15g+gqJaAIb+f3Q+9W/f56n98LCyuHOk0pg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dw9dgrhsn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 02 May 2026 20:25:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 642KLEX4040265;
	Sat, 2 May 2026 20:25:45 GMT
Received: from labops-common-sca-01.us.oracle.com (labops-common-sca-01.us.oracle.com [10.132.26.161])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4dw7q7jm9m-1;
	Sat, 02 May 2026 20:25:45 +0000 (GMT)
From: Dai Ngo <dai.ngo@oracle.com>
To: cem@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/1] xfs: fix use of uninitialized imap in xfs_fs_map_blocks error path
Date: Sat,  2 May 2026 13:25:36 -0700
Message-ID: <20260502202542.111830-1-dai.ngo@oracle.com>
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
 scancount=1 engine=8.19.0-2604200000 definitions=main-2605020206
X-Proofpoint-GUID: wagl80WS-a0B_OWkKkItZyd96bOX_D-f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAyMDIwNiBTYWx0ZWRfX/jOm6YOdiidt
 PWV3ESfLxEZhHRtjLVQRRLmP3aYzSw3QUDH3uCPQfcH2jf6SxSfYIbJhuZzksMQQk8KVDnaNlhz
 WkiNPKS6Nf1SHmXm7sbMtEhv9DD4D6cTnD4PqFEpur997xxyJLmTO1SCcX87iBdHO0EyFt+SWg4
 dLP/LeAN0PXLT8Dm3k9sAUf9svLio8TUVVe92kZTrc+ZQsBUfInTOZZcgpBJTpeRt803v/f/aGg
 OMBtv8mvNtwjKYh5OomC/anA8QK4jomblkNqrP/s9TDV7iHz23+tPq5RWaHbViwyagW6ETD6Qd+
 WEzo0eS1A3YBR230P64tsxP8DqFSycUWnKkvZpfblzLoetCGcAOgQsapbuEtvZt/ZiHraCi2pvc
 lA/nNx4gG0MJw6E3iQ0Ug3tBtl8TQiCMHCytgBVZRKRLO27X9XTZp0ETdNliLowc4TC9FvgWLhj
 JM/PRn1+1nlD4JaI1Qg==
X-Proofpoint-ORIG-GUID: wagl80WS-a0B_OWkKkItZyd96bOX_D-f
X-Authority-Analysis: v=2.4 cv=HZckiCE8 c=1 sm=1 tr=0 ts=69f65dca cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=yPCof4ZbAAAA:8 a=NnFJWWH6Egn-NMX9bF4A:9
X-Rspamd-Queue-Id: 561684B36D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-21364-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dai.ngo@oracle.com,linux-nfs@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,oracle.com:dkim,oracle.com:mid];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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

v2:
  . drop the check for (!error). Already checked above.

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


