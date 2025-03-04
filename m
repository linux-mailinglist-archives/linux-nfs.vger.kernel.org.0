Return-Path: <linux-nfs+bounces-10444-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 208ABA4D210
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Mar 2025 04:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DFA53AC93E
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Mar 2025 03:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC9A18A6A5;
	Tue,  4 Mar 2025 03:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ngD2Y1wo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C4782866
	for <linux-nfs@vger.kernel.org>; Tue,  4 Mar 2025 03:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741059260; cv=none; b=K1HmDPQh/1uvBWZB1HhdnWqHxQ8lgfWp539LIdI1mr9xMi3J7EFAEs9pVZ9/X2c3pV4D46/edP0De/xN1vpZyoPWS9AhSDY+pD4//6gMjLeUTg3DayjvuOs9XypAvx8hqBtvsvNaMgRRN9gqUzwDIxMb6+SVbOFkAPAxLEYqiw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741059260; c=relaxed/simple;
	bh=RLfnlgfKYgsLeQk3EJ5rH/kXaHrtcgOqBbEGT0r5Gxs=;
	h=From:To:Cc:Subject:Date:Message-Id; b=oCmZ2wOiaJuA42bjIkOZPKQefiTBmiyw4dTywhY4YATGsoIcygayxb4gxvMzwoHwZgZHzHfL7IHFLCsNXwxbo6xlal83ksXTBKaWR4d+gSIwujZ4AK2D3QE786E3heCUyIUWw4FUTtQae+R25+HquINrQyJ6JezfPVjKUB/mwow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ngD2Y1wo; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5241NIr5009015;
	Tue, 4 Mar 2025 03:34:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:date:from:message-id:subject:to; s=corp-2023-11-20; bh=6o0vmng5
	thEsG5o5e6pCGzwak4ov268vOUpaWuv29lc=; b=ngD2Y1woDnM71ZCoG7vjvkpf
	gyIYhzxL+KHNs2XgIY0Utaip/uikBMhEtCVGdt68ybN8pZ0UOIbihd0BbT0RcCtx
	tBYknvQXkpWJEP7Nay/IxOE4wxfCMAmqmw1jhIoiEJ0WZ90gLFFUBRbVIsKAHLX0
	sTrRBMKPduX4BexTpYPGq6vrE7kmo3MKM60sEWNBCKsAeHhlxcUR07i7D4/d11LS
	b1wR3/UpNoz+rManjfqd5kETik1loWYOzHVdFslYNJ7N1ReaEKz1Zb2eu7WOp/x8
	QHMM2WafQMsPgvQjCr2jXDv9OC+IQBvGVTqZB95hdU9h9lvwx+9Q4RHTSdIdrQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4541r43w3j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Mar 2025 03:34:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5243Sv5D010885;
	Tue, 4 Mar 2025 03:34:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rp9w3se-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Mar 2025 03:34:02 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5243Y2SW011680;
	Tue, 4 Mar 2025 03:34:02 GMT
Received: from ca-common-sca.us.oracle.com (ca-common-sca.us.oracle.com [10.132.20.202])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 453rp9w3rs-1;
	Tue, 04 Mar 2025 03:34:01 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        okorniev@redhat.com, tom@talpey.com
Cc: linux-nfs@vger.kernel.org, sagi@grimberg.me
Subject: [PATCH V3 0/2] NFSD: offer write delegation for OPEN with OPEN4_SHARE_ACCESS only
Date: Mon,  3 Mar 2025 19:33:42 -0800
Message-Id: <1741059224-4846-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_02,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503040028
X-Proofpoint-ORIG-GUID: l2k5cgu0sBA2msJtDHVIzOhDL31CZVua
X-Proofpoint-GUID: l2k5cgu0sBA2msJtDHVIzOhDL31CZVua
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
   implementation may unavoidably do (e.g., due to buffer cache
   constraints)."

Also in section 10.4.1

  "Similarly, when closing a file opened for OPEN4_SHARE_ACCESS_WRITE/
   OPEN4_SHARE_ACCESS_BOTH and if an OPEN_DELEGATE_WRITE delegation
   is in effect"

When a write delegation is granted for OPEN with OPEN4_SHARE_ACCESS_WRITE,
a new pair of nfsd_file and struct file are allocated with read access
and added to nfs4_file's fi_fds[]. This is to allow the client to use
the delegation stateid to do reads.

No additional action is needed when the delegation is returned. The
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

 fs/nfsd/nfs4state.c | 75 ++++++++++++++++++++++++++++++------------------
 1 file changed, 47 insertions(+), 28 deletions(-)


