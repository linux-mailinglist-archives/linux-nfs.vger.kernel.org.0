Return-Path: <linux-nfs+bounces-21773-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLoeHZpnD2pKKgYAu9opvQ
	(envelope-from <linux-nfs+bounces-21773-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2026 22:14:18 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AEF45ABAE3
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2026 22:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 96DA6300373A
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2026 20:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CC13FB072;
	Thu, 21 May 2026 20:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CmjUZpoM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E863E6389
	for <linux-nfs@vger.kernel.org>; Thu, 21 May 2026 20:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779394452; cv=none; b=kx7rp3Qfj52OkxaipxkFVjTlTp7X5qlNPFEBS3oIPH1TzzLPiQZ2yTaTn/aTxjYkevoQAtgaXCv80QF1U+NnTi0ijuQ+wjubMKmXCCCDuAujW2bTSizraBvVYW/OAB+HYr3AyNoEwe8lu9QOkTBCRxM0RE4DePBc3AgUnmcsLCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779394452; c=relaxed/simple;
	bh=bJNZkmJu6lUCFUXLDRwmtF7kMB+2PWrzRgA6D6p4ay8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HMCVXYgCBObTGy9i7i2CbuyCf4tayRkdFC6+No11rfnI1DASFmcgXZUtnvqBLr6+7aj+feMvGEX1gurOEPVhMKRA1xSl+IVARsWS5+dJjVk8K9B4tg38Lq2mOTa492XB7L9REhwqRvuIfUXsgkI1MuEhTPnLvoTClkBwv3XVMH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CmjUZpoM; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64LJfleg3405276;
	Thu, 21 May 2026 20:14:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=A9CIalVl/pqlcJ1E
	vCekjC/SHde6XOeor2K/bmyzlRg=; b=CmjUZpoMq2tyx6qr3llc1o2+omL3WcP1
	pkLE8+8PYddxxjK1W9hGyPcXolKUPOBIWbTZipH1cWWeTJ4FlLoITtHLkmENlRKy
	wBTDTFnqGgyAn1n6chlO5j3yY0Qon5EKv3ZHYF+/SbB6nHt3Zs+VmKmnZIq03c/r
	ZSeTrpOGfOwNb5aTwfT6wbLuRTOWgcpO5IYB2o/VmhMs0y8OQ8aBG+1fZVt+j66D
	HIffbQ9vKyWc/Jd21xMIvhoso6qYaA7loC6gGgBfzDK+oqOrGt0TMURMN/iT5Qp1
	oT5NV6AlHrGiaedJTKa5zkYg9cv7e0WeUyLgn31oaRGy5KJV0yInjw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e6h8723hu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 20:14:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64LK9ix4033737;
	Thu, 21 May 2026 20:14:01 GMT
Received: from labops-common-sca-01.us.oracle.com (labops-common-sca-01.us.oracle.com [10.132.26.161])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4e84efm12u-1;
	Thu, 21 May 2026 20:14:01 +0000 (GMT)
From: Dai Ngo <dai.ngo@oracle.com>
To: trondmy@kernel.org, anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/1] NFS: Don't always trust server inode size while client holds write delegation
Date: Thu, 21 May 2026 13:13:46 -0700
Message-ID: <20260521201354.3294507-1-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605130000 definitions=main-2605210203
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDIwMyBTYWx0ZWRfX5phhL9bydLxP
 fzxWcqvQDK0iv+zY/KMb01CYYo3sWP2ly2liFHfSC3V+CIjaW1yVvb2ChJQKCQ8aSpnCKAIUgY5
 lPW2kN32HWMv2dJcv0Df0S+TzDygs9A8xH80XnFdMTatOFYjAQAaQ+Vxu6gPyj07Yo0j/gdxu6E
 /gJTxGLqJVqpKKic+9U/VcNIEPL/pMwSd3vWiH7S969kdtab7psUY1chcK8+aadhR5aNxmXe6aS
 L9rMuvV5ayZpp3DIFLGdWFR2IpTwhSuimu25kUbyGTWfp6eoJyIB3ltRntb8hVUMSMmyuChdVLX
 cgxS+4IJZzNEIkHr97ezgIJbc2owgcBIOOwgoMaJqCReF9lIwqYPVMYIOY1A+X3Nnia1ds1azKz
 i3uYkho8xtKZFA/6pHpKaL+j5CbK+Jg0jwBrQIntDC5DyaE3vGA83/BmX1H076QWS0WUZLrYaAu
 cIUpZZxNX4Qq4aUZ88aaNw4YubcihkE7/7d/ejUw=
X-Proofpoint-GUID: pe7oaUeRfoGpd2OM3fzGrNNnrCLpnTvO
X-Proofpoint-ORIG-GUID: pe7oaUeRfoGpd2OM3fzGrNNnrCLpnTvO
X-Authority-Analysis: v=2.4 cv=TLN1jVla c=1 sm=1 tr=0 ts=6a0f678b b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=yPCof4ZbAAAA:8
 a=rdvSnXTJRlWthDItqToA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13839
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-21773-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:mid,oracle.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[dai.ngo@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7AEF45ABAE3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

With a write delegation, the server permits the client to buffer writes
and associated metadata updates (including file size changes) locally and
defer propagating them to the server. As a result, the server-reported
GETATTR size may legitimately lag behind the client’s cached size for the
duration of the delegation, so it must not be treated as authoritative.

This patch modifies nfs_wcc_update_inode to update the cached inode size
only when the client does not hold a write delegation or the cache_validity
of the nfs_inode has the NFS_INO_INVALID_SIZE bit set.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfs/inode.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

v2:
  . added missing 'NFS:' on Subject line.

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 4786343eeee0..21161ebbd953 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -1649,8 +1649,11 @@ static void nfs_wcc_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 			&& (fattr->valid & NFS_ATTR_FATTR_SIZE)
 			&& i_size_read(inode) == nfs_size_to_loff_t(fattr->pre_size)
 			&& !nfs_have_writebacks(inode)) {
-		trace_nfs_size_wcc(inode, fattr->size);
-		i_size_write(inode, nfs_size_to_loff_t(fattr->size));
+		if ((!nfs_have_write_delegation(inode)) ||
+			(NFS_I(inode)->cache_validity & NFS_INO_INVALID_SIZE)) {
+			trace_nfs_size_wcc(inode, fattr->size);
+			i_size_write(inode, nfs_size_to_loff_t(fattr->size));
+		}
 	}
 }
 
-- 
2.47.3


