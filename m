Return-Path: <linux-nfs+bounces-10516-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53084A556BF
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Mar 2025 20:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3B98176DE4
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Mar 2025 19:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B5C2144BC;
	Thu,  6 Mar 2025 19:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oYlGz3Id"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1531A83EE
	for <linux-nfs@vger.kernel.org>; Thu,  6 Mar 2025 19:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741289526; cv=none; b=oo5fapfXW/HEPI8DaIMhW4PJVkS65HSY8Dln65XhrHL8FhhLCZCbEWHj95xbLios/c9PJ11NZXRSBzA+4sby/woZE2sjSeR00cDq5UsGhrLJBZ2oLBdtvcpsAJ3WYrt+jjRPXewHWsCd5jn2qD5g4Jg0a1pKK+Wdbzmu6uKAQls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741289526; c=relaxed/simple;
	bh=46bnwe9k6ir0h7hkChhdrXT7Trpkyu7lhBiGASDHdAw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=iFMT6MTXtpbj7/GhpTFtn5n9UF/Yk10xRgFkPRHeeCSLnJ6cLttmT0MOD5gTa6IyAeyV1FRoAQ8AtREiKWje8VCntg/MfeAU5LYJY7Ig0NcOu0HLI01y3OzyLt6Sdn02tTWBD0lVA51B53eXwDG42oSAdQ+WGOu1Sya1yEEL7vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oYlGz3Id; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526Fi5Vm003835;
	Thu, 6 Mar 2025 19:31:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:date:from:message-id:subject:to; s=corp-2023-11-20; bh=MC4rowLS
	vagN8NZWw8SWm7dGeAaxAb98bc0IpFTPPnk=; b=oYlGz3IdZPIRLyRokvpOb51q
	wyottjw+t3faxFH0LteOZVbEtZDI8Zb9YAWvE7lJBej4lrwd6mbos/PtHzA8Wbun
	lmHiq4bFE8oq1k+/TowbnyxBafK8QnN2PIxhntRKwAthWLaFZw4WUf2Y+iGXOEqp
	9V38bBPCZcRPf5hiNKHwAuEuK1MqlscRs7u8D8ORUCvleDcjWLtIAJeA7AvmVP2k
	/yuJryfPzDYedkH1wfu+CNsNFUyYAc1FjqklLZvoG0MkZQlF4DgECJEAETv7sz2E
	EBy7GdNv6sJ03My1nJWenxuA6yE/p2151tOsce2ro1zDSN43dpoSfePeXhiDCA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453uaw2u1n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Mar 2025 19:31:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 526IGuNT003236;
	Thu, 6 Mar 2025 19:31:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rpcjvat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Mar 2025 19:31:48 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 526JVlLe004657;
	Thu, 6 Mar 2025 19:31:47 GMT
Received: from ca-common-sca.us.oracle.com (ca-common-sca.us.oracle.com [10.132.20.202])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 453rpcjv9r-1;
	Thu, 06 Mar 2025 19:31:47 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        okorniev@redhat.com, tom@talpey.com
Cc: linux-nfs@vger.kernel.org, sagi@grimberg.me
Subject: [PATCH V6 0/1] NFSD: offer write delegation for OPEN with OPEN4_SHARE_ACCESS only
Date: Thu,  6 Mar 2025 11:31:32 -0800
Message-Id: <1741289493-15305-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_06,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503060148
X-Proofpoint-GUID: HDMxrlnQqrwM5DGCEuL0l4EettV0vUFQ
X-Proofpoint-ORIG-GUID: HDMxrlnQqrwM5DGCEuL0l4EettV0vUFQ
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
    fixed some nits from Jeff's comments
v6: Fix deny_mode issue by not setting the read access in st_access_bmap
    when adding read access to write delegation.

 fs/nfsd/nfs4state.c | 75 ++++++++++++++++++++++++++++++------------------
 1 file changed, 47 insertions(+), 28 deletions(-)


