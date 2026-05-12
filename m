Return-Path: <linux-nfs+bounces-21567-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMXbE/dxA2rH5wEAu9opvQ
	(envelope-from <linux-nfs+bounces-21567-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:31:19 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A7D527B0D
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC8233305D35
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 18:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348F237997E;
	Tue, 12 May 2026 18:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UB8Bxh9t"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EC4371D10
	for <linux-nfs@vger.kernel.org>; Tue, 12 May 2026 18:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609664; cv=none; b=JsBgESOeHXWsINDZJaRVcoohKG6ViPc6kj7XL9YfkuAXbuB0CICYT9rlobbF3R5JTuvXGIm8Z8Utzsz1Twa5CVrSR9b6Ih27q5CwP1smB7LdpVB0eeGhOVpB6uWQ102sC61GR9B/rOAylGB3JIy14D+ePpIP9KSX3HFO70YY6Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609664; c=relaxed/simple;
	bh=4kzgLPhpnjk/Gf1le2k2SBCMThlve08pcyuN4hRn2EE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KakrpwCtWPBM8Z3LAAv14ZzJPKsxq3enSGfy8lKFuJv6L7Xb2zev4kyS3FODckimn72eU/TWNYCdcLkDQRetubRpAmMh+pOnhajcbWOHlD1bv2JygzQAI4cQxGFqXijiCmuEWvMYcWR+toO+v6vFHzWA64KGHb3/g1EXHaZ66Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UB8Bxh9t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D8DEC2BCC7;
	Tue, 12 May 2026 18:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778609664;
	bh=4kzgLPhpnjk/Gf1le2k2SBCMThlve08pcyuN4hRn2EE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UB8Bxh9tb0E677tNQnIA2/pBOxBtK6UUr9BA6UaHQG/qLw0QB1ZxP6hT/cKyRAwoF
	 OFYj4hkzTKDNSb22owNJSqQcDVaVaaSWw2hOcrA14Qijy/F2PLooL8/1OQLcwWpfci
	 E8bmsicEePSdPc3u4jF3Ur7udn33tE54FmWWdbrHv9E79EXqj13yZttHpaiucsJA+X
	 m8EvpEKb8dE0zgMBEHVUZZ341iUjFrjHOY0yIj2zGbcIimB1/PISrIoDRPj7Nyolcs
	 iPgYhhjAIfg3JqtS8MVRBEXc1CZiEhP+QCS6KmXmk5Nu0ZFZIJ971ec+5LPgd1uz+Z
	 X6KO5fMX0zBww==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 12 May 2026 14:14:02 -0400
Subject: [PATCH 27/38] lockd: Use xdrgen XDR functions for the NLMv3
 CANCEL_RES procedure
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-nlm4-xdrgen-v1-27-19d99b2634b4@oracle.com>
References: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
In-Reply-To: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=1790;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=xfs2k6XvoF7R3VuszwAJCe/8/GlTQTLz1auMsq94+j4=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqA23mu0pmkYX6oA0UWI+PqwtuzNrA5I5c4tsiS
 yR7URfFfqSJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCagNt5gAKCRAzarMzb2Z/
 l79bD/0f0XvLJtRWb49Lv0sRYKUCGtHLakpgX9uBxFlF0bPfkTL9a0+bwoAIORr+82fWHhpX5ES
 O4kkflQKXC4YTrNpH8RAPboyhFcGJOegyqPSgyyG2oahe+jKmMq5Gkc7iKXhi/6nUNmstADyCIp
 89gNN+pt3XeoeW95dpTwUPlpWxBmgw8hB9G2CG90SUFt4a0G2Pv5B4XGBUiUMrwET2JTkhnyRn3
 I8hQ4kmUMamPxNs//HPiPVjA/TFInUpOehjOme892uVGYzQeRX1uiVCZjrjPkLVNcq0TsW7sWW7
 G8zAvBQ0zNz6ivDKb9y3iJn5BsCfl8s6MLrFT5YXHrQh5lZNJBMEjOR9gzklDk66tZF4iGT2a48
 09P4QcCP7COdyuKeSAtFBW9rtS22tRYDHG/XtAD3KCfRspXWXVTYiiXbdTSckwpv8lQi38IHhvd
 raopECrFxsEaMKIJd/aoSqY01ydig4h9WOJHmQTSXocBz15nnlLVsX+zY+SOY4kYOkGGxZ45FFI
 B50b1B9lQxuy2Tjb8g66CJmFA/mrKMSkNJObO0NuVI/ZlHAZdxtZ42hAxKg/+p3DhuTzSWDZ25k
 2UmiZkYxV0mb3zL0JbfZj4+Mznz26J2FBqoWWXMHnj9MI0Cnwk8gQbxqyNb4SGFMLpUdaPKmOKT
 6nOWdQXnfqloWZA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: D5A7D527B0D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21567-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Continue the xdrgen migration by converting NLMv3 CANCEL_RES,
the callback that a remote NLM uses to return async CANCEL
results to this lockd.  The procedure now uses
nlm_svc_decode_nlm_res and nlm_svc_encode_void, generated
from the NLM version 3 protocol specification.

Setting pc_argzero to zero is safe because the generated
decoder fills the argp->xdrgen subfields before the procedure
runs, so the zeroing memset performed by the dispatch layer
is no longer needed.

Setting pc_xdrressize to XDR_void reflects that CANCEL_RES, as
a callback, returns no data; the previous value of St
over-reserved a status word in the reply buffer.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svcproc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index c86ba0b94793..e7d399afbe83 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -1290,15 +1290,15 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_xdrressize	= XDR_void,
 		.pc_name	= "LOCK_RES",
 	},
-	[NLMPROC_CANCEL_RES] = {
-		.pc_func = nlmsvc_proc_null,
-		.pc_decode = nlmsvc_decode_void,
-		.pc_encode = nlmsvc_encode_void,
-		.pc_argsize = sizeof(struct lockd_res),
-		.pc_argzero = sizeof(struct lockd_res),
-		.pc_ressize = sizeof(struct nlm_void),
-		.pc_xdrressize = St,
-		.pc_name = "CANCEL_RES",
+	[NLM_CANCEL_RES] = {
+		.pc_func	= nlmsvc_proc_null,
+		.pc_decode	= nlm_svc_decode_nlm_res,
+		.pc_encode	= nlm_svc_encode_void,
+		.pc_argsize	= sizeof(struct nlm_res),
+		.pc_argzero	= 0,
+		.pc_ressize	= 0,
+		.pc_xdrressize	= XDR_void,
+		.pc_name	= "CANCEL_RES",
 	},
 	[NLMPROC_UNLOCK_RES] = {
 		.pc_func = nlmsvc_proc_null,

-- 
2.54.0


