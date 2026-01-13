Return-Path: <linux-nfs+bounces-17813-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76182D1ADD5
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Jan 2026 19:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A53330783E4
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Jan 2026 18:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC21C34F489;
	Tue, 13 Jan 2026 18:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="riYppCrS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B814934EF08;
	Tue, 13 Jan 2026 18:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768329474; cv=none; b=t4XCqFGf0qqfTMne5NYsVMMj662YSswih2o9dZXkRpvPWYXWBddIifioJtaKVmDeLhFGmeTuCBtUIsUJ5/Ccs8VyFEYi4DrGm2kUZgi37r4zPeVQvS1Gye46yPRUrxMfbKtUxCsw4klCp/iuabSqg4s/eWgeOIzaUy5Baa0llGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768329474; c=relaxed/simple;
	bh=q3DEc+IbL4zNDWLm0VRqoUmfXFlFslRgkIrNwTn/ISU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ukya6qmFEf+V6tS3YyUHbWMlwiUIicXHgxGb3vsGTfADuxBMrpsfge7LmWiDaHO8a4WBWdUSpzx70tj+yo5FVwaAIX34KT4Zw9+FBI8ZuHawnj3PC34/b1CtooWz+JRSQ2A3HI+8lBHBuQgJd/NYDqwewuAhb7vaf93Nu9PoWdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=riYppCrS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66102C19423;
	Tue, 13 Jan 2026 18:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768329472;
	bh=q3DEc+IbL4zNDWLm0VRqoUmfXFlFslRgkIrNwTn/ISU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=riYppCrSppQkRxvPscyxwBIVBU6nCC0TKlGpd3/PBp4Gc1dZ4AGKzg54D9Qu2ReVK
	 xE7KUs0ntEuAO61BjGQ+6aeCvNeU51ZMjdrdT19TkhVwABlMnZQxxgltatyIP66I8/
	 9M+T/gKxuN9TNnEpGDJ2E11NRqZK7+OQJVg55zJBNQ7iX2jewB01ty6qzhkkHB0hS+
	 4VK1jI+eCe8BHz0v/kWBJ14Y89dPzFR+YIZ/V4gqKaXZUUt6Aj4HU65HyoXgYSZ4ZT
	 98h70305Ra/iax4UNd+d5cfKZwHgO1H6FH8ESVClp80fyswXDadyamXUKbJlisENLF
	 IzP1b3m/N0pPA==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 13 Jan 2026 13:37:40 -0500
Subject: [PATCH 2/2] nfsd/sunrpc: move rq_cachetype into struct
 nfsd_thread_local_info
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260113-rq_private-v1-2-88ed308364e6@kernel.org>
References: <20260113-rq_private-v1-0-88ed308364e6@kernel.org>
In-Reply-To: <20260113-rq_private-v1-0-88ed308364e6@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: Ben Coddington <bcodding@hammerspace.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4122; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=q3DEc+IbL4zNDWLm0VRqoUmfXFlFslRgkIrNwTn/ISU=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpZpD8vXOprTcVD+rsBCO157VjC7HpzKOv7ocBU
 qkr6rjv24KJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaWaQ/AAKCRAADmhBGVaC
 FfNGEACxoR5kW/Mzhe2MSKWl0US1YpbOQ7/jVygklDChvjsuUPQnFzy5eu8vMcKDuLozAu4k71s
 YmF8KVqT4scX/CZKALdwuZ6cIfEUMCPVlEEQm6QQKosYBgiL15A6p76SFJSvu1/FExKeNbE3V9n
 a77XgFAAZTl/VCCQr96H8WIWUKXmSNztUIiDbaAUL3kLYOAbMrI0KqhT7yHbATSz5PeZuY4x8MQ
 oZjzWBw2/UGtA+46IWcsLyGHdULFPLYBKaySxXtb8kB09yPX271ONXMTOny4DP+hxrKTQzK8kp3
 LYQ+/GFjfDvT17P11ix4/l0bsHuRTAZQs7oLJBzRZBen90F5rKZVqLz198umu26pteRAxxeVmtL
 B8ekhVK7RFcdUWjvNEIJ0MnSLlcIeZ91ucuRV+Hk+tyyTj2fJ5XeDscxdNoCtrE5vJYIdY/ObKN
 xudDV9PUFz+eFT1CB+Dl9E3kjHhkeM98Tjg5sdaHPxz+GgWg4CZaGAP46dci6WUYw7IfxT2koy9
 SX6W8agMr9AJoZgErDMVLvTXYnGfnD+VzSxjVM+NxFhyoyoJsuKaY/+PHXuYaoodEtELbEDINJN
 6sAI/VqZrpR/1e32RVu9HP0pVsSdRxzz5YW6xioGYJpydwNs1TfjLfPxzHl04UNR0iucfGagLqt
 stFP/N7XLBsT/rA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

