Return-Path: <linux-nfs+bounces-10466-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65110A4EE86
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Mar 2025 21:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B75C13AB229
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Mar 2025 20:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB634215F7D;
	Tue,  4 Mar 2025 20:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KLWrv2Mr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C681F8917
	for <linux-nfs@vger.kernel.org>; Tue,  4 Mar 2025 20:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741120732; cv=none; b=J+o+x2W9R9N+XOQMIzOlIF8JhC2i10kkaC682u6XsAMx09U7xKVvgjHUAHbK2QIQdH0SIJNvSfQANYgeumdYsoDULyHubCwL3wof98pCH/XjK1ah3NcGt+IjQNa8KoFNU398VJWL6WRgDLtpjIANM+J/chCFr/WjmOvH5WlJEGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741120732; c=relaxed/simple;
	bh=AMG5OFX5ZX7jWXiEgGwNR2PTrURCKQLuA3flaiORWaM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=ZtQxkbvDXDB+Ar5S8y4uMIaU+b7uTgfnYZ3mcNKHBsNRTI3tIqOOq21HG9tHTut/d8fqyw4D3VcixM4ZvP1k4u7jqZsuSmicmS/YzcC5mE8Y6J/o6BwEOaCEhpffbtJHuutImgnFUt7ZKNr81k+ufStCg3am/y2Yc6r3hpocqls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KLWrv2Mr; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524HMgjI013756;
	Tue, 4 Mar 2025 20:38:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:date:from:message-id:subject:to; s=corp-2023-11-20; bh=wGVVOGej
	1FJsf1s+ti0uUVUPO4s6UhV/FfhpAv+t9sg=; b=KLWrv2Mryhp6eD686tNBjtbk
	8uWDkDtqy3cNM7awRp6unQMbTdnnOtzqb+sxTlisIqTuU5UKGmIbrKZL2dVRIelE
	xBruPEXAzL8OI2jS1bcJyP3Hb3+uRXNzkSlQgxRn+Jb+qZF6DVc4t/+sSB9lvZHN
	3rTTnuh9k1SIlDmx8TJmZS10Rz82qMQE/qZ0EvpUox6ZPKBTsEVJIDq0tsm2comM
	SsIQB1/JPHKAYSX16sWFTQlXx/LiC34RVZ3gQpziGxUPmQ7kR7XqvU3vO8h2ohGy
	9TilwydUPd8vU7hVzKSw+UCGlKd1CiDbc02KCp772xZkpEiv3zhZNIExrOjLEg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u9qe5cs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Mar 2025 20:38:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 524KJWgl022480;
	Tue, 4 Mar 2025 20:38:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rwvef3p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Mar 2025 20:38:37 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 524KcbOc022127;
	Tue, 4 Mar 2025 20:38:37 GMT
Received: from ca-common-sca.us.oracle.com (ca-common-sca.us.oracle.com [10.132.20.202])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 453rwveeye-1;
	Tue, 04 Mar 2025 20:38:37 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        okorniev@redhat.com, tom@talpey.com
Cc: linux-nfs@vger.kernel.org, sagi@grimberg.me
Subject: [PATCH V4 0/2] NFSD: offer write delegation for OPEN with OPEN4_SHARE_ACCESS only
Date: Tue,  4 Mar 2025 12:38:11 -0800
Message-Id: <1741120693-2517-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_08,2025-03-04_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2503040166
X-Proofpoint-ORIG-GUID: aUuzD0-9oh0GkAK7C87oe4PdhdTYtT_0
X-Proofpoint-GUID: aUuzD0-9oh0GkAK7C87oe4PdhdTYtT_0
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

v4: reacted to Jeff's comment.

 fs/nfsd/nfs4state.c | 78 ++++++++++++++++++++++++++++++------------------
 1 file changed, 49 insertions(+), 29 deletions(-)


