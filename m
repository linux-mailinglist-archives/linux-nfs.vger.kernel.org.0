Return-Path: <linux-nfs+bounces-12266-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 963C0AD3B26
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 16:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 588DF7A844F
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 14:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC9914B06C;
	Tue, 10 Jun 2025 14:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RpB1ShYR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5108ED517
	for <linux-nfs@vger.kernel.org>; Tue, 10 Jun 2025 14:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749565928; cv=none; b=he5Lx/mM0pKwb5AuMUPswMJHuyiAgdrbqpiOxg6h9bs8WU8LYmhT4EQMhf5LdhoNm7zsoqQCgmfHRLCamLYnCRzPS2TgyEK4lyyqgqZWC2GkXIUsApM+13ruGJQIT3zZ/+L2WvPPmQhnOjCzMBNw2bYSM6CR/VHIRrCOMWRcaHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749565928; c=relaxed/simple;
	bh=Co+Tmpzu8w3ruqpJ7cX814EM4u7tKdoikdusTMgUvx8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=q0DwJxI01mZbB3vODvF9FZMNqFpX22CDVfaOQ0Cq/BhlrIlc/f403B9Z+1vfdObm3VeNECfsL+gDDf6lAnf36Ca0K39u1LXZeECrwFE6ZpSUptwAA1wR+yI2SH1cKTySR2WxqZ8Yo/+qNydl6O7RUfifwLfMVS9PizkyrZ4pLQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RpB1ShYR; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AERiZm029722;
	Tue, 10 Jun 2025 14:32:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:date:from:message-id:subject:to; s=corp-2025-04-25; bh=/JLOwa+2
	lYyfRT3G6ECn6FwJbK0Vx1p7XUNo5/+jA9I=; b=RpB1ShYRZYnXQt30/CRzHTBT
	Q+RKwYEWnY2EppdkBjQ4EOG+db89+rX0UtZj8Rpvxrd1D/hGDv4INoNhoAb1YkzW
	7xy/RqTYbsz2eWkEuzOyqzZjQVYu1kMa9w5fqi7Va/Ut+kCfvCLPuqSRI027Dvmn
	dnz6Y3I5u8ouo0LJXCNoH3V7TqSoqmxS+CMClSI2q1MTSdGS+1TCCQ+BH7sxy93Z
	6yTr5BAWQVZte0pag779b7pIOhyCtKVOBKgmi12oQ6dmYFsCRkfLI2FGMjEqr2Lv
	88RRxxeQZJRCYgn4D2lO7eRF0H/cxs9rmj2V2s/69a/zZ4ynTEIdnQMYIvESTA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474dad4a3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 14:31:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55ADuuEK020662;
	Tue, 10 Jun 2025 14:31:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 474bv9harr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 14:31:58 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55AEVvAW021725;
	Tue, 10 Jun 2025 14:31:57 GMT
Received: from ca-common-sca.us.oracle.com (ca-common-sca.us.oracle.com [10.132.20.202])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 474bv9haqx-1;
	Tue, 10 Jun 2025 14:31:57 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        okorniev@redhat.com, tom@talpey.com
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH V2 1/1] NFSD: detect mismatch of file handle and delegation stateid in OPEN op
Date: Tue, 10 Jun 2025 07:31:42 -0700
Message-Id: <1749565902-33511-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_05,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506100115
X-Proofpoint-ORIG-GUID: 1rgnIiphEHsmQE4AXmcCnPAM1O48otHb
X-Authority-Analysis: v=2.4 cv=EJwG00ZC c=1 sm=1 tr=0 ts=684841df b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=_b5mIpdGg7oPPr66HrIA:9 cc=ntf awl=host:13206
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDExNSBTYWx0ZWRfX5WH8CJFmlSkF 6UzMUD+w/slgxQTcNPWkCpUM+HgNAokyJxSGCn7L+nNYU6MbUqxRTw2MIddQfZGHmkKSpJalgTt uX2HKt2oyZBbHmw/Z9iFzyx2FEnLKHNR++GePJTHUvfpzvDSh9nTetZLr+VXQ0qUKcbSgvedCPt
 6JSoyH2VNW+qzDmwx15amZugaTIkdyRwnRVQZavUK8CgqqtZ5p+4WQgyCCBaLf3JmHZhVAmxvx1 8x7fn2dr9ZTafni+S4PS1tySNT+NxaKjwoHcXILnXRIvnwolOl05wvxtoL+l7Ne+gmf7Qjyv5At D+qwlbwoAHp1KYYrmhSiTGJl6dEKZFcPr9xOHd7V7BjRqI1fclcQTTIvJ8MMyhYFQJ45gLLIemm
 Lc1vTy9BVzDWgRtJKkBtIifXMsTbn1PK6FAwdRvjdFDaFSFaQWNeBA1Dya38gZkyJGUyttHS
X-Proofpoint-GUID: 1rgnIiphEHsmQE4AXmcCnPAM1O48otHb
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

When the client sends an OPEN with claim type CLAIM_DELEG_CUR_FH or
CLAIM_DELEGATION_CUR, the delegation stateid and the file handle
must belongs to the same file, otherwise return NFS4ERR_INVAL.

Note that RFC8881, section 8.2.4, mandates the server to return
NFS4ERR_BAD_STATEID if the selected table entry does not match the
current filehandle. However returning NFS4ERR_BAD_STATEID in the
OPEN causes the client to retry the operation and therefor get the
client into a loop. To avoid this situation we return NFS4ERR_INVAL
instead.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
V1 -> V2: replace NFS4ERR_BAD_STATEID with NFS4ERR_INVAL and add
          comment to explain the deviation from the spec.

 fs/nfsd/nfs4state.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index be2ee641a22d..ade812bd2996 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6320,7 +6320,16 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 			goto out;
 		if (dp && nfsd4_is_deleg_cur(open) &&
 				(dp->dl_stid.sc_file != fp)) {
-			status = nfserr_bad_stateid;
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
 			goto out;
 		}
 		stp = nfsd4_find_and_lock_existing_open(fp, open);
-- 
2.43.5


