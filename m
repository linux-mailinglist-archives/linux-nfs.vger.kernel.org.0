Return-Path: <linux-nfs+bounces-15130-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6518BCD5E0
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Oct 2025 15:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 310061896509
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Oct 2025 13:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C7D2F362F;
	Fri, 10 Oct 2025 13:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Segy0FdU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4064B287271
	for <linux-nfs@vger.kernel.org>; Fri, 10 Oct 2025 13:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760104594; cv=none; b=f4+fmX+L/awLpGJBYbgYU0wUi0vqd2nPkLNHtAP0CW3y0VLrH7x7QwEHRaQuRA1xnhyIb1YhBEgLe2fM39bliZ7kJ3hiz3vetQu0YmHWMRGaLPDeTPFdI6hNK3HjQG4R4P9d9G7qbaG7elFHqJ7cQvIP2CLLfAs+S1y7JSiAg48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760104594; c=relaxed/simple;
	bh=CMqZGEBzsDSxGJHfRr+lXZ/Di/r7vUSoH+c4QzQI1Mg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lhUI6fQtsZHFkK76OyEi78Vut27GWlxGMnTbTjBcoL4dKrbZrgcNHoKcTG+1JJr+f4OX6pBF3Q0Xyxdsn0dVkyPwkTNQLI5IW7a2B8Qzxd50qipw7IscqVlJyKg43HCYu1es3ftgNV2b3lv1TAyhY7izekl+FioTA62vQR1we/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Segy0FdU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7232C4CEFE;
	Fri, 10 Oct 2025 13:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760104593;
	bh=CMqZGEBzsDSxGJHfRr+lXZ/Di/r7vUSoH+c4QzQI1Mg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Segy0FdUnrjaB4HHdHs4HYsM9amEfe3yARdTTlpJgL9Kg/OB0pXc1mjZndyXBPwhD
	 bQGemaltsiIV461DLkYNXtrNFCmVjDr19TovCTYKR050zjxPqVlwZPHecAXAJteC+T
	 jV0iiP5agVnWHtEIsqq2CPdGZGyIUCGmM0zIpxryJ4k52QTk1Eg6+DR6Fmky4hk9PL
	 0dS4C68rYG7q1Fk3hMXFTAbRP8HDLOgwP/jByq9B6FhmXZxWFkRgYWRMX/U16XG4j8
	 oRI5h9GQ7SHUd7OZXZOH7rl3nePdWbWraR1659HWaW6WtJQzPtUlpBFAUMbWRTORR/
	 zO2AUOo6++XxA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 5/5] NFSD: Move nfsd4_cache_this()
Date: Fri, 10 Oct 2025 09:56:23 -0400
Message-ID: <20251010135623.1723-6-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010135623.1723-1-cel@kernel.org>
References: <20251010135623.1723-1-cel@kernel.org>
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

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c | 22 ++++++++++++++++++++++
 fs/nfsd/xdr4.h      | 22 ----------------------
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 7d297ac2bf2b..e8143bbc7974 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -3477,6 +3477,28 @@ gen_callback(struct nfs4_client *clp, struct nfsd4_setclientid *se, struct svc_r
 	return;
 }
 
+static inline bool nfsd4_is_solo_sequence(struct nfsd4_compoundres *resp)
+{
+	struct nfsd4_compoundargs *args = resp->rqstp->rq_argp;
+
+	return args->opcnt == 1 && args->ops[0].opnum == OP_SEQUENCE;
+}
+
+/*
+ * The session reply cache only needs to cache replies that the client
+ * actually asked us to.  But it's almost free for us to cache compounds
+ * consisting of only a SEQUENCE op, so we may as well cache those too.
+ * Also, the protocol doesn't give us a convenient response in the case
+ * of a replay of a solo SEQUENCE op that wasn't cached
+ * (RETRY_UNCACHED_REP can only be returned in the second op of a
+ * compound).
+ */
+static inline bool nfsd4_cache_this(struct nfsd4_compoundres *resp)
+{
+	return (resp->cstate.slot->sl_flags & NFSD4_SLOT_CACHETHIS)
+		|| nfsd4_is_solo_sequence(resp);
+}
+
 /*
  * Maybe cache a reply. nfsd4_check_resp_size() has bounded the cache size.
  */
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index d1837a10b0c2..6f0129ea754d 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -923,28 +923,6 @@ struct nfsd4_compoundres {
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
- * The session reply cache only needs to cache replies that the client
- * actually asked us to.  But it's almost free for us to cache compounds
- * consisting of only a SEQUENCE op, so we may as well cache those too.
- * Also, the protocol doesn't give us a convenient response in the case
- * of a replay of a solo SEQUENCE op that wasn't cached
- * (RETRY_UNCACHED_REP can only be returned in the second op of a
- * compound).
- */
-static inline bool nfsd4_cache_this(struct nfsd4_compoundres *resp)
-{
-	return (resp->cstate.slot->sl_flags & NFSD4_SLOT_CACHETHIS)
-		|| nfsd4_is_solo_sequence(resp);
-}
-
 static inline bool nfsd4_last_compound_op(struct svc_rqst *rqstp)
 {
 	struct nfsd4_compoundres *resp = rqstp->rq_resp;
-- 
2.51.0


