Return-Path: <linux-nfs+bounces-23263-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IhN0KUXsU2r2gAMAu9opvQ
	(envelope-from <linux-nfs+bounces-23263-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jul 2026 21:34:29 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C114745C6A
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jul 2026 21:34:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cJfOlhSo;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23263-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23263-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58A743024170
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jul 2026 19:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11056369981;
	Sun, 12 Jul 2026 19:31:28 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236F539A064
	for <linux-nfs@vger.kernel.org>; Sun, 12 Jul 2026 19:31:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783884688; cv=none; b=OAqDzRNFZT68hhC/YYlYHje8ZBbmbp3pI+ASTovlShVhYiiAuSlRfHvMpkGDN3eUSt/AQhQ8o7B/nbwVyA+4terGNI2aR8qLAm54RmWQHZrX7XJm42x0z6/FyLgFD9evfVrO1b0HMpLpEWs6pW8O3VQ4uvxrQ85FuAIGg3HNasY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783884688; c=relaxed/simple;
	bh=Ok3axHCQMbvxxZpN8qdELQV2LGaIqGnfzTiqf4+GIoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cFnmoncXYxFdbsKIq0bEy/U3KxR6xSkMWUaI8129pftsAesoXLgAbIPptNB1mtDbU8NUFSFlvoQ7ZkiTmHMcgC62/q2+AaW20dlIsIWbcIcHoxuQJIS+iOUffhW8ji7hOEjxXaBwP1RGSdrZVmMPQHOEbxMHnUb6mgGtrCCL9cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJfOlhSo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E2871F00A3A;
	Sun, 12 Jul 2026 19:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783884685;
	bh=HSQ6+XVw+V2FU3QO+wRvBKCElJs48OwSTAQAOudM2ms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cJfOlhSoZL6WBuRbJ5DX9DZgkGfBgcbLPyAL6fcXwKhNRRLCoG6RplG/bQ54knf3i
	 HJAC67yrceerUzhcMbrdYKAhWqPzpON+RpM3KDU96qudQTVJ/XasXealHMYOrlXiz+
	 W5dQO+rEnaNhCRaK6wU8p5A1Num3SqTL7jxTK7awsHWz7BL6fpMQlieyqmprINoJY+
	 VR5heEw0zadjDb5143EYJoQZNMMdJIFZnSIniKpnX+X2Ms5MtusT7ObImKuB50gr2w
	 HM5JFyU7S+cO6cbez2viqvsZd7GvtHVS3HozHpVw3HFf41kxQShYNamKKr8HGIw2eE
	 siIUkvV2GBG+g==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>
Subject: [PATCH 2/5] xdrgen: Share void RPC procedure handlers across programs
Date: Sun, 12 Jul 2026 15:31:19 -0400
Message-ID: <20260712193122.116845-3-cel@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260712193122.116845-1-cel@kernel.org>
References: <20260712193122.116845-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23263-lists,linux-nfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:neil@brown.name,m:jlayton@kernel.org,m:okorniev@redhat.com,m:dai.ngo@oracle.com,m:tom@talpey.com,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0C114745C6A

The generated server-side decoder and encoder for a void procedure
argument or result are named after the RPC program (for example,
nfs_svc_decode_void). xdrgen derives that prefix from the program
name alone, not the version, so two versions of one program built
into the same module emit the identical symbol. NFSv2 and NFSv3
both declare program NFS_PROGRAM; once both are converted, fs/nfsd
fails to link with multiple definitions of nfs_svc_decode_void and
nfs_svc_encode_void.

A void handler carries no program- or version-specific behavior:
each merely forwards to xdrgen_decode_void() or xdrgen_encode_void().
Define one shared pair, xdrgen_svc_decode_void() and
xdrgen_svc_encode_void(), in the xdrgen builtins, and stop the
program generator from emitting a per-program void handler.

lockd is the one in-tree consumer that already emits per-program
void handlers, so regenerate the NLMv3 and NLMv4 XDR code to drop
nlm_svc_{decode,encode}_void() and nlm4_svc_{decode,encode}_void()
and point both procedure tables at the shared handlers. The shared
handlers are identical to the generated ones they replace, so no
wire behavior changes.

Only the server (svc) handlers are affected. The client-side void
stubs remain static and per-program, so they do not collide.

Signed-off-by: Chuck Lever <cel@kernel.org>
---
 fs/lockd/nlm3xdr_gen.c                        | 28 -------------
 fs/lockd/nlm3xdr_gen.h                        |  2 -
 fs/lockd/nlm4xdr_gen.c                        | 28 -------------
 fs/lockd/nlm4xdr_gen.h                        |  2 -
 fs/lockd/svc4proc.c                           | 40 +++++++++----------
 fs/lockd/svcproc.c                            | 40 +++++++++----------
 include/linux/sunrpc/xdrgen/_builtins.h       | 32 +++++++++++++++
 tools/net/sunrpc/xdrgen/generators/program.py |  8 ++++
 .../templates/C/program/decoder/argument.j2   |  4 --
 .../templates/C/program/encoder/result.j2     |  4 --
 10 files changed, 80 insertions(+), 108 deletions(-)

diff --git a/fs/lockd/nlm3xdr_gen.c b/fs/lockd/nlm3xdr_gen.c
index df14692ce37f..4b6e3ee7a719 100644
--- a/fs/lockd/nlm3xdr_gen.c
+++ b/fs/lockd/nlm3xdr_gen.c
@@ -271,20 +271,6 @@ xdrgen_decode_nlm_notifyargs(struct xdr_stream *xdr, struct nlm_notifyargs *ptr)
 	return true;
 }
 
