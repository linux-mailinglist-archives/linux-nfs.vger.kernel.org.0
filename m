Return-Path: <linux-nfs+bounces-22628-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1DkYHgdGMWphfwUAu9opvQ
	(envelope-from <linux-nfs+bounces-22628-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 14:48:07 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F0F68F8BB
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 14:48:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=JA6xS3UN;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22628-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22628-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E210B303043C
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 12:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E65037104A;
	Tue, 16 Jun 2026 12:45:50 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFA036C5AE;
	Tue, 16 Jun 2026 12:45:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781613950; cv=none; b=fdh16cZWRSUTgn5bhAQunJSeUD0ipuPsYdhu0FIRBIdypuWruze6GIYftRrFg0bKVMOyfml7RoL5whrWHfHJIu3WvPXE9KXNH9YdRHmBPB4qqtmp1Quv4QEUnzeE1I13IEht0INtc1v7CLi0m97+SAZoEKBm4Qk1fYLgCktjMOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781613950; c=relaxed/simple;
	bh=M4zxhHAVtISP+D+ZK6UgJXWt0loPNP7sK4eV6EkCkwQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D4aiYSmBcwz4THXuW5rpCMhPEAU/B5w1+W+JWnqGj9j+Ywf4p/DNKGp/pDHj4O0oGxIZx8jopVgGYQ0VZMromsIPpG9bfaucJtZZBi5eaKWefVQ8JTjZHo2nCUPonpPRxXI/pIbUxXVNJh8nH1VMrq7Mi1SobA9IokH3neeA7SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JA6xS3UN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D891F000E9;
	Tue, 16 Jun 2026 12:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781613948;
	bh=B+8SJgJFaYF4cSmpoxji9/Z672p5xeT/BVQZNVpBf6s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=JA6xS3UNXBB6RHmRjYjh0gFiuavLSfeFF+je56KEPOHpTUVaNs7tjnAIWllS3+oyV
	 RxdTk9yfwFixFB1VH23iBSB+KvYqa7FfEYbLJqGnILdEclJ0BqLlnyfsxxb9QT4R0l
	 PLEUzPbZkPq1xJCQYOFVqTvlnK0FaZfZx1/14kg0S2TmMyWTwlZ7yP+gMXqlGHtJis
	 AzLEHi05TFFSrj0FL1FwtOUhFfLOJodKo6z1mNMddzrX7vvqNDyvRhL8U9z7rtVUiD
	 IpVdahZAAXAAUgvkGLLiBDcEqYkzMnuycVqTWTjnbn262Cp7J5/iJpTewe19v1eF64
	 UAj48rXZaEwmg==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 16 Jun 2026 08:45:36 -0400
Subject: [PATCH v4 4/4] sunrpc: remove unused svc_version vs_count field
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-exportd-netlink-v4-4-03505aee3883@kernel.org>
References: <20260616-exportd-netlink-v4-0-03505aee3883@kernel.org>
In-Reply-To: <20260616-exportd-netlink-v4-0-03505aee3883@kernel.org>
To: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Chuck Lever <cel@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve Dickson <steved@redhat.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8485; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=M4zxhHAVtISP+D+ZK6UgJXWt0loPNP7sK4eV6EkCkwQ=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqMUV2QUAUeGKHgLWkhUKJwvueSeL1Zlc6b+PaS
 RLXc7pTNmmJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCajFFdgAKCRAADmhBGVaC
 FcYiD/9In8veZTdqc/QVOPlc6csrhQERhIYTdqq+1RR1UPL6rZrdGpQPhoDJ9+Lnz7vNrxvHyQN
 Ko292mcwsZ2Yz+4qO6QnYIlPHTYfJMjioQNYOsq7q94gJ8+sS6eu/kfqgc1k18p00M+7Lw9WWZk
 QOI6QS44s1sN0IV8/Ax6fo0/I7Pnt/ZMwgIOwjI1HnqjZQctMnFSXsel1wK6+XgyNddsDmgDilr
 zZhXUk31gTV02cT1pMrBLuyvk+pWpm1AP0V7nNQckm3ksaRAD8pW91BIPrMEFH2DQRbmqaw1ydE
 RSgShssquNkerHFDf20P1UqZIQbrXRk4o2wEqgdj4THSO6+GOIxpdlyXxMAcuAcxz4q/oCfsc/x
 jdTYZo/eUs6jV5CZM4D5YICj/1cWmSypE8XUkJdzGHLpqsShaKZT9WLZI2jOkn9NYw9jTc4y6g5
 nZSCqzn+yIzBYAfGyeLz2gteLNL3/0a5d8Vy9mftvQLD3RHIT2v7EURJx1ORfLJZm9AHwANfC8f
 OgqJjyFDcgBG6do28MpSYEUtBgDJy4XAiPgVKtPn6jXU8jNcASS8HB9R6bwyHR63LtYRt2EQpE0
 gqtNMAbDpENNP6Wgqau0kgRVrLgmPbV1bqUtKAQIghRKrSqdipX4Y+VAYA61+FADInXPtZLX0VE
 FEAzphKo/28LHHQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22628-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:cel@kernel.org,m:trondmy@kernel.org,m:anna@kernel.org,m:steved@redhat.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jlayton@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 71F0F68F8BB

Now that svc_seq_show() and the nfsd netlink stats handler both use
the per-netns svc_stat vs_count arrays, the global per-version
vs_count percpu counters are no longer read by anything. Remove the
vs_count field from struct svc_version and all the associated
DEFINE_PER_CPU_ALIGNED arrays and initializers across nfsd, lockd,
and the NFS client callback service.

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/lockd/svc4proc.c        | 4 ----
 fs/lockd/svcproc.c         | 7 -------
 fs/nfs/callback_xdr.c      | 6 ------
 fs/nfsd/localio.c          | 3 ---
 fs/nfsd/nfs2acl.c          | 3 ---
 fs/nfsd/nfs3acl.c          | 3 ---
 fs/nfsd/nfs3proc.c         | 3 ---
 fs/nfsd/nfs4proc.c         | 3 ---
 fs/nfsd/nfsproc.c          | 3 ---
 include/linux/sunrpc/svc.h | 1 -
 net/sunrpc/svc.c           | 3 ---
 11 files changed, 39 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 080dffce9d8e..c096c0c0cf60 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -1420,14 +1420,10 @@ union nlm4svc_xdrstore {
 	struct nlm4_shareres_wrapper	shareres;
 };
 
-static DEFINE_PER_CPU_ALIGNED(unsigned long,
-			      nlm4svc_call_counters[ARRAY_SIZE(nlm4svc_procedures)]);
-
 const struct svc_version nlmsvc_version4 = {
 	.vs_vers	= 4,
 	.vs_nproc	= ARRAY_SIZE(nlm4svc_procedures),
 	.vs_proc	= nlm4svc_procedures,
-	.vs_count	= nlm4svc_call_counters,
 	.vs_dispatch	= nlmsvc_dispatch,
 	.vs_xdrsize	= sizeof(union nlm4svc_xdrstore),
 };
diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index dce6f6e3fd40..07f65a03f300 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -1433,25 +1433,18 @@ union nlmsvc_xdrstore {
  * NLMv1 defines only procedures 1 - 15. Linux lockd also implements
  * procedures 0 (NULL) and 16 (SM_NOTIFY).
  */
-static DEFINE_PER_CPU_ALIGNED(unsigned long, nlm1svc_call_counters[17]);
-
 const struct svc_version nlmsvc_version1 = {
 	.vs_vers	= 1,
 	.vs_nproc	= 17,
 	.vs_proc	= nlmsvc_procedures,
-	.vs_count	= nlm1svc_call_counters,
 	.vs_dispatch	= nlmsvc_dispatch,
 	.vs_xdrsize	= sizeof(union nlmsvc_xdrstore),
 };
 
-static DEFINE_PER_CPU_ALIGNED(unsigned long,
-			      nlm3svc_call_counters[ARRAY_SIZE(nlmsvc_procedures)]);
-
 const struct svc_version nlmsvc_version3 = {
 	.vs_vers	= 3,
 	.vs_nproc	= ARRAY_SIZE(nlmsvc_procedures),
 	.vs_proc	= nlmsvc_procedures,
-	.vs_count	= nlm3svc_call_counters,
 	.vs_dispatch	= nlmsvc_dispatch,
 	.vs_xdrsize	= sizeof(union nlmsvc_xdrstore),
 };
diff --git a/fs/nfs/callback_xdr.c b/fs/nfs/callback_xdr.c
index 4382baddc9ee..eec6040556c9 100644
--- a/fs/nfs/callback_xdr.c
+++ b/fs/nfs/callback_xdr.c
@@ -1090,26 +1090,20 @@ static const struct svc_procedure nfs4_callback_procedures1[] = {
 	}
 };
 
-static DEFINE_PER_CPU_ALIGNED(unsigned long,
-			      nfs4_callback_count1[ARRAY_SIZE(nfs4_callback_procedures1)]);
 const struct svc_version nfs4_callback_version1 = {
 	.vs_vers = 1,
 	.vs_nproc = ARRAY_SIZE(nfs4_callback_procedures1),
 	.vs_proc = nfs4_callback_procedures1,
-	.vs_count = nfs4_callback_count1,
 	.vs_xdrsize = NFS4_CALLBACK_XDRSIZE,
 	.vs_dispatch = nfs_callback_dispatch,
 	.vs_hidden = true,
 	.vs_need_cong_ctrl = true,
 };
 
-static DEFINE_PER_CPU_ALIGNED(unsigned long,
-			      nfs4_callback_count4[ARRAY_SIZE(nfs4_callback_procedures1)]);
 const struct svc_version nfs4_callback_version4 = {
 	.vs_vers = 4,
 	.vs_nproc = ARRAY_SIZE(nfs4_callback_procedures1),
 	.vs_proc = nfs4_callback_procedures1,
-	.vs_count = nfs4_callback_count4,
 	.vs_xdrsize = NFS4_CALLBACK_XDRSIZE,
 	.vs_dispatch = nfs_callback_dispatch,
 	.vs_hidden = true,
diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
index c3eb0557b3e1..c458c01e9478 100644
--- a/fs/nfsd/localio.c
+++ b/fs/nfsd/localio.c
@@ -210,14 +210,11 @@ static const struct svc_procedure localio_procedures1[] = {
 };
 
 #define LOCALIO_NR_PROCEDURES ARRAY_SIZE(localio_procedures1)
-static DEFINE_PER_CPU_ALIGNED(unsigned long,
-			      localio_count[LOCALIO_NR_PROCEDURES]);
 const struct svc_version localio_version1 = {
 	.vs_vers	= 1,
 	.vs_nproc	= LOCALIO_NR_PROCEDURES,
 	.vs_proc	= localio_procedures1,
 	.vs_dispatch	= nfsd_dispatch,
-	.vs_count	= localio_count,
 	.vs_xdrsize	= XDR_QUADLEN(UUID_SIZE),
 	.vs_hidden	= true,
 };
diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
index 827f90194c43..0fd6d9def3b4 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -389,13 +389,10 @@ static const struct svc_procedure nfsd_acl_procedures2[5] = {
 	},
 };
 
-static DEFINE_PER_CPU_ALIGNED(unsigned long,
-			      nfsd_acl_count2[ARRAY_SIZE(nfsd_acl_procedures2)]);
 const struct svc_version nfsd_acl_version2 = {
 	.vs_vers	= 2,
 	.vs_nproc	= ARRAY_SIZE(nfsd_acl_procedures2),
 	.vs_proc	= nfsd_acl_procedures2,
-	.vs_count	= nfsd_acl_count2,
 	.vs_dispatch	= nfsd_dispatch,
 	.vs_xdrsize	= NFS3_SVC_XDRSIZE,
 };
diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
index a87f9d7f32be..6b6b289db636 100644
--- a/fs/nfsd/nfs3acl.c
+++ b/fs/nfsd/nfs3acl.c
@@ -278,13 +278,10 @@ static const struct svc_procedure nfsd_acl_procedures3[3] = {
 	},
 };
 
