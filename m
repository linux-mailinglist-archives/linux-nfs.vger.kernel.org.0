Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA866644E7
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jan 2023 16:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbjAJPcj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Jan 2023 10:32:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239128AbjAJPcF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Jan 2023 10:32:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B186A19E
        for <linux-nfs@vger.kernel.org>; Tue, 10 Jan 2023 07:32:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 56E26B81731
        for <linux-nfs@vger.kernel.org>; Tue, 10 Jan 2023 15:32:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76468C433D2
        for <linux-nfs@vger.kernel.org>; Tue, 10 Jan 2023 15:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673364715;
        bh=oAxPDMAyY/pzExKpIK91p0RQaGuRctv40FADZysbNfw=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=HSK9t6WmfUDIBZPfXDgqjoqH1R+puc3MvFWLd+TBuLpj4U0V+a7NetoV/H1pHH69Z
         d6rJ3H31PnuXLA9TUbF3ks1czcjV7pfwZMpXkclAlznoZP6cNP23JKg/X8YB0v1JuQ
         0g0O7Qozenr3R5iMGjYLotVxlo0kWNeMLkLqiKY/PZlvwYP+1+akwCO1F2AfbYvCOE
         NVT3h8OMoskTrAOb2/EqQVf0kp5r1yWRwWQFEq0zQksAoRAV8VQL1ZaAUIwO3Kdm8P
         4/pax9Odp0C1A+2+iYjJlfGm3P9kfX3iMoP73aKOf61sTfej3KThf3Q/UZ7QCvkp7T
         M1aUmV0dPEPKQ==
Subject: [PATCH v1 1/2] SUNRPC: Use per-CPU counters to tally server RPC
 counts
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 10 Jan 2023 10:31:54 -0500
Message-ID: <167336471457.15674.3314353339832539275.stgit@bazille.1015granger.net>
In-Reply-To: <167336437322.15674.16325059932149395877.stgit@bazille.1015granger.net>
References: <167336437322.15674.16325059932149395877.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

- Improves counting accuracy
 - Reduces cross-CPU memory traffic

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc.c              |   15 ++++++++++-----
 fs/nfs/callback_xdr.c       |    6 ++++--
 fs/nfsd/nfs2acl.c           |    5 +++--
 fs/nfsd/nfs3acl.c           |    5 +++--
 fs/nfsd/nfs3proc.c          |    5 +++--
 fs/nfsd/nfs4proc.c          |    7 ++++---
 fs/nfsd/nfsproc.c           |    6 +++---
 include/linux/lockd/lockd.h |    4 ++--
 include/linux/sunrpc/svc.h  |    2 +-
 net/sunrpc/stats.c          |   11 ++++++++---
 net/sunrpc/svc.c            |    2 +-
 11 files changed, 42 insertions(+), 26 deletions(-)

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index 0b28a6cf9303..1da00230860c 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -721,7 +721,7 @@ static int nlmsvc_dispatch(struct svc_rqst *rqstp)
 /*
  * Define NLM program and procedures
  */
