Return-Path: <linux-nfs+bounces-19837-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBQ6O4IBq2msZQEAu9opvQ
	(envelope-from <linux-nfs+bounces-19837-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 06 Mar 2026 17:32:02 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F919224EED
	for <lists+linux-nfs@lfdr.de>; Fri, 06 Mar 2026 17:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C3BC30031F6
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Mar 2026 16:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F613EDACA;
	Fri,  6 Mar 2026 16:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g1+Kp7XF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FE53988EE
	for <linux-nfs@vger.kernel.org>; Fri,  6 Mar 2026 16:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772814586; cv=none; b=AMbISxHfUYX/bcUzHejnbvmR34UpTQir5JweqVahP+ddjr01LDwVj2ZXHIPVRMsEBlm7In4k2Rdk3wnkQ+y1YqIPPERxTMacG/DdHMxuEt8AoQ8rfDVI38GAC2LgFcLZIfwn5oHmDvfHqOFx4Zc49uretGvjt9Zscah9LjFU140=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772814586; c=relaxed/simple;
	bh=NFEikTdtv3rQ0cy54GdJNryBH6H26yKat9B2I25PBEg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gxe2wcDFILfcJezarz0kXx8pPYEOQe2kmuv+sJWUxj3WXxuKZ3PD3nRrqkGgHrf1dcEvkS7Ryhgjy3060dZViSZi1ubIl/zQlKA2FsFR+AGQFgEv08cTdS9UdDcl68OftH95Uq0VIYrmxgh0PSKRCR5O91svk2Rs8+ruyTQEMt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=g1+Kp7XF; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 626GHrVR3463847;
	Fri, 6 Mar 2026 16:29:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=t0LPF0q6YiZGdy+1ETcnMx/Gdfrx4
	2GegZ+B9duTAHU=; b=g1+Kp7XF5WUEmb2WMBTxWefU2MyASVB3BiqarVGq/KNth
	fMcoq/moeTkfJEAu3D3NFtyfnXvASiUdU7s8uexgN6uJqSxn0v0XmBjHeb9FX8wf
	ovae5mO4chGgU/H0v22X3/YmkrQeeFVzPB1O0bob/vXJQ7d2FWo7O/oj3pful15e
	jL81pVKH3LsgG1/vW3xWpZLWae3tBd73v8K22A1H+uUuPM/PprkSYRKz1qfgxk6y
	Fk1+pdk74m4k7Hkz3hkSBVD+V3yYTmFdvZbWxNA67TGui1X9XANx8Oh7pQFnVW3G
	QqszCTozA9DucfL3Z726hclZJZWdkENfZXmh+dhrw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cr2asr0qf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Mar 2026 16:29:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 626GT84J023057;
	Fri, 6 Mar 2026 16:29:30 GMT
Received: from labops-common-sca-01.us.oracle.com (labops-common-sca-01.us.oracle.com [10.132.26.161])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4ckptk5h0r-1;
	Fri, 06 Mar 2026 16:29:30 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: trondmy@kernel.org, anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v3 1/1] pNFS: Serialize SCSI PR registration to avoid reservation conflicts
Date: Fri,  6 Mar 2026 08:29:22 -0800
Message-ID: <20260306162927.3276695-1-dai.ngo@oracle.com>
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
 definitions=2026-03-06_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603060156
X-Proofpoint-GUID: DI7L29DDgH3QZeDl40jTQyjRMW9cUSvD
X-Proofpoint-ORIG-GUID: DI7L29DDgH3QZeDl40jTQyjRMW9cUSvD
X-Authority-Analysis: v=2.4 cv=ZdUQ98VA c=1 sm=1 tr=0 ts=69ab00eb b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=yPCof4ZbAAAA:8 a=w8h26E0HzORGd8iTHiwA:9 cc=ntf
 awl=host:12267
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDE1NSBTYWx0ZWRfX1XI2oGx/jmxN
 EJW178ts0FHhdfc2Vr7TzmtvBQuYBraHaMEqnvQCAFLZ3YhrZOh0W7kAmymGg4dCvx/imCLs2Ea
 6mXiyP4sG+yEMNfuekyaQ0m0S1+BSrjNkm3/EJyz2mt9ITpbxinamE2xwuUSThKrwdU3KtCl36g
 w0S8JUY6VmPOhjr9oI4tx2DEUlhD1F/7q2RlOl9gZbjqwYmQntbipGGC5VOWY8t8wi4RShLPRQH
 MGFXQRuiIpx74ajyhPN5nXOYUpb5f2mdlu2S5PRxd2f46h7Sde5vPF7KVDWGOMwwInj4ws959hI
 7ZsGkgTJ/qq7gxeQBbBNVrik9jEB8txNa5hO51uocKnvSic5aZdo2uhgNzq0r0wqeHXO+Pcw18n
 408xPR8xwbRkRsfoEz85siTkxpeicTtx56YN0XXBUEE0kXn9AldbUIhdMfBCHsfAQKUe3X6KWyT
 A6kvVYDUWiAs6eh/my7rUFMt+/sdPbzkCfQ5DqPk=
