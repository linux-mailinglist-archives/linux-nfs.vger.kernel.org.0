Return-Path: <linux-nfs+bounces-19252-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJ4vJpY/n2laZgQAu9opvQ
	(envelope-from <linux-nfs+bounces-19252-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Feb 2026 19:29:42 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2927C19C48C
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Feb 2026 19:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC5EA30B3BFA
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Feb 2026 18:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869B7267B90;
	Wed, 25 Feb 2026 18:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eurpojlO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E8A2DF13B
	for <linux-nfs@vger.kernel.org>; Wed, 25 Feb 2026 18:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772043880; cv=none; b=JjWZrwZf/1TiI2gKeO5ndfjHp8k4ua02KZlxRYvOVbawBFeLsBMcNnnlBAwSSS+zUwiTyw097y8TwngsGBYv34FDhz8jqFcvgpW3fO5oVfKRfAh+MdQ+X6yPG9zKQHoYH0C75zi+pBVQpeV3GvDsNAYU/fw0xvxOOqaaE7AncAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772043880; c=relaxed/simple;
	bh=OVqcOTf/mN6RNV08idIQXxiX74pvJWMN5OnSbAMq1Og=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HY3CG1soe8n6KahoBLSnIzPBRHWcvgol1YI+4U+Ri4rWnGIFjvs6X9AvsTxTr9DzLJkFmF6RF9UMmlL2EoL4bWF+GlNHZ/QeUd/OXasH8dEEZeIwTzgA3RL2bDLZYAjaMelk052UDOci7JU7fclh2WnciCeYOtVayDPbjsjBxVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eurpojlO; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PHvcKx369379;
	Wed, 25 Feb 2026 18:24:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=HCTdbOoBBVtUcsFZgKBrOGFMgJgn+
	2eWZUQhjxduH6s=; b=eurpojlOcm3lJc+lY1tXFGK72ZdM1MIwqc6xayGQV5bkk
	JztQwhwi0NqsZIfoSgNw+2OsU/uCueq8aq/6dgl02wRIAn8QLRuweNcjr8BP8/Gy
	Qo9vJ1ABs5ueFnmoZRvQF1H6pCIKUl0pxSlHPiWUpi054ioHJMfh5OT9alGNfwor
	BtEq4omxM3P1lcVbw+RW4WL4qfVO2rwov1gqqa2izRUdFvkHE3GwhV+jnuyRcuWv
	dvBQ//ev5gjFpbApqmQiMAzq+B6PLseEgzV9ZrsnJinnISjecM5PdVkG3OhCglN1
	pPolIrXOnsJYREi7jUAwJSHLniYVTpj5DYMy6FISg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf4k5xruv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Feb 2026 18:24:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61PGwjs6012588;
	Wed, 25 Feb 2026 18:24:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35fpt57-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Feb 2026 18:24:23 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 61PION2f030308;
	Wed, 25 Feb 2026 18:24:23 GMT
Received: from labops-common-sca-01.us.oracle.com (labops-common-sca-01.us.oracle.com [10.132.26.161])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4cf35fpt4c-1;
	Wed, 25 Feb 2026 18:24:23 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neil@brown.name,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v4 1/1] NFSD: move accumulated callback ops to per-net namespace
Date: Wed, 25 Feb 2026 10:22:28 -0800
Message-ID: <20260225182418.723304-1-dai.ngo@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2602130000 definitions=main-2602250176
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDE3NiBTYWx0ZWRfX9It2YfmgX5oK
 d7xrExdLmlMIx9eijC8HJkdGv6iZDS0jQH4YFXaOpow+X208qrRrq6Yicd1L1Mlr5yghl6AIt5Z
 1CNjPy0ULfL8oqPINE772jWNzEXTn3tEyBAq0LYC6ytbLBkJTiBXyeWx67rJS00wfTeWaL5Bjtv
 mj/hXL2KJZkpQxuOdRTmbM6M5bqUrRZS8GqaTQu3vOVdUO0emSTkY55VPz5wds7UExrH6sg44wf
 CGFc6F+wLq/vHC8TyJwytx6lqHT1wxLRJfwrd95joxCaixgBcK3a7MV+gGJdu3cIaGkUdJl4der
 9F40pQV7hN+1LXZOdt81uriBKYNvkqAhnaY9OnTHnUGsu2RnftMliaQOeVmNM75LmBWh5tvTHVt
 wVKTDvJyc26EjNLLaj7qEg9e8g87fHRtVGgMzKmF49S/JIek6PJhVA84WDtdBxsVfCT+Totwl+B
 pHAPhgRfYOf7dT2LqGfREjwgt2eFwRvnA3l7H8uA=
X-Proofpoint-GUID: 4lMeYSwLkQGyuKReZE84PDhD2XcMnDMP
X-Authority-Analysis: v=2.4 cv=b9C/I9Gx c=1 sm=1 tr=0 ts=699f3e58 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8 a=ohjVso3qAccVKakBY48A:9 cc=ntf
 awl=host:13810
X-Proofpoint-ORIG-GUID: 4lMeYSwLkQGyuKReZE84PDhD2XcMnDMP
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19252-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[oracle.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:mid,oracle.com:dkim,oracle.com:email];
	TAGGED_RCPT(0.00)[linux-nfs];
	FROM_NEQ_ENVFROM(0.00)[dai.ngo@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 2927C19C48C
X-Rspamd-Action: no action

Moves the callback RPC program, version, and stats structures from
global statics into struct nfsd_net so that each network namespace
gets its own callback counters and program definition.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4callback.c | 75 ++++++++++++++++++++++--------------------
 fs/nfsd/nfsctl.c       |  5 +++
 fs/nfsd/state.h        |  2 ++
 3 files changed, 47 insertions(+), 35 deletions(-)

v2:
  . free memory allocated for nn->nfsd_cb_version4.counts in
    nfsd_net_cb_stats_init() on error in nfsd_net_init().
v3:
  . reword commit message.
  . fix initialization of nn->nfsd_cb_program.nrvers.
v4:
  . fix merge conflict in nfsd_net_exit in nfsd-testing branch.

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
index 032ab44feb70..5daa647ef0fa 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -2216,6 +2216,9 @@ static __net_init int nfsd_net_init(struct net *net)
 	int retval;
 	int i;
 
+	retval = nfsd_net_cb_stats_init(nn);
+	if (retval)
+		return retval;
 	retval = nfsd_export_init(net);
 	if (retval)
 		goto out_export_error;
@@ -2256,6 +2259,7 @@ static __net_init int nfsd_net_init(struct net *net)
 out_idmap_error:
 	nfsd_export_shutdown(net);
 out_export_error:
+	nfsd_net_cb_stats_shutdown(nn);
 	return retval;
 }
 
@@ -2286,6 +2290,7 @@ static __net_exit void nfsd_net_exit(struct net *net)
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
 	kfree_sensitive(nn->fh_key);
+	nfsd_net_cb_stats_shutdown(nn);
 	nfsd_proc_stat_shutdown(net);
 	percpu_counter_destroy_many(nn->counter, NFSD_STATS_COUNTERS_NUM);
 	nfsd_idmap_shutdown(net);
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 3159c7b67f50..832b49a3da10 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -893,4 +893,6 @@ struct nfsd4_get_dir_delegation;
 struct nfs4_delegation *nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
 						struct nfsd4_get_dir_delegation *gdd,
 						struct nfsd_file *nf);
+int nfsd_net_cb_stats_init(struct nfsd_net *nn);
+void nfsd_net_cb_stats_shutdown(struct nfsd_net *nn);
 #endif   /* NFSD4_STATE_H */
-- 
2.47.3


