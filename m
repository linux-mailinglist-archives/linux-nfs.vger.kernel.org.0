Return-Path: <linux-nfs+bounces-10468-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1220DA4EE88
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Mar 2025 21:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6718A18936EA
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Mar 2025 20:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A13F259C83;
	Tue,  4 Mar 2025 20:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Yv7cfkyw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977F120C039
	for <linux-nfs@vger.kernel.org>; Tue,  4 Mar 2025 20:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741120737; cv=none; b=lwcgRDSkB/VPTPvv1PMmY8Sj7FHvhYQj7isJk3h4UlneF9ef3h6ioyIrTcCsTREthldZOejELqyDkL/yERyoAMu165ab042CofEk+TxnS9QXsBd8U/+dftYyn3P3/vPAtMXJP4yFP4vjJsM8Xy2lJcl9Pbc5sm0m6W5qoWfDvls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741120737; c=relaxed/simple;
	bh=BPCiGs9R2s9E3JoIE/f1A4djCFP1XRutOTV7QtsuckA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=QiZ5vetKx0a0aRwBTJNFIQ+emU80GL4iivBdNEZtW+RZB8bUo5P1Lf3V3tjFal1LEIjz1mqOIgRSnl9K5L1hfmlXVxwuZTpnZDmcUdKybDxaKGPM79opOiovirtmhzu5zgZnxtZgSBnhnKnYf+9n7y5qOG52XsFf7JJXv4Tq9qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Yv7cfkyw; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524HMiLs011957;
	Tue, 4 Mar 2025 20:38:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:date:from:in-reply-to:message-id:references:subject:to; s=
	corp-2023-11-20; bh=YciVef/dX2xxyLfOkerz1IOcM2MPHy6FZKnepPfdp6s=; b=
	Yv7cfkyw3sO0LbY1qjHcNiC+3XyqTW3jFuW4FF//Wn4A9Xue/xg7Vgi3Sec1H+cN
	H6lc1l3h4Yy+cbpTX2koQKyjwMfWb6wieWTtB6xl8j36bG3C9fDPXcoXGK5mCpM8
	v8zy3hdvHlLEYUvQ4tGLCDsODI2EN3jrWyAdoGSUi66gWwDFtXtsZCpFVNc9DuFZ
	5y8/yqcLsVtDT5WvtABnPO5Fe3fCC4RQ8h4m4JPcYSAwbHEgHL4jIZ9mICxqsLnM
	f1KYKYcu/3BGMiOQ/xWVlu8oCwmtp6WiqTwD1CatMcZJ75MAWPCxhYwiuRbYuXJE
	N9+d2tijrbaR62zTCEYUcA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453ub763t8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Mar 2025 20:38:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 524J4Pv7021934;
	Tue, 4 Mar 2025 20:38:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rwvef4a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Mar 2025 20:38:39 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 524KcbOg022127;
	Tue, 4 Mar 2025 20:38:38 GMT
Received: from ca-common-sca.us.oracle.com (ca-common-sca.us.oracle.com [10.132.20.202])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 453rwveeye-3;
	Tue, 04 Mar 2025 20:38:38 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        okorniev@redhat.com, tom@talpey.com
Cc: linux-nfs@vger.kernel.org, sagi@grimberg.me
Subject: [PATCH V4 2/2] NFSD: allow client to use write delegation stateid for READ
Date: Tue,  4 Mar 2025 12:38:13 -0800
Message-Id: <1741120693-2517-3-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1741120693-2517-1-git-send-email-dai.ngo@oracle.com>
References: <1741120693-2517-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_08,2025-03-04_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2503040166
X-Proofpoint-GUID: 8xYTGRnZIRuRGsQb9r_nlPQ6LqGl6ao5
X-Proofpoint-ORIG-GUID: 8xYTGRnZIRuRGsQb9r_nlPQ6LqGl6ao5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

Allow READ using write delegation stateid granted on OPENs with
OPEN4_SHARE_ACCESS_WRITE only, to accommodate clients whose WRITE
implementation may unavoidably do (e.g., due to buffer cache
constraints).

