Return-Path: <linux-nfs+bounces-15159-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A07BD0847
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Oct 2025 19:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A3E33BE141
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Oct 2025 17:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BA72EC558;
	Sun, 12 Oct 2025 17:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCDBKYpi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1312EC0BC
	for <linux-nfs@vger.kernel.org>; Sun, 12 Oct 2025 17:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760288872; cv=none; b=GuBMLrybGIaeNq4WzKSCP6AKKbGP4pqoHBjf9U84U7sdScPZD8KZh90Ldp2Fl5inCJCGrZj/HPl+ibmel+GuZLEisVb9Jt7mkvhQ151K3FWKNlY1klXceQ7bjO6Sa18jR/egnszniJ75PbS6gjRWwICnMX7jbfkmsJZy7k1GvCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760288872; c=relaxed/simple;
	bh=Z9HNZpVsF2WpOB+CDNuT7iiDT3n/xZGCurveq87vbJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lHjjDHz46cE1WzgPm4hYxkMXmK7BDK7ZnnwWEXqLaf0vjx42sycRhXcTD8njM4rNpuWF1GmPPo8G46Yl3zuday+wcdpneQaaFuxJCDaUaWYH0nTHmrWrX2Z8aGKT/Tp5PLrvT2EU+EVlzGbc2y+bRbQdEMCV76/wcAVclFd6/ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZCDBKYpi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1681CC4CEF8;
	Sun, 12 Oct 2025 17:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760288872;
	bh=Z9HNZpVsF2WpOB+CDNuT7iiDT3n/xZGCurveq87vbJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZCDBKYpiVp3bLtqwFhF6ARKIPBTxsUJEMvGa+O2hc5QF/mwd09pwOxfD4bTYGA6aJ
	 i3sbbHcYgZZJU7v4/T3s8mpfXC8vOYSUJcKrRGYmWgzbT6J4QlVgmITmCFua40SGGJ
	 3pcRLt+Zl1UYRdWcUByu66Oyk492TDZ6MPLuBQCHrV/EhPjaQ5yN1Tba68AxcACK07
	 n5scPuFyd8ejPAfD6TF4ieIPmZIIa3DxgAyNbJRgu0YyJXbH8trx483QPZ7HwgZ2Pn
	 fD4+dLrXIyJE7yXCMmD43ikgAguGAgtWQALJPd09bxT9poT7b8GkBv2SgOHB6qiwyE
	 GmbLr6fxSuXhQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v4 4/4] NFSD: Move nfsd4_cache_this()
Date: Sun, 12 Oct 2025 13:07:46 -0400
Message-ID: <20251012170746.9381-5-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251012170746.9381-1-cel@kernel.org>
References: <20251012170746.9381-1-cel@kernel.org>
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
next to its only caller.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c | 22 ++++++++++++++++++++++
 fs/nfsd/xdr4.h      | 22 ----------------------
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 4b4467e54ec9..5fd2138cb074 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -3476,6 +3476,28 @@ gen_callback(struct nfs4_client *clp, struct nfsd4_setclientid *se, struct svc_r
 	return;
 }
 
+static inline bool nfsd4_is_solo_sequence(struct nfsd4_compoundres *resp)
+{
+	struct nfsd4_compoundargs *args = resp->rqstp->rq_argp;
+
+	return args->opcnt == 1;
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
  * Cache a reply. nfsd4_check_resp_size() has bounded the cache size.
  */
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index d4548a16a36e..6f0129ea754d 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -923,28 +923,6 @@ struct nfsd4_compoundres {
 	struct nfsd4_compound_state	cstate;
 };
 
-static inline bool nfsd4_is_solo_sequence(struct nfsd4_compoundres *resp)
-{
-	struct nfsd4_compoundargs *args = resp->rqstp->rq_argp;
-
-	return args->opcnt == 1;
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


