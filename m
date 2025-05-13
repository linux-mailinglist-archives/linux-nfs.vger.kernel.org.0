Return-Path: <linux-nfs+bounces-11694-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1981BAB5967
	for <lists+linux-nfs@lfdr.de>; Tue, 13 May 2025 18:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E4163BE803
	for <lists+linux-nfs@lfdr.de>; Tue, 13 May 2025 16:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A915414A8B;
	Tue, 13 May 2025 16:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iJiXgiN4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1CE2BE7BD
	for <linux-nfs@vger.kernel.org>; Tue, 13 May 2025 16:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747152603; cv=none; b=MB5UnTNYUjLDi4EDFWG0aqRxf4a6y9Ri6/j0fTahPxWRyVOmxPbIFCmgqPccyrV/knF+J9axMmasezr9J/G0TjexukorsJhDwKSau6d2ib0seeBv8OCU+7yzyKEQKU/RGPIZs8IFr2J5MJgKLwtafuRvKeAFROGQlKdg140BPYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747152603; c=relaxed/simple;
	bh=wDr0703dTOsZz2Nrv+2Z8ZKs/Onizp1XSP1dgUjImiM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=UPYif6lm6eZMMzdy+VyjVM1jiaIUW7qAVK7dtdoLiwC0xtSJK0CiLtS14bd0xplZNMrj/CuxQnU6fTHVDQJUd6uc7JN/tfA+OS6N8IUx5ZWDP2xN/sMm4evV1y9hvFXpaSEVFM3dp4RvoI132HIl8cSDp63aCW/j3UeF/bMv2Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iJiXgiN4; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54DCHMrk018233;
	Tue, 13 May 2025 16:09:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:date:from:message-id:subject:to; s=corp-2025-04-25; bh=X9OttEs5
	Ov28LUVZSDeppcTClwOJddCs/vJVnn3h8cw=; b=iJiXgiN4qYEShnFy/F2PmTpa
	1RrxllFNov/W3z/Jyu+efVhZa7+fMH/hauDwhlHS3mJ35DEEF+XPgqLbw7FYjySk
	Ii6898YXlZdfZPmntjccuYDYbG47kj33hj8vBXanVmgkOvQI2WWW9fuYOhETq1AT
	OVSZdtkvr+NR0dpb8zVmTA24a9crm8jSzb2FpMJsZq1sanDs+EfpbEw/Vos9KZPd
	WHf4yph9UBGiFoXv1azj0q5NTjzzjop336HlOq+S+nO8t/R+WHyxotuvoViavKOQ
	O7Fp9T6hSj1vgus09WTTRkcDnJDMfEsX7P8YVgStUY7f5T2hxVcfN2xKlVg3rA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j11c53h9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 16:09:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54DFDQ05004534;
	Tue, 13 May 2025 16:09:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46m7d8xe5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 16:09:43 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54DG9gha025807;
	Tue, 13 May 2025 16:09:42 GMT
Received: from ca-common-sca.us.oracle.com (ca-common-sca.us.oracle.com [10.132.20.202])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 46m7d8xe4t-1;
	Tue, 13 May 2025 16:09:42 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        okorniev@redhat.com, tom@talpey.com
Cc: linux-nfs@vger.kernel.org, sagi@grimberg.me
Subject: [PATCH V6 0/1] NFSD: offer write delegation for OPEN with OPEN4_SHARE_ACCESS only
Date: Tue, 13 May 2025 09:08:27 -0700
Message-Id: <1747152508-22656-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-13_03,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505130153
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDE1MyBTYWx0ZWRfXzxVCbbY9hMjV Qa8dHjGSiZecnA2oV3DmgcKwzr45SBNUF+cJxf+Iy2pA2kL+oJaqkbtYrwVO1vRis44o21YeHbs C+hx11snhirob2EpEA2tZe3VR9qWrNLds0/lugMaj0ofTXLhgzGHmC/7Q//SL19E2eZRJESY7mu
 lOzVUw1Yt6TImPGimlKYkPJcEKhQeBiEnwWazKEaVQRfxraDgMl9L7h/YjKGkMo8cwbX6g9HRHi pqe7ZZE2no6N5vZRI/DDYW1KifJ7UWlfxvKKoXCiM9EebN7PgjIk6+Qm5lvcAhj9QlghGuziGro kA9qmObO1H3zJWIKmyFKgc7SNRtk3ppdewIVN7Cap2PPFRyXNAQ0Y970o/Y8l5v6AC3eEdFRMO0
 AEejMVpqMeQuUClDMGLdJNK11Fo8vLIuEXNLmfwLu3nek3TWwr+MT5ROcaIZolYQOPHRDQSI
X-Authority-Analysis: v=2.4 cv=YJ2fyQGx c=1 sm=1 tr=0 ts=68236ec8 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=dt9VzEwgFbYA:10 a=sbfVIj92kYCz5HpZM4AA:9 cc=ntf awl=host:13185
X-Proofpoint-GUID: LQCQS6jvSA8zvDpEosWOOk3SI6rHIsCG
X-Proofpoint-ORIG-GUID: LQCQS6jvSA8zvDpEosWOOk3SI6rHIsCG
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

This is a resend of the v6 version of the patch that was reviewed
by Jeff.

I will send the fix for the nfsd_file leak problem that Jeff discovered
in the subsequent patch.

-------------------------------------------------------------------
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