For write delegation granted for OPEN with OPEN4_SHARE_ACCESS_WRITE
a new nfsd_file and a struct file are allocated to use for reads.
The nfsd_file is freed when the file is closed by release_all_access.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 44 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index b533225e57cf..35018af4e7fb 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6126,6 +6126,34 @@ nfs4_delegation_stat(struct nfs4_delegation *dp, struct svc_fh *currentfh,
 	return rc == 0;
 }
 
+/*
+ * Add NFS4_SHARE_ACCESS_READ to the write delegation granted on OPEN
+ * with NFS4_SHARE_ACCESS_WRITE by allocating separate nfsd_file and
+ * struct file to be used for read with delegation stateid.
+ *
+ */
+static bool
+nfsd4_add_rdaccess_to_wrdeleg(struct svc_rqst *rqstp, struct nfsd4_open *open,
+			      struct svc_fh *fh, struct nfs4_ol_stateid *stp)
+{
+	struct nfs4_file *fp;
+	struct nfsd_file *nf = NULL;
+
+	if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) ==
+			NFS4_SHARE_ACCESS_WRITE) {
+		if (nfsd_file_acquire_opened(rqstp, fh, NFSD_MAY_READ, NULL, &nf))
+			return (false);
+		fp = stp->st_stid.sc_file;
+		spin_lock(&fp->fi_lock);
+		__nfs4_file_get_access(fp, NFS4_SHARE_ACCESS_READ);
+		set_access(NFS4_SHARE_ACCESS_READ, stp);
+		fp = stp->st_stid.sc_file;
+		fp->fi_fds[O_RDONLY] = nf;
+		spin_unlock(&fp->fi_lock);
+	}
+	return (true);
+}
+
 /*
  * The Linux NFS server does not offer write delegations to NFSv4.0
  * clients in order to avoid conflicts between write delegations and
@@ -6151,8 +6179,9 @@ nfs4_delegation_stat(struct nfs4_delegation *dp, struct svc_fh *currentfh,
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
@@ -6197,7 +6226,8 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	memcpy(&open->op_delegate_stateid, &dp->dl_stid.sc_stateid, sizeof(dp->dl_stid.sc_stateid));
 
 	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
-		if (!nfs4_delegation_stat(dp, currentfh, &stat)) {
+		if ((!nfsd4_add_rdaccess_to_wrdeleg(rqstp, open, fh, stp)) ||
+				!nfs4_delegation_stat(dp, currentfh, &stat)) {
 			nfs4_put_stid(&dp->dl_stid);
 			destroy_delegation(dp);
 			goto out_no_deleg;
@@ -6353,7 +6383,8 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 	* Attempt to hand out a delegation. No error return, because the
 	* OPEN succeeds even if we fail.
 	*/
-	nfs4_open_delegation(open, stp, &resp->cstate.current_fh);
+	nfs4_open_delegation(rqstp, open, stp,
+		&resp->cstate.current_fh, current_fh);
 
 	/*
 	 * If there is an existing open stateid, it must be updated and
@@ -7098,10 +7129,6 @@ nfs4_find_file(struct nfs4_stid *s, int flags)
 
 	switch (s->sc_type) {
 	case SC_TYPE_DELEG:
-		spin_lock(&s->sc_file->fi_lock);
-		ret = nfsd_file_get(s->sc_file->fi_deleg_file);
-		spin_unlock(&s->sc_file->fi_lock);
-		break;
 	case SC_TYPE_OPEN:
 	case SC_TYPE_LOCK:
 		if (flags & RD_STATE)
@@ -7277,6 +7304,7 @@ nfs4_preprocess_stateid_op(struct svc_rqst *rqstp,
 		status = find_cpntf_state(nn, stateid, &s);
 	if (status)
 		return status;
+
 	status = nfsd4_stid_check_stateid_generation(stateid, s,
 			nfsd4_has_session(cstate));
 	if (status)
-- 
2.43.5


