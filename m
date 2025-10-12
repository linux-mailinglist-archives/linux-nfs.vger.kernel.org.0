Return-Path: <linux-nfs+bounces-15158-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 98689BD0844
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Oct 2025 19:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 94F904E1917
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Oct 2025 17:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F88F2ECE82;
	Sun, 12 Oct 2025 17:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VpvgWhz7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBA32ECD27
	for <linux-nfs@vger.kernel.org>; Sun, 12 Oct 2025 17:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760288871; cv=none; b=UvoccykR6pE00ZRhyTP6Ztf+4/FGjS5W3aNZG5n2gWXJ+zoe9FteVwgS/Z9rWP0J05LWkfUrNnkP9QCZe9A1OmMz3w9Jq+XAKVyWFYAp+Sg0OcR/oy1fZ4jh8pd4KhNwXKfPRr3saQV4dxB0myVBtPQYvcUpvLqTH/poCkNipxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760288871; c=relaxed/simple;
	bh=3Mpl9dOVX8WZaQt7FxUvuj2mf05P3/fSW8Jt3znOBpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qU4BECQEpuhfazMU/IIq0/Csu3Zx/EtUYuyfXfuk3nz7ZO92CLxXdmy3oV7kmXNr/O7U93h7NtcpUwo1Co+esSUxVfNZ9ZQsKYvdT4AEUb5EC38gPn9vIF6De6BsooHE2Fa7+mi9njPtMr4RU2ek/1dWn3/l6uZVQGXEcWyb4BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VpvgWhz7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BEBFC4CEE7;
	Sun, 12 Oct 2025 17:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760288871;
	bh=3Mpl9dOVX8WZaQt7FxUvuj2mf05P3/fSW8Jt3znOBpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VpvgWhz7FNT1txfFz2VOH+joSqDXPs8aSruddnwRmU6Kx1o6NIbsx9Zn54AB3lpJ1
	 q5GElDuILIDEot9hQWsm50oe2GxNqlQNseEqgfSqf772XDpF+tivUvwOdqlUfousMp
	 UIe3JgOhfIJH1gklFzissd7uXbG/pepLsGqs3De/NcVebNilg3f0wq4hVWqIQ0lJuq
	 tZlMySa1T6bTARmbgmaYe88qvH3ULEXd3LGNDc72ciIceRsk/qlxW0T/VBhIZBvIje
	 KfnDzVYiKmvTLxD7B+7hFzY3oqO/CB/pyn0PsbWfZKdUFpF495rpHYYLApz/puB/VP
	 P7eXnfW4xnmCg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	rtm@csail.mit.edu
Subject: [PATCH v4 2/4] NFSD: Never cache a COMPOUND when the SEQUENCE operation fails
Date: Sun, 12 Oct 2025 13:07:44 -0400
Message-ID: <20251012170746.9381-3-cel@kernel.org>
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

RFC 8881 normatively mandates that operations where the initial
SEQUENCE operation in a compound fails must not modify the slot's
replay cache.

nfsd4_cache_this() doesn't prevent such caching. So when SEQUENCE
fails, cstate.data_offset is not set, allowing
read_bytes_from_xdr_buf() to access uninitialized memory.

Reported-by: <rtm@csail.mit.edu>
Closes: https://lore.kernel.org/linux-nfs/c3628d57-94ae-48cf-8c9e-49087a28cec9@oracle.com/T/#t
Fixes: 468de9e54a90 ("nfsd41: expand solo sequence check")
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


