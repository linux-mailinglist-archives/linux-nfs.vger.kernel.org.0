Return-Path: <linux-nfs+bounces-10443-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC43A4D211
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Mar 2025 04:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20A167A6B03
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Mar 2025 03:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F6314F9FB;
	Tue,  4 Mar 2025 03:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TUQZSinu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0F88836
	for <linux-nfs@vger.kernel.org>; Tue,  4 Mar 2025 03:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741059258; cv=none; b=C2O7hAP6F/rzEVvOb/EdN7bXR65Hx76Nn1b9547FsFWyb9Y8xc/wjrTcdqBDH53pV8i3d66hNIm4SHcyfpk/o1Am4gp1nQBBt/g8kuG6pBRSHaF2EjEJuXwSNaOj2k6tU7QGjcOkaERPgQqTYRphqi+PTqCL2TXPCk4VYlzjB1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741059258; c=relaxed/simple;
	bh=/VRmRaoP8tlOOIYAt6HvtsZrEAzcFl30++Jgh+uSNt4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=NuS2d/pkLCcs45dS4npidtotJsRc0Fh8YNb2HE9W/LjHmGZjbQS9Y3s6UsgelAf8KM4F8hRw9UoQSAVNkQcqSbMjJVbRD5nl/nvcAbDegdAOQPDcfI/kq8mrhfUMPgLha0+N7a2BTdUOviKRUhpHCNVjCQnLif/W52lL0o0vmJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TUQZSinu; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5241OHRf016384;
	Tue, 4 Mar 2025 03:34:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:date:from:in-reply-to:message-id:references:subject:to; s=
	corp-2023-11-20; bh=06gwkYsI+a84qFLsh1bh8QxEtZObvGNbDmcO7DZpCq4=; b=
	TUQZSinuAjA/OB67I9bPy8Gx0F9yTPAdY7XaZS7CMEeiXwbdajHZiov5qUyV8HvX
	ZKXMXc/OBN0m0RVKdPAAfxiGiLaHIdw6vOW9vN5zFF7Blh6Px1BeuqCGpSWdlajL
	YgfGk4TW4JZwLpTdvG6kiLp4rY102qXf34t7H8Vw/we9dL/aAcGvm+T59uuT6SiS
	PVIgL5sJHU1pbYzQiDKgu17Eo99Lsyc96oJk8eETcstRN3xeBwAbq+++rZPSpVcm
	TvKnIM0lhkgC3z2ZQch7ItIhjlyRetvZCst3eLtaepnuAqslfv3ruaF3wsC+/10Y
	1Vr1HSPTiy0Xy4Y7RMH5wA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453ub74411-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Mar 2025 03:34:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5242t4eE011083;
	Tue, 4 Mar 2025 03:34:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rp9w3st-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Mar 2025 03:34:03 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5243Y2SY011680;
	Tue, 4 Mar 2025 03:34:03 GMT
Received: from ca-common-sca.us.oracle.com (ca-common-sca.us.oracle.com [10.132.20.202])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 453rp9w3rs-2;
	Tue, 04 Mar 2025 03:34:03 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        okorniev@redhat.com, tom@talpey.com
Cc: linux-nfs@vger.kernel.org, sagi@grimberg.me
Subject: [PATCH V3 1/2] NFSD: Offer write delegation for OPEN with OPEN4_SHARE_ACCESS_WRITE
Date: Mon,  3 Mar 2025 19:33:43 -0800
Message-Id: <1741059224-4846-2-git-send-email-dai.ngo@oracle.com>
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
X-Proofpoint-GUID: I5JFSVbJL2RNsWqqfqoktjbTf4tusdHS
X-Proofpoint-ORIG-GUID: I5JFSVbJL2RNsWqqfqoktjbTf4tusdHS
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

RFC8881, section 9.1.2 says:

  "In the case of READ, the server may perform the corresponding
   check on the access mode, or it may choose to allow READ for
   OPEN4_SHARE_ACCESS_WRITE, to accommodate clients whose WRITE
   implementation may unavoidably do (e.g., due to buffer cache
   constraints)."

and in section 10.4.1:
   "Similarly, when closing a file opened for OPEN4_SHARE_ACCESS_WRITE/
   OPEN4_SHARE_ACCESS_BOTH and if an OPEN_DELEGATE_WRITE delegation
   is in effect"

This patch offers write delegation for OPEN with OPEN4_SHARE_ACCESS_WRITE
only. Also deleted no longer use find_rw_file().

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 34 +++++++++++++---------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 0f97f2c62b3a..b533225e57cf 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -633,18 +633,6 @@ find_readable_file(struct nfs4_file *f)
 	return ret;
 }
 
-static struct nfsd_file *
-find_rw_file(struct nfs4_file *f)
-{
-	struct nfsd_file *ret;
-
-	spin_lock(&f->fi_lock);
-	ret = nfsd_file_get(f->fi_fds[O_RDWR]);
-	spin_unlock(&f->fi_lock);
-
-	return ret;
-}
-
 struct nfsd_file *
 find_any_file(struct nfs4_file *f)
 {
@@ -5382,7 +5370,6 @@ static int nfsd4_cb_recall_done(struct nfsd4_callback *cb,
 	if (dp->dl_stid.sc_status)
 		/* CLOSED or REVOKED */
 		return 1;
-
 	switch (task->tk_status) {
 	case 0:
 		return 1;
@@ -5987,14 +5974,19 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	 *  "An OPEN_DELEGATE_WRITE delegation allows the client to handle,
 	 *   on its own, all opens."
 	 *
-	 * Furthermore the client can use a write delegation for most READ
-	 * operations as well, so we require a O_RDWR file here.
+	 * Furthermore, section 9.1.2 says:
+	 *
+	 *  "In the case of READ, the server may perform the corresponding
+	 *  check on the access mode, or it may choose to allow READ for
+	 *  OPEN4_SHARE_ACCESS_WRITE, to accommodate clients whose WRITE
+	 *  implementation may unavoidably do (e.g., due to buffer cache
+	 *  constraints)."
 	 *
-	 * Offer a write delegation in the case of a BOTH open, and ensure
-	 * we get the O_RDWR descriptor.
+	 *  We choose to offer a write delegation for OPEN with the
+	 *  OPEN4_SHARE_ACCESS_WRITE access mode to accommodate such clients.
 	 */
-	if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) == NFS4_SHARE_ACCESS_BOTH) {
-		nf = find_rw_file(fp);
+	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
+		nf = find_writeable_file(fp);
 		dl_type = deleg_ts ? OPEN_DELEGATE_WRITE_ATTRS_DELEG : OPEN_DELEGATE_WRITE;
 	}
 
@@ -6116,7 +6108,7 @@ static bool
 nfs4_delegation_stat(struct nfs4_delegation *dp, struct svc_fh *currentfh,
 		     struct kstat *stat)
 {
-	struct nfsd_file *nf = find_rw_file(dp->dl_stid.sc_file);
+	struct nfsd_file *nf = find_writeable_file(dp->dl_stid.sc_file);
 	struct path path;
 	int rc;
 
@@ -7063,7 +7055,7 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
 		return_revoked = true;
 	if (typemask & SC_TYPE_DELEG)
 		/* Always allow REVOKED for DELEG so we can
-		 * retturn the appropriate error.
+		 * return the appropriate error.
 		 */
 		statusmask |= SC_STATUS_REVOKED;
 
-- 
2.43.5