-static DEFINE_PER_CPU_ALIGNED(unsigned long,
-			      nfsd_acl_count3[ARRAY_SIZE(nfsd_acl_procedures3)]);
 const struct svc_version nfsd_acl_version3 = {
 	.vs_vers	= 3,
 	.vs_nproc	= ARRAY_SIZE(nfsd_acl_procedures3),
 	.vs_proc	= nfsd_acl_procedures3,
-	.vs_count	= nfsd_acl_count3,
 	.vs_dispatch	= nfsd_dispatch,
 	.vs_xdrsize	= NFS3_SVC_XDRSIZE,
 };
diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index aeda7a802bdf..2d5ab2178702 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -1068,13 +1068,10 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 	},
 };
 
-static DEFINE_PER_CPU_ALIGNED(unsigned long,
-			      nfsd_count3[ARRAY_SIZE(nfsd_procedures3)]);
 const struct svc_version nfsd_version3 = {
 	.vs_vers	= 3,
 	.vs_nproc	= ARRAY_SIZE(nfsd_procedures3),
 	.vs_proc	= nfsd_procedures3,
 	.vs_dispatch	= nfsd_dispatch,
-	.vs_count	= nfsd_count3,
 	.vs_xdrsize	= NFS3_SVC_XDRSIZE,
 };
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 3e4de45aa360..fbfa69cb9dcc 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -4151,13 +4151,10 @@ static const struct svc_procedure nfsd_procedures4[2] = {
 	},
 };
 
