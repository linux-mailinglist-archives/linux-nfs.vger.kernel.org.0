Return-Path: <linux-nfs+bounces-12273-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF68DAD3D97
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 17:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30DA41884C8B
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 15:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC305201034;
	Tue, 10 Jun 2025 15:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IyEyVKaA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218041DF754
	for <linux-nfs@vger.kernel.org>; Tue, 10 Jun 2025 15:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749569755; cv=none; b=IMEbRWWrGjdZa+1xgXFevgI2tzBlLUQXQcIXN3k+pcyUrRt1v9mHogfK6cFUFssL39PhdxEBluo83H7iY0RbWbj4mnQ9DkVimjED5prE1cC+WowUIwW9NGtWsB/HHi77QttM02lp69bivNZ0S1Ii3ttciavRtSA1Ay8gAtZPJKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749569755; c=relaxed/simple;
	bh=8P6ArUEXjpHgMJ+vBwnxqYu3kjVkbnjW3EoGcX/qGCw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=U6oQzHgJtqwiPIcudUPH4/86tye6uVbvlgLrKCYYpeaMs1UwumYqOnVDcYxP0po+2tKf963T0WkiSs+y7oqTRsBZYTsnbWoLI7wgBlQvN7wSNg1D1jbzy/tg8NCTlysWnJNzRDkJl6kU7hFwgm9xYgVCglh2RoWrTK04IX27krA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IyEyVKaA; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AEXdjc006193;
	Tue, 10 Jun 2025 15:35:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:date:from:message-id:subject:to; s=corp-2025-04-25; bh=r7/ypDD0
	vsptHBEs8LmzapJq4YV3eklhzbtl6o7N+sE=; b=IyEyVKaAlaMIB7ZIyMPI0VNQ
	wEEerDsF6jqsc6zASjCXN/5Gka683tsrAhWHSrB91jmMkG/340kLb/LjRTZHH4Dd
	605hz5uy1cRa3af7c0ek8S/8u/DMxArEcaC9pdzhNgQK7wmD9EyF78lNuOK9Hixz
	sTz+0j9E6ZnDxcMZys66PI7poeqKzkaj/41RpTnzsokb8gV1ccCxVS2ca9fbhfP/
	4+PUPVsjvflduyabWc1OeiwOUz5+efewicz37xIK2MQXEjAk0/ZvZDIlxr3VzqUf
	BudCkqU5dHgWUu3aLbOSZ0EOjxhtvL0D1w/uRVy4ob1Fp8s90XJiBGLljCdlPQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474dad4en3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 15:35:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55AFWDfK031270;
	Tue, 10 Jun 2025 15:35:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bv8vtwq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 15:35:44 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55AFZhMZ009184;
	Tue, 10 Jun 2025 15:35:43 GMT
Received: from ca-common-sca.us.oracle.com (ca-common-sca.us.oracle.com [10.132.20.202])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 474bv8vtwg-1;
	Tue, 10 Jun 2025 15:35:43 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        okorniev@redhat.com, tom@talpey.com
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH V3 1/1] NFSD: detect mismatch of file handle and delegation stateid in OPEN op
Date: Tue, 10 Jun 2025 08:35:28 -0700
Message-Id: <1749569728-39435-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_07,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506100125
X-Proofpoint-ORIG-GUID: V-h8fjVcSlLnE0lhEbI-aFPt4rnasTlh
X-Authority-Analysis: v=2.4 cv=EJwG00ZC c=1 sm=1 tr=0 ts=684850d0 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6IFa9wvqVegA:10 a=BQGwlwCTAAAA:8 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=66K8s856GpnV8DZNcEAA:9 a=HFqQS4YDwGEJ6BLTKAzC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDEyNSBTYWx0ZWRfXy98guKNKpEd1 5zW6l3yXqo8A+e4xOzAZMSU9PlZ951dyt/1tfMcjKg5EQrXaYb4ydlcDQ1q8tQi+Qk97U9dSmZB m7BxuFd3B5Z7z4HOtHfE3+gACNbElHgQVhR26/HPjFPhdE9VRVrfs6KkpcccamJbUGOVg3Yln0x
 CqiZ+y0DjH4oIox8CSYFDGXNJftOf9BHZaMXseDFxj1759JE7fmjm4ALO+m8AX+pZKbB2FFP0MF f3+ptDCd/YQY+FQ55XYdUQdWQA8vI8w+a11B+lC99dNGkmP9rpCNlZwiZK7tg87tig3xrsQNnnU T1rsIOS/3PgZ1qFaMenwAYmtgOajCVlmcW2xmIhBQy36x1d9w4YX1E6u3BBnHC01KX8CkgVES20
 FUoUlD5SWR0DAf+t+NWu9vJEuYjfDy2VvVAzueCyBRmQfZdYvkmnygiT6ur/SQwzjduwXy1h
X-Proofpoint-GUID: V-h8fjVcSlLnE0lhEbI-aFPt4rnasTlh
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

NFSD: detect mismatch of file handle and delegation stateid in OPEN op

When the client sends an OPEN with claim type CLAIM_DELEG_CUR_FH or
CLAIM_DELEGATION_CUR, the delegation stateid and the file handle
must belong to the same file, otherwise return NFS4ERR_INVAL.

Note that RFC8881, section 8.2.4, mandates the server to return
NFS4ERR_BAD_STATEID if the selected table entry does not match the
current filehandle. However returning NFS4ERR_BAD_STATEID in the
OPEN causes the client to retry the operation and therefor get the
client into a loop. To avoid this situation we return NFS4ERR_INVAL
instead.

Reported-by: Petro Pavlov <petro.pavlov@vastdata.com>
Fixes: c44c5eeb2c02 ("[PATCH] nfsd4: add open state code for CLAIM_DELEGATE_CUR")
Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
V1 -> V2: replace NFS4ERR_BAD_STATEID with NFS4ERR_INVAL and add
          comment to explain the deviation from the spec.
V2 -> V3: squash V1 and V2 together.
          Add Reported-by and Fixes tag.


 fs/nfsd/nfs4state.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 59a693f22452..ade812bd2996 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6318,6 +6318,20 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 		status = nfs4_check_deleg(cl, open, &dp);
 		if (status)
 			goto out;
+		if (dp && nfsd4_is_deleg_cur(open) &&
+				(dp->dl_stid.sc_file != fp)) {
+			/*
+			 * RFC8881, section 8.2.4, mandates the server to return
+			 * NFS4ERR_BAD_STATEID if the selected table entry does
+			 * not match the current filehandle.
+			 * However returning NFS4ERR_BAD_STATEID in the OPEN causes
+			 * the client to retry the operation and therefor get the
+			 * client into a loop. To avoid this situation we return
+			 * NFS4ERR_INVAL instead.
+			 */
+			status = nfserr_inval;
+			goto out;
+		}
 		stp = nfsd4_find_and_lock_existing_open(fp, open);
 	} else {
 		open->op_file = NULL;
-- 
2.43.5


