Return-Path: <linux-nfs+bounces-19488-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAHgByTfpGn5ugUAu9opvQ
	(envelope-from <linux-nfs+bounces-19488-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 02 Mar 2026 01:51:48 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B361C1D2302
	for <lists+linux-nfs@lfdr.de>; Mon, 02 Mar 2026 01:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1DD1B3009081
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Mar 2026 00:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2227B78F39;
	Mon,  2 Mar 2026 00:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="o4uSnlHk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90457215F7D
	for <linux-nfs@vger.kernel.org>; Mon,  2 Mar 2026 00:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772412706; cv=none; b=t/ZwNrXJ+O0N4CB/NMXFUJFoyw1nswpUjXWSqdQhAApC5u3lDcdhC0VoVi6VWwMgmx9w0s/t/Bw7UgqTjhReozTOeCGueBN2xJbin29adwGUxQ0aWlIngoEZrRgHnElyI8X9jAdsu1zAA8aA4fxDMNeuLarUlxN46cqw9lmEAKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772412706; c=relaxed/simple;
	bh=a3zfmoTUL2udsYzD8WxZJU1WrmdZ/8ARY0tHQ/RdwDk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GqVZKB4oYmlYYZUR3UWtr3JoP3quoKqmVSns9fL9Pvp0NTUzWsvkWYTB3ZbOUn3Ohe/vo0sQwfpWAW6Sr9aSVa58HJNPJO5UTtAOIFWh1GXTiRGOM9+F+XS21z5gLwlhGppR4Wp09hlLgW/R6P74JZeX3bps6IGR5bT18SLRpXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=o4uSnlHk; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6220jktD2222253;
	Mon, 2 Mar 2026 00:51:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=DEfBP1/q1xSkoz1d0nRE2YpqRBj/Z
	PaLxXt7StjbSM4=; b=o4uSnlHkxG90JpaLZmt5vR639teAy9c3Un/2Xr8OXHbmP
	rmbksVWLRBgs08Tauh0bsoMk2/d95dJgqpK55KJ20on1IMivcPnC1Ff0rBKCpAoq
	8hvBdIKGsjc/6qQ54C8AWskmQx7zHFwED3v64E5BytXzOA2maatx+qhOPU7qoK3H
	ufpu0EGUP550wIp4LDaJ932/w6WO1s/NlAiAQzBiRdrSZDlP9teccy23cJ73bOAn
	oOzo6B72WWAPwsbreMFD9CjTeNgj/e8HR2EID7+majd30KlamR7l+HdTr+CLwPzM
	bgP02W5g6MTITIA5U9JTg7SCWLDmpqgBXrVM2jQWw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ckshbscpc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Mar 2026 00:51:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6220dkvH027757;
	Mon, 2 Mar 2026 00:51:40 GMT
Received: from labops-common-sca-01.us.oracle.com (labops-common-sca-01.us.oracle.com [10.132.26.161])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4ckpt81r48-1;
	Mon, 02 Mar 2026 00:51:40 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: trondmy@kernel.org, anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] pNFS: Serialize SCSI PR registration to avoid reservation conflicts
Date: Sun,  1 Mar 2026 16:51:23 -0800
Message-ID: <20260302005138.1844156-1-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-01_05,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603020005
X-Proofpoint-GUID: kabIt3ZcKzWtQI65ta9Jp3ZC0UYfQcIu
X-Proofpoint-ORIG-GUID: kabIt3ZcKzWtQI65ta9Jp3ZC0UYfQcIu
X-Authority-Analysis: v=2.4 cv=Qaxrf8bv c=1 sm=1 tr=0 ts=69a4df1d cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=yPCof4ZbAAAA:8 a=w8h26E0HzORGd8iTHiwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDAwNCBTYWx0ZWRfX+qurlwlAlgWK
 NzESH2E82PbEdbdqv3sDNaP9YRlo0c8AyiIEOXADldU4lgzE9ZUzhufCAk6mpFLlvwaWeP92u6/
 7cOzSosM6QE+8OFS5Evdv+weLj7mDbF8k/Phoi/usUteaSn9vvt1k1Sz9WQ3L4C082H4PZzbPOq
 c55KAFh6Jwc6wgmuxxAG9JCYFKyLvE8/Tvq+Eoo3Jm6ie1jVjimdKmrKQG5P+jAm3svKk41lcif
 K/BU7Glhluc76Dq5gqQe91UKtegDeHEvvf8RchHRxWY3SiY4bjJyT/XIHUBFOys/jJVev8IoTuH
 fdWCmrHlRmq7xngDAaLniMPMyBFLAklhbalsKwzu+kE28AoDgNDGv0X4kvvIXOYtQU9UMRVj9SV
 GeJJlx0rUQqRffUiCFL60coE463QXfFdigJOa4sYCsQR5g1JV9wwYha3HCFLkYUuheGuzxPaMSS
 gOmxvtGVY0NcDa8iiNQ==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19488-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dai.ngo@oracle.com,linux-nfs@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:dkim,oracle.com:email];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B361C1D2302
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