The svc_rqst->rq_cachetype field is only accessed by nfsd. Move it
into the nfsd_thread_local_info instead.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4xdr.c          | 3 ++-
 fs/nfsd/nfscache.c         | 3 ++-
 fs/nfsd/nfsd.h             | 1 +
 fs/nfsd/nfssvc.c           | 5 +++--
 include/linux/sunrpc/svc.h | 1 -
 5 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 5172dbd0cb05956f8d5465e08fec93b5133ec55f..884b792c95a387fba24b6f540063c90d7fc1f1b0 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2598,6 +2598,7 @@ nfsd4_opnum_in_range(struct nfsd4_compoundargs *argp, struct nfsd4_op *op)
 static bool
 nfsd4_decode_compound(struct nfsd4_compoundargs *argp)
 {
+	struct nfsd_thread_local_info *ntli = argp->rqstp->rq_private;
 	struct nfsd4_op *op;
 	bool cachethis = false;
 	int auth_slack= argp->rqstp->rq_auth_slack;
@@ -2690,7 +2691,7 @@ nfsd4_decode_compound(struct nfsd4_compoundargs *argp)
 	if (argp->minorversion)
 		cachethis = false;
 	svc_reserve_auth(argp->rqstp, max_reply + readbytes);
-	argp->rqstp->rq_cachetype = cachethis ? RC_REPLBUFF : RC_NOCACHE;
+	ntli->ntli_cachetype = cachethis ? RC_REPLBUFF : RC_NOCACHE;
 
 	argp->splice_ok = nfsd_read_splice_ok(argp->rqstp);
 	if (readcount > 1 || max_reply > PAGE_SIZE - auth_slack)
diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
index ab13ee9c7fd8421ce6f66e3dc20d657b6442fbb8..154468ceccdc12dbeab3a1f19086e8ac9d37a223 100644
--- a/fs/nfsd/nfscache.c
+++ b/fs/nfsd/nfscache.c
@@ -467,10 +467,11 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp, unsigned int start,
 		      unsigned int len, struct nfsd_cacherep **cacherep)
 {
 	struct nfsd_net		*nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
+	struct nfsd_thread_local_info *ntli = rqstp->rq_private;
 	struct nfsd_cacherep	*rp, *found;
 	__wsum			csum;
 	struct nfsd_drc_bucket	*b;
-	int type = rqstp->rq_cachetype;
+	int type = ntli->ntli_cachetype;
 	LIST_HEAD(dispose);
 	int rtn = RC_DOIT;
 
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 938906c6d10cd65e7e3a1bc889b4fdcb56918f6f..a2e35a4fa105380c2d99cb0865003e0f7f4a8e8d 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -84,6 +84,7 @@ extern const struct seq_operations nfs_exports_op;
 
 struct nfsd_thread_local_info {
 	struct nfs4_client	**ntli_lease_breaker;
+	int			ntli_cachetype;
 };
 
 /*
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 8ce366c9e49220e8baf475c2e5f3424fedc1cec1..294876910cf22b4271eb3b447d23b63866fae179 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -983,6 +983,7 @@ nfsd(void *vrqstp)
  */
 int nfsd_dispatch(struct svc_rqst *rqstp)
 {
+	struct nfsd_thread_local_info *ntli = rqstp->rq_private;
 	const struct svc_procedure *proc = rqstp->rq_procinfo;
 	__be32 *statp = rqstp->rq_accept_statp;
 	struct nfsd_cacherep *rp;
@@ -993,7 +994,7 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
 	 * Give the xdr decoder a chance to change this if it wants
 	 * (necessary in the NFSv4.0 compound case)
 	 */
-	rqstp->rq_cachetype = proc->pc_cachetype;
+	ntli->ntli_cachetype = proc->pc_cachetype;
 
 	/*
 	 * ->pc_decode advances the argument stream past the NFS
@@ -1038,7 +1039,7 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
 	 */
 	smp_store_release(&rqstp->rq_status_counter, rqstp->rq_status_counter + 1);
 
-	nfsd_cache_update(rqstp, rp, rqstp->rq_cachetype, nfs_reply);
+	nfsd_cache_update(rqstp, rp, ntli->ntli_cachetype, nfs_reply);
 out_cached_reply:
 	return 1;
 
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index ab8237ba9596e9f31e2c42abedec435a23162b40..62152e4f3bccee3e7d4d99ad08d6a50ca1252c1e 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -218,7 +218,6 @@ struct svc_rqst {
 	u32			rq_vers;	/* program version */
 	u32			rq_proc;	/* procedure number */
 	u32			rq_prot;	/* IP protocol */
-	int			rq_cachetype;	/* catering to nfsd */
 	unsigned long		rq_flags;	/* flags field */
 	ktime_t			rq_qtime;	/* enqueue time */
 

-- 
2.52.0


