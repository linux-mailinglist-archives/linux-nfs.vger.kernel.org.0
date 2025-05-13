Return-Path: <linux-nfs+bounces-11695-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F02AB5968
	for <lists+linux-nfs@lfdr.de>; Tue, 13 May 2025 18:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 795931B60A61
	for <lists+linux-nfs@lfdr.de>; Tue, 13 May 2025 16:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3232BE0F0;
	Tue, 13 May 2025 16:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S49fAUzj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401872BE7A5
	for <linux-nfs@vger.kernel.org>; Tue, 13 May 2025 16:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747152606; cv=none; b=nOZE6pk6RDWRVNXSiHp2s+bRAR8e7svNHScdDS4p0gNsMUhylZESt2sQ6losJI5i5TXJdPcodqe7DRjjwYmafpp5wzKE2yPoSC39TVtXqpQ9LANbQ1Bp3qrpjdNV+5YqO8ttKcN/83oP+7HG3SJYWQzH5k8GUSroTUMLbH8oIpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747152606; c=relaxed/simple;
	bh=AnS+46qYDThiXmXQy1fdI0UPIi6L/M4XrIRTbRI7Y9w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=HT6A1d0mHSiTC+Xc2z/T/lgyHTpU3zKNRTHPHJxRC2AnZ83QE3lSba72maKMoKrDrwnXet/6LKNjz4pTwqN28eY6eaxDHW7f0nOyLYsUIdJ1g4i0yBWRolq+vtck7LdtKOeDHBuGw7sHmQnBziqZLQTegtQriAw/wznwbTLS/iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=S49fAUzj; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54DCHLWH018203;
	Tue, 13 May 2025 16:09:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:date:from:in-reply-to:message-id:references:subject:to; s=
	corp-2025-04-25; bh=wV6qIDtfoA+AaTTv8DkllOmaUlo9NPiZyhIPBaWPpxw=; b=
	S49fAUzjEduGwscINe9zJRoFA0PnibK0KntVcbWfkZXE/nCSAbZksNw9Su1qdjcl
	UeTJ12GabwEqylHuWMDdBEIcUAcOa6s453ODWNzvIAQrK24YYpxm3oRmt8C46zhr
	s6roAeaLOyoJN5ZvPX4mj/uFJW7FgkHjsM7WwObdmum5y3i89goABrnTnell47NU
	3vbTyfY/5OXVKHZ8hozgwNLfb8mpZpg87Po1LtKTGCm75oOHqYYbxUSxlc9q13hw
	DVxVpRjB+G1WAPo5b6w3fjz57/diD819udcMxFpug9jrMwG/kLWGOUYD6SQL41Au
	rXWO9rfHO1ktJvstzR+p3w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j11c53hc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 16:09:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54DFEVCi004094;
	Tue, 13 May 2025 16:09:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46m7d8xe6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 16:09:44 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54DG9ghc025807;
	Tue, 13 May 2025 16:09:43 GMT
Received: from ca-common-sca.us.oracle.com (ca-common-sca.us.oracle.com [10.132.20.202])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 46m7d8xe4t-2;
	Tue, 13 May 2025 16:09:43 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        okorniev@redhat.com, tom@talpey.com
Cc: linux-nfs@vger.kernel.org, sagi@grimberg.me
Subject: [PATCH V6 1/1] NFSD: Offer write delegation for OPEN with OPEN4_SHARE_ACCESS_WRITE
Date: Tue, 13 May 2025 09:08:28 -0700
Message-Id: <1747152508-22656-2-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1747152508-22656-1-git-send-email-dai.ngo@oracle.com>
References: <1747152508-22656-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-13_03,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505130153
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDE1MyBTYWx0ZWRfX7oLHMNg3Vx4U WVPLf+U0dMURYKoeDZa/1CN6Byk73G0oSBWMiSkornPQKi+QyYxHwDCW1wcRnn3dkfLFwlR1YKJ 8y4kkDLuGj5bY6DeBThSNjubV11ME8UpFkPezp4tOtcZCkWNna3dE/GxCRPOuIBZwWwxpRx6Xi0
 XxlpiGOLQGktN8mGdMmjSdAVlQIzOjW0zsE/nK6Uj7ZOzy3HEP0kXRyGih/23PaEqcpfyNXibnH AvBIoBiCU894I5mV1IZ+r2qIN3XqrRA03vo7H5ahVuhI0rReDJgzj4l00eEfsytBHaGTbzVa2N1 4uRNKnXdjNN3r84Iq9xWbZ/cKrtUVIpA1QKWBicqAYh0DdbPG8R5l04MlYba1H1/NazCuj2s+3a
 Y1Kw/G7qH4I8DSxLrgCwkriGpDysbr7KKiQgnqgtUoCm6orXucqtfk/uIXs5HNG5RJ18M3dj
