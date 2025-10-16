Return-Path: <linux-nfs+bounces-15290-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 999B4BE3CCF
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Oct 2025 15:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AD671882FC5
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Oct 2025 13:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60731DF982;
	Thu, 16 Oct 2025 13:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="leV5TIoW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B48442C
	for <linux-nfs@vger.kernel.org>; Thu, 16 Oct 2025 13:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760622602; cv=none; b=ug09ZwZhgZUd3h7dvvSOXGAkhPinucKbYfxgxwSj2DSoaAHrjVLWo2v4hr8+LTkJVQIcvpU8nJFWxWyWf9KQFmLM1FJPICLzRl/ePNEF0aSL97hPtsBy53U2xElYFAZ2xnfLs9rHUYjcfaF9yvaj37/gw03DoSGM1j75otcrNbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760622602; c=relaxed/simple;
	bh=9KrpRNrcAN2OgiIYR619TBS3VdjFwLXNHJb9l9X1xok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NPPlPrRj7xfn3Vd3fks2agLopdv2NQkcDR/lWhi7sAFXvlV2q6RDPCibAdIsEmheNlPcfB32Z+lvRSRaefuoPgB5LbAMDdwHOpyN6dPDPe/+Xt9OAAOy09jh95lFQ+UDzZnvVGRy+QZMLO17P1wPSF8S7i7P2Yx7EcbSJq7NORM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=leV5TIoW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1025C116B1;
	Thu, 16 Oct 2025 13:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760622602;
	bh=9KrpRNrcAN2OgiIYR619TBS3VdjFwLXNHJb9l9X1xok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=leV5TIoWnzaFVxJ3MYrSMyPurwXIb733ISDp9a4YQHEq5W1wfnopybIi3eho1GWDV
	 8+Vvryb2fCRmqbK8kWmcsbHMFQx84gFgg/6gfW/eBR6abhvvL6MErJNxXJwMkS+dIO
	 05cy3THlDWwTa3YuDpKtCcgCtsQc7yntH4MwBmozwjtXyxMZpN6ZHZJIIXsoA71XoJ
	 m2G+0U8yy6U/jtiaaDuhBZkOSRhGc1vmiwgv5ZiQ4RH6B6CHMdWIgPAGRbrcnbxlmo
	 DgeIda811jYD0TnL/Riug1nNeHr+EcGEo1F6JODcdg+Ah3qeg1r7YOm3emlJ7QbK0f
	 tyXWuI323vLsw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	rtm@csail.mit.edu
Subject: [PATCH v5 2/4] NFSD: Never cache a COMPOUND when the SEQUENCE operation fails
Date: Thu, 16 Oct 2025 09:49:56 -0400
Message-ID: <20251016134958.14050-3-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016134958.14050-1-cel@kernel.org>
References: <20251016134958.14050-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

RFC 8881 normatively mandates that operations where the initial
SEQUENCE operation in a compound fails must not modify the slot's
replay cache.

nfsd4_cache_this() doesn't prevent such caching. So when SEQUENCE
fails, cstate.data_offset is not set, allowing
read_bytes_from_xdr_buf() to access uninitialized memory.

Reported-by: <rtm@csail.mit.edu>
Closes: https://lore.kernel.org/linux-nfs/c3628d57-94ae-48cf-8c9e-49087a28cec9@oracle.com/T/#t
Fixes: 468de9e54a90 ("nfsd41: expand solo sequence check")
Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index c9053ef4d79f..4b4467e54ec9 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -3486,7 +3486,20 @@ nfsd4_store_cache_entry(struct nfsd4_compoundres *resp)
 	struct nfsd4_slot *slot = resp->cstate.slot;
 	unsigned int base;
 
-	dprintk("--> %s slot %p\n", __func__, slot);
+	/*
+	 * RFC 5661 Section 2.10.6.1.2:
+	 *
+	 * Any time SEQUENCE ... returns an error ... [t]he replier MUST NOT
+	 * modify the reply cache entry for the slot whenever an error is
+	 * returned from SEQUENCE ...
+	 *
+	 * Because nfsd4_store_cache_entry is called only by
+	 * nfsd4_sequence_done(), nfsd4_store_cache_entry() is called only
+	 * when a SEQUENCE operation was part of the COMPOUND.
+	 * nfs41_check_op_ordering() ensures SEQUENCE is the first op.
+	 */
+	if (resp->opcnt == 1 && resp->cstate.status != nfs_ok)
+		return;
 
 	slot->sl_flags |= NFSD4_SLOT_INITIALIZED;
 	slot->sl_opcnt = resp->opcnt;
-- 
2.51.0


