Return-Path: <linux-nfs+bounces-22404-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id X+LJAwc+KGp9AwMAu9opvQ
	(envelope-from <linux-nfs+bounces-22404-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Jun 2026 18:23:35 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B768662508
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Jun 2026 18:23:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="k/mOTqMi";
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22404-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22404-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0C8623067F5C
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Jun 2026 16:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE60D3AFCFE;
	Tue,  9 Jun 2026 16:16:07 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6A63AE6F8;
	Tue,  9 Jun 2026 16:16:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781021767; cv=none; b=VAnGWs9NxBBlaG6Uwt42C1ErX69MqTJPF8CTLUEYdORv70+Foy00ZTziihEHo1wzUhVZ77aMQ83HHUMowuNAjatj8WBmHz8dnM6K9/96aLeCx//mzKO7FtNQb4pl4ftDS1ApXQlapS4xyxz4JaHROnF3jHSnWgZGIsKFW4XidxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781021767; c=relaxed/simple;
	bh=kXiHY93vA6zkSsMC+yOT6/a94LEpKb0VCYdPFzVa6+o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PFfZ9u+nXd+nx9fkeEzGde5+O2Mvgh4pM3A/bU/hYQlEMu0GQCG1nyiJDyz5W5pGfHjv7YxxQbB12t91AgH6fM9WJsqxMl3bkVjHeu1hbPMOng8VX6X/wfoiqTjoVkGOcX5JRUvkUhRvGGqJTmd/tmO7WSu0QsuoGEPHvGc8his=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/mOTqMi; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14BBD1F00898;
	Tue,  9 Jun 2026 16:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781021766;
	bh=E7aa3zmJtAIXv0aXZe5AhKnYwW2BQgjkdD7bYX4VrQA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=k/mOTqMiwU1FFklSKhCtMuI9kxdzk8OXNRCL/r+IqKI+DXsnBMQo2dbymyWpCXohx
	 XerG+crzxNN58wmiIPRswL4NFcC8pDXDmieCuNxcq7J7j1IG7IKZTlbK/zzvpk133g
	 OtVbDdnz9X6HD/h/isNThFKJ19mq3yS5oJL+jgHwHEJ7XSWVcNIieI99zWncTRwjAp
	 Mp0iJi7QDEoau82zY4QK4l9yF0bB0z/dLeCTQHl0Nhi9THklhU2nmK3jaXMVgZVcoH
	 fQ3jDRpir9kdsEztdJzcVHJE16xdb8gg6sHjlmRvtNAEhcrLPhxrKHlPcJvMs8g0r4
	 Xbr4BgFh7OSmQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 09 Jun 2026 12:15:57 -0400
Subject: [PATCH v3 4/4] sunrpc: remove unused svc_version vs_count field
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-exportd-netlink-v3-4-aa5508a5bb1d@kernel.org>
References: <20260609-exportd-netlink-v3-0-aa5508a5bb1d@kernel.org>
In-Reply-To: <20260609-exportd-netlink-v3-0-aa5508a5bb1d@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve Dickson <steved@redhat.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8485; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=kXiHY93vA6zkSsMC+yOT6/a94LEpKb0VCYdPFzVa6+o=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqKDw/H4Tm6q5uQKm6Rc+ZBGnbmHOfd0bJea3el
 MaWisvpszKJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaig8PwAKCRAADmhBGVaC
 FdfCD/4hhXYR7V4FvbyEOFbrHAopks20uHEvSta12PO934OzQNqtnAsHOKWs5a7JOky0DhQKYJp
 EIfGB5SagD0CL28A2BX2g81UBCLrWcyu79q//FzPEOnpwYTwnR3psywvh86UOvMOflLnb0Qgaw+
 kC2W5JGO+wWHE0Fxl3C2y+H+UvgGZ0Jy9/qtwnGyfLtgBHC26obr5yinNyzVmB5cdZoO9qYJerl
 Ost/LI463DoMk8I3q5qHR7goqBIIjVZwzmtXEMvkdxv/uc/ul//UCNsnbAyjiWI3vvdpijlHtmu
 x1H+Bl4/7GAgWJoKOF+70NysMNDlJJyMmKY9bx8AoudYrH0yFrtLkPAsSgjnuaYGtEBI47V3vbR
 xHVokPHHlPlcrFg0aGRRRD03D5o3djk5DYmGgNjPvLIMC5tVaReCMpwrYSC9DBWWqBJkQiEwSoJ
 e/iNyIg1f1eYxleHgAkmsvgqUZv0Gv40QXrHuXsFhiQotoUY1iPc1nCaDs7i2lEPi3VqjiT7rwP
 e0+rYHlz77xfzAhEoC4IJastwfG8P01p6s4st+wbW2l0NPXVQlwB9hQZHv8p3nYTQlNcHvwQs9e
 tWz2kWxeopo51l+Ky3DyMNZBd2IPqN1JI8M/5tWh4csnry6aHmIo70ZFokQA6MhmqnhrecXzxim
 e+8+ROH6BS5K1JA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22404-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:chuck.lever@oracle.com,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:steved@redhat.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jlayton@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9B768662508

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
index 78e675470c4b..8910ee9c2c24 100644
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
index 4836887f11ef..8f81d95fc5ff 100644
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
index 0c37d7c6d28c..3e9819fa6cee 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -4129,13 +4129,10 @@ static const struct svc_procedure nfsd_procedures4[2] = {
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
index 8873033d1e82..9efd261fae45 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -838,13 +838,10 @@ static const struct svc_procedure nfsd_procedures2[18] = {
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
index 4be6204f6630..db9ee1d3a50b 100644
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
index 200b57e633dd..61e1c56c3657 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1405,9 +1405,6 @@ svc_generic_init_request(struct svc_rqst *rqstp,
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


