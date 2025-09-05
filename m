Return-Path: <linux-nfs+bounces-14088-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAEAB463C0
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 21:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20B4D165DD5
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 19:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30226272E51;
	Fri,  5 Sep 2025 19:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSFGlnFE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC05271468
	for <linux-nfs@vger.kernel.org>; Fri,  5 Sep 2025 19:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757100978; cv=none; b=H/pbLznOCV46pwOgNtFWXxDqpPLhxtqLcu8A+uR+4WKGpJnNzoeStzpCfX7Y0qfVsEWX3z4CPvd+Bk4vT4Z5ki4uBJL9IAI9bx+B5EfWEYEBPV0csfEGGEwVyiwVqUIoG8IlA3yzvnTTH0f5B6xTI7aHBC0LM9wAlSb9XHgmkXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757100978; c=relaxed/simple;
	bh=kU8dTtEzDljzx0AAdyexknRz7Tm2f8O8nKjlmqOWOF8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=PXXEVmEa/ucOISHk5wDJJVEOIuu3lHMydm+oCTxF4ZbLZ+zTCetveakjDtClVGwDjI4GGjWdw0LwRjKTI8a6nnlXmaKmGO2OJIdwQ1tJxDqmxePUAmSf955KAuEVx1kHIj+1Iqi2vg/z1uAhXUaK6WIvuRGifnOWELkUelOWk3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FSFGlnFE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D89C4CEF1
	for <linux-nfs@vger.kernel.org>; Fri,  5 Sep 2025 19:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757100977;
	bh=kU8dTtEzDljzx0AAdyexknRz7Tm2f8O8nKjlmqOWOF8=;
	h=From:To:Subject:Date:From;
	b=FSFGlnFEyVl0X3owMZ8o0DK15pWhc4DEAgscyH8i2p0iD8emrAICR3CLr5ImDXF6+
	 VhNBWKu9g2cQ0VhKpsies6Pjfja1nt5uPmsRnAWGgs1bkxmKVLWalc4464ZTD7cTuR
	 FISSmbYe1z+T7m5XktgOXsxqDEywHWGfOYghHLnmq4RJojWe57V5K/hR0kiKDpuHiy
	 Hdc7LmodoozEHolc+gXIyywg0WH2iRBesevDKKSotk5RuSxMIcZuURPw/OdfywOzZt
	 5+bdSrZNSla+cI8gDV4vPh3y6dUFyZBRaxl2RDNud+vcLIY4j7rzwd5ACNLHCPYM8A
	 1+y88blSK6U/Q==
From: Trond Myklebust <trondmy@kernel.org>
To: linux-nfs@vger.kernel.org
Subject: [PATCH] Revert "SUNRPC: Don't allow waiting for exiting tasks"
Date: Fri,  5 Sep 2025 15:36:16 -0400
Message-ID: <03d73fa2736e18d2a8697dad6654bec99ee94572.1757100947.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

This reverts commit 14e41b16e8cb677bb440dca2edba8b041646c742.

This patch breaks the LTP acct02 test, so let's revert and look for a
better solution.

Reported-by: Mark Brown <broonie@kernel.org>
Reported-by: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
Link: https://lore.kernel.org/linux-nfs/7d4d57b0-39a3-49f1-8ada-60364743e3b4@sirena.org.uk/
Cc: stable@vger.kernel.org # 6.15.x
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/sched.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index 73bc39281ef5..9b45fbdc90ca 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -276,8 +276,6 @@ EXPORT_SYMBOL_GPL(rpc_destroy_wait_queue);
 
 static int rpc_wait_bit_killable(struct wait_bit_key *key, int mode)
 {
-	if (unlikely(current->flags & PF_EXITING))
-		return -EINTR;
 	schedule();
 	if (signal_pending_state(mode, current))
 		return -ERESTARTSYS;
-- 
2.51.0