-static unsigned int nlmsvc_version1_count[17];
+static DEFINE_PER_CPU_ALIGNED(unsigned long, nlmsvc_version1_count[17]);
 static const struct svc_version	nlmsvc_version1 = {
 	.vs_vers	= 1,
 	.vs_nproc	= 17,
@@ -730,26 +730,31 @@ static const struct svc_version	nlmsvc_version1 = {
 	.vs_dispatch	= nlmsvc_dispatch,
 	.vs_xdrsize	= NLMSVC_XDRSIZE,
 };
-static unsigned int nlmsvc_version3_count[24];
+
+static DEFINE_PER_CPU_ALIGNED(unsigned long,
+			      nlmsvc_version3_count[ARRAY_SIZE(nlmsvc_procedures)]);
 static const struct svc_version	nlmsvc_version3 = {
 	.vs_vers	= 3,
-	.vs_nproc	= 24,
+	.vs_nproc	= ARRAY_SIZE(nlmsvc_procedures),
 	.vs_proc	= nlmsvc_procedures,
 	.vs_count	= nlmsvc_version3_count,
 	.vs_dispatch	= nlmsvc_dispatch,
 	.vs_xdrsize	= NLMSVC_XDRSIZE,
 };
+
 #ifdef CONFIG_LOCKD_V4
-static unsigned int nlmsvc_version4_count[24];
+static DEFINE_PER_CPU_ALIGNED(unsigned long,
+			      nlmsvc_version4_count[ARRAY_SIZE(nlmsvc_procedures4)]);
 static const struct svc_version	nlmsvc_version4 = {
 	.vs_vers	= 4,
-	.vs_nproc	= 24,
+	.vs_nproc	= ARRAY_SIZE(nlmsvc_procedures4),
 	.vs_proc	= nlmsvc_procedures4,
 	.vs_count	= nlmsvc_version4_count,
 	.vs_dispatch	= nlmsvc_dispatch,
 	.vs_xdrsize	= NLMSVC_XDRSIZE,
 };
 #endif
+
 static const struct svc_version *nlmsvc_version[] = {
 	[1] = &nlmsvc_version1,
 	[3] = &nlmsvc_version3,
diff --git a/fs/nfs/callback_xdr.c b/fs/nfs/callback_xdr.c
index 13b2af55497d..321af81c456e 100644
--- a/fs/nfs/callback_xdr.c
+++ b/fs/nfs/callback_xdr.c
@@ -1069,7 +1069,8 @@ static const struct svc_procedure nfs4_callback_procedures1[] = {
 	}
 };
 
-static unsigned int nfs4_callback_count1[ARRAY_SIZE(nfs4_callback_procedures1)];
+static DEFINE_PER_CPU_ALIGNED(unsigned long,
+			      nfs4_callback_count1[ARRAY_SIZE(nfs4_callback_procedures1)]);
 const struct svc_version nfs4_callback_version1 = {
 	.vs_vers = 1,
 	.vs_nproc = ARRAY_SIZE(nfs4_callback_procedures1),
@@ -1081,7 +1082,8 @@ const struct svc_version nfs4_callback_version1 = {
 	.vs_need_cong_ctrl = true,
 };
 
-static unsigned int nfs4_callback_count4[ARRAY_SIZE(nfs4_callback_procedures1)];
+static DEFINE_PER_CPU_ALIGNED(unsigned long,
+			      nfs4_callback_count4[ARRAY_SIZE(nfs4_callback_procedures1)]);
 const struct svc_version nfs4_callback_version4 = {
 	.vs_vers = 4,
 	.vs_nproc = ARRAY_SIZE(nfs4_callback_procedures1),
diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
index 1457f59f447a..dea55883e099 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -377,10 +377,11 @@ static const struct svc_procedure nfsd_acl_procedures2[5] = {
 	},
 };
 
-static unsigned int nfsd_acl_count2[ARRAY_SIZE(nfsd_acl_procedures2)];
+static DEFINE_PER_CPU_ALIGNED(unsigned long,
+			      nfsd_acl_count2[ARRAY_SIZE(nfsd_acl_procedures2)]);
 const struct svc_version nfsd_acl_version2 = {
 	.vs_vers	= 2,
-	.vs_nproc	= 5,
+	.vs_nproc	= ARRAY_SIZE(nfsd_acl_procedures2),
 	.vs_proc	= nfsd_acl_procedures2,
 	.vs_count	= nfsd_acl_count2,
 	.vs_dispatch	= nfsd_dispatch,
diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
index 647108138e8a..bf1c52c1bdab 100644
--- a/fs/nfsd/nfs3acl.c
+++ b/fs/nfsd/nfs3acl.c
@@ -266,10 +266,11 @@ static const struct svc_procedure nfsd_acl_procedures3[3] = {
 	},
 };
 
-static unsigned int nfsd_acl_count3[ARRAY_SIZE(nfsd_acl_procedures3)];
+static DEFINE_PER_CPU_ALIGNED(unsigned long,
+			      nfsd_acl_count3[ARRAY_SIZE(nfsd_acl_procedures3)]);
 const struct svc_version nfsd_acl_version3 = {
 	.vs_vers	= 3,
-	.vs_nproc	= 3,
+	.vs_nproc	= ARRAY_SIZE(nfsd_acl_procedures3),
 	.vs_proc	= nfsd_acl_procedures3,
 	.vs_count	= nfsd_acl_count3,
 	.vs_dispatch	= nfsd_dispatch,
diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index d01b29aba662..1c73921c02e0 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -1064,10 +1064,11 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 	},
 };
 
-static unsigned int nfsd_count3[ARRAY_SIZE(nfsd_procedures3)];
+static DEFINE_PER_CPU_ALIGNED(unsigned long,
+			      nfsd_count3[ARRAY_SIZE(nfsd_procedures3)]);
 const struct svc_version nfsd_version3 = {
 	.vs_vers	= 3,
-	.vs_nproc	= 22,
+	.vs_nproc	= ARRAY_SIZE(nfsd_procedures3),
 	.vs_proc	= nfsd_procedures3,
 	.vs_dispatch	= nfsd_dispatch,
 	.vs_count	= nfsd_count3,
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 770e5b09cc1a..1c62249c370f 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -3596,12 +3596,13 @@ static const struct svc_procedure nfsd_procedures4[2] = {
 	},
 };
 
-static unsigned int nfsd_count3[ARRAY_SIZE(nfsd_procedures4)];
+static DEFINE_PER_CPU_ALIGNED(unsigned long,
+			      nfsd_count4[ARRAY_SIZE(nfsd_procedures4)]);
 const struct svc_version nfsd_version4 = {
 	.vs_vers		= 4,
-	.vs_nproc		= 2,
+	.vs_nproc		= ARRAY_SIZE(nfsd_procedures4),
 	.vs_proc		= nfsd_procedures4,
-	.vs_count		= nfsd_count3,
+	.vs_count		= nfsd_count4,
 	.vs_dispatch		= nfsd_dispatch,
 	.vs_xdrsize		= NFS4_SVC_XDRSIZE,
 	.vs_rpcb_optnl		= true,
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index a5570cf75f3f..262a277f39f1 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -838,11 +838,11 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 	},
 };
 
