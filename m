Return-Path: <linux-nfs+bounces-10445-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA895A4D212
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Mar 2025 04:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E5D73ACA7A
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Mar 2025 03:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6384B14F9FB;
	Tue,  4 Mar 2025 03:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W4EnVx7S"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85968836
	for <linux-nfs@vger.kernel.org>; Tue,  4 Mar 2025 03:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741059264; cv=none; b=BqOcDe/IRW5Gd8RV07yIOTiNlMf2ppWAuf5AM+M7OBjHSBeTboUSIKP1n0yuWX+cUFdI6V6JsPPG7+W/2TN2G+SwsVgL21Yu0EJNbbtQ3wnNiMIyNZB+TqKcPrKunR9ludezJhBjZKiA3OJ9cvnTch5HKhKZRLwi2aJf/DwOJ3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741059264; c=relaxed/simple;
	bh=tuju5Tr26iPly0bjU/qPaWowZbsP7b5OUqHcoCLQGuY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=H5PwbDYlsqWQUxPBEfr0HpBOf1TGxJcTI/myecyE0h7kbeZ/NYClxDtzIq9M2x/6l1bQqmE61a3DpTkblSkyweCJU/h/augvqzdaXVCjLgVQI7rosQkNNOay/Iq8OQmaklccNDFPgZImT9YLq4pUw7mlUm7VLOv48ir5ynzTCDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W4EnVx7S; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5241Mckt007220;
	Tue, 4 Mar 2025 03:34:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:date:from:in-reply-to:message-id:references:subject:to; s=
	corp-2023-11-20; bh=CbacZXO/4vntt9jKXEnikFmyBKD+8RWJN3D8Mf0bPrs=; b=
	W4EnVx7SRHd8h1ZmA+RfahfRC1MJ8szqk271i2Rp88eobCyXHWNwhbhLnEALmb5P
	3KLq627gdaNpVzN1bimwLm1ItfMtqs891d4DG8WuwQD80yopeMA9mJesJuvbq8eh
	1/fxx/wxMJqZQWshb995NXeTVQzSlL2ClFUg/fG0J8DGd253UgmnTl2kyjLnCbhB
	hQzzm3n8BEandBiXOKOfhqGTPhTfnv4YYnEfOvEbMENvnsw7zCJBOv+2W7vJcByy
	p8KBvJ+vtZL4lC0uRtFvfqq78lkr6jmDXXH3hYlJ65caHVIkPURM0YM1dR/4zpBN
	hkoQKnXcSpzx1NeGa+1GMw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4541r43w3k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Mar 2025 03:34:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5240tIB2010882;
	Tue, 4 Mar 2025 03:34:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rp9w3t6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Mar 2025 03:34:04 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5243Y2Sa011680;
	Tue, 4 Mar 2025 03:34:04 GMT
Received: from ca-common-sca.us.oracle.com (ca-common-sca.us.oracle.com [10.132.20.202])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 453rp9w3rs-3;
	Tue, 04 Mar 2025 03:34:04 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        okorniev@redhat.com, tom@talpey.com
Cc: linux-nfs@vger.kernel.org, sagi@grimberg.me
Subject: [PATCH V3 2/2] NFSD: allow client to use write delegation stateid for READ
Date: Mon,  3 Mar 2025 19:33:44 -0800
Message-Id: <1741059224-4846-3-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1741059224-4846-1-git-send-email-dai.ngo@oracle.com>
References: <1741059224-4846-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_02,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503040028
X-Proofpoint-ORIG-GUID: cYuVyt2xBB06StZ7doqq74sHwOQa0Ry-
X-Proofpoint-GUID: cYuVyt2xBB06StZ7doqq74sHwOQa0Ry-
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

Allow READ using write delegation stateid granted on OPENs with
OPEN4_SHARE_ACCESS_WRITE only, to accommodate clients whose WRITE
implementation may unavoidably do (e.g., due to buffer cache
constraints).

When a write delegation is granted for OPEN with OPEN4_SHARE_ACCESS_WRITE,
a new pair of nfsd_file and struct file are allocated with read access
and added to nfs4_file's fi_fds[]. This is to allow the client to use
the delegation stateid to do reads.