-static DEFINE_PER_CPU_ALIGNED(unsigned long,
-			      nfsd_count4[ARRAY_SIZE(nfsd_procedures4)]);
 const struct svc_version nfsd_version4 = {
 	.vs_vers		= 4,
 	.vs_nproc		= ARRAY_SIZE(nfsd_procedures4),
 	.vs_proc		= nfsd_procedures4,
-	.vs_count		= nfsd_count4,
 	.vs_dispatch		= nfsd_dispatch,
 	.vs_xdrsize		= NFS4_SVC_XDRSIZE,
 	.vs_rpcb_optnl		= true,
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index a73d5c259cd9..b8421cde795a 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -845,13 +845,10 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 	},
 };
 
-static DEFINE_PER_CPU_ALIGNED(unsigned long,
-			      nfsd_count2[ARRAY_SIZE(nfsd_procedures2)]);
 const struct svc_version nfsd_version2 = {
 	.vs_vers	= 2,
 	.vs_nproc	= ARRAY_SIZE(nfsd_procedures2),
 	.vs_proc	= nfsd_procedures2,
-	.vs_count	= nfsd_count2,
 	.vs_dispatch	= nfsd_dispatch,
 	.vs_xdrsize	= NFS2_SVC_XDRSIZE,
 };
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 3a0152d926fb..34490c0ba88c 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -408,7 +408,6 @@ struct svc_version {
 	u32			vs_vers;	/* version number */
 	u32			vs_nproc;	/* number of procedures */
 	const struct svc_procedure *vs_proc;	/* per-procedure info */
-	unsigned long __percpu	*vs_count;	/* call counts */
 	u32			vs_xdrsize;	/* xdrsize needed for this version */
 
 	/* Don't register with rpcbind */
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index f748004835f7..dce268d8ec8e 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1435,9 +1435,6 @@ svc_generic_init_request(struct svc_rqst *rqstp,
 	memset(rqstp->rq_argp, 0, procp->pc_argzero);
 	memset(rqstp->rq_resp, 0, procp->pc_ressize);
 
-	/* Bump per-procedure stats counter */
-	this_cpu_inc(versp->vs_count[rqstp->rq_proc]);
-
 	/* Bump per-net per-procedure stats counter */
 	if (rqstp->rq_server->sv_stats &&
 	    rqstp->rq_server->sv_stats->program == progp &&

-- 
2.54.0


