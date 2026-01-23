Return-Path: <linux-nfs+bounces-18374-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EOqHsrDc2kCygAAu9opvQ
	(envelope-from <linux-nfs+bounces-18374-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 19:54:02 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D665D79D23
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 19:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AFEA7300E48C
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 18:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8142BD5A7;
	Fri, 23 Jan 2026 18:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nN9SPpon"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7682BD58A
	for <linux-nfs@vger.kernel.org>; Fri, 23 Jan 2026 18:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769194393; cv=none; b=re0JcIBSuryXytRimtSiVKZL2lTc5gH4DE3CLbqj8OmlgnBnDLgbl3+Ha48Sn4E5Hp2e47nGg+tSImpRySK8kl93Bht3g+K5Nn5zxvAtGrAXNcafjJU/OR+qZiLS1ERLcR63923vkHZByYYIG6tEGh/Bj/j5VYBxdQsY95wcj78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769194393; c=relaxed/simple;
	bh=ZGrZw0vZgDHGOex3xZ14K51PcUem9TJ3srVkzj30Jdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mKHjGGUYjV/Uv2UcXOtzopvIVUMHyjhwZslee9vfgJ89L15JcjW10A7jm9GvTYqW3rLswDuCb0Pnt1LP4tyBSoorQUDqa600BBW04npX0cgFscTjj7yCKr7jdFcRdp1/mgMh/S/xDzHcgW3g4Bkb0GB2OK2SE8W0+otAXZ9TniQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nN9SPpon; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1272C116D0;
	Fri, 23 Jan 2026 18:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769194393;
	bh=ZGrZw0vZgDHGOex3xZ14K51PcUem9TJ3srVkzj30Jdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nN9SPponYNKc7Nyh+4Okvu95Z/6Ck0ZIqDcdOmMyLYFBmypSs8xPpHaECiUm/dssc
	 8KfQCjtvIumj+kh9x7/BvJjnZKP37DWdKOrMx1Ymif4pVZRIKga9sHYbg5hOQGMoGB
	 5LtrFVWy8A4zqK3M1N5nV7nhb7QWJvArOYTIeDmzuT48gW1RMXlS2hcAoPARuTdjcr
	 GXMDgujPxH54RWAgIp57dec3Qj9lqaLhMdpLTSqwx06PpLcA/f/JiM5BgGI7THAw9v
	 pPVANuZulrK7na3ukflGt7pZul6a3IzlZWUrOzUrIlFX4cGLivYiJtIa309c2OfMu5
	 AQSdbb7P02G/w==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 13/42] lockd: Relocate svc_version definitions to XDR layer
Date: Fri, 23 Jan 2026 13:52:30 -0500
Message-ID: <20260123185259.1215767-14-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260123185259.1215767-1-cel@kernel.org>
References: <20260123185259.1215767-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18374-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: D665D79D23
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Public RPC server interfaces become cluttered when internal
XDR implementation details leak into them. The procedure count,
maximum XDR buffer size, and per-CPU call counters serve no
purpose outside the code that encodes and decodes NLM protocol
messages. Exposing these values through global headers creates
unnecessary coupling between the RPC dispatch logic and the
XDR layer.

Relocating the svc_version structure definitions confines this
implementation information to the files where XDR encoding and
decoding occur. In svc.c, the buffer size computation now reads
vs_xdrsize from the version structures rather than relying on a
preprocessor constant. This calculation occurs at service
initialization, after the linker has resolved the version
structure definitions. The dispatch function becomes non-static
because both the version structures and the dispatcher reside in
different translation units.

The NLMSVC_XDRSIZE macro is removed from xdr.h because buffer
size is now computed from the union of XDR argument and result
structures, matching the pattern used in other RPC services.
Version 1 and 3 share the same procedure table but maintain
separate counter arrays. Version 4 remains separate due to its
distinct procedure definitions.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/lockd.h    |  6 ++++--
 fs/lockd/svc.c      | 48 +++++++++++----------------------------------
 fs/lockd/svc4proc.c | 23 +++++++++++++++++++++-
 fs/lockd/svcproc.c  | 38 ++++++++++++++++++++++++++++++++++-
 fs/lockd/xdr.h      |  5 -----
 5 files changed, 74 insertions(+), 46 deletions(-)

