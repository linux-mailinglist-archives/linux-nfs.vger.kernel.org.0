Return-Path: <linux-nfs+bounces-12331-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94223AD5F3D
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jun 2025 21:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CB3A1BC23AF
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jun 2025 19:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6157F235355;
	Wed, 11 Jun 2025 19:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZ/fJ3fy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9AF1DFF7
	for <linux-nfs@vger.kernel.org>; Wed, 11 Jun 2025 19:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749671221; cv=none; b=mLmYYWP0upMoBr5BERj/xsQaWkGxEV7rcTVpX9m6DLwp3DFhbLOY/Dn/0vjeqHdFIaS9On7GjETsfulspZDn7OhqZd6R29IuyeQ6qgBs/JDvvZN0Y66DnvBzq+6xQd+MVl89SBJfI8tJUkbUnolMqxZw2L5MN51DqSZ1tynHxX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749671221; c=relaxed/simple;
	bh=KjWMl1hi37VHSmPNBFlitoycQA8WaXc/Bl1U+ZcQJto=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FClIEdVXgLMA9q8MAev4QAZDejUUBTkQC9FPzgxHYlEsMiYzjPoMgNuZsRHoGupRYUOIlXKhoxpbxqF1fVHkoOhm5+W3l3fEab3BtMa0u2Shoi9VqJOBbwJWlQ/pVNWb70XqIl+p6pXJyUp8G/q9Yr9pmT+5/Wz8emcgxDzB+18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZ/fJ3fy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BA581C4CEE3;
	Wed, 11 Jun 2025 19:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749671220;
	bh=KjWMl1hi37VHSmPNBFlitoycQA8WaXc/Bl1U+ZcQJto=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=UZ/fJ3fykHZCpV1AL5UlfFLRkrlyNH32AUK/JbCkZErswC/eEbS4Xg2F1ZteAGywE
	 kbX3S+aK4uGFaQFkwzTXcAcGA0xI/TiQtr/SwXgrrLYuRQggm35sJxFQ8U377qS2T3
	 9sC60DV8GC1itQEzIPShHxHVDBxjJFy6s8Zp1VWocZfkxXe67HdztfS/kEkJCnaN4I
	 tmcjUYtHgNerjy/DjId2bfSbZSITbImjx0FRzTdwzhCcu5xBoLuBPpDpdwKBnaz6Td
	 kdiD0h0bg1BX8a0buUgR/ohwi4YrU9droYJXkJVemxMMMDB3dB7cwDew5NNGmlqV89
	 NdW5t0AyoILeQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B005CC71136;
	Wed, 11 Jun 2025 19:47:00 +0000 (UTC)
From: Nikhil Jha via B4 Relay <devnull+njha.janestreet.com@kernel.org>
Date: Wed, 11 Jun 2025 15:46:39 -0400
Subject: [PATCH] sunrpc: fix loop in gss seqno cache
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-fix-loop-in-seqno-cache-v1-1-9f9214d60dbf@janestreet.com>
X-B4-Tracking: v=1; b=H4sIAB7dSWgC/x2MSwqAMBDFriKzdsCKH/Qq4qKMTx2QVlsQoXh3i
 8tAkkQRQRFpLBIF3BrVuwymLEh26zawLpmpruq26ozhVR8+vD9ZHUdczrNY2cGdrL2RxmKApVy
 fAVn9z9P8vh/ZbBoTaQAAAA==
X-Change-ID: 20250611-fix-loop-in-seqno-cache-6cf71c4ae9ea
To: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, Nikhil Jha <njha@janestreet.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749671220; l=1544;
 i=njha@janestreet.com; s=20250314; h=from:subject:message-id;
 bh=9sWz8NPFHiKr5lOYqBHxNwkYPRmoCG3mDz0qaSDWR0w=;
 b=5JfBNmFl00aFr2bigOweLPqYoaLoGSSxsYkIHnxGUMfe2YfbJrflSJfBxrGXHSY0dc1piph2Y
 vzhcaadtJIVBMmJy554OOcuMOdHbUKFh8QdJ9z/7/8JHbbrq/yMlrHj
X-Developer-Key: i=njha@janestreet.com; a=ed25519;
 pk=92gWYi0ImmcatlW+pFEFh9viqpRf/PE8phYeWuNeGaA=
X-Endpoint-Received: by B4 Relay for njha@janestreet.com/20250314 with
 auth_id=360
X-Original-From: Nikhil Jha <njha@janestreet.com>
Reply-To: njha@janestreet.com

From: Nikhil Jha <njha@janestreet.com>

There was a silly bug in the initial implementation where a loop
variable was not incremented. This commit increments the loop variable.

This bug is somewhat tricky to catch because it can only happen on loops
of two or more. If it is hit, it locks up a kernel thread in an infinite
loop.

Signed-off-by: Nikhil Jha <njha@janestreet.com>
Tested-by: Nikhil Jha <njha@janestreet.com>
---
 net/sunrpc/auth_gss/auth_gss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
index 0fa244f16876f3c434fd507b4d53c5eefd748ce4..7b943fbafcc38ba79a685589d696017e8cdc694a 100644
--- a/net/sunrpc/auth_gss/auth_gss.c
+++ b/net/sunrpc/auth_gss/auth_gss.c
@@ -1724,7 +1724,7 @@ gss_validate(struct rpc_task *task, struct xdr_stream *xdr)
 	maj_stat = gss_validate_seqno_mic(ctx, task->tk_rqstp->rq_seqnos[0], seq, p, len);
 	/* RFC 2203 5.3.3.1 - compute the checksum of each sequence number in the cache */
 	while (unlikely(maj_stat == GSS_S_BAD_SIG && i < task->tk_rqstp->rq_seqno_count))
-		maj_stat = gss_validate_seqno_mic(ctx, task->tk_rqstp->rq_seqnos[i], seq, p, len);
+		maj_stat = gss_validate_seqno_mic(ctx, task->tk_rqstp->rq_seqnos[i++], seq, p, len);
 	if (maj_stat == GSS_S_CONTEXT_EXPIRED)
 		clear_bit(RPCAUTH_CRED_UPTODATE, &cred->cr_flags);
 	if (maj_stat)

---
base-commit: 488ef3560196ee10fc1c5547e1574a87068c3494
change-id: 20250611-fix-loop-in-seqno-cache-6cf71c4ae9ea

Best regards,
-- 
Nikhil Jha <njha@janestreet.com>



