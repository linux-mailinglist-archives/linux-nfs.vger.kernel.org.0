Return-Path: <linux-nfs+bounces-10104-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 297AAA34E87
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Feb 2025 20:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBF0A188E0C9
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Feb 2025 19:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289E4245AFB;
	Thu, 13 Feb 2025 19:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JGHljcTz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CDF28A2CE
	for <linux-nfs@vger.kernel.org>; Thu, 13 Feb 2025 19:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739475474; cv=none; b=lBUJIqJPI3xPURt3XsqLtTy2KNBxFeA1ZcpUy2dJXKSARPEkkbkkV2rclRBPD+3+AxHrT0EUoRC5hrPfSA5NhvdnwJQURNQ1oFlMsM8gyrTlCrpCcFpM+sx8KKiweC6Sd0BU1UUhPgRtevv26pIKqTht66GmGtRkWMxPpvQVxOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739475474; c=relaxed/simple;
	bh=583N5IYHYWnIa06nHN91AXw0XwFuuRqPVQoEpcYAAs4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=d36HA/Frzy4hNTUdP7pGbwcP5a67uVj0DYHCCx/1nqJRVNGlQhzsqIOlkAFTsHMZu9i5m6OZTP14bdhRPEU9naaUCnFMxl0P0hRRFFku8a1gHip4UJ3+l/4qZ2zYx0HVzTJFjjl+G+nfJZrkuFwyEVGQEYhOnf2+z8OvMuJxtRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JGHljcTz; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DGffvt015258;
	Thu, 13 Feb 2025 19:37:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:date:from:in-reply-to:message-id:references:subject:to; s=
	corp-2023-11-20; bh=RcMJZYKbn1SWt7R49ALbi3bIcWL9aUssjs4zugCpCg8=; b=
	JGHljcTzmtORMT28oWPzlfIXETuVXcV8O62Ywbyyy0PMNG5v4Uf2TXoW9e66Rfky
	MaxihtuzpfQy7yOFXkquYTzmhnEwNpzDkVLMaSAnNRWqzcpjduho0rgnjqNnd8Ed
	cpk39UrH1TIpo0+hpw1P5O3Ifcg2oOjvVF6+XDHCnvMGdMV8BDQHMyGI974FwWVY
	5glame+ckwIfcdV7czgvXFjdu8aQ9jedqpRgv13iqVXqKTffclJ11WbURDlgdoVX
	Zd2EGRzPXY506SlwXkxsNitiYkW7ojHH5N/ACKh5KjIUBTIleRCMLctso77eSTnQ
	jWdkChBqM0xP7PYJYynbRg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0t4a9c5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 19:37:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51DIaFTK001307;
	Thu, 13 Feb 2025 19:37:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44p632m3u8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 19:37:41 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 51DJbd0n036455;
	Thu, 13 Feb 2025 19:37:41 GMT
Received: from ca-common-sca.us.oracle.com (ca-common-sca.us.oracle.com [10.132.20.202])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 44p632m3t9-3;
	Thu, 13 Feb 2025 19:37:41 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        okorniev@redhat.com, tom@talpey.com
Cc: linux-nfs@vger.kernel.org, sagi@grimberg.me
Subject: [PATCH 2/2] NFSD: allow client to use write delegation stateid for READ
Date: Thu, 13 Feb 2025 11:37:18 -0800
Message-Id: <1739475438-5640-3-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1739475438-5640-1-git-send-email-dai.ngo@oracle.com>
References: <1739475438-5640-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_08,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502130138
X-Proofpoint-ORIG-GUID: 6rACTp2acXrnn9oPnPLgb-vI3JErp_Ou
X-Proofpoint-GUID: 6rACTp2acXrnn9oPnPLgb-vI3JErp_Ou
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

Allow read using write delegation stateid granted on OPENs with
OPEN4_SHARE_ACCESS_WRITE only, to accommodate clients whose WRITE
implementation may unavoidably do (e.g., due to buffer cache
constraints).

When this condition is detected in nfsd4_encode_read the access
mode FMODE_READ is temporarily added to the file's f_mode and is
removed when the read is done.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4proc.c | 15 ++++++++++++++-
 fs/nfsd/nfs4xdr.c  |  8 ++++++++
 fs/nfsd/xdr4.h     |  1 +
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index f6e06c779d09..be43627bbf78 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -973,7 +973,18 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	/* check stateid */
 	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
 					&read->rd_stateid, RD_STATE,
-					&read->rd_nf, NULL);
+					&read->rd_nf, &read->rd_wd_stid);
+	/*
+	 * rd_wd_stid is needed for nfsd4_encode_read to allow write
+	 * delegation stateid used for read. Its refcount is decremented
+	 * by nfsd4_read_release when read is done.
+	 */
+	if (!status && read->rd_wd_stid &&
+		(read->rd_wd_stid->sc_type != SC_TYPE_DELEG ||
+		delegstateid(read->rd_wd_stid)->dl_type != NFS4_OPEN_DELEGATE_WRITE)) {
+		nfs4_put_stid(read->rd_wd_stid);
+		read->rd_wd_stid = NULL;
+	}
 
 	read->rd_rqstp = rqstp;
 	read->rd_fhp = &cstate->current_fh;
@@ -984,6 +995,8 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 static void
 nfsd4_read_release(union nfsd4_op_u *u)
 {
+	if (u->read.rd_wd_stid)
+		nfs4_put_stid(u->read.rd_wd_stid);
 	if (u->read.rd_nf)
 		nfsd_file_put(u->read.rd_nf);
 	trace_nfsd_read_done(u->read.rd_rqstp, u->read.rd_fhp,
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index e67420729ecd..3996678bab3f 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4498,6 +4498,7 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
 	unsigned long maxcount;
 	__be32 wire_data[2];
 	struct file *file;
+	bool wronly = false;
 
 	if (nfserr)
 		return nfserr;
@@ -4515,10 +4516,17 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
 	maxcount = min_t(unsigned long, read->rd_length,
 			 (xdr->buf->buflen - xdr->buf->len));
 
+	if (!(file->f_mode & FMODE_READ) && read->rd_wd_stid) {
+		/* allow READ using write delegation stateid */
+		wronly = true;
+		file->f_mode |= FMODE_READ;
+	}
 	if (file->f_op->splice_read && splice_ok)
 		nfserr = nfsd4_encode_splice_read(resp, read, file, maxcount);
 	else
 		nfserr = nfsd4_encode_readv(resp, read, file, maxcount);
+	if (wronly)
+		file->f_mode &= ~FMODE_READ;
 	if (nfserr) {
 		xdr_truncate_encode(xdr, eof_offset);
 		return nfserr;
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index c26ba86dbdfd..2f053beed899 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -426,6 +426,7 @@ struct nfsd4_read {
 	struct svc_rqst		*rd_rqstp;          /* response */
 	struct svc_fh		*rd_fhp;            /* response */
 	u32			rd_eof;             /* response */
+	struct nfs4_stid	*rd_wd_stid;        /* internal */
 };
 
 struct nfsd4_readdir {
-- 
2.43.5


