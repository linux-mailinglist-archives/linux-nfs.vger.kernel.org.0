Return-Path: <linux-nfs+bounces-19366-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOiDATWioGlVlAQAu9opvQ
	(envelope-from <linux-nfs+bounces-19366-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Feb 2026 20:42:45 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB461AE933
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Feb 2026 20:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD97330FC53D
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Feb 2026 19:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4991F44CF51;
	Thu, 26 Feb 2026 19:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RfDv8C0t"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559F14508F9
	for <linux-nfs@vger.kernel.org>; Thu, 26 Feb 2026 19:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772134591; cv=none; b=eydeerJH2WS5BvUCr9lTGnwNwugmVfshSW+CC2BWaKaHyT6EQrceGZJAoJAeS8Tdt8wrYqgZFMdRhgFiZXvC3isDjZP9TUs4JzFl9smn6CWV5g/yoKVPXvLgmLLyrDxoxpFyRnmXsc/snupVQZb7Al79ncC8Eh5hYmfyr7FXo7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772134591; c=relaxed/simple;
	bh=P5pwEW4HeMHRYS/tkcUJvDdZzGeeJ1yO/2fnDFulgj8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UAoRsEHejoncJkpNhmrlFQMmu1fbBSKN5jKmKisIY8BmH0RbPF8yO26Zr8r6EnwrtGxo8GBZk672Ymip372AP8rLGBOydnZafgzVgMwEiaC5p8aFtudPc5l+A9ROpUlD/BfDO/j9BQ0k2UrlhgAjyq/Psp8lOx7IGJI1K0E2lsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RfDv8C0t; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QDNDR3193388;
	Thu, 26 Feb 2026 19:36:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=qumOrejF3bVwz8cE7kDqG09j5LHkI
	/UnFW4iIHrzn3w=; b=RfDv8C0tOWb7MTuq9Bbn1yTGJYQMYk2LQ1TzetHfzKh/0
	yiqUMxZNp1oJ/40H5355mdYwA/Unv8qhpAkBVd/v4TUFmS5uHlDdnuURpu+dYRSD
	rSNyCE919St+WyYT8JP3pTbYktc76VpGeYI8CW6v+ourQz9+NmfiW4dE5cuoOl1I
	I6g3sxItGEYYRLeEv0K+Qw17kC275Y6nzt+dBxVcA51tm60xfT/5n8IxdSBhUqhi
	0RKa5CKjXxshTJxAeF6eUyHHQvg1KOGIiV+5malvYUMSvoiWG0RfBU3mwkK/6fqs
	M3gg6Pbg3H+BHNP9vP48vRc9gHNHGdu1gA8ywmWkg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cjgg3sbym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 19:36:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61QJ1oVM015677;
	Thu, 26 Feb 2026 19:36:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35d4ty5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 19:36:14 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 61QJaDLs032891;
	Thu, 26 Feb 2026 19:36:13 GMT
Received: from labops-common-sca-01.us.oracle.com (labops-common-sca-01.us.oracle.com [10.132.26.161])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4cf35d4txp-1;
	Thu, 26 Feb 2026 19:36:13 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neil@brown.name,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v5 1/1] NFSD: move accumulated callback ops to per-net namespace
Date: Thu, 26 Feb 2026 11:35:48 -0800
Message-ID: <20260226193611.1038076-1-dai.ngo@oracle.com>
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
 definitions=2026-02-26_02,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602260179
X-Authority-Analysis: v=2.4 cv=XZqEDY55 c=1 sm=1 tr=0 ts=69a0a0af cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8 a=zHtvTW8leqFcTVHmRYkA:9
X-Proofpoint-GUID: 0QmPRatN1fddgxCu6XKVI0SErmoVSNB5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDE3OSBTYWx0ZWRfX1SRSI6oaUso/
 VJMezVPVTJp7eo1V2ur9Rkmf2ikS6s1vPkorNtoOAwPsvcp28Xhi3Y8a6q2aqJjXgwItXqeYvjm
 ADgmQcx5S3EEFkZdnWNQJ6nSmorYlyCcxo9Lr3eR7xehvNnNC0KaSESkwnphtCSyxdEelfaktOT
 I4mqmsUC2ybffudDEZfYgWRk2bRMf8PQhNgNiVQMr2pawwKrsm9o6lSsAuynWk+SP62+cK05Qin
 zKzCanvApp/KF5ZX5LHHeRzxbYGgbb1aHCOiFTCN2DB7+vPLbQqil3HNKE0rKjZYOZcv2ItTiKT
 W2iAJydNYFZS4E+lsdLwcZ+9TYWRPmb76CJMR82spzmpgH/Kape/6cQubz/Lc1jrrDChpzlr9rh
 NxTHnzRqPAl84dQ0RGiyaFmCZuKaBTTfA5BaWnc1ARySbI2bub1seRbbfizimXUuF7LFIft1w/m
 B3Wp4B5ULcU7vz4wMig==
X-Proofpoint-ORIG-GUID: 0QmPRatN1fddgxCu6XKVI0SErmoVSNB5
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
	TAGGED_FROM(0.00)[bounces-19366-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: 6BB461AE933
X-Rspamd-Action: no action

Track accumulated callback operations on a per-network-namespace basis
instead of globally, ensuring proper isolation and behavior when running
nfsd in containers.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/netns.h        |  5 +++
 fs/nfsd/nfs4callback.c | 75 ++++++++++++++++++++++--------------------
 fs/nfsd/nfsctl.c       |  5 +++
 fs/nfsd/state.h        |  2 ++
 4 files changed, 52 insertions(+), 35 deletions(-)

v2:
  . free memory allocated for nn->nfsd_cb_version4.counts in
    nfsd_net_cb_stats_init() on error in nfsd_net_init().
v3:
  . reword commit message.
  . fix initialization of nn->nfsd_cb_program.nrvers.
v4:
  . fix merge conflict in nfsd_net_exit in nfsd-testing branch.
v5:
  . restore commit message to the original in v1

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 6ad3fe5d7e12..c101bf2c24c2 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -228,6 +228,11 @@ struct nfsd_net {
 	struct list_head	local_clients;
 #endif
 	siphash_key_t		*fh_key;
+
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
index 9b05462da4cc..490193c1877d 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -895,4 +895,6 @@ struct nfsd4_get_dir_delegation;
 struct nfs4_delegation *nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
 						struct nfsd4_get_dir_delegation *gdd,
 						struct nfsd_file *nf);
+int nfsd_net_cb_stats_init(struct nfsd_net *nn);
+void nfsd_net_cb_stats_shutdown(struct nfsd_net *nn);
 #endif   /* NFSD4_STATE_H */
-- 
2.47.3


