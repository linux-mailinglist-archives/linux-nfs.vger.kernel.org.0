Return-Path: <linux-nfs+bounces-19780-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cO4kNtmMqGmLvgAAu9opvQ
	(envelope-from <linux-nfs+bounces-19780-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Mar 2026 20:49:45 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A16EB2072FC
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Mar 2026 20:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CEEFD30217EF
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Mar 2026 19:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F247288514;
	Wed,  4 Mar 2026 19:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GhNEikZn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9861C3890ED
	for <linux-nfs@vger.kernel.org>; Wed,  4 Mar 2026 19:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772653783; cv=none; b=QEzo2EQtfurRJY82HdOWN2DilzPc+2wxQpjOywH7yf0Mdmdn3dMwWzPfxI5o3jgt3ABvlIYO0R5E5TH+fL3URzYfr8OEYSloaOw3qEu1Rd3hnhQMcd+y/F4L5wbhOiHvt3oZtLBYEwQH9WPeUYSMRaXTbBUlgWZRKyLKruXUqUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772653783; c=relaxed/simple;
	bh=OEp8xVZIQNj8UD9hBBfHilCzoh1fMH2uKVPKW5aroEc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h9CC4tFutBBt7Z3Ai7sf4CAqjFOrSvs903tMWic6diBA3Qdqn5Ezc/WUKZtJzlp3mKTE+pnSmePrKSbMjIChrMFF1RQjmuB8MIPYThq0yn5LTGrvUMnW+pJ/RjeCpicX3hvJzLHDXRieKeUjSYyg2fMuSSnpB8vKT19T1XbwToQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GhNEikZn; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 624JOAgX3505893;
	Wed, 4 Mar 2026 19:49:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=oIMuv/eZ35IUDZ0O0JG+tthIqK+2M
	F/TPv2/qZ7GgSQ=; b=GhNEikZnX1cn2eAkb9ssQXJ6u4e48VjRz9GKvTSs99Up9
	ucmFkiU1p/f9/cSr7xkPHi5VEkSRzmjeWZDBnSPPQtpBpLGCl/1SCnlECLsU8GRn
	seMp6s7+FEmT8uQWkVNHNiwMiRycU73L9fGTsgrvmysTjP8vmh9pOEkGwLaK0xF0
	/73YMKBFabTLT33ZRybEUsZ8zij/XEYlH6abvRs71jfIY70zGpq2vO1iy5L50czX
	IYRwgdXvv+wmItwkk9OIciOjv0riW74bp0yc4F7vjDmXj5nb5U1U43/Sgp5P1WEl
	l6r9CUxuoAnmiMalccKL9dYJyDUPjj9HMR8bgm/Qg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cptunr1f3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Mar 2026 19:49:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 624Hx2vO029671;
	Wed, 4 Mar 2026 19:49:35 GMT
Received: from labops-common-sca-01.us.oracle.com (labops-common-sca-01.us.oracle.com [10.132.26.161])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4ckptc83e2-1;
	Wed, 04 Mar 2026 19:49:35 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: trondmy@kernel.org, anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/1] pNFS: Serialize SCSI PR registration to avoid reservation conflicts
Date: Wed,  4 Mar 2026 11:49:12 -0800
Message-ID: <20260304194931.2592156-1-dai.ngo@oracle.com>
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
 definitions=2026-03-04_07,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 mlxscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2602130000 definitions=main-2603040162
X-Proofpoint-GUID: Zag3mMPKpDSwq4VOqXaAILW96BIVjqTc
X-Proofpoint-ORIG-GUID: Zag3mMPKpDSwq4VOqXaAILW96BIVjqTc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDE2MSBTYWx0ZWRfX1xUXCcWekWWR
 OO48uyQk2iW2cWXl9A2B63yPaQNyreRbcRnwj+ShkU2vbWdH86IGwc8kA/yacOuButD7nX67GZF
 cUOk2nf2rdBTGVyPUu+FjdcRhxwlR/MHib9dBvku2xbTbPG/llitYKnynHaqkN8NppRJFPSZjNj
 4b0txdQ5OdaOim5y05NBI/Az75QVFRuEQiHB2KE5WXxXozGynbBZybqlAwguLl0b0fi7ky9ghhQ
 UaVn0jbZnfzRSdU/iKMBycNQsKpaPtUDg9vxceV8T1198ysyfD405NMLAiysN3ClKu0TDhmb1Qa
 21wQoJrkso3SXutUz3L7XcusDYA2+hbcote7x1F33kIIxDkNSZxJdsAWvg96rnTcsOrMAuwjUBR
 77iudT8eDodBGxz4JlQ3K85gAWCnyqJHoV06U1j4ogI6hqiUSjZAx9cSsPpxMC0MszAOAt+5wZg
 EYObkL3zgI6oCL1O8Cw==
