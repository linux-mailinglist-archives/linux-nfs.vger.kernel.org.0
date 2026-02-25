Return-Path: <linux-nfs+bounces-19233-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OB3HKRfQnmnwXQQAu9opvQ
	(envelope-from <linux-nfs+bounces-19233-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Feb 2026 11:33:59 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 114D3195CDE
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Feb 2026 11:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3AD213019FC2
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Feb 2026 10:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A602E2DFB;
	Wed, 25 Feb 2026 10:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Jk0E3+EX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCC232A3D1
	for <linux-nfs@vger.kernel.org>; Wed, 25 Feb 2026 10:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772015634; cv=none; b=P/xDWSJMO7BqGt+QAp+8f0XbVu1de+lHSzdjkYhp9T0Y1JGC3DyKyJefocnMpOa9/L26Qfh6bT6Bchm46vA0G6sDmIOg/CnkQZjXqWmzxp4NjIL2FTdu/25XwcX3g/Lla4Hm7GA+d4FALUiKqZDtJfpQE/d7T4flYhOpOuseXW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772015634; c=relaxed/simple;
	bh=0pfty/ETi9SSmG8iAf6yqrT36uOz5XzNEi+28GWauf8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rcVxVdnloYYoxBWDsl8+FWfU+0x/mmfUdAMR1A/KamyAaV0oTp53cjJB/q6fsNekJMLe3OSvsmsBIsJK9pL1FS2Wce7l6XNr86cINKFJnu7x8gEwAqWbA4a5BYkco078wk06e9a9p4mdTa7RJ8UVBTdGV3EpkRaquyVJuME+gXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Jk0E3+EX; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61P1xJMf1059873;
	Wed, 25 Feb 2026 10:33:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=kcvh1Kve7aXdZ3cKUi5w6urdICy+9
	AV9IPA27yAxO1E=; b=Jk0E3+EXfgIrdExbecAlm/fi9bacupkAtMxGiGVcueA7Z
	sDs8Uyf61oXfyy7s2kUVZIlTOEGrbwYWKQ5GnurAifE+USdPTzfGi8jKXH1gyiSR
	+lxCvzXSJXSUXXtUZLMF8PMiL0tRaHr6O3FbbMvd/u0CZPIQpOKFVc3oogufLKDK
	kohGJlqf428A6ysYVYyekSPWdEM8bqQ740ACBHrki9joV7wFLFXoq+0/G9xQmcVA
	UFo6iajrcMa/THwGqpoZ5eOIfQIdnQaVtLLFu03QuqGBHQS2+svLiQjPTr7BOZ2b
	e+dnXePsxAF84j9WhZkOc7iQ+g6TnIg0qCViWlxrA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf3m7wvub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Feb 2026 10:33:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61P9GRX8015638;
	Wed, 25 Feb 2026 10:33:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35b5xa5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Feb 2026 10:33:41 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 61PAXf97026172;
	Wed, 25 Feb 2026 10:33:41 GMT
Received: from labops-common-sca-01.us.oracle.com (labops-common-sca-01.us.oracle.com [10.132.26.161])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4cf35b5x9r-1;
	Wed, 25 Feb 2026 10:33:40 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neil@brown.name,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/1] NFSD: move accumulated callback ops to per-net namespace
Date: Wed, 25 Feb 2026 02:30:14 -0800
Message-ID: <20260225103337.587416-1-dai.ngo@oracle.com>
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
 definitions=2026-02-24_03,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602250103
