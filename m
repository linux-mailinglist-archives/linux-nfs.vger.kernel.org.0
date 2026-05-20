Return-Path: <linux-nfs+bounces-21722-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCbMG8UBDWrorwUAu9opvQ
	(envelope-from <linux-nfs+bounces-21722-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 02:35:17 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 315875864D1
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 02:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BDAD130237E1
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 00:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4281E0B9C;
	Wed, 20 May 2026 00:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J1I1i2SK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31400157A5A;
	Wed, 20 May 2026 00:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779237312; cv=none; b=ccjJOKnaIoer0b+HzWb2217zizlwliDfAGGnxFOk0uZDj70e9y5VBKwjsk5nP3Ei22WDJ7BacqURUxd1tv43vxOyaEloFv7v5CPFyYi5ztxEzKjblPsrZfB6bcPdKUZijIqOBdr36OP4reBoPk2UdNZRp2jSd/nQO1CjA+EP9Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779237312; c=relaxed/simple;
	bh=KcgYRtkeGmAhJYgDJrMs1JgmX1hEmhj+mE0E+2y28T4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q7A1vyLarVmav1gwsF9HAtLjj3gIi3vIPIcX95G51DgUpAYIx5I/Cgi8ME1TyurVV3pp/knWWOAtIppLaCvRKcpdbbM8uOwBAPrnEMfeyXsJE67Ddz3iBpvVO1yK/OQzI0CYHqLBTsx6hrSowdixJutPvH+D+/ePfaNhkpi+AvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=J1I1i2SK; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JNgeKC954986;
	Wed, 20 May 2026 00:35:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=7qNKF
	EVvQh7s+6BHXsY3Zo1oqF8vVmV2yIJw5O/zhLI=; b=J1I1i2SKJ4njUmhFnN8zq
	Qj6howRgoEyB9+QhJzbD8aTNYdZqovRvd6p/b7uWNUFRSmFkLFezbbp2UO4mIc1v
	f8rTy5OK16tWdRbNK3PIKdHRE1m/2SrNLXGNUqGanS1t6yayHIS6ZXD//SeADuUd
	12/0MeFCOoYWYLWlpaHC+Cuan6UW9cOi4wruniN6RlFJ3NWwebCOK378AY7zOLGO
	Df0h4wZB2sQ0UNvDLctSrk4EcxhjbQUBxL7MCuomybeyHDwcyLsnOi1VkGhnbrc5
	uK7gR5+JxXyJvIU4fIxlqUbhZSKawGhGaeXgURU0yxmUc27q17PvDSSsiPhuDOQW
	A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e6h4q6597-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 May 2026 00:35:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64K0OsT0006236;
	Wed, 20 May 2026 00:35:08 GMT
Received: from labops-common-sca-01.us.oracle.com (labops-common-sca-01.us.oracle.com [10.132.26.161])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4e84ecyhhb-2;
	Wed, 20 May 2026 00:35:08 +0000 (GMT)
From: Dai Ngo <dai.ngo@oracle.com>
To: cem@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] xfs: fix use of uninitialized imap in xfs_fs_map_blocks error path
Date: Tue, 19 May 2026 17:32:58 -0700
Message-ID: <20260520003503.2399326-2-dai.ngo@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=NdnWEWD4 c=1 sm=1 tr=0 ts=6a0d01bd b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8 a=0CBWd1vnmm2x7jB9DQsA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13839
X-Proofpoint-GUID: uQiPBovsh5UitQaypT7u93pG_kAHGwU0
X-Proofpoint-ORIG-GUID: uQiPBovsh5UitQaypT7u93pG_kAHGwU0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDAwMyBTYWx0ZWRfXwbL+cf5zh37W
 kecIau+r9gsxaInCgRFdfskxpAWUEQtuOhcSFN/6c2xj5XmPcZLW1qDnFXhgNOyccKh96+4jJCd
 yNdtzhxdwob+90DlK5cJ2uvbZMWaVZxXttqh662pSiTzHuRlAwpuncU6U6wCJYfZbSR/VbQlt6i
 z8kxxs7AWYgffUwW0xeGRsFn19uI387BC+8Ow9yoPm5eB853DQjdUgwYGW2qbF+IyK+GN7zn7J5
 dG6Co20aCS7l7UddxLjICM1wnMogzcQidOgfGta2Sp9nOsL19RDlWrIuMtPOaiOwv3mKpg5z4R1
 IIdu3/8LiwC3s6vUdIKffpPqOnPE7x5/eLuY1SvmiT+aDfNbDwKUCYQ+YF+JmhwyyGt8j7EfWOe
 6DPXfu83p8zoBJ1X7uPtCj+Lvf151peEhNkR9lIUeAlEr0WDezv1OgvGnrboKFoQsTd1KSTSN3V
 ydlbvkYNJr8WMe/bdLoonV1uY98yk8RsbjDID7Qw=
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
	TAGGED_FROM(0.00)[bounces-21722-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: 315875864D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
 fs/xfs/xfs_pnfs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_pnfs.c b/fs/xfs/xfs_pnfs.c
index 221e55887a2a..b792e066b403 100644
--- a/fs/xfs/xfs_pnfs.c
+++ b/fs/xfs/xfs_pnfs.c
@@ -174,12 +174,15 @@ xfs_fs_map_blocks(
 	lock_flags = xfs_ilock_data_map_shared(ip);
 	error = xfs_bmapi_read(ip, offset_fsb, end_fsb - offset_fsb,
 				&imap, &nimaps, bmapi_flags);
+	if (error) {
+		xfs_iunlock(ip, lock_flags);
+		goto out_unlock;
+	}
 	seq = xfs_iomap_inode_sequence(ip, 0);
 
 	ASSERT(!nimaps || imap.br_startblock != DELAYSTARTBLOCK);
 
-	if (!error && write &&
-	    (!nimaps || imap.br_startblock == HOLESTARTBLOCK)) {
+	if (write && (!nimaps || imap.br_startblock == HOLESTARTBLOCK)) {
 		if (offset + length > XFS_ISIZE(ip))
 			end_fsb = xfs_iomap_eof_align_last_fsb(ip, end_fsb);
 		else if (nimaps && imap.br_startblock == HOLESTARTBLOCK)
-- 
2.47.3