X-Rspamd-Queue-Id: 6F919224EED
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
	TAGGED_FROM(0.00)[bounces-19837-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dai.ngo@oracle.com,linux-nfs@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oracle.com:dkim,oracle.com:email,oracle.com:mid];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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

Protect the registration path with a mutex so only one thread performs
PR registration at a time. Other threads wait for registration to finish
and only then re-check PNFS_BDEV_REGISTERED, ensuring no I/O is issued
until PR registration is complete.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfs/blocklayout/blocklayout.h |  8 +++-----
 fs/nfs/blocklayout/dev.c         | 15 ++++++++++++---
 2 files changed, 15 insertions(+), 8 deletions(-)

v2:
    . remove fio test from commit message.
    . rename pbd_mutex to pbd_registration_mutex and add a description
      of its usage.
    . move declaration of pbd_registration_mutex before the (*map)().
    . protect unregistration op with pbd_registration_mutex.
v3:
    . replace PNFS_BDEV_REGISTERED flag in pnfs_block_dev with
      blkdev_registered boolean.

diff --git a/fs/nfs/blocklayout/blocklayout.h b/fs/nfs/blocklayout/blocklayout.h
index 6da40ca19570..311b14334902 100644
--- a/fs/nfs/blocklayout/blocklayout.h
+++ b/fs/nfs/blocklayout/blocklayout.h
@@ -111,17 +111,15 @@ struct pnfs_block_dev {
 
 	struct file			*bdev_file;
 	u64				disk_offset;
-	unsigned long			flags;
 
+	bool				blkdev_registered;
 	u64				pr_key;
+	/* Mutex to serialize SCSI PR register/unregister operations. */
+	struct mutex			pbd_registration_mutex;
 
 	bool (*map)(struct pnfs_block_dev *dev, u64 offset,
 			struct pnfs_block_dev_map *map);
-};
 
-/* pnfs_block_dev flag bits */
-enum {
-	PNFS_BDEV_REGISTERED = 0,
 };
 
 /* sector_t fields are all in 512-byte sectors */
diff --git a/fs/nfs/blocklayout/dev.c b/fs/nfs/blocklayout/dev.c
index cc6327d97a91..f1e77c4290ae 100644
--- a/fs/nfs/blocklayout/dev.c
+++ b/fs/nfs/blocklayout/dev.c
@@ -33,10 +33,15 @@ static bool bl_register_scsi(struct pnfs_block_dev *dev)
 	const struct pr_ops *ops = bdev->bd_disk->fops->pr_ops;
 	int status;
 
-	if (test_and_set_bit(PNFS_BDEV_REGISTERED, &dev->flags))
+	mutex_lock(&dev->pbd_registration_mutex);
+	if (dev->blkdev_registered) {
+		mutex_unlock(&dev->pbd_registration_mutex);
 		return true;
+	}
+	dev->blkdev_registered = true;
 
 	status = ops->pr_register(bdev, 0, dev->pr_key, true);
+	mutex_unlock(&dev->pbd_registration_mutex);
 	if (status) {
 		trace_bl_pr_key_reg_err(bdev, dev->pr_key, status);
 		return false;
@@ -55,9 +60,12 @@ static void bl_unregister_dev(struct pnfs_block_dev *dev)
 		return;
 	}
 
-	if (dev->type == PNFS_BLOCK_VOLUME_SCSI &&
-		test_and_clear_bit(PNFS_BDEV_REGISTERED, &dev->flags))
+	mutex_lock(&dev->pbd_registration_mutex);
+	if (dev->type == PNFS_BLOCK_VOLUME_SCSI && dev->blkdev_registered) {
+		dev->blkdev_registered = false;
 		bl_unregister_scsi(dev);
+	}
+	mutex_unlock(&dev->pbd_registration_mutex);
 }
 
 bool bl_register_dev(struct pnfs_block_dev *dev)
@@ -572,6 +580,7 @@ bl_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 	top = kzalloc_obj(*top, gfp_mask);
 	if (!top)
 		goto out_free_volumes;
+	mutex_init(&top->pbd_registration_mutex);
 
 	ret = bl_parse_deviceid(server, top, volumes, nr_volumes - 1, gfp_mask);
 
-- 
2.47.3