No additional actions is needed when the delegation is returned. The
nfsd_file for read remains attached to the nfs4_file and is freed when
the open stateid is closed.

Suggested-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 41 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index b533225e57cf..d2c6c43b5d0c 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6126,6 +6126,30 @@ nfs4_delegation_stat(struct nfs4_delegation *dp, struct svc_fh *currentfh,
 	return rc == 0;
 }
 
+/*
+ * Add NFS4_SHARE_ACCESS_READ to the write delegation granted on OPEN
+ * with NFS4_SHARE_ACCESS_READ by allocating separate nfsd_file and
+ * struct file to be used for read with delegation stateid.
+ *
+ */
+static void
+nfs4_add_rdaccess_to_wrdeleg(struct svc_rqst *rqstp, struct svc_fh *fh,
+			     struct nfs4_ol_stateid *stp)
+{
+	struct nfs4_file *fp;
+	struct nfsd_file *nf = NULL;
+
+	if (nfsd_file_acquire_opened(rqstp, fh, NFSD_MAY_READ, NULL, &nf))
+		return;
+	fp = stp->st_stid.sc_file;
+	spin_lock(&fp->fi_lock);
+	__nfs4_file_get_access(fp, NFS4_SHARE_ACCESS_READ);
+	set_access(NFS4_SHARE_ACCESS_READ, stp);
+	fp = stp->st_stid.sc_file;
+	fp->fi_fds[O_RDONLY] = nf;
+	spin_unlock(&fp->fi_lock);
+}
+
 /*
  * The Linux NFS server does not offer write delegations to NFSv4.0
  * clients in order to avoid conflicts between write delegations and
@@ -6151,8 +6175,9 @@ nfs4_delegation_stat(struct nfs4_delegation *dp, struct svc_fh *currentfh,
  * open or lock state.
  */
 static void
-nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
-		     struct svc_fh *currentfh)
+nfs4_open_delegation(struct svc_rqst *rqstp, struct nfsd4_open *open,
+		     struct nfs4_ol_stateid *stp, struct svc_fh *currentfh,
+		     struct svc_fh *fh)
 {
 	bool deleg_ts = open->op_deleg_want & OPEN4_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS;
 	struct nfs4_openowner *oo = openowner(stp->st_stateowner);
@@ -6207,6 +6232,10 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 		dp->dl_cb_fattr.ncf_cur_fsize = stat.size;
 		dp->dl_cb_fattr.ncf_initial_cinfo = nfsd4_change_attribute(&stat);
 		trace_nfsd_deleg_write(&dp->dl_stid.sc_stateid);
+
+		if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) ==
+					NFS4_SHARE_ACCESS_WRITE)
+			nfs4_add_rdaccess_to_wrdeleg(rqstp, fh, stp);
 	} else {
 		open->op_delegate_type = deleg_ts ? OPEN_DELEGATE_READ_ATTRS_DELEG :
 						    OPEN_DELEGATE_READ;
@@ -6353,7 +6382,8 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 	* Attempt to hand out a delegation. No error return, because the
 	* OPEN succeeds even if we fail.
 	*/
-	nfs4_open_delegation(open, stp, &resp->cstate.current_fh);
+	nfs4_open_delegation(rqstp, open, stp,
+		&resp->cstate.current_fh, current_fh);
 
 	/*
 	 * If there is an existing open stateid, it must be updated and
@@ -7098,10 +7128,6 @@ nfs4_find_file(struct nfs4_stid *s, int flags)
 
 	switch (s->sc_type) {
 	case SC_TYPE_DELEG:
-		spin_lock(&s->sc_file->fi_lock);
-		ret = nfsd_file_get(s->sc_file->fi_deleg_file);
-		spin_unlock(&s->sc_file->fi_lock);
-		break;
 	case SC_TYPE_OPEN:
 	case SC_TYPE_LOCK:
 		if (flags & RD_STATE)
@@ -7277,6 +7303,7 @@ nfs4_preprocess_stateid_op(struct svc_rqst *rqstp,
 		status = find_cpntf_state(nn, stateid, &s);
 	if (status)
 		return status;
+
 	status = nfsd4_stid_check_stateid_generation(stateid, s,
 			nfsd4_has_session(cstate));
 	if (status)
-- 
2.43.5