X-Authority-Analysis: v=2.4 cv=YJ2fyQGx c=1 sm=1 tr=0 ts=68236ec8 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=E-AFT-5SpMYJ9XpW4S0A:9 cc=ntf awl=host:13185
X-Proofpoint-GUID: hu1xyAKK5V5SQkOmBIliVZyQqaL8vUua
X-Proofpoint-ORIG-GUID: hu1xyAKK5V5SQkOmBIliVZyQqaL8vUua
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

RFC8881, section 9.1.2 says:

  "In the case of READ, the server may perform the corresponding
   check on the access mode, or it may choose to allow READ for
   OPEN4_SHARE_ACCESS_WRITE, to accommodate clients whose WRITE
   implementation may unavoidably do reads (e.g., due to buffer cache
   constraints)."

and in section 10.4.1:
   "Similarly, when closing a file opened for OPEN4_SHARE_ACCESS_WRITE/
   OPEN4_SHARE_ACCESS_BOTH and if an OPEN_DELEGATE_WRITE delegation
   is in effect"

This patch allow READ using write delegation stateid granted on OPENs
with OPEN4_SHARE_ACCESS_WRITE only, to accommodate clients whose WRITE
implementation may unavoidably do (e.g., due to buffer cache
constraints).

For write delegation granted for OPEN with OPEN4_SHARE_ACCESS_WRITE
a new nfsd_file and a struct file are allocated to use for reads.
The nfsd_file is freed when the file is closed by release_all_access.

Suggested-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 75 ++++++++++++++++++++++++++++-----------------
 1 file changed, 47 insertions(+), 28 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 0f97f2c62b3a..295415fda985 100644
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
@@ -5987,14 +5975,19 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
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
+	 *  implementation may unavoidably do reads (e.g., due to buffer
+	 *  cache constraints)."
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
 
@@ -6116,7 +6109,7 @@ static bool
 nfs4_delegation_stat(struct nfs4_delegation *dp, struct svc_fh *currentfh,
 		     struct kstat *stat)
 {
-	struct nfsd_file *nf = find_rw_file(dp->dl_stid.sc_file);
+	struct nfsd_file *nf = find_writeable_file(dp->dl_stid.sc_file);
 	struct path path;
 	int rc;
 
@@ -6134,6 +6127,33 @@ nfs4_delegation_stat(struct nfs4_delegation *dp, struct svc_fh *currentfh,
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
+		fp = stp->st_stid.sc_file;
+		fp->fi_fds[O_RDONLY] = nf;
+		spin_unlock(&fp->fi_lock);
+	}
+	return true;
+}
+
 /*
  * The Linux NFS server does not offer write delegations to NFSv4.0
  * clients in order to avoid conflicts between write delegations and
@@ -6159,8 +6179,9 @@ nfs4_delegation_stat(struct nfs4_delegation *dp, struct svc_fh *currentfh,
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
@@ -6205,7 +6226,8 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	memcpy(&open->op_delegate_stateid, &dp->dl_stid.sc_stateid, sizeof(dp->dl_stid.sc_stateid));
 
 	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
-		if (!nfs4_delegation_stat(dp, currentfh, &stat)) {
+		if (!nfsd4_add_rdaccess_to_wrdeleg(rqstp, open, fh, stp) ||
+				!nfs4_delegation_stat(dp, currentfh, &stat)) {
 			nfs4_put_stid(&dp->dl_stid);
 			destroy_delegation(dp);
 			goto out_no_deleg;
@@ -6361,7 +6383,8 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 	* Attempt to hand out a delegation. No error return, because the
 	* OPEN succeeds even if we fail.
 	*/
-	nfs4_open_delegation(open, stp, &resp->cstate.current_fh);
+	nfs4_open_delegation(rqstp, open, stp,
+		&resp->cstate.current_fh, current_fh);
 
 	/*
 	 * If there is an existing open stateid, it must be updated and
@@ -7063,7 +7086,7 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
 		return_revoked = true;
 	if (typemask & SC_TYPE_DELEG)
 		/* Always allow REVOKED for DELEG so we can
-		 * retturn the appropriate error.
+		 * return the appropriate error.
 		 */
 		statusmask |= SC_STATUS_REVOKED;
 
@@ -7106,10 +7129,6 @@ nfs4_find_file(struct nfs4_stid *s, int flags)
 
 	switch (s->sc_type) {
 	case SC_TYPE_DELEG:
-		spin_lock(&s->sc_file->fi_lock);
-		ret = nfsd_file_get(s->sc_file->fi_deleg_file);
-		spin_unlock(&s->sc_file->fi_lock);
-		break;
 	case SC_TYPE_OPEN:
 	case SC_TYPE_LOCK:
 		if (flags & RD_STATE)
-- 
2.43.5


