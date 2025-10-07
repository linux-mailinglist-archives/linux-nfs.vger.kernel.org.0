Return-Path: <linux-nfs+bounces-15027-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA836BC2080
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Oct 2025 18:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A04D419A2E11
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Oct 2025 16:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5AF2E764C;
	Tue,  7 Oct 2025 16:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYcImu3a"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878C22E7177
	for <linux-nfs@vger.kernel.org>; Tue,  7 Oct 2025 16:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759853062; cv=none; b=o6YskIU+jnWzf3z4vbABfG1aZq7Um3z36rNjEjId/acMNyJqA9QVQDGWNPExMhOUSnaDncCzCAilsAd07Fdk0T/mNHcpwHBrvspSMQNAa5n+qs74uP1sNEnAP11Ne+Up4WTiyx95Btxp1LCZY1JAgHu9Jf+BmbDgHSlkvCClkLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759853062; c=relaxed/simple;
	bh=CfWBSsugOLgWs0/b0gLQc10dGjExCXB+o8uM0EKYNwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C4n03nuoHCCzaO2JiENL51jnHlqRksOx+HlZhdNl5no3zytCeB8n54kqbpKceco/mNBmovC9LMaarSIGTMS4qXzT3zKYhxRCcg5q5bUb5uhxW5tpJ8B+r1TYdG6mtFoXndY6+vAIe6YowCOWjOcThcQFgTWvgEXLGSxMLi4NvQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYcImu3a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B71AC4CEF1;
	Tue,  7 Oct 2025 16:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759853062;
	bh=CfWBSsugOLgWs0/b0gLQc10dGjExCXB+o8uM0EKYNwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DYcImu3adj+OfzLCxTNGl1okySO60B58Xls+M81RqjDZbzA6rbDATETkTSLb61Inj
	 4EZm7lI6TCSMsTP/9T8A0RIy9fMzrHSDgI3kQfaB5v8VdN1P6pg222rRpMRIkRTyBJ
	 Ryoo5DbBsrA67LthDTUP6RhyNSiuFSG0kXKHbwLYgD80wV1exM1p7Keh7PPiiglHFD
	 Ylvg4NTTbPMuuE5M1vMbFxH29D0WoV7j3aYWZnUJ4bcpj7UpYlmgrtwM1GyaWDmJjz
	 WlTzgBSFzlQs2oswzmI9TqeXMvxNRG8Wz/VrOH+dxbM4w5q2u8mehoubnW2Cyav6Uy
	 Qzb6+puXRwOsA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 4/4] NFSD: Move nfsd4_cache_this()
Date: Tue,  7 Oct 2025 12:04:13 -0400
Message-ID: <20251007160413.4953-5-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007160413.4953-1-cel@kernel.org>
References: <20251007160413.4953-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

nfsd4_cache_this() has one call site, and is not related to XDR at
all. It doesn't belong in fs/nfsd/xdr4.h.

As a clean-up, move this function (and its helper) to nfs4state.c,
next to its caller.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c | 23 +++++++++++++++++++++++
 fs/nfsd/xdr4.h      | 23 -----------------------
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index c9053ef4d79f..2c4fa4a23463 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -3476,6 +3476,29 @@ gen_callback(struct nfs4_client *clp, struct nfsd4_setclientid *se, struct svc_r
 	return;
 }
 
+static bool nfsd4_is_solo_sequence(struct nfsd4_compoundres *resp)
+{
+	struct nfsd4_compoundargs *args = resp->rqstp->rq_argp;
+
+	return args->opcnt == 1 && args->ops[0].opnum == OP_SEQUENCE;
+}
+
+/*
+ * Solo SEQUENCE operations are not supposed respect the setting in the
+ * sa_cachethis field, since that field controls whether the operations
+ * /after/ the SEQUENCE are preserved in the slot reply cache. Because
+ * clients might use a solo SEQUENCE to query the current state of the
+ * session or slot, a cached reply would return stale data to the client.
+ *
+ * Therefore NFSD treats solo SEQUENCE as an uncached operation no matter
+ * how the sa_cachethis field is set.
+ */
+static bool nfsd4_cache_this(struct nfsd4_compoundres *resp)
+{
+	return (resp->cstate.slot->sl_flags & NFSD4_SLOT_CACHETHIS) &&
+		!nfsd4_is_solo_sequence(resp);
+}
+
 /*
  * Cache a reply. nfsd4_check_resp_size() has bounded the cache size.
  */
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 9619e78f0ed2..6f0129ea754d 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -923,29 +923,6 @@ struct nfsd4_compoundres {
 	struct nfsd4_compound_state	cstate;
 };
 
-static inline bool nfsd4_is_solo_sequence(struct nfsd4_compoundres *resp)
-{
-	struct nfsd4_compoundargs *args = resp->rqstp->rq_argp;
-
-	return args->opcnt == 1 && args->ops[0].opnum == OP_SEQUENCE;
-}
-
-/*
- * Solo SEQUENCE operations are not supposed respect the setting in the
- * sa_cachethis field, since that field controls whether the operations
- * /after/ the SEQUENCE are preserved in the slot reply cache. Because
- * clients might use a solo SEQUENCE to query the current state of the
- * session or slot, a cached reply would return stale data to the client.
- *
- * Therefore NFSD treats solo SEQUENCE as an uncached operation no matter
- * how the sa_cachethis field is set.
- */
-static inline bool nfsd4_cache_this(struct nfsd4_compoundres *resp)
-{
-	return (resp->cstate.slot->sl_flags & NFSD4_SLOT_CACHETHIS) &&
-		!nfsd4_is_solo_sequence(resp);
-}
-
 static inline bool nfsd4_last_compound_op(struct svc_rqst *rqstp)
 {
 	struct nfsd4_compoundres *resp = rqstp->rq_resp;
-- 
2.51.0


