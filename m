Return-Path: <linux-nfs+bounces-21920-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIKiMgVDFGqmLQcAu9opvQ
	(envelope-from <linux-nfs+bounces-21920-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 25 May 2026 14:39:33 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF595CA992
	for <lists+linux-nfs@lfdr.de>; Mon, 25 May 2026 14:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 19A6430087D4
	for <lists+linux-nfs@lfdr.de>; Mon, 25 May 2026 12:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B830238424F;
	Mon, 25 May 2026 12:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HcUoi8C2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A633839B6;
	Mon, 25 May 2026 12:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779712744; cv=none; b=JqZ7ktO5Q2+EmxTpHTziQjZPqkrHI9Ec2R9mbHQyveFS0tKGGMLosYQPGbSXpMvro/aRekhNqKXnkGYQGD2VRDYS0za+cnTDx6G0M1HG85V8wi6xPJiEe4UH7/YDCtA0e3SDIvCuGh3AXRu+4Ikl6nMJtXJuxUt3Ou3+9hiOSvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779712744; c=relaxed/simple;
	bh=YpsnZICd+OwAEPHJWxvrCatjXdcPBTLD06TkzL/ArQ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e+f/UQJ5oiOWKEqIEg1EkIgQroJMmjH0jhCtlwLA0vPVuUVU9lxQiNU9o2zbCofXBo0YVn1yUCCNUpYbl62ZOB8aZYlDxg98zlQ3d1psPOjM4uqSFrLGuQGYyuHRfEe8nkRdN8vXSO0TvsD2NiP0FcxvvIwb4sJuUF7rTXBAgS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HcUoi8C2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E2311F000E9;
	Mon, 25 May 2026 12:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779712743;
	bh=adhZRUNWM2evnjf9fbjGilGijSVBjQi9Ym5pL/7Yun8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=HcUoi8C21y+TTzvW4SE+5FqcsShPTzauqTiBoMvlBpGCUB05oB0iNygkqKY+gC94n
	 qAJrBqebqZ3Yq18DZK1Sjvi0oDBPJBET16pJ0vFECE1r1u2ERkRuhaslAbZ1rclWoJ
	 CZUpcCVELWnrAhOk5W5XXi30YoSCViCB+jHbNhoGW5ZUl19EWnucU2BAg9035u+6L1
	 j+piqrBRTBIAHC0aJ5oybxcCc8RBHlhba+MyHagFpY8Zo4smPnFEb/mkH274teD+Lt
	 pcDdfWg+4eqoQCXUNzEs27TbfRVrq7bVPlHzfT260eVAkK/pfL/dh4yFbDO67Vrzaj
	 MbU7ZS0ClNEqg==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 25 May 2026 08:38:50 -0400
Subject: [PATCH v2 4/4] sunrpc: remove unused svc_version vs_count field
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-exportd-netlink-v2-4-40003fed450c@kernel.org>
References: <20260525-exportd-netlink-v2-0-40003fed450c@kernel.org>
In-Reply-To: <20260525-exportd-netlink-v2-0-40003fed450c@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve Dickson <steved@redhat.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8477; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=YpsnZICd+OwAEPHJWxvrCatjXdcPBTLD06TkzL/ArQ0=;
 b=kA0DAAoBAA5oQRlWghUByyZiAGoUQuGgiq5vP8l47lU9iT5VxesSi5BWLg2iMkqjQWXzfmIOU
 IkCMwQAAQoAHRYhBEvA17JEcbKhhOr10wAOaEEZVoIVBQJqFELhAAoJEAAOaEEZVoIVncQQANCc
 /xUqk/r6lTtjmMXKZQqGndZ+oT7WPOGZo474tYvsoH3CWJfibC6wiTFrHiWHjj19LbEkrBD+kUk
 RoY0QVXHPNBcMLPBQA3kROCMGpLuqSd1E3+3ecGQfkV+FSI4y+7x+Ke6YpQKfDFmW0pnv5ogdRE
 ttwOhRNVter85MJEjN164c0D++vSub7C4oozCtbIvIWEf1h3yTXiy1fx9/TxfCYp4YLEkbm5/l3
 HxGjI5xVwEdy3gvyPsfBl2BJzasj6PnU3ESs+YkDRsHN5zVJsf7f8if6oeKVzj4QY7Sc5S3PfI9
 cBD93Grxk8MKJ6xuJN+5fQDHT7Zt0BfTbT+urZrCWYIQ+LxOV7l3/AQk/5BtAX4WKq6JzRuyqxg
 D14GnW9+ZnO73f7fFr/Qe/ArWqrLxZevG4wDHdf8mqrWiGM92BjiKEpldEY89tdt/1myde5/2xE
 7gidimm70jYo9/alkE1EE5vjr/ovGtHpmoa/wa4DvDSahwHHmRu0VSKOUS/QP3oHdurVPOf0zfn
 FW85/FNUocBySE08TK66HNazfyxUG4YpkqowAjzs3SuYXAQVi6Xj1E+wa4kDhFCM7XXu9aE7RZP
 Lw4IOQ7W2qn1hkNVnQdWtVlpmlhfmHHQOIx0VTWYwYMm2O7OX7O51oUq+iOW8pXo5U708NbIqlB
 YHWZQ
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21920-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8EF595CA992
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index be710d809a3b..81cb245c45b6 100644
--- a/fs/nfsd/localio.c
+++ b/fs/nfsd/localio.c
@@ -204,14 +204,11 @@ static const struct svc_procedure localio_procedures1[] = {
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
index 76305b86c1a9..eb8095c5c22d 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -384,13 +384,10 @@ static const struct svc_procedure nfsd_acl_procedures2[5] = {
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
index e87731380be8..a7029914d7ba 100644
--- a/fs/nfsd/nfs3acl.c
+++ b/fs/nfsd/nfs3acl.c
@@ -273,13 +273,10 @@ static const struct svc_procedure nfsd_acl_procedures3[3] = {
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
index 34f2921e4ef8..9ddebfd0dd29 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -4122,13 +4122,10 @@ static const struct svc_procedure nfsd_procedures4[2] = {
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
index bf7c57cbfa3d..caaca2cd7fcf 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1372,9 +1372,6 @@ svc_generic_init_request(struct svc_rqst *rqstp,
 	memset(rqstp->rq_argp, 0, procp->pc_argzero);
 	memset(rqstp->rq_resp, 0, procp->pc_ressize);
 
-	/* Bump per-procedure stats counter */
-	this_cpu_inc(versp->vs_count[rqstp->rq_proc]);
-
 	/* Bump per-net per-procedure stats counter */
 	if (rqstp->rq_server->sv_stats &&
 	    rqstp->rq_server->sv_stats->vs_count &&

-- 
2.54.0