diff --git a/fs/lockd/lockd.h b/fs/lockd/lockd.h
index c889475a74e0..17db7b3ad2c7 100644
--- a/fs/lockd/lockd.h
+++ b/fs/lockd/lockd.h
@@ -221,9 +221,10 @@ struct nlm_block {
  * Global variables
  */
 extern const struct rpc_program	nlm_program;
-extern const struct svc_procedure nlmsvc_procedures[24];
+extern const struct svc_version nlmsvc_version1;
+extern const struct svc_version nlmsvc_version3;
 #ifdef CONFIG_LOCKD_V4
-extern const struct svc_procedure nlmsvc_procedures4[24];
+extern const struct svc_version nlmsvc_version4;
 #endif
 extern int			nlmsvc_grace_period;
 extern unsigned long		nlm_timeout;
@@ -318,6 +319,7 @@ void		  nlmsvc_traverse_blocks(struct nlm_host *, struct nlm_file *,
 void		  nlmsvc_grant_reply(struct nlm_cookie *, __be32);
 void		  nlmsvc_release_call(struct nlm_rqst *);
 void		  nlmsvc_locks_init_private(struct file_lock *, struct nlm_host *, pid_t);
+int		  nlmsvc_dispatch(struct svc_rqst *rqstp);
 
 /*
  * File handling for the server personality
diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index 9dd7f8e11544..490551369ef2 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -44,7 +44,6 @@
 #include "netlink.h"
 
 #define NLMDBG_FACILITY		NLMDBG_SVC
-#define LOCKD_BUFSIZE		(1024 + NLMSVC_XDRSIZE)
 
 static struct svc_program	nlmsvc_program;
 
@@ -319,6 +318,7 @@ static struct notifier_block lockd_inet6addr_notifier = {
 static int lockd_get(void)
 {
 	struct svc_serv *serv;
+	unsigned int bufsize;
 	int error;
 
 	if (nlmsvc_serv) {
@@ -334,7 +334,15 @@ static int lockd_get(void)
 		printk(KERN_WARNING
 			"lockd_up: no pid, %d users??\n", nlmsvc_users);
 
-	serv = svc_create(&nlmsvc_program, LOCKD_BUFSIZE, lockd);
+#ifdef CONFIG_LOCKD_V4
+	bufsize = 1024 + max3(nlmsvc_version1.vs_xdrsize,
+			      nlmsvc_version3.vs_xdrsize,
+			      nlmsvc_version4.vs_xdrsize);
+#else
+	bufsize = 1024 + max(nlmsvc_version1.vs_xdrsize,
+			     nlmsvc_version3.vs_xdrsize);
+#endif
+	serv = svc_create(&nlmsvc_program, bufsize, lockd);
 	if (!serv) {
 		printk(KERN_WARNING "lockd_up: create service failed\n");
 		return -ENOMEM;
@@ -640,7 +648,7 @@ module_exit(exit_nlm);
  *  %0: Processing complete; do not send a Reply
  *  %1: Processing complete; send Reply in rqstp->rq_res
  */
-static int nlmsvc_dispatch(struct svc_rqst *rqstp)
+int nlmsvc_dispatch(struct svc_rqst *rqstp)
 {
 	const struct svc_procedure *procp = rqstp->rq_procinfo;
 	__be32 *statp = rqstp->rq_accept_statp;
@@ -671,40 +679,6 @@ static int nlmsvc_dispatch(struct svc_rqst *rqstp)
 /*
  * Define NLM program and procedures
  */
-static DEFINE_PER_CPU_ALIGNED(unsigned long, nlmsvc_version1_count[17]);
-static const struct svc_version	nlmsvc_version1 = {
-	.vs_vers	= 1,
-	.vs_nproc	= 17,
-	.vs_proc	= nlmsvc_procedures,
-	.vs_count	= nlmsvc_version1_count,
-	.vs_dispatch	= nlmsvc_dispatch,
-	.vs_xdrsize	= NLMSVC_XDRSIZE,
-};
-
-static DEFINE_PER_CPU_ALIGNED(unsigned long,
-			      nlmsvc_version3_count[ARRAY_SIZE(nlmsvc_procedures)]);
-static const struct svc_version	nlmsvc_version3 = {
-	.vs_vers	= 3,
-	.vs_nproc	= ARRAY_SIZE(nlmsvc_procedures),
-	.vs_proc	= nlmsvc_procedures,
-	.vs_count	= nlmsvc_version3_count,
-	.vs_dispatch	= nlmsvc_dispatch,
-	.vs_xdrsize	= NLMSVC_XDRSIZE,
-};
-
-#ifdef CONFIG_LOCKD_V4
-static DEFINE_PER_CPU_ALIGNED(unsigned long,
-			      nlmsvc_version4_count[ARRAY_SIZE(nlmsvc_procedures4)]);
-static const struct svc_version	nlmsvc_version4 = {
-	.vs_vers	= 4,
-	.vs_nproc	= ARRAY_SIZE(nlmsvc_procedures4),
-	.vs_proc	= nlmsvc_procedures4,
-	.vs_count	= nlmsvc_version4_count,
-	.vs_dispatch	= nlmsvc_dispatch,
-	.vs_xdrsize	= NLMSVC_XDRSIZE,
-};
-#endif
-
 static const struct svc_version *nlmsvc_version[] = {
 	[1] = &nlmsvc_version1,
 	[3] = &nlmsvc_version3,
diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index c934f832fd04..0f31fec178c8 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -519,7 +519,7 @@ struct nlm_void			{ int dummy; };
 #define	St	1					/* status */
 #define	Rg	4					/* range (offset + length) */
 
-const struct svc_procedure nlmsvc_procedures4[24] = {
+static const struct svc_procedure nlm4svc_procedures[24] = {
 	[NLMPROC_NULL] = {
 		.pc_func = nlm4svc_proc_null,
 		.pc_decode = nlm4svc_decode_void,
@@ -761,3 +761,24 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_name = "FREE_ALL",
 	},
 };
+
+/*
+ * Storage requirements for XDR arguments and results
+ */
+union nlm4svc_xdrstore {
+	struct nlm_args			args;
+	struct nlm_res			res;
+	struct nlm_reboot		reboot;
+};
+
+static DEFINE_PER_CPU_ALIGNED(unsigned long,
+			      nlm4svc_call_counters[ARRAY_SIZE(nlm4svc_procedures)]);
+
+const struct svc_version nlmsvc_version4 = {
+	.vs_vers	= 4,
+	.vs_nproc	= ARRAY_SIZE(nlm4svc_procedures),
+	.vs_proc	= nlm4svc_procedures,
+	.vs_count	= nlm4svc_call_counters,
+	.vs_dispatch	= nlmsvc_dispatch,
+	.vs_xdrsize	= sizeof(union nlm4svc_xdrstore),
+};
diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index fdab66ff0fe8..fe689f76aeae 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -544,7 +544,7 @@ struct nlm_void			{ int dummy; };
 #define	No	(1+1024/4)			/* Net Obj */
 #define	Rg	2				/* range - offset + size */
 
-const struct svc_procedure nlmsvc_procedures[24] = {
+static const struct svc_procedure nlmsvc_procedures[24] = {
 	[NLMPROC_NULL] = {
 		.pc_func = nlmsvc_proc_null,
 		.pc_decode = nlmsvc_decode_void,
@@ -786,3 +786,39 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_name = "FREE_ALL",
 	},
 };
+
+/*
+ * Storage requirements for XDR arguments and results
+ */
+union nlmsvc_xdrstore {
+	struct nlm_args			args;
+	struct nlm_res			res;
+	struct nlm_reboot		reboot;
+};
+
+/*
+ * NLMv1 defines only procedures 1 - 15. Linux lockd also implements
+ * procedures 0 (NULL) and 16 (SM_NOTIFY).
+ */
+static DEFINE_PER_CPU_ALIGNED(unsigned long, nlm1svc_call_counters[17]);
+
+const struct svc_version nlmsvc_version1 = {
+	.vs_vers	= 1,
+	.vs_nproc	= 17,
+	.vs_proc	= nlmsvc_procedures,
+	.vs_count	= nlm1svc_call_counters,
+	.vs_dispatch	= nlmsvc_dispatch,
+	.vs_xdrsize	= sizeof(union nlmsvc_xdrstore),
+};
+
+static DEFINE_PER_CPU_ALIGNED(unsigned long,
+			      nlm3svc_call_counters[ARRAY_SIZE(nlmsvc_procedures)]);
+
+const struct svc_version nlmsvc_version3 = {
+	.vs_vers	= 3,
+	.vs_nproc	= ARRAY_SIZE(nlmsvc_procedures),
+	.vs_proc	= nlmsvc_procedures,
+	.vs_count	= nlm3svc_call_counters,
+	.vs_dispatch	= nlmsvc_dispatch,
+	.vs_xdrsize	= sizeof(union nlmsvc_xdrstore),
+};
diff --git a/fs/lockd/xdr.h b/fs/lockd/xdr.h
index af821ecf2a4e..3c60817c4349 100644
--- a/fs/lockd/xdr.h
+++ b/fs/lockd/xdr.h
@@ -88,11 +88,6 @@ struct nlm_reboot {
 	struct nsm_private	priv;
 };
 
-/*
- * Contents of statd callback when monitored host rebooted
- */
-#define NLMSVC_XDRSIZE		sizeof(struct nlm_args)
-
 bool	nlmsvc_decode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 bool	nlmsvc_decode_testargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 bool	nlmsvc_decode_lockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-- 
2.52.0


