Return-Path: <linux-nfs+bounces-10490-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 745B0A50E51
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Mar 2025 23:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EDBE16B7A4
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Mar 2025 22:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D50259C9C;
	Wed,  5 Mar 2025 22:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q0I3XDGT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5153C2E3373
	for <linux-nfs@vger.kernel.org>; Wed,  5 Mar 2025 22:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741212338; cv=none; b=JWJlU8QZ3zsUNd/2L/po3g4/En6UJYfAgQQFVnQBD+gJTYgNgAPhWNAEL/B2TuQVKGCA9QsL/F9UihCr2c0I55PvUIEiCZwEXLdLpHX5a68fyBWABuNEKWctx0reV53QbvpERe6XdZ0ADmYhzdkZ8gT/dMTGB85akXTwyNm6uyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741212338; c=relaxed/simple;
	bh=+8yCcq2te3gGWBxkK3navaeqIhXL6J/J4LmxuKrNe1Q=;
	h=From:To:Cc:Subject:Date:Message-Id; b=K87DxI3lufyplzmAMBeYXxTE/8Ia3Z1+hAjl2ksqZYCDOWnhqTSeOGIFnrZTHM6SbEm3kW1L8W2+JKExvEkmHr3NeZXGE4BydFQ/4roWQu8zsm5ptAasj/2yasL8rhFI1vFJxNlLV3xZq/GgCD8/sSX+PHSdBHL2f6VGUpQQfus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Q0I3XDGT; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525LBhhT031171;
	Wed, 5 Mar 2025 22:05:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:date:from:message-id:subject:to; s=corp-2023-11-20; bh=7iIhqxMN
	bsi1uh+Cb0uXPDWtiiIAhU2VrbP3KwuQ1D0=; b=Q0I3XDGTQWcWI/b+lD43Ty9w
	z/2EicOywKdGsfnRc/Fb5W10jV5lI08kFDZlfGegbBkkhAZLrsR6lgkbMxjfIDf0
	9Rxvzz77iWUjWELgwHHLpCea4mey7VFqwVC0chTDEn+/GtIF5coH8c3ytKHOPCwX
	3NCNbloeUqiGUKnaDms59g8YZBX415CBt++kW8b78WdG+FnYLCF6Lpe6DRyy1APM
	VYAmfRe1v6x0og9uz7Y+0q/bvf9VUR1hYAHqkLCcKMWC4AV4SRWZhcEmRCe7mVAm
	LNXptAqVoImwWu3eIJ1ciBu2iF6aA9pxmFfDzlyojJPmQBcEVyiCr31AywGJhA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u8hgx8s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 22:05:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 525L2VN1039103;
	Wed, 5 Mar 2025 22:05:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rpbrshg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 22:05:23 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 525M5NRd030215;
	Wed, 5 Mar 2025 22:05:23 GMT
Received: from ca-common-sca.us.oracle.com (ca-common-sca.us.oracle.com [10.132.20.202])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 453rpbrsh1-1;
	Wed, 05 Mar 2025 22:05:22 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        okorniev@redhat.com, tom@talpey.com
Cc: linux-nfs@vger.kernel.org, sagi@grimberg.me
Subject: [PATCH V5 0/1] NFSD: offer write delegation for OPEN with OPEN4_SHARE_ACCESS only
Date: Wed,  5 Mar 2025 14:05:07 -0800
Message-Id: <1741212308-13521-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_09,2025-03-05_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503050170
X-Proofpoint-GUID: aIffjXEtWYlzz_b7vOFURQfkz3oYxbxt
X-Proofpoint-ORIG-GUID: aIffjXEtWYlzz_b7vOFURQfkz3oYxbxt
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

From RFC8881 does not explicitly state that server must grant write
delegation to OPEN with OPEN4_SHARE_ACCESS_WRITE only. However there
are text in the RFC that implies it is up to the server implementation
to offer write delegation for OPEN with OPEN4_SHARE_ACCESS_WRITE only.

Section 9.1.2:

  "In the case of READ, the server may perform the corresponding
   check on the access mode, or it may choose to allow READ for
   OPEN4_SHARE_ACCESS_WRITE, to accommodate clients whose WRITE
   implementation may unavoidably do reads (e.g., due to buffer
   cache constraints)."

Also in section 10.4.1

  "Similarly, when closing a file opened for OPEN4_SHARE_ACCESS_WRITE/
   OPEN4_SHARE_ACCESS_BOTH and if an OPEN_DELEGATE_WRITE delegation
   is in effect"

When a write delegation is granted for OPEN with OPEN4_SHARE_ACCESS_WRITE,
a new pair of nfsd_file and struct file are allocated with read access
and added to nfs4_file's fi_fds[]. This is to allow the client to use
the delegation stateid to do reads.

No additional actions is needed when the delegation is returned. The
nfsd_file for read remains attached to the nfs4_file and is freed when
the open stateid is closed.

The use of separate nfsd_file for read was suggested by Chuck.

I also tried the suggestion by Jeff which is to "acquire a R/W open from
the get-go instead when you intend to grant a delegation". To implement
this approach, in nfs4_get_vfs_file OPEN4_SHARE_ACCESS_READ was added to
op_share_access before computing the 'oflag' and 'access' flag. This
forces the rest of the code to process the OPEN as if it was sent with
access mode OPEN4_SHARE_ACCESS_WRITE|OPEN4_SHARE_ACCESS_READ.

This mostly works except a case where the file was created with 0222
permission and the user credential of OPEN is not the same as the owner
of the file. In this case the OPEN fails with NFS4ERR_ACCESS. This is
because nfsd_permission was called with (MAY_READ | MAY_WRITE) mask
and the file permission is 0222.

I don't see any simple fix for this nfsd_permission issue. Basically
the access mode has to be rdwr when creating the nfsd_file but the access
mode passed to nfsd_permission to check should be rdonly (the original
OPEN's op_share_access).

v4: reacted to Jeff's comment
v5: merged both patches into one to avoid potential bisect problem.
    fixed some nits from Jeff's comments.

 fs/nfsd/nfs4state.c | 76 ++++++++++++++++++++++++++++++------------------
 1 file changed, 48 insertions(+), 28 deletions(-)




