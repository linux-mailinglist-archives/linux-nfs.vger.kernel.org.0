Return-Path: <linux-nfs+bounces-18985-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oE88EP7mlGmjIgIAu9opvQ
	(envelope-from <linux-nfs+bounces-18985-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 23:09:02 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC401514FC
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 23:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D99F3058DFE
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 22:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1C4313E0F;
	Tue, 17 Feb 2026 22:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KtsLt7CJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E65313276
	for <linux-nfs@vger.kernel.org>; Tue, 17 Feb 2026 22:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771366048; cv=none; b=ESLo3vesGIndnn29dhK58U9q9gz4aDiClx5QCgng4o0nZHGXUM6b+gSz1g+B9p9hJ0Ng6VPpl/mru7wONQawjTEVd47bNdIjg6GtTgeE/9LpuRY2Twg4isWARCfgIZX2RTc2CrgU2w4eW+z0Ug0VB4Fhu8SatwuQos9fGH7gwBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771366048; c=relaxed/simple;
	bh=RBYmr+Qyr4dtDFyVnvUZeLWW6wzTrWwBev+sp69RFFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Os479OTwCTsj0flPEyGeUQsR1DCADA+kowsRRhUuX45tdo3Tl58jwc8X+0NNXOgC612qc7ND6zeHUx3/uQVD2sP3Y+mHwK39B0OwAiQ2JjnI8bf4eF2DFdjmSSl99Poa5ac5erQGRcTDHYlTRnlh+66/kth9xvZ2uDZcmQ3cWug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KtsLt7CJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71277C4CEF7;
	Tue, 17 Feb 2026 22:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771366048;
	bh=RBYmr+Qyr4dtDFyVnvUZeLWW6wzTrWwBev+sp69RFFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KtsLt7CJHuX7AqL2toia85qZeVXDOqdhbZnLWpmBtCgvSUnIilWbQ8UlOPKSnBo5L
	 IT/GglApyXZsBcTKcAlGYB7CeDMcI//TjWn69E5ybAuLs5fpcsNJYXVo9hqcR7AYFi
	 rf98DjBxv1gIC34Lt/+MXs53nlc7kqcKH2LdLBHXJQjp/dCcHexMI3ME19DAVIx4XF
	 jSpJkWMMmktzD3BQAqFW6r831V1fTaoZbepN6XVXnYVydaySpb2bxNSzI41qV3kXSY
	 j1nl5b/E2Y0aDg0MEgHD9apwfsnPTn60vDJOE0ytKgie9AF96e7cchE1boTlgIFTVL
	 DQLUM73Bct2BA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 02/29] lockd: Use xdrgen XDR functions for the NLMv4 NULL procedure
Date: Tue, 17 Feb 2026 17:06:54 -0500
Message-ID: <20260217220721.1928847-3-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260217220721.1928847-1-cel@kernel.org>
References: <20260217220721.1928847-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	TAGGED_FROM(0.00)[bounces-18985-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9AC401514FC
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Hand-written XDR encoders and decoders are difficult to maintain
and can inadvertently diverge from protocol specifications. By
migrating to xdrgen-generated code, we improve type safety and
ensure the implementation exactly matches the NLM version 4
protocol specification.

This patch begins the migration by converting the NULL procedure
to use nlm4_svc_decode_void and nlm4_svc_encode_void generated
from Documentation/sunrpc/xdr/nlm4.x. The NULL procedure is
straightforward as it has no arguments or results, making it an
ideal starting point for this series.

The pc_xdrressize field is set to XDR_void (zero) to reflect
that this procedure returns no XDR-encoded data. The argzero
field is also set to zero since xdrgen decoders reliably
initialize all decoded values.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c | 40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index c99f192bce77..4fcd66beb4df 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -13,7 +13,17 @@
 #include <linux/sunrpc/svc_xprt.h>
 
 #include "lockd.h"
+
+/*
+ * xdr.h defines SM_MAXSTRLEN and SM_PRIV_SIZE as macros.
+ * nlm4xdr_gen.h defines them as enum constants. Undefine the
+ * macros to allow the xdrgen enum definitions to be used.
+ */
+#undef SM_MAXSTRLEN
+#undef SM_PRIV_SIZE
+
 #include "share.h"
+#include "nlm4xdr_gen.h"
 #include "xdr4.h"
 
 #define NLMDBG_FACILITY		NLMDBG_CLIENT
@@ -92,13 +102,19 @@ nlm4svc_retrieve_args(struct svc_rqst *rqstp, struct nlm_args *argp,
 	}
 }
 
-/*
- * NULL: Test for presence of service
+/**
+ * nlm4svc_proc_null - NULL: Test for presence of service
+ * @rqstp: RPC transaction context
+ *
+ * Returns:
+ *   %rpc_success:		RPC executed successfully
+ *
+ * RPC synopsis:
+ *   void NLMPROC4_NULL(void) = 0;
  */
 static __be32
 nlm4svc_proc_null(struct svc_rqst *rqstp)
 {
-	dprintk("lockd: NULL          called\n");
 	return rpc_success;
 }
 
@@ -531,15 +547,15 @@ struct nlm_void			{ int dummy; };
 #define	Rg	4					/* range (offset + length) */
 
 static const struct svc_procedure nlm4svc_procedures[24] = {
-	[NLMPROC_NULL] = {
-		.pc_func = nlm4svc_proc_null,
-		.pc_decode = nlm4svc_decode_void,
-		.pc_encode = nlm4svc_encode_void,
-		.pc_argsize = sizeof(struct nlm_void),
-		.pc_argzero = sizeof(struct nlm_void),
-		.pc_ressize = sizeof(struct nlm_void),
-		.pc_xdrressize = St,
-		.pc_name = "NULL",
+	[NLMPROC4_NULL] = {
+		.pc_func	= nlm4svc_proc_null,
+		.pc_decode	= nlm4_svc_decode_void,
+		.pc_encode	= nlm4_svc_encode_void,
+		.pc_argsize	= XDR_void,
+		.pc_argzero	= 0,
+		.pc_ressize	= 0,
+		.pc_xdrressize	= XDR_void,
+		.pc_name	= "NULL",
 	},
 	[NLMPROC_TEST] = {
 		.pc_func = nlm4svc_proc_test,
-- 
2.53.0