X-Authority-Analysis: v=2.4 cv=O5U0fR9W c=1 sm=1 tr=0 ts=699ed006 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8 a=TcovN42iIufsKO83s8cA:9
X-Proofpoint-GUID: NbJPhjW5QVqrhrkNpKkpzdP3brmQ-4d8
X-Proofpoint-ORIG-GUID: NbJPhjW5QVqrhrkNpKkpzdP3brmQ-4d8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDEwMyBTYWx0ZWRfX92dbv4BNAxn0
 i41zFTWt1lfCtI2OASBR3yHSWzeUBmkitiQNjjLUdrKMQgZ7Up3m3JHekEk/SXccxL6WcCBmnnc
 komOtLlfMChHz1X9eitz9uXAdTi/kegSihbsl016LPnKqmaI7d4XA8s5ITjCG2z3inPEKv/1gmB
 eu+knGoY97jNmTiZ3HAilS+2/3xTRID9jFa/VayLSWuZgGpYEjuLZ7w7oiy+ePqPSnqUpgIOG9Q
 eQXRlTaKuQN3gFgIwdmA1i7O302Ti9adKjZuDjA9fpalCKFooLB7tmNez9Pi/Np6MpVgwsVBxJy
 daFyCavgk1s2+G9iD7ZXXWq86Zuzw8q19X2GSAPCmzbFDpSLUK7Pi9Pl6qslXNXYtj0YUMwLCFK
 zBMJcka2/eopkuAcSMb3CbWvZVe1amNjJW4GllU95UqOhsxNGbsT/NhaiKQ/KyB5VFIb/fPbDES
 rYaA/jC2e+fUa9aHnZA==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:mid,oracle.com:dkim,oracle.com:email];
	FROM_NEQ_ENVFROM(0.00)[dai.ngo@oracle.com,linux-nfs@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-19233-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 114D3195CDE
X-Rspamd-Action: no action

Track accumulated callback operations on a per-network-namespace basis
instead of globally, ensuring proper isolation and behavior when running
nfsd in containers.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/netns.h        |  4 +++
 fs/nfsd/nfs4callback.c | 75 ++++++++++++++++++++++--------------------
 fs/nfsd/nfsctl.c       |  5 +++
 fs/nfsd/state.h        |  2 ++
 4 files changed, 51 insertions(+), 35 deletions(-)

v2:
  . free memory allocated for nn->nfsd_cb_version4.counts in
    nfsd_net_cb_stats_init() on error in nfsd_net_init().

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 9fa600602658..62a5949490ea 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -224,6 +224,10 @@ struct nfsd_net {
 	spinlock_t              local_clients_lock;
 	struct list_head	local_clients;
 #endif
+	struct rpc_version	nfsd_cb_version4;
+	const struct rpc_version *nfsd_cb_versions[2];
+	struct rpc_program	nfsd_cb_program;
+	struct rpc_stat		nfsd_cb_stat;
 };
 
 /* Simple check to find out if a given net was properly initialized */
diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index aea8bdd2fdc4..aad4276b2f1b 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1016,7 +1016,7 @@ static int nfs4_xdr_dec_cb_offload(struct rpc_rqst *rqstp,
 	.p_decode  = nfs4_xdr_dec_##restype,				\
 	.p_arglen  = NFS4_enc_##argtype##_sz,				\
 	.p_replen  = NFS4_dec_##restype##_sz,				\
-	.p_statidx = NFSPROC4_CB_##call,				\
+	.p_statidx = NFSPROC4_CLNT_##proc,				\
 	.p_name    = #proc,						\
 }
 
@@ -1032,40 +1032,7 @@ static const struct rpc_procinfo nfs4_cb_procedures[] = {
 	PROC(CB_GETATTR,	COMPOUND,	cb_getattr,	cb_getattr),
 };
 
-static unsigned int nfs4_cb_counts[ARRAY_SIZE(nfs4_cb_procedures)];
-static const struct rpc_version nfs_cb_version4 = {
-/*
- * Note on the callback rpc program version number: despite language in rfc
- * 5661 section 18.36.3 requiring servers to use 4 in this field, the
- * official xdr descriptions for both 4.0 and 4.1 specify version 1, and
- * in practice that appears to be what implementations use.  The section
- * 18.36.3 language is expected to be fixed in an erratum.
- */
-	.number			= 1,
-	.nrprocs		= ARRAY_SIZE(nfs4_cb_procedures),
-	.procs			= nfs4_cb_procedures,
-	.counts			= nfs4_cb_counts,
-};
-
-static const struct rpc_version *nfs_cb_version[2] = {
-	[1] = &nfs_cb_version4,
-};
-
-static const struct rpc_program cb_program;
-
-static struct rpc_stat cb_stats = {
-	.program		= &cb_program
-};
-
 #define NFS4_CALLBACK 0x40000000
-static const struct rpc_program cb_program = {
-	.name			= "nfs4_cb",
-	.number			= NFS4_CALLBACK,
-	.nrvers			= ARRAY_SIZE(nfs_cb_version),
-	.version		= nfs_cb_version,
-	.stats			= &cb_stats,
-	.pipe_dir_name		= "nfsd4_cb",
-};
 
 static int max_cb_time(struct net *net)
 {
@@ -1152,14 +1119,15 @@ static int setup_callback_client(struct nfs4_client *clp, struct nfs4_cb_conn *c
 		.addrsize	= conn->cb_addrlen,
 		.saddress	= (struct sockaddr *) &conn->cb_saddr,
 		.timeout	= &timeparms,
-		.program	= &cb_program,
 		.version	= 1,
 		.flags		= (RPC_CLNT_CREATE_NOPING | RPC_CLNT_CREATE_QUIET),
 		.cred		= current_cred(),
 	};
 	struct rpc_clnt *client;
 	const struct cred *cred;
+	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
 
+	args.program = &nn->nfsd_cb_program;
 	if (clp->cl_minorversion == 0) {
 		if (!clp->cl_cred.cr_principal &&
 		    (clp->cl_cred.cr_flavor >= RPC_AUTH_GSS_KRB5)) {
@@ -1786,3 +1754,40 @@ bool nfsd4_run_cb(struct nfsd4_callback *cb)
 		nfsd41_cb_inflight_end(clp);
 	return queued;
 }
+
+void nfsd_net_cb_stats_shutdown(struct nfsd_net *nn)
+{
+	kfree(nn->nfsd_cb_version4.counts);
+}
+
+int nfsd_net_cb_stats_init(struct nfsd_net *nn)
+{
+	nn->nfsd_cb_version4.counts = kzalloc_objs(unsigned int,
+			ARRAY_SIZE(nfs4_cb_procedures), GFP_KERNEL);
+	if (!nn->nfsd_cb_version4.counts)
+		return -ENOMEM;
+	/*
+	 * Note on the callback rpc program version number: despite language
+	 * in rfc 5661 section 18.36.3 requiring servers to use 4 in this
+	 * field, the official xdr descriptions for both 4.0 and 4.1 specify
+	 * version 1, and in practice that appears to be what implementations
+	 * use. The section 18.36.3 language is expected to be fixed in an
+	 * erratum.
+	 */
+	nn->nfsd_cb_version4.number = 1;
+
+	nn->nfsd_cb_version4.nrprocs = ARRAY_SIZE(nfs4_cb_procedures);
+	nn->nfsd_cb_version4.procs = nfs4_cb_procedures;
+	nn->nfsd_cb_versions[1] = &nn->nfsd_cb_version4;
+
+	memset(&nn->nfsd_cb_stat, 0, sizeof(nn->nfsd_cb_stat));
+	nn->nfsd_cb_program.name = "nfs4_cb";
+	nn->nfsd_cb_program.number = NFS4_CALLBACK;
+	nn->nfsd_cb_program.nrvers = sizeof(struct rpc_version *) * 2;
+	nn->nfsd_cb_program.version = &nn->nfsd_cb_versions[0];
+	nn->nfsd_cb_program.pipe_dir_name = "nfsd4_cb";
+	nn->nfsd_cb_program.stats = &nn->nfsd_cb_stat;
+	nn->nfsd_cb_stat.program = &nn->nfsd_cb_program;
+
+	return 0;
+}
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index e9acd2cd602c..b24a838afcaa 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -2158,6 +2158,9 @@ static __net_init int nfsd_net_init(struct net *net)
 	int retval;
 	int i;
 
+	retval = nfsd_net_cb_stats_init(nn);
+	if (retval)
+		return retval;
 	retval = nfsd_export_init(net);
 	if (retval)
 		goto out_export_error;
@@ -2198,6 +2201,7 @@ static __net_init int nfsd_net_init(struct net *net)
 out_idmap_error:
 	nfsd_export_shutdown(net);
 out_export_error:
+	nfsd_net_cb_stats_shutdown(nn);
 	return retval;
 }
 
@@ -2227,6 +2231,7 @@ static __net_exit void nfsd_net_exit(struct net *net)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
+	nfsd_net_cb_stats_shutdown(nn);
 	nfsd_proc_stat_shutdown(net);
 	percpu_counter_destroy_many(nn->counter, NFSD_STATS_COUNTERS_NUM);
 	nfsd_idmap_shutdown(net);
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 6fcbf1e427d4..72d98088627a 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -877,4 +877,6 @@ struct nfsd4_get_dir_delegation;
 struct nfs4_delegation *nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
 						struct nfsd4_get_dir_delegation *gdd,
 						struct nfsd_file *nf);
+int nfsd_net_cb_stats_init(struct nfsd_net *nn);
+void nfsd_net_cb_stats_shutdown(struct nfsd_net *nn);
 #endif   /* NFSD4_STATE_H */
-- 
2.47.3


