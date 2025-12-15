Return-Path: <linux-nfs+bounces-17105-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27209CBF644
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Dec 2025 19:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 52AAF301EDDC
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Dec 2025 18:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A619312807;
	Mon, 15 Dec 2025 18:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jtaVfuG6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A085324716
	for <linux-nfs@vger.kernel.org>; Mon, 15 Dec 2025 18:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765822490; cv=none; b=i728roZbKHc42xtzna3HTGTouKD1DURtJu289QeZw2/HYupNezbwaa5i+b3JBxIuZ4x9Gd79OnHrWdyhI1mMnMsjyg62+MIuF/eH+cTgHukKnsXpnpwDWmHxS12uMTkIsJg8b339pGkjLI/XsQlnNpt1ZftnTY/NfkaT7/VZt2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765822490; c=relaxed/simple;
	bh=dlxqzCKgDc8LQIWZsDZuYJvu8Kf2YDso9qT4U6rZQEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U0dpv0GBQo9ZjMudqCKC7TAytKb9CvbwfIXETFQQM/4baP9JAAzmTCvnHkN9LNwxdqPre0Aqjs8bkexzmHDlq7dkTES1iC9remrt/vKQevgHQGrh7N2CxtIVSihgd8u52mmxsIb1wJ3owDWiAf2yQv00aHrYoa/jOE0OA+qhtPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jtaVfuG6; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BFFNWid2398484;
	Mon, 15 Dec 2025 18:14:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=jlYkqoncKYLOfP4U1hq91cbPuT3qdr1U5/LMw3hzOcs=; b=
	jtaVfuG6orlHmmdOgje3lD8iShXL3aEmJS7MIzWAL5mCKSqnCsuI+ldSYgMSWH5X
	gXEOJfYQ+Q0xm54AVD9c+CHiLgziQIpDy2nhAHl0WNMIXH0iCnMQwWzzE/sK8EPq
	Qo2I9nttzEhbLslQJp1ZtTk9JUK6lvW8nKmQ0gEoXlRzYg+CFBexUpDaUbevKGGO
	4psj/cAjBb0lM3DlXd+VL5KKDnaVRdZZrqWKei5M8nBa/LVIZ3F5w6TJg5Uj7FqJ
	vNoTMx3KGtWnVGbbZRus0YzXMQdFIKM2i4VlttRXb2mlFpoLEeCxHF0xw+u2zNS9
	/g9SXq6sNu8v/dgbq9GSQg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b10prjhke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 18:14:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BFHO4te024834;
	Mon, 15 Dec 2025 18:14:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xk98b8t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 18:14:25 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BFIEOYI011653;
	Mon, 15 Dec 2025 18:14:24 GMT
Received: from labops-common-sca-01.us.oracle.com (labops-common-sca-01.us.oracle.com [10.132.26.161])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4b0xk98b7y-2;
	Mon, 15 Dec 2025 18:14:24 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neilb@ownmail.net,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/3] NFSD: Move clientid_hashval and same_clid to header files
Date: Mon, 15 Dec 2025 10:13:33 -0800
Message-ID: <20251215181418.2201035-2-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251215181418.2201035-1-dai.ngo@oracle.com>
References: <20251215181418.2201035-1-dai.ngo@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-15_04,2025-12-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512150158
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDE1OCBTYWx0ZWRfX+SJtit23QmCq
 iY5b1gRXCuokz+TswJ9TUNJhFbjNvXFZqt30Iuh9qNvedHh4D+KD+L7XTMpeLJ8mKTp0PKCV5Rl
 ofzchQgkfR6MDMiO5mQsJzkyvHox/VviahrUJbh3RVofRBVXipPHhhnTCrCenQwsTN9R58ho6au
 a1msX2nweRUXpPwy+UuX7K0ZrUGPS5/pxsPLzBlHIeIghGPQx3m7t7cEDJ6fFFdD9aW3hqofqg8
 Cr7pXusBtEQUVEOel4zchZ98n4ImBiZARKl7JLhauU9qsuMdqlhaAZXgVqfKRCSRYJ9ep+MeCum
 42As4RMO91XENQ5PBmI2UOS1NPrsnk2XRxtDhFYvWw4DMTnoc8pv5VW5wTjF56jCykxqDPY59Tk
 U8f9DdqcDZ2ZUacoEqw0g8DDtgNiqQ==
X-Proofpoint-GUID: hj7g7tiSzdsz_HLuJGb8RFpUV44dsPkI
X-Proofpoint-ORIG-GUID: hj7g7tiSzdsz_HLuJGb8RFpUV44dsPkI
X-Authority-Analysis: v=2.4 cv=dParWeZb c=1 sm=1 tr=0 ts=69405002 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=BUYROoPNI3fnFxjlhbcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10

As preparation for introducing infrastructure to track SCSI fencing events,
relocate the clientid_hashval function from nfs4state.c to nfsd.h and the
same_clid function from nfs4state.c to state.h.

No functional changes are introduced in this commit—only movement of code
to improve accessibility for forthcoming enhancements.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 15 ---------------
 fs/nfsd/nfsd.h      |  5 +++++
 fs/nfsd/state.h     |  5 +++++
 3 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 35004568d43e..13b4dc89b1e8 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1423,15 +1423,6 @@ static void revoke_delegation(struct nfs4_delegation *dp)
 	destroy_unhashed_deleg(dp);
 }
 
-/*
- * SETCLIENTID state
- */
-
-static unsigned int clientid_hashval(u32 id)
-{
-	return id & CLIENT_HASH_MASK;
-}
-
 static unsigned int clientstr_hashval(struct xdr_netobj name)
 {
 	return opaque_hashval(name.data, 8) & CLIENT_HASH_MASK;
@@ -2621,12 +2612,6 @@ same_verf(nfs4_verifier *v1, nfs4_verifier *v2)
 	return 0 == memcmp(v1->data, v2->data, sizeof(v1->data));
 }
 
-static int
-same_clid(clientid_t *cl1, clientid_t *cl2)
-{
-	return (cl1->cl_boot == cl2->cl_boot) && (cl1->cl_id == cl2->cl_id);
-}
-
 static bool groups_equal(struct group_info *g1, struct group_info *g2)
 {
 	int i;
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 50be785f1d2c..369efe6ed665 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -510,6 +510,11 @@ static inline bool nfsd_attrs_supported(u32 minorversion, const u32 *bmval)
 	return bmval_is_subset(bmval, nfsd_suppattrs[minorversion]);
 }
 
+static inline unsigned int clientid_hashval(u32 id)
+{
+	return id & CLIENT_HASH_MASK;
+}
+
 /* These will return ERR_INVAL if specified in GETATTR or READDIR. */
 #define NFSD_WRITEONLY_ATTRS_WORD1 \
 	(FATTR4_WORD1_TIME_ACCESS_SET   | FATTR4_WORD1_TIME_MODIFY_SET)
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 1e736f402426..b737e8cfe6d5 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -865,6 +865,11 @@ static inline bool try_to_expire_client(struct nfs4_client *clp)
 	return clp->cl_state == NFSD4_EXPIRABLE;
 }
 
+static inline int same_clid(clientid_t *cl1, clientid_t *cl2)
+{
+	return (cl1->cl_boot == cl2->cl_boot) && (cl1->cl_id == cl2->cl_id);
+}
+
 extern __be32 nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp,
 		struct dentry *dentry, struct nfs4_delegation **pdp);
 #endif   /* NFSD4_STATE_H */
-- 
2.47.3


