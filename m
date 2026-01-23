Return-Path: <linux-nfs+bounces-18376-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKBFF9XDc2kCygAAu9opvQ
	(envelope-from <linux-nfs+bounces-18376-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 19:54:13 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F0ACF79D48
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 19:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F3C7B3042D54
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 18:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D5B23182D;
	Fri, 23 Jan 2026 18:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxCVwJlG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD8523C4E9
	for <linux-nfs@vger.kernel.org>; Fri, 23 Jan 2026 18:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769194395; cv=none; b=XKNlpMyqNVBRqxc9ESWxTGtReccJXk+7Km8mJaD5Q6TtAQyUhdP82soQy7I3lk/pFYaLp2U6etMJGWu0/I/Yden9CJfM+SXyGvgQaoglOIFC+K997EJQ33/1CeDIEQBIQWBxOIiuKGasYJPnZTqgN9lHIw9oedNj9y7hxiiJwDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769194395; c=relaxed/simple;
	bh=bKzq/R8dyDtvSbPpQ7ca4bsqQzTXq7nqO0b+vpvDOrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qXUDvLv+KHohvze/FXS4qPW33g66MWhAwMR3jFTRegvUdunv9YMRKLJDoBu/OdJkzsecojjtzWduO+KoBnEJsOD8Dj7MKvP/12k0BN1jzL0FItvLyJWuAgwY4wVqoZkxviMdoV1DLL9M3i3HNQJSj9IU7g8eqGO5ei2x/KSpM4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxCVwJlG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89EA3C4CEF1;
	Fri, 23 Jan 2026 18:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769194395;
	bh=bKzq/R8dyDtvSbPpQ7ca4bsqQzTXq7nqO0b+vpvDOrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BxCVwJlGqbxpLGO+pZMTbmOd00kAw4IS5m3jOnvPMRJbYkRpcnvQEcYBliD4SQdvW
	 EDoEsm5narr2z7w/rhQ7Lt/Xcpt/ZYOv3pkW9kL4SjrWThOy2cMzauLBMw2k5rZALp
	 1/qWezQrWrhNOALv96r162YcgZHavfRibSDUv2/PZ8tCOh+DsnUW+YmoCExDpvSHe6
	 7bkQSDFl9PCXdQHlneOg6npK3Ia0dU7CJ2xkTGbv10sal2o9bKmyIjW3KoGad9/oV4
	 kJXFK3QAarMEpiwSGS9Oq0xjOnf/cvlpppCPtFy8uYxzygLqho1a1le+EHTNRD1wtP
	 SbZ0/ILeqd3QA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 15/42] lockd: Use xdrgen XDR functions for the NLMv4 NULL procedure
Date: Fri, 23 Jan 2026 13:52:32 -0500
Message-ID: <20260123185259.1215767-16-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18376-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: F0ACF79D48
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

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c | 40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 0f31fec178c8..28b2e35a1e8c 100644
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
@@ -87,13 +97,19 @@ nlm4svc_retrieve_args(struct svc_rqst *rqstp, struct nlm_args *argp,
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
 
@@ -520,15 +536,15 @@ struct nlm_void			{ int dummy; };
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
2.52.0


