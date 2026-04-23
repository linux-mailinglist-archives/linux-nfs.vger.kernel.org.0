Return-Path: <linux-nfs+bounces-21056-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LUSDXNc6mksygIAu9opvQ
	(envelope-from <linux-nfs+bounces-21056-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 19:52:51 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82611455C64
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 19:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FCC3300B13E
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 17:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00641241139;
	Thu, 23 Apr 2026 17:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C5rkA6aJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4411C28690
	for <linux-nfs@vger.kernel.org>; Thu, 23 Apr 2026 17:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776966767; cv=none; b=QGj61Sa6Zn0Irsl6b6QrJWgrI9zUa5+H7+fdtmtnb1AgLPA11etMoMvjLOdx41ECzeac920MVgXDfMPdcHHcw0yZ/9u4IMr0+kbxsYkOdh7CD9R5Hh83NTvL6eE3kfWhrE5Xm3KIkIm841vik6K90ahY7GXQXf/yv4YjoRGB6GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776966767; c=relaxed/simple;
	bh=hfeBMAocPTNaLmkkRCgZaaY42W6o55+1YX8GWABRq60=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VrIQjXFFfT5bg5dfJI5hfs8IeVSaF48aVY+OBSuYZt7J+1+BTML0AKxE/Vk548zP5wa4i79WDyj0BYForXFjsoceuNoi4L/iArN5RjehDNU7o1eg3Xn+C7SYR3iFefVC0i1XugUab5cboWi5opCBUpCgY2vq+DvcW0TRpn+JnWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C5rkA6aJ; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63NGT7nk055562;
	Thu, 23 Apr 2026 17:52:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=/dTsqn4738ILNiyK1J6DdQD5QVn73
	IQMhC2Ha8Z2oD8=; b=C5rkA6aJeezLE3KctuRy7udQdavpoTBrsGwI0s6z0SYRf
	PYYUKJPhhdw31gGeqrpId4hAFTP/ZVSgeQjZ2S95+KqO+uZ4q+bcn2lZWAW8NK3b
	riliyt2CnviRFq2LwF+XHPRxwIi15ACClrWN9A+cAwVKVE4jgmTv/+6WNMmbl9SZ
	SkKAW1LkKmYz0pCKpBsslI9NhNybzbruWHlJQeVlk3ZADIlxdgBYQQR7VYYhrr7O
	S8rz52inLz2+B1gq36+9qSFOZAqEsydv23Ntnc7sO94mqdG59mQq0Dhw+nC1NQWG
	oVtuVDH86e8uWq5FMHPaAC8Jl9VvcjJoxH5uXqTtg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dpenm3ydw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Apr 2026 17:52:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63NHkSZB040844;
	Thu, 23 Apr 2026 17:52:36 GMT
Received: from labops-common-sca-01.us.oracle.com (labops-common-sca-01.us.oracle.com [10.132.26.161])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4dpjjgf1y4-1;
	Thu, 23 Apr 2026 17:52:35 +0000 (GMT)
From: Dai Ngo <dai.ngo@oracle.com>
To: trondmy@kernel.org, anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFS: fix eof updates after NFSv4.2 fallocate/zero-range
Date: Thu, 23 Apr 2026 10:52:10 -0700
Message-ID: <20260423175233.4175269-1-dai.ngo@oracle.com>
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
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2604200000 definitions=main-2604230173
X-Authority-Analysis: v=2.4 cv=FNUrAeos c=1 sm=1 tr=0 ts=69ea5c64 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=yPCof4ZbAAAA:8 a=PqYeln0rHlJyf4IMnMIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE3MyBTYWx0ZWRfX2tIBR8v4HiMp
 1bXRuRIhTFW/zdqTIIby34i13afqxKsxW7jDriDOnLLcEc4ZbdJF12w1e+ZzwlyKKyPm/noZD8Q
 dLFi/MdZLmFZe8V6kDBOASdPJQVpG7/es07QOyfGjfDxN/rbNdV5iu8MhsUQNAIIhhO9JeKuLpc
 EPJaDAA3eaTKcgh/+Fcf8p9eYk+vOAVmTWb2HTrhHKri425akgjCO7CUBx5zDMLKhB9HMyewaa9
 jfbyRWFD6PqNZB7iHnn6OSRZ5cdPfDM3Cz3MLpaZwUOohWwTj4Ft8QAv3kGYbw5xvmE5maUSxpX
 CYrkuXgIh4ZotdSpJUCdeG3BzgqEFtReoXxRs/JAy7ElLnPLQxsLkUSIM19mU9cEgBOpL3iNhTZ
 GULlYtY8bbrhi7ByCZkaAOQy79aq9oWHPBWmVNrphRZXwU7vXn/69MFGD8/GjnI6rOhKuEjht+6
 u3QPISn2SKd24N0zObQ==
X-Proofpoint-GUID: Xz03yDlCbdNrkzXxNZifjoLCcp81E6kY
X-Proofpoint-ORIG-GUID: Xz03yDlCbdNrkzXxNZifjoLCcp81E6kY
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21056-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 82611455C64
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Generic/075 reliably exposes a regression when the client holds an
NFSv4 write delegation: ZERO_RANGE/ALLOCATE extends the file on the
server, but the local inode keeps the old i_size. The test then fails
with 'Size error' because the post-op attribute refresh refuses to
touch i_size while a delegation is outstanding, and the cached EOF
was never marked stale.

Update _nfs42_proc_fallocate() so that on success it:

- bumps i_size when the operation extends the file, and
- marks NFS_INO_INVALID_BLOCKS since the block count can also change

Tested with xfstests generic/075 over NFSv4.2.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfs/nfs42proc.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 7b3ca68fb4bb..1f728107a7fb 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -81,12 +81,17 @@ static int _nfs42_proc_fallocate(struct rpc_message *msg, struct file *filep,
 	status = nfs4_call_sync(server->client, server, msg,
 				&args.seq_args, &res.seq_res, 0);
 	if (status == 0) {
-		if (nfs_should_remove_suid(inode)) {
-			spin_lock(&inode->i_lock);
+		loff_t newsize = offset + len;
+
+		spin_lock(&inode->i_lock);
+		if (newsize > i_size_read(inode))
+			i_size_write(inode, newsize);
+		nfs_set_cache_invalid(inode, NFS_INO_INVALID_BLOCKS);
+		if (nfs_should_remove_suid(inode))
 			nfs_set_cache_invalid(inode,
-				NFS_INO_REVAL_FORCED | NFS_INO_INVALID_MODE);
-			spin_unlock(&inode->i_lock);
-		}
+					      NFS_INO_REVAL_FORCED |
+					      NFS_INO_INVALID_MODE);
+		spin_unlock(&inode->i_lock);
 		status = nfs_post_op_update_inode_force_wcc(inode,
 							    res.falloc_fattr);
 	}
-- 
2.47.3