This problem can be reproduced by running 'fio' test with this
workload:

[global]
ioengine=libaio     # Also try 'io_uring'
direct=1            # Bypass local cache to stress pNFS paths
verify=0
rw=read             # 100% Reads
bs=2M               # Large blocks to saturate bandwidth
size=10G            # Large enough to outsize any cache
runtime=60
time_based
group_reporting
directory=/tmp/mnt/testvm1 # Your pNFS mount point

[parallel-stress]
numjobs=4           # Multiple threads to trigger multiple DS connections
iodepth=8           # Keep the I/O pipeline full
[parallel-stress2]
numjobs=4           # Multiple threads to trigger multiple DS connections
iodepth=8           # Keep the I/O pipeline full
[parallel-stress3]
numjobs=4           # Multiple threads to trigger multiple DS connections
iodepth=8           # Keep the I/O pipeline full
[parallel-stress4]
numjobs=4           # Multiple threads to trigger multiple DS connections
iodepth=8           # Keep the I/O pipeline full

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfs/blocklayout/blocklayout.h | 1 +
 fs/nfs/blocklayout/dev.c         | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/blocklayout/blocklayout.h b/fs/nfs/blocklayout/blocklayout.h
index 6da40ca19570..535db8b0e89c 100644
--- a/fs/nfs/blocklayout/blocklayout.h
+++ b/fs/nfs/blocklayout/blocklayout.h
@@ -117,6 +117,7 @@ struct pnfs_block_dev {
 
 	bool (*map)(struct pnfs_block_dev *dev, u64 offset,
 			struct pnfs_block_dev_map *map);
+	struct mutex			pbd_mutex;
 };
 
 /* pnfs_block_dev flag bits */
diff --git a/fs/nfs/blocklayout/dev.c b/fs/nfs/blocklayout/dev.c
index cc6327d97a91..45630781f1a8 100644
--- a/fs/nfs/blocklayout/dev.c
+++ b/fs/nfs/blocklayout/dev.c
@@ -33,10 +33,14 @@ static bool bl_register_scsi(struct pnfs_block_dev *dev)
 	const struct pr_ops *ops = bdev->bd_disk->fops->pr_ops;
 	int status;
 
-	if (test_and_set_bit(PNFS_BDEV_REGISTERED, &dev->flags))
+	mutex_lock(&dev->pbd_mutex);
+	if (test_and_set_bit(PNFS_BDEV_REGISTERED, &dev->flags)) {
+		mutex_unlock(&dev->pbd_mutex);
 		return true;
+	}
 
 	status = ops->pr_register(bdev, 0, dev->pr_key, true);
+	mutex_unlock(&dev->pbd_mutex);
 	if (status) {
 		trace_bl_pr_key_reg_err(bdev, dev->pr_key, status);
 		return false;
@@ -572,6 +576,7 @@ bl_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 	top = kzalloc_obj(*top, gfp_mask);
 	if (!top)
 		goto out_free_volumes;
+	mutex_init(&top->pbd_mutex);
 
 	ret = bl_parse_deviceid(server, top, volumes, nr_volumes - 1, gfp_mask);
 
-- 
2.47.3


