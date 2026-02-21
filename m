Return-Path: <linux-nfs+bounces-19079-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKRWDXQqmmljZQMAu9opvQ
	(envelope-from <linux-nfs+bounces-19079-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Feb 2026 22:58:12 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 911FF16E04A
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Feb 2026 22:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4CD2301E949
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Feb 2026 21:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3209B1CF7D5;
	Sat, 21 Feb 2026 21:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AjDzU7vT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329773148A8
	for <linux-nfs@vger.kernel.org>; Sat, 21 Feb 2026 21:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771711071; cv=none; b=arECmKS3/2FpWT88c06N1aarPxoLk0J799PT8OvIHlGrweIMgTjasRRNPDK03OHDi7V8VtvgCi2aKO9fEbw71fYsEcqKIlzaeLYmcavy58u/tWyECo/m52L3jhe+DPwhF0r+sPcS44Tekpdxl/3dvj4EFX5zxt8peexHWtZtFgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771711071; c=relaxed/simple;
	bh=yWYuFOXySkpYiOID4+duBqlJz44z3zeR6LTDxVCPSBc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Au8rr3VDMgbYWorLzo3RkYxMyA+yFDAFzEEOKH6WmeXIBhYO6gHQ6bmWlIAaAhIrIa6MAN3NfozgjF61ZJx0odyR7GKPPgmZG3v12H72UD9eaVtqokrIaZ+iqHQCxHMpZnZA2y4ODSjW7Vhap3z2BnSauy03r7k0QJVMLjePkoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AjDzU7vT; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61LLQsgp2449804;
	Sat, 21 Feb 2026 21:57:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=Jm2nXO2AwKcpu0iDQlr9AYFT3n3p2
	jiVFmin1kKP5CQ=; b=AjDzU7vTo3HSxBDHAwEmxxulTk24zEyov/sNeMlm09BAO
	GXzZJehk5bunosQV3A4MdyPnD1rLk3vNj9kWakv/VAp4JjWreq9ZZUYGTRpTi+GU
	uXfbp8OfGPHevSs5EwpoU8BpR+WNcdddYoKvMYitULnsgUivwWEOxiG/oSQ0l7fq
	p/LBbxScCgU/N/YcWB4e4Tc4Qc4olEdlQC0yq4ioLEPF3Q2avPSLdH55asPG/bUO
	K3DU3rFkinQ5DYLPN8UVrIPX4JrgbsHme9ZuTBSKCxQg9kiixBLB6NhfqVNeU449
	2I3CIBr0AM6bJLL6OeGn4gVwoIVTVsrCirr+94JwA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf4ar8f9t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Feb 2026 21:57:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61LIIj0U028929;
	Sat, 21 Feb 2026 21:57:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35728v4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Feb 2026 21:57:36 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 61LLvZAK028389;
	Sat, 21 Feb 2026 21:57:35 GMT
Received: from labops-common-sca-01.us.oracle.com (labops-common-sca-01.us.oracle.com [10.132.26.161])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4cf35728v2-1;
	Sat, 21 Feb 2026 21:57:35 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neil@brown.name,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSD: Expose callback statistics in /proc/net/rpc/nfsd
Date: Sat, 21 Feb 2026 13:57:15 -0800
Message-ID: <20260221215733.3643669-1-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-21_06,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602210214
X-Authority-Analysis: v=2.4 cv=La0xKzfi c=1 sm=1 tr=0 ts=699a2a51 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8 a=99WY_jpS41XEmtIu6mQA:9
X-Proofpoint-ORIG-GUID: 9gqDJIoU8epx5EdIAbjrsnwHA8E2tALY
X-Proofpoint-GUID: 9gqDJIoU8epx5EdIAbjrsnwHA8E2tALY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIxMDIxMyBTYWx0ZWRfX313aD72zKrc/
 3eE6nWOJ/N7gHW1jVtwNlYtsrH5EBjPj4hEJtmkguqX9ebmJuoHNOf04rYrt5c21GInYj5P+qhj
 wnKRo4M9jAQccF2SeX1YIIKLJXeOwfDddFPjDg3QFf/vY8f8dEqKU6xyE4SJbWXZ1WmD91han/S
 uTPMkqnQ14RClXikM0w9w3nVzC0poyZqlWCt5V4iNbA2iyaBsBR5eBw4i/jtdDSIx0YwVawaTW7
 Nmb+6lg/K6e4jTyhJTNq6MbgCI+/njFaPFurOYmKwKzgb7YTcJiAH83RmOUMTC+OVTr1TnSM9iF
 7eCrgPPUAchlFtvhrY+oTYhBaAl89JSd45ozcSTXMO/QVB+uLRUULZXKlUk9Rk9XVyCgrNf7ztu
 rypBUTruEczgQ+SHCvYS7KtLRoPfs4fyKL6Qu93wnw+43pe2SC8k0y/fvau/9lCR3R+l7f2Rm3l
 z2QhpP48k80BvJtV3Ug==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[dai.ngo@oracle.com,linux-nfs@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-19079-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 911FF16E04A
X-Rspamd-Action: no action

Extend /proc/net/rpc/nfsd output to report NFSv4 callback activity:

. Add system-wide counters for each callback operation.
. Add per-client callback operation statistics, similar to mountstats(8)
  raw format.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4callback.c | 33 ++++++++++++++++++++++++++++++++-
 fs/nfsd/nfsd.h         |  1 +
 fs/nfsd/stats.c        |  2 ++
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index e00b2aea8da2..5d6c91b2da24 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -36,6 +36,7 @@
 #include <linux/sunrpc/xprt.h>
 #include <linux/sunrpc/svc_xprt.h>
 #include <linux/slab.h>
+#include <linux/sunrpc/metrics.h>
 #include "nfsd.h"
 #include "state.h"
 #include "netns.h"
@@ -1016,7 +1017,7 @@ static int nfs4_xdr_dec_cb_offload(struct rpc_rqst *rqstp,
 	.p_decode  = nfs4_xdr_dec_##restype,				\
 	.p_arglen  = NFS4_enc_##argtype##_sz,				\
 	.p_replen  = NFS4_dec_##restype##_sz,				\
-	.p_statidx = NFSPROC4_CB_##call,				\
+	.p_statidx = NFSPROC4_CLNT_##proc,				\
 	.p_name    = #proc,						\
 }
 
@@ -1786,3 +1787,33 @@ bool nfsd4_run_cb(struct nfsd4_callback *cb)
 		nfsd41_cb_inflight_end(clp);
 	return queued;
 }
+
+void nfsd4_show_cb_stats(struct nfsd_net *nn, struct seq_file *seq)
+{
+	const struct rpc_procinfo *pinfo;
+	const struct rpc_version *ver;
+	struct nfs4_client *clp;
+	int ix;
+
+	/* display system-wide status, count per op */
+	ver = cb_program.version[1];
+	for (ix = 0; ix < ver->nrprocs; ix++) {
+		pinfo = &ver->procs[ix];
+		if (pinfo->p_name)
+			seq_printf(seq, "%s: %d\n",
+				pinfo->p_name, ver->counts[pinfo->p_statidx]);
+	}
+
+	/* display per-client status, similar to mountstats(8) in raw format */
+	spin_lock(&nn->client_lock);
+	for (ix = 0; ix < CLIENT_HASH_SIZE; ix++) {
+		list_for_each_entry(clp, &nn->conf_id_hashtbl[ix], cl_idhash) {
+			if (!clp->cl_cb_client)
+				continue;
+			seq_printf(seq, "\nClient[%pISpc]:\n",
+					(struct sockaddr *)&clp->cl_addr);
+			rpc_clnt_show_stats(seq, clp->cl_cb_client);
+		}
+	}
+	spin_unlock(&nn->client_lock);
+}
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 7c009f07c90b..cec0c6167ddb 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -591,6 +591,7 @@ extern void nfsd4_ssc_init_umount_work(struct nfsd_net *nn);
 #endif
 
 extern void nfsd4_init_leases_net(struct nfsd_net *nn);
+void nfsd4_show_cb_stats(struct nfsd_net *nn, struct seq_file *seq);
 
 #else /* CONFIG_NFSD_V4 */
 static inline int nfsd4_is_junction(struct dentry *dentry)
diff --git a/fs/nfsd/stats.c b/fs/nfsd/stats.c
index f7eaf95e20fc..cc601719ef26 100644
--- a/fs/nfsd/stats.c
+++ b/fs/nfsd/stats.c
@@ -66,6 +66,8 @@ static int nfsd_show(struct seq_file *seq, void *v)
 		percpu_counter_sum_positive(&nn->counter[NFSD_STATS_WDELEG_GETATTR]));
 
 	seq_putc(seq, '\n');
+
+	nfsd4_show_cb_stats(nn, seq);
 #endif
 
 	return 0;
-- 
2.47.3