-/**
- * nlm_svc_decode_void - Decode a void argument
- * @rqstp: RPC transaction context
- * @xdr: source XDR data stream
- *
- * Return values:
- *   %true: procedure arguments decoded successfully
- *   %false: decode failed
- */
-bool nlm_svc_decode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr)
-{
-	return xdrgen_decode_void(xdr);
-}
-
 /**
  * nlm_svc_decode_nlm_testargs - Decode a nlm_testargs argument
  * @rqstp: RPC transaction context
@@ -651,20 +637,6 @@ xdrgen_encode_nlm_notifyargs(struct xdr_stream *xdr, const struct nlm_notifyargs
 	return true;
 }
 
-/**
- * nlm_svc_encode_void - Encode a void result
- * @rqstp: RPC transaction context
- * @xdr: target XDR data stream
- *
- * Return values:
- *   %true: procedure results encoded successfully
- *   %false: encode failed
- */
-bool nlm_svc_encode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr)
-{
-	return xdrgen_encode_void(xdr);
-}
-
 /**
  * nlm_svc_encode_nlm_testres - Encode a nlm_testres result
  * @rqstp: RPC transaction context
diff --git a/fs/lockd/nlm3xdr_gen.h b/fs/lockd/nlm3xdr_gen.h
index 3824ffe2aae4..bdbfc26ba0e4 100644
--- a/fs/lockd/nlm3xdr_gen.h
+++ b/fs/lockd/nlm3xdr_gen.h
@@ -13,7 +13,6 @@
 #include <linux/sunrpc/xdrgen/_builtins.h>
 #include <linux/sunrpc/xdrgen/nlm3.h>
 
-bool nlm_svc_decode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 bool nlm_svc_decode_nlm_testargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 bool nlm_svc_decode_nlm_lockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 bool nlm_svc_decode_nlm_cancargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
@@ -24,7 +23,6 @@ bool nlm_svc_decode_nlm_notifyargs(struct svc_rqst *rqstp, struct xdr_stream *xd
 bool nlm_svc_decode_nlm_shareargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 bool nlm_svc_decode_nlm_notify(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 
-bool nlm_svc_encode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 bool nlm_svc_encode_nlm_testres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 bool nlm_svc_encode_nlm_res(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 bool nlm_svc_encode_nlm_shareres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
diff --git a/fs/lockd/nlm4xdr_gen.c b/fs/lockd/nlm4xdr_gen.c
index 5a60aff06714..f98d74ee3d41 100644
--- a/fs/lockd/nlm4xdr_gen.c
+++ b/fs/lockd/nlm4xdr_gen.c
@@ -300,20 +300,6 @@ xdrgen_decode_nlm4_notifyargs(struct xdr_stream *xdr, struct nlm4_notifyargs *pt
 	return true;
 }
 
-/**
- * nlm4_svc_decode_void - Decode a void argument
- * @rqstp: RPC transaction context
- * @xdr: source XDR data stream
- *
- * Return values:
- *   %true: procedure arguments decoded successfully
- *   %false: decode failed
- */
-bool nlm4_svc_decode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr)
-{
-	return xdrgen_decode_void(xdr);
-}
-
 /**
  * nlm4_svc_decode_nlm4_testargs - Decode a nlm4_testargs argument
  * @rqstp: RPC transaction context
@@ -704,20 +690,6 @@ xdrgen_encode_nlm4_notifyargs(struct xdr_stream *xdr, const struct nlm4_notifyar
 	return true;
 }
 
-/**
- * nlm4_svc_encode_void - Encode a void result
- * @rqstp: RPC transaction context
- * @xdr: target XDR data stream
- *
- * Return values:
- *   %true: procedure results encoded successfully
- *   %false: encode failed
- */
-bool nlm4_svc_encode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr)
-{
-	return xdrgen_encode_void(xdr);
-}
-
 /**
  * nlm4_svc_encode_nlm4_testres - Encode a nlm4_testres result
  * @rqstp: RPC transaction context
diff --git a/fs/lockd/nlm4xdr_gen.h b/fs/lockd/nlm4xdr_gen.h
index ce9dda0a052a..1a72c26ad18a 100644
--- a/fs/lockd/nlm4xdr_gen.h
+++ b/fs/lockd/nlm4xdr_gen.h
@@ -13,7 +13,6 @@
 #include <linux/sunrpc/xdrgen/_builtins.h>
 #include <linux/sunrpc/xdrgen/nlm4.h>
 
-bool nlm4_svc_decode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 bool nlm4_svc_decode_nlm4_testargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 bool nlm4_svc_decode_nlm4_lockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 bool nlm4_svc_decode_nlm4_cancargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
@@ -24,7 +23,6 @@ bool nlm4_svc_decode_nlm4_notifyargs(struct svc_rqst *rqstp, struct xdr_stream *
 bool nlm4_svc_decode_nlm4_shareargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 bool nlm4_svc_decode_nlm4_notify(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 
-bool nlm4_svc_encode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 bool nlm4_svc_encode_nlm4_testres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 bool nlm4_svc_encode_nlm4_res(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 bool nlm4_svc_encode_nlm4_shareres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index d104aab0881a..5a70dbe9c6a4 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -1167,8 +1167,8 @@ static __be32 nlm4svc_proc_free_all(struct svc_rqst *rqstp)
 static const struct svc_procedure nlm4svc_procedures[24] = {
 	[NLMPROC4_NULL] = {
 		.pc_func	= nlm4svc_proc_null,
-		.pc_decode	= nlm4_svc_decode_void,
-		.pc_encode	= nlm4_svc_encode_void,
+		.pc_decode	= xdrgen_svc_decode_void,
+		.pc_encode	= xdrgen_svc_encode_void,
 		.pc_argsize	= XDR_void,
 		.pc_argzero	= 0,
 		.pc_ressize	= 0,
@@ -1228,7 +1228,7 @@ static const struct svc_procedure nlm4svc_procedures[24] = {
 	[NLMPROC4_TEST_MSG] = {
 		.pc_func	= nlm4svc_proc_test_msg,
 		.pc_decode	= nlm4_svc_decode_nlm4_testargs,
-		.pc_encode	= nlm4_svc_encode_void,
+		.pc_encode	= xdrgen_svc_encode_void,
 		.pc_argsize	= sizeof(struct nlm4_testargs_wrapper),
 		.pc_argzero	= 0,
 		.pc_ressize	= 0,
@@ -1238,7 +1238,7 @@ static const struct svc_procedure nlm4svc_procedures[24] = {
 	[NLMPROC4_LOCK_MSG] = {
 		.pc_func	= nlm4svc_proc_lock_msg,
 		.pc_decode	= nlm4_svc_decode_nlm4_lockargs,
-		.pc_encode	= nlm4_svc_encode_void,
+		.pc_encode	= xdrgen_svc_encode_void,
 		.pc_argsize	= sizeof(struct nlm4_lockargs_wrapper),
 		.pc_argzero	= 0,
 		.pc_ressize	= 0,
@@ -1248,7 +1248,7 @@ static const struct svc_procedure nlm4svc_procedures[24] = {
 	[NLMPROC4_CANCEL_MSG] = {
 		.pc_func	= nlm4svc_proc_cancel_msg,
 		.pc_decode	= nlm4_svc_decode_nlm4_cancargs,
-		.pc_encode	= nlm4_svc_encode_void,
+		.pc_encode	= xdrgen_svc_encode_void,
 		.pc_argsize	= sizeof(struct nlm4_cancargs_wrapper),
 		.pc_argzero	= 0,
 		.pc_ressize	= 0,
@@ -1258,7 +1258,7 @@ static const struct svc_procedure nlm4svc_procedures[24] = {
 	[NLMPROC4_UNLOCK_MSG] = {
 		.pc_func	= nlm4svc_proc_unlock_msg,
 		.pc_decode	= nlm4_svc_decode_nlm4_unlockargs,
-		.pc_encode	= nlm4_svc_encode_void,
+		.pc_encode	= xdrgen_svc_encode_void,
 		.pc_argsize	= sizeof(struct nlm4_unlockargs_wrapper),
 		.pc_argzero	= 0,
 		.pc_ressize	= 0,
@@ -1268,7 +1268,7 @@ static const struct svc_procedure nlm4svc_procedures[24] = {
 	[NLMPROC4_GRANTED_MSG] = {
 		.pc_func	= nlm4svc_proc_granted_msg,
 		.pc_decode	= nlm4_svc_decode_nlm4_testargs,
-		.pc_encode	= nlm4_svc_encode_void,
+		.pc_encode	= xdrgen_svc_encode_void,
 		.pc_argsize	= sizeof(struct nlm4_testargs_wrapper),
 		.pc_argzero	= 0,
 		.pc_ressize	= 0,
@@ -1278,7 +1278,7 @@ static const struct svc_procedure nlm4svc_procedures[24] = {
 	[NLMPROC4_TEST_RES] = {
 		.pc_func	= nlm4svc_proc_null,
 		.pc_decode	= nlm4_svc_decode_nlm4_testres,
-		.pc_encode	= nlm4_svc_encode_void,
+		.pc_encode	= xdrgen_svc_encode_void,
 		.pc_argsize	= sizeof(struct nlm4_testres),
 		.pc_argzero	= 0,
 		.pc_ressize	= 0,
@@ -1288,7 +1288,7 @@ static const struct svc_procedure nlm4svc_procedures[24] = {
 	[NLMPROC4_LOCK_RES] = {
 		.pc_func	= nlm4svc_proc_null,
 		.pc_decode	= nlm4_svc_decode_nlm4_res,
-		.pc_encode	= nlm4_svc_encode_void,
+		.pc_encode	= xdrgen_svc_encode_void,
 		.pc_argsize	= sizeof(struct nlm4_res),
 		.pc_argzero	= 0,
 		.pc_ressize	= 0,
@@ -1298,7 +1298,7 @@ static const struct svc_procedure nlm4svc_procedures[24] = {
 	[NLMPROC4_CANCEL_RES] = {
 		.pc_func	= nlm4svc_proc_null,
 		.pc_decode	= nlm4_svc_decode_nlm4_res,
-		.pc_encode	= nlm4_svc_encode_void,
+		.pc_encode	= xdrgen_svc_encode_void,
 		.pc_argsize	= sizeof(struct nlm4_res),
 		.pc_argzero	= 0,
 		.pc_ressize	= 0,
@@ -1308,7 +1308,7 @@ static const struct svc_procedure nlm4svc_procedures[24] = {
 	[NLMPROC4_UNLOCK_RES] = {
 		.pc_func	= nlm4svc_proc_null,
 		.pc_decode	= nlm4_svc_decode_nlm4_res,
-		.pc_encode	= nlm4_svc_encode_void,
+		.pc_encode	= xdrgen_svc_encode_void,
 		.pc_argsize	= sizeof(struct nlm4_res),
 		.pc_argzero	= 0,
 		.pc_ressize	= 0,
@@ -1318,7 +1318,7 @@ static const struct svc_procedure nlm4svc_procedures[24] = {
 	[NLMPROC4_GRANTED_RES] = {
 		.pc_func	= nlm4svc_proc_granted_res,
 		.pc_decode	= nlm4_svc_decode_nlm4_res,
-		.pc_encode	= nlm4_svc_encode_void,
+		.pc_encode	= xdrgen_svc_encode_void,
 		.pc_argsize	= sizeof(struct nlm4_res_wrapper),
 		.pc_argzero	= 0,
 		.pc_ressize	= 0,
@@ -1328,7 +1328,7 @@ static const struct svc_procedure nlm4svc_procedures[24] = {
 	[NLMPROC4_SM_NOTIFY] = {
 		.pc_func	= nlm4svc_proc_sm_notify,
 		.pc_decode	= nlm4_svc_decode_nlm4_notifyargs,
-		.pc_encode	= nlm4_svc_encode_void,
+		.pc_encode	= xdrgen_svc_encode_void,
 		.pc_argsize	= sizeof(struct nlm4_notifyargs_wrapper),
 		.pc_argzero	= 0,
 		.pc_ressize	= 0,
@@ -1337,8 +1337,8 @@ static const struct svc_procedure nlm4svc_procedures[24] = {
 	},
 	[17] = {
 		.pc_func	= nlm4svc_proc_unused,
-		.pc_decode	= nlm4_svc_decode_void,
-		.pc_encode	= nlm4_svc_encode_void,
+		.pc_decode	= xdrgen_svc_decode_void,
+		.pc_encode	= xdrgen_svc_encode_void,
 		.pc_argsize	= 0,
 		.pc_argzero	= 0,
 		.pc_ressize	= 0,
@@ -1347,8 +1347,8 @@ static const struct svc_procedure nlm4svc_procedures[24] = {
 	},
 	[18] = {
 		.pc_func	= nlm4svc_proc_unused,
-		.pc_decode	= nlm4_svc_decode_void,
-		.pc_encode	= nlm4_svc_encode_void,
+		.pc_decode	= xdrgen_svc_decode_void,
+		.pc_encode	= xdrgen_svc_encode_void,
 		.pc_argsize	= 0,
 		.pc_argzero	= 0,
 		.pc_ressize	= 0,
@@ -1357,8 +1357,8 @@ static const struct svc_procedure nlm4svc_procedures[24] = {
 	},
 	[19] = {
 		.pc_func	= nlm4svc_proc_unused,
-		.pc_decode	= nlm4_svc_decode_void,
-		.pc_encode	= nlm4_svc_encode_void,
+		.pc_decode	= xdrgen_svc_decode_void,
+		.pc_encode	= xdrgen_svc_encode_void,
 		.pc_argsize	= 0,
 		.pc_argzero	= 0,
 		.pc_ressize	= 0,
@@ -1398,7 +1398,7 @@ static const struct svc_procedure nlm4svc_procedures[24] = {
 	[NLMPROC4_FREE_ALL] = {
 		.pc_func	= nlm4svc_proc_free_all,
 		.pc_decode	= nlm4_svc_decode_nlm4_notify,
-		.pc_encode	= nlm4_svc_encode_void,
+		.pc_encode	= xdrgen_svc_encode_void,
 		.pc_argsize	= sizeof(struct nlm4_notify_wrapper),
 		.pc_argzero	= 0,
 		.pc_ressize	= 0,
diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index a1f9d66c2981..7ba628939cff 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -1176,8 +1176,8 @@ static __be32 nlmsvc_proc_free_all(struct svc_rqst *rqstp)
 static const struct svc_procedure nlmsvc_procedures[24] = {
 	[NLM_NULL] = {
 		.pc_func	= nlmsvc_proc_null,
-		.pc_decode	= nlm_svc_decode_void,
-		.pc_encode	= nlm_svc_encode_void,
+		.pc_decode	= xdrgen_svc_decode_void,
+		.pc_encode	= xdrgen_svc_encode_void,
 		.pc_argsize	= XDR_void,
 		.pc_argzero	= 0,
 		.pc_ressize	= 0,
@@ -1237,7 +1237,7 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
 	[NLM_TEST_MSG] = {
 		.pc_func	= nlmsvc_proc_test_msg,
 		.pc_decode	= nlm_svc_decode_nlm_testargs,
-		.pc_encode	= nlm_svc_encode_void,
+		.pc_encode	= xdrgen_svc_encode_void,
 		.pc_argsize	= sizeof(struct nlm_testargs_wrapper),
 		.pc_argzero	= 0,
 		.pc_ressize	= 0,
@@ -1247,7 +1247,7 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
 	[NLM_LOCK_MSG] = {
 		.pc_func	= nlmsvc_proc_lock_msg,
 		.pc_decode	= nlm_svc_decode_nlm_lockargs,
-		.pc_encode	= nlm_svc_encode_void,
+		.pc_encode	= xdrgen_svc_encode_void,
 		.pc_argsize	= sizeof(struct nlm_lockargs_wrapper),
 		.pc_argzero	= 0,
 		.pc_ressize	= 0,
@@ -1257,7 +1257,7 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
 	[NLM_CANCEL_MSG] = {
 		.pc_func	= nlmsvc_proc_cancel_msg,
 		.pc_decode	= nlm_svc_decode_nlm_cancargs,
-		.pc_encode	= nlm_svc_encode_void,
+		.pc_encode	= xdrgen_svc_encode_void,
 		.pc_argsize	= sizeof(struct nlm_cancargs_wrapper),
 		.pc_argzero	= 0,
 		.pc_ressize	= 0,
@@ -1267,7 +1267,7 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
 	[NLM_UNLOCK_MSG] = {
 		.pc_func	= nlmsvc_proc_unlock_msg,
 		.pc_decode	= nlm_svc_decode_nlm_unlockargs,
-		.pc_encode	= nlm_svc_encode_void,
+		.pc_encode	= xdrgen_svc_encode_void,
 		.pc_argsize	= sizeof(struct nlm_unlockargs_wrapper),
 		.pc_argzero	= 0,
 		.pc_ressize	= 0,
@@ -1277,7 +1277,7 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
 	[NLM_GRANTED_MSG] = {
 		.pc_func	= nlmsvc_proc_granted_msg,
 		.pc_decode	= nlm_svc_decode_nlm_testargs,
-		.pc_encode	= nlm_svc_encode_void,
+		.pc_encode	= xdrgen_svc_encode_void,
 		.pc_argsize	= sizeof(struct nlm_testargs_wrapper),
 		.pc_argzero	= 0,
 		.pc_ressize	= 0,
@@ -1287,7 +1287,7 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
 	[NLM_TEST_RES] = {
 		.pc_func	= nlmsvc_proc_null,
 		.pc_decode	= nlm_svc_decode_nlm_testres,
-		.pc_encode	= nlm_svc_encode_void,
+		.pc_encode	= xdrgen_svc_encode_void,
 		.pc_argsize	= sizeof(struct nlm_testres),
 		.pc_argzero	= 0,
 		.pc_ressize	= 0,
@@ -1297,7 +1297,7 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
 	[NLM_LOCK_RES] = {
 		.pc_func	= nlmsvc_proc_null,
 		.pc_decode	= nlm_svc_decode_nlm_res,
-		.pc_encode	= nlm_svc_encode_void,
+		.pc_encode	= xdrgen_svc_encode_void,
 		.pc_argsize	= sizeof(struct nlm_res),
 		.pc_argzero	= 0,
 		.pc_ressize	= 0,
@@ -1307,7 +1307,7 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
 	[NLM_CANCEL_RES] = {
 		.pc_func	= nlmsvc_proc_null,
 		.pc_decode	= nlm_svc_decode_nlm_res,
-		.pc_encode	= nlm_svc_encode_void,
+		.pc_encode	= xdrgen_svc_encode_void,
 		.pc_argsize	= sizeof(struct nlm_res),
 		.pc_argzero	= 0,
 		.pc_ressize	= 0,
@@ -1317,7 +1317,7 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
 	[NLM_UNLOCK_RES] = {
 		.pc_func	= nlmsvc_proc_null,
 		.pc_decode	= nlm_svc_decode_nlm_res,
-		.pc_encode	= nlm_svc_encode_void,
+		.pc_encode	= xdrgen_svc_encode_void,
 		.pc_argsize	= sizeof(struct nlm_res),
 		.pc_argzero	= 0,
 		.pc_ressize	= 0,
@@ -1327,7 +1327,7 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
 	[NLM_GRANTED_RES] = {
 		.pc_func	= nlmsvc_proc_granted_res,
 		.pc_decode	= nlm_svc_decode_nlm_res,
-		.pc_encode	= nlm_svc_encode_void,
+		.pc_encode	= xdrgen_svc_encode_void,
 		.pc_argsize	= sizeof(struct nlm_res_wrapper),
 		.pc_argzero	= 0,
 		.pc_ressize	= 0,
@@ -1337,7 +1337,7 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
 	[NLM_SM_NOTIFY] = {
 		.pc_func	= nlmsvc_proc_sm_notify,
 		.pc_decode	= nlm_svc_decode_nlm_notifyargs,
-		.pc_encode	= nlm_svc_encode_void,
+		.pc_encode	= xdrgen_svc_encode_void,
 		.pc_argsize	= sizeof(struct nlm_notifyargs_wrapper),
 		.pc_argzero	= 0,
 		.pc_ressize	= 0,
@@ -1346,8 +1346,8 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
 	},
 	[17] = {
 		.pc_func	= nlmsvc_proc_unused,
-		.pc_decode	= nlm_svc_decode_void,
-		.pc_encode	= nlm_svc_encode_void,
+		.pc_decode	= xdrgen_svc_decode_void,
+		.pc_encode	= xdrgen_svc_encode_void,
 		.pc_argsize	= 0,
 		.pc_argzero	= 0,
 		.pc_ressize	= 0,
@@ -1356,8 +1356,8 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
 	},
 	[18] = {
 		.pc_func	= nlmsvc_proc_unused,
-		.pc_decode	= nlm_svc_decode_void,
-		.pc_encode	= nlm_svc_encode_void,
+		.pc_decode	= xdrgen_svc_decode_void,
+		.pc_encode	= xdrgen_svc_encode_void,
 		.pc_argsize	= 0,
 		.pc_argzero	= 0,
 		.pc_ressize	= 0,
@@ -1366,8 +1366,8 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
 	},
 	[19] = {
 		.pc_func	= nlmsvc_proc_unused,
-		.pc_decode	= nlm_svc_decode_void,
-		.pc_encode	= nlm_svc_encode_void,
+		.pc_decode	= xdrgen_svc_decode_void,
+		.pc_encode	= xdrgen_svc_encode_void,
 		.pc_argsize	= 0,
 		.pc_argzero	= 0,
 		.pc_ressize	= 0,
@@ -1407,7 +1407,7 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
 	[NLM_FREE_ALL] = {
 		.pc_func	= nlmsvc_proc_free_all,
 		.pc_decode	= nlm_svc_decode_nlm_notify,
-		.pc_encode	= nlm_svc_encode_void,
+		.pc_encode	= xdrgen_svc_encode_void,
 		.pc_argsize	= sizeof(struct nlm_notify_wrapper),
 		.pc_argzero	= 0,
 		.pc_ressize	= 0,
diff --git a/include/linux/sunrpc/xdrgen/_builtins.h b/include/linux/sunrpc/xdrgen/_builtins.h
index a723fb1da9c8..c9033eb1c829 100644
--- a/include/linux/sunrpc/xdrgen/_builtins.h
+++ b/include/linux/sunrpc/xdrgen/_builtins.h
@@ -296,4 +296,36 @@ xdrgen_encode_opaque(struct xdr_stream *xdr, opaque val)
 	return true;
 }
 
+struct svc_rqst;
+
+/**
+ * xdrgen_svc_decode_void - Decode a void argument
+ * @rqstp: RPC transaction context
+ * @xdr: source XDR data stream
+ *
+ * Return values:
+ *   %true: procedure arguments decoded successfully
+ *   %false: decode failed
+ */
+static inline bool
+xdrgen_svc_decode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr)
+{
+	return xdrgen_decode_void(xdr);
+}
+
+/**
+ * xdrgen_svc_encode_void - Encode a void result
+ * @rqstp: RPC transaction context
+ * @xdr: target XDR data stream
+ *
+ * Return values:
+ *   %true: procedure results encoded successfully
+ *   %false: encode failed
+ */
+static inline bool
+xdrgen_svc_encode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr)
+{
+	return xdrgen_encode_void(xdr);
+}
+
 #endif /* _SUNRPC_XDRGEN__BUILTINS_H_ */
