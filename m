Return-Path: <linux-nfs+bounces-22184-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CkXCSTIHWrgdwkAu9opvQ
	(envelope-from <linux-nfs+bounces-22184-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 19:57:56 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B621162395E
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 19:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80682305EA40
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jun 2026 17:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913EE3E0C46;
	Mon,  1 Jun 2026 17:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0LJcgbl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869193314B7;
	Mon,  1 Jun 2026 17:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780336460; cv=none; b=fCdmKDB3NH7jTH+iiKqo3IAWGF4QFOFloLQ4AS1S62g39nJiRVOjiQ+mGWW0fNQW8e2nuaEjmQ3xemWfAj8iWf73cVt9KmCzWEqHV1RwVhWcKFJb6Nzt+NeNQumcpf7Z0hBCN+3jjzqlmRaIe4CA5Y/mv3e8907hfncjDz5Rp8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780336460; c=relaxed/simple;
	bh=Df+fYzQqMI1GeA45P6JsTCTJmOrcAu4SR0z2gpGCea4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FsFmH9WXaTw33x7IC6c9ijL+raNmQDiQGTzouhpnqsH1nU8EvPBydvKKQol7rHWydeurlQIJiF6KJzWJKi3MS0YHTFv/fZFhQYdO56AcweDBO3/1cZOWmqlVrFABR2T4SHHVo8ziGEMapIJUq31Szd1tBCg8t63lVriREfOJkzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0LJcgbl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04EED1F00893;
	Mon,  1 Jun 2026 17:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780336459;
	bh=n67+QMBasbqZL2nolv5f53FlukG25uE1k5+NU1mtaHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d0LJcgblHKikjbLANLFLreCi5bYhQywXj6XO6lQQRkFyOI63GepCJ8ilJxvlYBV0y
	 jr2FTJIa0b5BUAOTzRNiGfl/kNP+g7ROKF0y1R55/BlE3tbGOcXgGA0NpBVTt0Be7m
	 /Y61s34g8CumOQI+pKG9tV67D24CNdLKPcJxWfPCldRmHdqgA8tczlpbmvQ7jUEX83
	 it4nPnMlqdykyTP7UJPqf5toxNZeyvRrbafVgQOvNrsoxhRjML5OXf6QzyIkrugO9b
	 0HQVw3EDLGV54tjmaJ0Xv2gnDhkm+psZPKmuMdIAEv6cEH/lh5ZaGF9lH0qEMILXxt
	 mMMIgH56vaZDQ==
From: Chuck Lever <cel@kernel.org>
To: Anna Schumaker <anna@kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 2/2] xprtrdma: Remove tautological I2 assertion in rpcrdma_reply_put
Date: Mon,  1 Jun 2026 13:54:13 -0400
Message-ID: <20260601175413.29544-3-cel@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601175413.29544-1-cel@kernel.org>
References: <20260601175413.29544-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22184-lists,linux-nfs=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B621162395E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

rpcrdma_reply_put() sets req->rl_reply to NULL when it is
non-NULL, and skips the block when it is already NULL.  The
WARN_ON_ONCE(req->rl_reply) that follows can never fire
because both paths leave rl_reply NULL.

Remove the dead assertion and its comment.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/verbs.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index da2c6fa44154..92c691d2521f 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -1259,10 +1259,6 @@ void rpcrdma_reply_put(struct rpcrdma_buffer *buffers, struct rpcrdma_req *req)
 		req->rl_reply = NULL;
 		rpcrdma_rep_put(buffers, rep);
 	}
-	/* I2: rl_reply NULL after the put closes the
-	 * 'rep on rb_free_reps still referenced by req' window.
-	 */
-	WARN_ON_ONCE(req->rl_reply);
 }
 
 /**
-- 
2.54.0