-
-static unsigned int nfsd_count2[ARRAY_SIZE(nfsd_procedures2)];
+static DEFINE_PER_CPU_ALIGNED(unsigned long,
+			      nfsd_count2[ARRAY_SIZE(nfsd_procedures2)]);
 const struct svc_version nfsd_version2 = {
 	.vs_vers	= 2,
-	.vs_nproc	= 18,
+	.vs_nproc	= ARRAY_SIZE(nfsd_procedures2),
 	.vs_proc	= nfsd_procedures2,
 	.vs_count	= nfsd_count2,
 	.vs_dispatch	= nfsd_dispatch,
diff --git a/include/linux/lockd/lockd.h b/include/linux/lockd/lockd.h
index 70ce419e2709..84de6b7c9948 100644
--- a/include/linux/lockd/lockd.h
+++ b/include/linux/lockd/lockd.h
@@ -196,9 +196,9 @@ struct nlm_block {
  * Global variables
  */
 extern const struct rpc_program	nlm_program;
-extern const struct svc_procedure nlmsvc_procedures[];
+extern const struct svc_procedure nlmsvc_procedures[24];
 #ifdef CONFIG_LOCKD_V4
-extern const struct svc_procedure nlmsvc_procedures4[];
+extern const struct svc_procedure nlmsvc_procedures4[24];
 #endif
 extern int			nlmsvc_grace_period;
 extern unsigned long		nlmsvc_timeout;
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 392d2d2620fa..1b078c9a2d60 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -377,7 +377,7 @@ struct svc_version {
 	u32			vs_vers;	/* version number */
 	u32			vs_nproc;	/* number of procedures */
 	const struct svc_procedure *vs_proc;	/* per-procedure info */
-	unsigned int		*vs_count;	/* call counts */
+	unsigned long __percpu	*vs_count;	/* call counts */
 	u32			vs_xdrsize;	/* xdrsize needed for this version */
 
 	/* Don't register with rpcbind */
diff --git a/net/sunrpc/stats.c b/net/sunrpc/stats.c
index 52908f9e6eab..65fc1297c6df 100644
--- a/net/sunrpc/stats.c
+++ b/net/sunrpc/stats.c
@@ -83,7 +83,8 @@ void svc_seq_show(struct seq_file *seq, const struct svc_stat *statp)
 {
 	const struct svc_program *prog = statp->program;
 	const struct svc_version *vers;
-	unsigned int i, j;
+	unsigned int i, j, k;
+	unsigned long count;
 
 	seq_printf(seq,
 		"net %u %u %u %u\n",
@@ -104,8 +105,12 @@ void svc_seq_show(struct seq_file *seq, const struct svc_stat *statp)
 		if (!vers)
 			continue;
 		seq_printf(seq, "proc%d %u", i, vers->vs_nproc);
-		for (j = 0; j < vers->vs_nproc; j++)
-			seq_printf(seq, " %u", vers->vs_count[j]);
+		for (j = 0; j < vers->vs_nproc; j++) {
+			count = 0;
+			for_each_possible_cpu(k)
+				count += per_cpu(vers->vs_count[j], k);
+			seq_printf(seq, " %lu", count);
+		}
 		seq_putc(seq, '\n');
 	}
 }
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index c2ed8b06fadb..2e1788314cf0 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1208,7 +1208,7 @@ svc_generic_init_request(struct svc_rqst *rqstp,
 	memset(rqstp->rq_resp, 0, procp->pc_ressize);
 
 	/* Bump per-procedure stats counter */
-	versp->vs_count[rqstp->rq_proc]++;
+	this_cpu_inc(versp->vs_count[rqstp->rq_proc]);
 
 	ret->dispatch = versp->vs_dispatch;
 	return rpc_success;


