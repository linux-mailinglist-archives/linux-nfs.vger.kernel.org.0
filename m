Return-Path: <linux-nfs+bounces-19249-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yE/YMvUwn2lXZQQAu9opvQ
	(envelope-from <linux-nfs+bounces-19249-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Feb 2026 18:27:17 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4562119B874
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Feb 2026 18:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39C6A300E274
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Feb 2026 17:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7FF27A45C;
	Wed, 25 Feb 2026 17:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c7uFJDGQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299163921F8
	for <linux-nfs@vger.kernel.org>; Wed, 25 Feb 2026 17:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772040423; cv=none; b=VL3nWHeZlWb3iwyxJu05ByxmPcRYJniZSxGgln/1ZwaUfm0dsFqjsLiNA3WnMwfgCZpBDiYOvuNWFHecSUbS6Ntd2IVDfP0E+Hgb1hTWq0y++dWeS6qfsXJxx0mNEQ/INmjwIHjpkmCn3NBNKrH/5+7aQJKtqYBGLKd0Ip3Ze+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772040423; c=relaxed/simple;
	bh=VX+9I2LESXm+bt70oDz5pNjcMtKg8Ehb0SerbLf4gB8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UuY2RpIAr8z0wF9nk92TnFCs1h8qR23N2lTBeAHz8v6vfjJy3pCR15EjZteAMmWIiuskFIJsFB9Bx2ESWtMl0ehCvm7P/ozQxCRH2cpOwJ2cVcrVWGxCVw9yT5gIZPVYFHqe6/ccs/FS/L5/nYK5vYqW58+EteaZslEI1HLCM5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=c7uFJDGQ; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PAXkix719572;
	Wed, 25 Feb 2026 17:26:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=2na+ediWwnuHOcGbe8vneetHABnxK
	+sGDnUu8Siu/AM=; b=c7uFJDGQk5bD7tBYdBoFipZePA9DTMbXbJEJYyI6peQnX
	vIgZ4fu6ZTU55xeTJPon/E6vHXvM/ibeLmv9QxTer5FMAsjRbu50LbW0r2DjJR7X
	wyNeYLq4v5y+aBECZdVKVdlvpsvsg4VUaYWzUqCzsmYjS7J2YSFxyiohTue/CRcM
	ep8RmdodTW4THT9uK2ywMWUndTdmMMGiyBCw3snJi/7tvxJArYgvwvHGl2rrobYE
	N16fhj2utpJmYLyiDVr8RzdgszfDTFcoJPj3opbcxQanf/2UEFusTUWy8IVwMsFC
	vnpYLqAZJqCxn236Ay2xCguKHX5F7c9wKCf/wBh9w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf34b6p0e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Feb 2026 17:26:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61PGM7vG028497;
	Wed, 25 Feb 2026 17:26:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35bbtdd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Feb 2026 17:26:42 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 61PHQfZA023650;
	Wed, 25 Feb 2026 17:26:41 GMT
Received: from labops-common-sca-01.us.oracle.com (labops-common-sca-01.us.oracle.com [10.132.26.161])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4cf35bbtd2-1;
	Wed, 25 Feb 2026 17:26:41 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neil@brown.name,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v3 1/1] NFSD: move accumulated callback ops to per-net namespace
Date: Wed, 25 Feb 2026 09:26:16 -0800
Message-ID: <20260225172624.707224-1-dai.ngo@oracle.com>
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
 definitions=2026-02-25_02,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602250167
X-Authority-Analysis: v=2.4 cv=GrlPO01C c=1 sm=1 tr=0 ts=699f30d3 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8 a=TcovN42iIufsKO83s8cA:9
X-Proofpoint-ORIG-GUID: Dxcfa9Sh2zNc3NZKMwUlwK4MucGGAs62
X-Proofpoint-GUID: Dxcfa9Sh2zNc3NZKMwUlwK4MucGGAs62
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDE2NyBTYWx0ZWRfX0q9VwNlcDoqa
 czkrIFVc8knuk5gLmvfisjZ+2uHi4K2xtVGpN7dwjClxq3bDsDkwplidmt4foIZ0E+Bmco+aBG8
 9OoI6MLMQYn86Y9rBcIF+UnLVZtkmntvWVILdv1pSwyQIcHI7RTIiOhrd2Mio37OjAaP5xol54E
 eutVYo6xoSjIEU4BT4ptvB/qvZo2BLWO6WWwEBIY4AaO2UAq64mH3+aFbYzWXCmvzF+EwzN7oid
 QfPpdLdZbAdumrRMiqZAPzP2Cp1F4xo4GC1U40rSZch5Yx7pUNby8WhfL0jOmXA6H7bzSJseFUC
 0wuQFm5CkO/RJk4bDrCLYGTewuupkvXZLPTvjvGvCH5P8sGGz9fVMddEmpBAwIr2n2c6wkLcjX1
 vW/rpiCVnGs3lSBPmYw2ZCgTeXE4uz0/YNcJbS+M8+PPCXITriZ3YUD6J7vI9gXlu/lWDTyvrM4
 b8yb4ADglOu/qhy5BFA==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19249-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[oracle.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:dkim,oracle.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-nfs];
	FROM_NEQ_ENVFROM(0.00)[dai.ngo@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 4562119B874
X-Rspamd-Action: no action

Moves the callback RPC program, version, and stats structures from
global statics into struct nfsd_net so that each network namespace
gets its own callback counters and program definition.

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
v3:
  . reword commit message.
  . fix initialization of nn->nfsd_cb_program.nrvers.

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
index aea8bdd2fdc4..759f24657c34 100644
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
+	nn->nfsd_cb_program.nrvers = ARRAY_SIZE(nn->nfsd_cb_versions);
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