X-Authority-Analysis: v=2.4 cv=V6lwEOni c=1 sm=1 tr=0 ts=69a88cd0 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=yPCof4ZbAAAA:8 a=RB7BpKAJ3d8g6uwT4AwA:9
 a=tCwZ0VhKLMDIaFnWcSrr:22
X-Rspamd-Queue-Id: A16EB2072FC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19780-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dai.ngo@oracle.com,linux-nfs@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,oracle.com:dkim,oracle.com:email,oracle.com:mid];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

With SCSI layouts, the NFS client must not submit I/O to the data server
until the Persistent Reservation (PR) registration has completed.

Currently, bl_register_scsi() sets PNFS_BDEV_REGISTERED before performing
the PR operation. If multiple threads concurrently start I/O to the same
SCSI device, the first thread sets the flag and begins registration,
while other threads observe the flag, skip registration, and proceed to
issue I/O. Those I/Os can hit RESERVATION CONFLICT, forcing fall back to
the MDS.

Protect the registration/unregistration operation path with a mutex so only
one thread performs the op at a time. Other threads wait for the operation
to finish and only then and only then re-check PNFS_BDEV_REGISTERED flag.
 
Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfs/blocklayout/blocklayout.h |  3 +++
 fs/nfs/blocklayout/dev.c         | 14 ++++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

v2:
    . remove fio test from commit message.
    . rename pbd_mutex to pbd_registration_mutex and add a description
      of its usage.
    . move declaration of pbd_registration_mutex before the (*map)().
    . protect unregistration op with pbd_registration_mutex.

diff --git a/fs/nfs/blocklayout/blocklayout.h b/fs/nfs/blocklayout/blocklayout.h
index 6da40ca19570..934a5b75ed1e 100644
--- a/fs/nfs/blocklayout/blocklayout.h
+++ b/fs/nfs/blocklayout/blocklayout.h
@@ -114,9 +114,12 @@ struct pnfs_block_dev {
 	unsigned long			flags;
 
 	u64				pr_key;
+	/* Mutex to serialize SCSI PR register/unregister operations. */
+	struct mutex			pbd_registration_mutex;
 
 	bool (*map)(struct pnfs_block_dev *dev, u64 offset,
 			struct pnfs_block_dev_map *map);
+
 };
 
 /* pnfs_block_dev flag bits */
diff --git a/fs/nfs/blocklayout/dev.c b/fs/nfs/blocklayout/dev.c
index cc6327d97a91..8d57368c7cf4 100644
--- a/fs/nfs/blocklayout/dev.c
+++ b/fs/nfs/blocklayout/dev.c
@@ -33,10 +33,15 @@ static bool bl_register_scsi(struct pnfs_block_dev *dev)
 	const struct pr_ops *ops = bdev->bd_disk->fops->pr_ops;
 	int status;
 
-	if (test_and_set_bit(PNFS_BDEV_REGISTERED, &dev->flags))
+	mutex_lock(&dev->pbd_registration_mutex);
+	if (dev->flags & BIT(PNFS_BDEV_REGISTERED)) {
+		mutex_unlock(&dev->pbd_registration_mutex);
 		return true;
+	}
+	dev->flags |= BIT(PNFS_BDEV_REGISTERED);
 
 	status = ops->pr_register(bdev, 0, dev->pr_key, true);
+	mutex_unlock(&dev->pbd_registration_mutex);
 	if (status) {
 		trace_bl_pr_key_reg_err(bdev, dev->pr_key, status);
 		return false;
@@ -55,9 +60,13 @@ static void bl_unregister_dev(struct pnfs_block_dev *dev)
 		return;
 	}
 
+	mutex_lock(&dev->pbd_registration_mutex);
 	if (dev->type == PNFS_BLOCK_VOLUME_SCSI &&
-		test_and_clear_bit(PNFS_BDEV_REGISTERED, &dev->flags))
+			dev->flags & BIT(PNFS_BDEV_REGISTERED)) {
+		dev->flags &= ~BIT(PNFS_BDEV_REGISTERED);
 		bl_unregister_scsi(dev);
+	}
+	mutex_unlock(&dev->pbd_registration_mutex);
 }
 
 bool bl_register_dev(struct pnfs_block_dev *dev)
@@ -572,6 +581,7 @@ bl_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 	top = kzalloc_obj(*top, gfp_mask);
 	if (!top)
 		goto out_free_volumes;
+	mutex_init(&top->pbd_registration_mutex);
 
 	ret = bl_parse_deviceid(server, top, volumes, nr_volumes - 1, gfp_mask);
 
-- 
2.47.3


