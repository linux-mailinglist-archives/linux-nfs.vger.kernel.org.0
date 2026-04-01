Return-Path: <linux-nfs+bounces-20593-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4B/DFMFrzWkkdQYAu9opvQ
	(envelope-from <linux-nfs+bounces-20593-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Apr 2026 21:02:25 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3723837F968
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Apr 2026 21:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 122CC3014662
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Apr 2026 18:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F73547CC8C;
	Wed,  1 Apr 2026 18:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SkYkMcQt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A0247B439
	for <linux-nfs@vger.kernel.org>; Wed,  1 Apr 2026 18:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775069626; cv=none; b=ggH/qYTyy3UT1guQ7XvqjpMqKBhMu0k+UrYecyCABh1ibnnS79zoGeXibvYp7t3rJKEzfE7OUGdMFCYaSWKyGYu0Q2KWjozNeDLGDmda33G2MoFObaUZ+YDfieUtUl0s/5ftE8cZb1dvQeklqoO/e65WvJGUhopsmONVIOCtwW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775069626; c=relaxed/simple;
	bh=hMTMvxolU3o9IzHB5tpexirnx8Iw1epQfrS89g7gmgA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Xot+ZBlCt0PKmjivQEqm7+Zqi3DQIDK3ZwtZLN9MMz35BZgl0sUgwIxiUGF9cmHhPBke+XBrO0oFjvIxrbYJ7eugxiiaQpNVpDW2rYs+2WiPIrlEMGB5ww4LsyUBfWnL1OKjzbvTnN6hKkbXW5FJqkx74d5OpXejSnBdXHBJR8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SkYkMcQt; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631Inpb21498479;
	Wed, 1 Apr 2026 18:53:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=g9nGPtzQMJRe+3k+
	3BBp8zv6bV45solpW3alTBGwaA4=; b=SkYkMcQtWYQZKcfmBMfeAymFN+wzf6GP
	d7voABapCKyh/fnM65QR2YCF3LoUzm/MchQMMmoG3XREUnAKt96OAoysbrysa9es
	f8AJF8+XU1J8jMzftcIkUDeeGzNGw557u/BzjirGuUcz0J1T3xNJ6lPeOLRPyNC3
	mJTFWt5qj13KN6QGXkik9D90Jej4vCeXuXN92rItFhHckDf1g/6P0o1bKBTGZR8Q
	LGUGvE7sMAhm5URhJyz/zEqfQCTOzaYZQv/Mq2P16QjOSyKeWVmYgICamxSMbNS6
	HJfHMJ0vR+9tyA0BnzSYbI5u1Uj2pIUkD2OwcEhga3obEOhE/Rsnfw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d65jwf844-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Apr 2026 18:53:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 631Iq8A4027541;
	Wed, 1 Apr 2026 18:53:42 GMT
Received: from labops-common-sca-01.us.oracle.com (labops-common-sca-01.us.oracle.com [10.132.26.161])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4d65ebs6h4-1;
	Wed, 01 Apr 2026 18:53:41 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: trondmy@kernel.org, anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] Don't always trust server inode size while client holds write delegation
Date: Wed,  1 Apr 2026 11:52:37 -0700
Message-ID: <20260401185322.2691848-1-dai.ngo@oracle.com>
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
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2603050001 definitions=main-2604010177
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDE3NyBTYWx0ZWRfX2gmpDHr7yGcj
 t3yqbMSS3EBWXiX7GaeSfYIl+rU0RgHwB4/bhJNltBfkKgaFCeFGRoVAtECcTKFgV4C85ZZK3gf
 P7jx7NJigyvbOyQvxIn/ASZJ8c89DD2gPr/3zEEFV46H5pH0GEEzc+joHvxaR5YB8uhBFBK3goP
 AYMSNm+tLmbz/NoqZO+W8gFt8yme2hjxnkvy3Flh3XMFJdf3sArAZ6giXowQ6KLBs5rulvJd3OF
 Nw2Qr46VTzAHUx8/g+oNLaFofLnDi2iwllklKs7LLyaOC9cL/C94eBG+nPXghBI2cXHnhju2mr8
 46qY2JmJCr/y/NnGdeKeCdjCsOAWNc/vhfCLCiVd0ahN1sV5ODRGG5PPfcWW9fyPYhNFg6vli4q
 TsFP2+Nt5XoLdAWMbrQMs6+8AAE8Vyh7l//O735e17+K10TwRqx/ps+5ocAAqfq/k7i5HJbM8Ku
 lcpTTdodXcBTar+XuDg==
X-Authority-Analysis: v=2.4 cv=CJEnnBrD c=1 sm=1 tr=0 ts=69cd69b6 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=yPCof4ZbAAAA:8
 a=dtOFvxagLQnViFfLHh0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: RbQJGBEoI0v0cv_7ojU3vzNDhrHJ-vNy
X-Proofpoint-GUID: RbQJGBEoI0v0cv_7ojU3vzNDhrHJ-vNy
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[oracle.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20593-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:dkim,oracle.com:email,oracle.com:mid];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[dai.ngo@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3723837F968
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