diff --git a/tools/net/sunrpc/xdrgen/generators/program.py b/tools/net/sunrpc/xdrgen/generators/program.py
index c0cb3f6d3319..37f9655c83fe 100644
--- a/tools/net/sunrpc/xdrgen/generators/program.py
+++ b/tools/net/sunrpc/xdrgen/generators/program.py
@@ -38,6 +38,8 @@ def emit_version_declarations(
     arguments = dict.fromkeys([])
     for procedure in version.procedures:
         if procedure.name not in excluded_apis:
+            if procedure.argument.type_name == "void":
+                continue
             arguments[procedure.argument.type_name] = None
     if len(arguments) > 0:
         print("")
@@ -48,6 +50,8 @@ def emit_version_declarations(
     results = dict.fromkeys([])
     for procedure in version.procedures:
         if procedure.name not in excluded_apis:
+            if procedure.result.type_name == "void":
+                continue
             results[procedure.result.type_name] = None
     if len(results) > 0:
         print("")
@@ -63,6 +67,8 @@ def emit_version_argument_decoders(
     arguments = dict.fromkeys([])
     for procedure in version.procedures:
         if procedure.name not in excluded_apis:
+            if procedure.argument.type_name == "void":
+                continue
             arguments[procedure.argument.type_name] = None
 
     template = environment.get_template("decoder/argument.j2")
@@ -105,6 +111,8 @@ def emit_version_result_encoders(
     results = dict.fromkeys([])
     for procedure in version.procedures:
         if procedure.name not in excluded_apis:
+            if procedure.result.type_name == "void":
+                continue
             results[procedure.result.type_name] = None
 
     template = environment.get_template("encoder/result.j2")
diff --git a/tools/net/sunrpc/xdrgen/templates/C/program/decoder/argument.j2 b/tools/net/sunrpc/xdrgen/templates/C/program/decoder/argument.j2
index 19b219dd276d..096d553b2a1e 100644
--- a/tools/net/sunrpc/xdrgen/templates/C/program/decoder/argument.j2
+++ b/tools/net/sunrpc/xdrgen/templates/C/program/decoder/argument.j2
@@ -11,9 +11,6 @@
  */
 bool {{ program }}_svc_decode_{{ argument }}(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-{% if argument == 'void' %}
-	return xdrgen_decode_void(xdr);
-{% else %}
 {% if argument in structs %}
 	struct {{ argument }} *argp = rqstp->rq_argp;
 {% else %}
@@ -21,5 +18,4 @@ bool {{ program }}_svc_decode_{{ argument }}(struct svc_rqst *rqstp, struct xdr_
 {% endif %}
 
 	return xdrgen_decode_{{ argument }}(xdr, argp);
-{% endif %}
 }
diff --git a/tools/net/sunrpc/xdrgen/templates/C/program/encoder/result.j2 b/tools/net/sunrpc/xdrgen/templates/C/program/encoder/result.j2
index 746592cfda56..4243d91966fd 100644
--- a/tools/net/sunrpc/xdrgen/templates/C/program/encoder/result.j2
+++ b/tools/net/sunrpc/xdrgen/templates/C/program/encoder/result.j2
@@ -11,9 +11,6 @@
  */
 bool {{ program }}_svc_encode_{{ result }}(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-{% if result == 'void' %}
-	return xdrgen_encode_void(xdr);
-{% else %}
 {% if result in structs %}
 	struct {{ result }} *resp = rqstp->rq_resp;
 
@@ -23,5 +20,4 @@ bool {{ program }}_svc_encode_{{ result }}(struct svc_rqst *rqstp, struct xdr_st
 
 	return xdrgen_encode_{{ result }}(xdr, *resp);
 {% endif %}
-{% endif %}
 }
-- 
2.54.0


