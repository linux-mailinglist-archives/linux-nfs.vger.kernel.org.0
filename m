Return-Path: <linux-nfs+bounces-21553-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEiMLBNwA2p15wEAu9opvQ
	(envelope-from <linux-nfs+bounces-21553-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:23:15 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5088F52777D
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F167031236D3
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 18:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F327E36C5A1;
	Tue, 12 May 2026 18:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jii3+NFA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA5336AB5B
	for <linux-nfs@vger.kernel.org>; Tue, 12 May 2026 18:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609651; cv=none; b=ZAwCpOHdF3Z6Mjx309KWMf9L7FaJEsSu1NMxluSAxTYNrCXduX4SQqmojx3035io3SXwuZKoRLeiiCQEDRq+VQt1oWVH2Gr+6jIjoktvNLVj4hGx4PlTECsPd6aMsIMc3JnRIstw0/k/kJyD45A/VG5hkIf/u3Sf6qPXh57jcQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609651; c=relaxed/simple;
	bh=88P4gT9MDn2vOLt8DJxhaEjW8pSrufSXPZSDqHS2zVk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qrGXuZyDcHhzhc9Yil/UF/ku73ju7aivVCFObNSwBZSEBOtxYhlFA6D8olSHW1DChF9cNO4f/5UMRhBMGNLF6qxz3GdYhCmI5xxIaYqmYXS/vOIs+S7RNjZ8F8syyQXt3SdDEnNlL0RjeqHPgTlaeOrBMT8IatUYnn1KXqWuuUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jii3+NFA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1358CC2BCF6;
	Tue, 12 May 2026 18:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778609651;
	bh=88P4gT9MDn2vOLt8DJxhaEjW8pSrufSXPZSDqHS2zVk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jii3+NFAN5EaJ7T1nS3zIh8+qUAEc9aCx2kdfYLFzK93B7j5ZyH2SCH/5N+PuKxhv
	 r11QEGEUWGBtyY94dYIPSzckdAhcI598TdyeGUF4NAARisLSPC8c6qSnzwZVC6Ix3Y
	 395X57a0m3OmOA81Mq3UWdqxl5rpL6++3UereHL+XnI9ky4J5YauwRE+6XK6D5Qq07
	 K19SUE7Zgj/NWV9fpi7FZaZMdO91lx0tSeX40iAR+P3iuPdM7wHgrCTVN4B3km6+LK
	 ALMJRac3yqAJW6eq8Q313IPBnHVuiccqnlM+XAZ2MS4JSfsNtHSIEBq9R1fPGj43F3
	 +1w42ujdNocPw==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 12 May 2026 14:13:48 -0400
Subject: [PATCH 13/38] lockd: Use xdrgen XDR functions for the NLMv3 NULL
 procedure
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-nlm4-xdrgen-v1-13-19d99b2634b4@oracle.com>
References: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
In-Reply-To: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=2743;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=+d7PMGXUXtRg/fA7/ylfzF6OLEq52Rtr7S9SnoQlY0E=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqA23kU/Qw1RpNsMnpUzo4I2TUKlfp138wCiVJu
 lw2RsTRIMGJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCagNt5AAKCRAzarMzb2Z/
 l3aiD/wL6gS2qUnKL5lOBGewwYLPD4RLOcnjdUu5fO/4il4uMHhP+vCijoAJPL6GSGGAeUy8x0o
 Z61MPmiiVVZHFv2QTmFts6Hk80gSK/nrvxpvpXUmHMoPbQucZ36YU73wh6q681ufMYWcwEJZbtZ
 fDtacGle1IGr1KtkEPcoVQD23b9jVNiSRfv06QRZkz/fP+tmNFbZ0TaMxa88R+bif41uA19x2ic
 xrXIN7BGjTudNq+5Wa9LHFVD7WLry1Cz7IQkOnFNqfHvaL9ZtQk4Xt7LnTEymHWH+kmRZiwTA4/
 v7+dIVaZ3VEG2KDrxYspsDiNXTdswtpEkqhvfr09EoRZwvkZacqo8WJ8emt3IE0we13zy4fbwRk
 dBjzIjBgNH7GDl93ojs+ZsC9ypGO1reK0dq7gs8Mn7JuesUEovvWp8IKCB4ulVst893bNH8Ma6i
 8Y2leR1kvmjKnqEol+O8bHtiKCzUsvOD0jKwWNh6jOWLjvstFQu4oLjz3waU8AY4f7v110EmzqO
 DbBhrBsHb3be9d9y7aH0yLJdOgwjOnY0w+RnsAcparc47pTVkOwbQfBHYnbuEmo2ZfHlMbIzjHZ
 kIC7gFXjzMoHetoeBIhIJ8U1tZ6mCJfdERaeYaM7Y6twlrkcb4GeF96XG9oWYFTbbJUsaS3p2fa
 TxNm3Aj6vLY4ukQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 5088F52777D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21553-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Hand-written XDR encoders and decoders are difficult to maintain
and can diverge from protocol specifications. Migrating to
xdrgen-generated code improves type safety and ensures the
implementation matches the NLM version 3 protocol specification
exactly.

Convert the NULL procedure to use nlm_svc_decode_void and
nlm_svc_encode_void, generated from
Documentation/sunrpc/xdr/nlm3.x. NULL has no arguments or
results, so it is the first procedure converted.

NULL returns no XDR-encoded data, so pc_xdrressize is set to
XDR_void. The argzero field is also set to zero since xdrgen
decoders initialize all decoded values.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svcproc.c | 42 ++++++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index a79c9a46db60..ad37f3611eea 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -13,7 +13,16 @@
 #include <linux/sunrpc/svc_xprt.h>
 
 #include "lockd.h"
+
+/*
+ * xdr.h defines SM_PRIV_SIZE as a macro. nlm3xdr_gen.h defines
+ * it as an enum constant. Undefine the macro before including
+ * the generated header.
+ */
+#undef SM_PRIV_SIZE
+
 #include "share.h"
+#include "nlm3xdr_gen.h"
 
 #define NLMDBG_FACILITY		NLMDBG_CLIENT
 
@@ -120,13 +129,18 @@ nlmsvc_retrieve_args(struct svc_rqst *rqstp, struct lockd_args *argp,
 	return nlm_lck_denied_nolocks;
 }
 
-/*
- * NULL: Test for presence of service
+/**
+ * nlmsvc_proc_null - NULL: Test for presence of service
+ * @rqstp: RPC transaction context
+ *
+ * Return:
+ *   %rpc_success:		RPC executed successfully
+ *
+ * RPC synopsis:
+ *   void NLM_NULL(void) = 0;
  */
-static __be32
-nlmsvc_proc_null(struct svc_rqst *rqstp)
+static __be32 nlmsvc_proc_null(struct svc_rqst *rqstp)
 {
-	dprintk("lockd: NULL          called\n");
 	return rpc_success;
 }
 
@@ -568,15 +582,15 @@ struct nlm_void			{ int dummy; };
 #define	Rg	2				/* range - offset + size */
 
 static const struct svc_procedure nlmsvc_procedures[24] = {
-	[NLMPROC_NULL] = {
-		.pc_func = nlmsvc_proc_null,
-		.pc_decode = nlmsvc_decode_void,
-		.pc_encode = nlmsvc_encode_void,
-		.pc_argsize = sizeof(struct nlm_void),
-		.pc_argzero = sizeof(struct nlm_void),
-		.pc_ressize = sizeof(struct nlm_void),
-		.pc_xdrressize = St,
-		.pc_name = "NULL",
+	[NLM_NULL] = {
+		.pc_func	= nlmsvc_proc_null,
+		.pc_decode	= nlm_svc_decode_void,
+		.pc_encode	= nlm_svc_encode_void,
+		.pc_argsize	= XDR_void,
+		.pc_argzero	= 0,
+		.pc_ressize	= 0,
+		.pc_xdrressize	= XDR_void,
+		.pc_name	= "NULL",
 	},
 	[NLMPROC_TEST] = {
 		.pc_func = nlmsvc_proc_test,

-- 
2.54.0


