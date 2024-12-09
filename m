Return-Path: <linux-nfs+bounces-8454-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 115219E93DA
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Dec 2024 13:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F7F61887749
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Dec 2024 12:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8602236F0;
	Mon,  9 Dec 2024 12:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPia26lV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041082236E5;
	Mon,  9 Dec 2024 12:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733747175; cv=none; b=BUbYSoXgT/Vb6UpeQrd+KPeuLHp87W/blu6D717EJCC0psYPXnygxbaTjYZsXniCsqrtdKB1Cj240CH5nbJhSrvsVcpIveR1meTRJv0n2kG0G83iTt7D0NZ6HK8OfY71btEjDEwE692mjz1+VXxE0fivJT++5P9JPqA96koPgC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733747175; c=relaxed/simple;
	bh=a/6vHuNAOOs0yuemhurpu0sOc7ofrM6NUoAi3itbNUs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=I3Vc2f5CmDD+59/ovboFHuoC1/7qdvf6DGAfLtP9p4EzxML0u8zSB7zeBfGILmxtwLXGaBD/CyBtLzcmUdn4shZZycFR7frguoZzi2Pz+WPpMqTDwvVyC8t7NVtLn1bD62427sAN/J3eSyV33EX0DK5aGiSDMZAnHQoPZjxDxGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPia26lV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D0E27C4CEDD;
	Mon,  9 Dec 2024 12:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733747174;
	bh=a/6vHuNAOOs0yuemhurpu0sOc7ofrM6NUoAi3itbNUs=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=gPia26lVPtcVSdAMO27BuhpBPdMGqXXDnFyGp0hAV8oR83Vi+3G+t2BBbIiQ/Rxep
	 6timAAbFxwvEs2gS9ACyM5vacQfCcwE9kvnzfJayVBf9Azr/YA6LSb6ogFzhSShGtD
	 VbeZxatGB0oBdVjSenYjZuaFNE55S9c7xaLFLms5Fam4cf+1nm+8YDTJaXoKTdaiAC
	 WxJSi6D1NL27c+kkVITtW5xGggCFo6IxpPRW+IUKI7Vd4Gg/hf79UToKFTcN4D2bQu
	 ivuuFR6htGTaPsIFPHcEy3jZXqyOZ/vbVmJEEwEAbddtxOrQAR4qlWsc8JWXjvAtdn
	 oDz3YwG4vnA/Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F3EE7717D;
	Mon,  9 Dec 2024 12:26:14 +0000 (UTC)
From: Vincent Mailhol via B4 Relay <devnull+mailhol.vincent.wanadoo.fr@kernel.org>
Date: Mon, 09 Dec 2024 21:25:56 +0900
Subject: [PATCH] nfsd: fix incorrect high limit in clamp() on
 over-allocation
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241209-nfs4state_fix-v1-1-7a66819c60f0@wanadoo.fr>
X-B4-Tracking: v=1; b=H4sIANPhVmcC/x2MQQqAIBAAvxJ7TnBFgvpKRJiutRcLVyKQ/p50n
 IGZCkKZSWDqKmS6WfhMDbDvwB8u7aQ4NAajjUWjR5WiWCmu0Br5UZsfInqMHgNCa65MTf+/eXn
 fDxK1LlhfAAAA
X-Change-ID: 20241209-nfs4state_fix-bc6f1c1fc1d1
To: NeilBrown <neilb@suse.de>, Andrew Morton <akpm@linux-foundation.org>, 
 "J. Bruce Fields" <bfields@fieldses.org>
Cc: David Laight <David.Laight@ACULAB.COM>, 
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
 Neil Brown <neilb@suse.de>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6431;
 i=mailhol.vincent@wanadoo.fr; h=from:subject:message-id;
 bh=biKwuRBMNlIV5wmE0TMmbH2x66QYghxgZBUd/wbFtdw=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDOlhD5/1fCxcUZ56/Nzfqa0LZwUt1lc1MhbV2RJZfzve5
 tCtbXr9HaUsDGJcDLJiiizLyjm5FToKvcMO/bWEmcPKBDKEgYtTACYimsDI8OJTi5XzhsZNPg0Z
 khs5Ft58IHBFZurhsxty+ZfcmW8vI8HwP9votF7xOWvRBcaC2e6nzts/4SzZxC6o0lyW1ZkfZrW
 RFQA=
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
X-Endpoint-Received: by B4 Relay for mailhol.vincent@wanadoo.fr/default
 with auth_id=291
X-Original-From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Reply-To: mailhol.vincent@wanadoo.fr

From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

If over allocation occurs in nfsd4_get_drc_mem(), total_avail is set
to zero. Consequently,

  clamp_t(unsigned long, avail, slotsize, total_avail/scale_factor);

gives:

  clamp_t(unsigned long, avail, slotsize, 0);

resulting in a clamp() call where the high limit is smaller than the
low limit, which is undefined: the result could be either slotsize or
zero depending on the order of evaluation.

Luckily, the two instructions just below the clamp() recover the
undefined behaviour:

  num = min_t(int, num, avail / slotsize);
  num = max_t(int, num, 1);

If avail = slotsize, the min_t() sets it back to 1. If avail = 0, the
max_t() sets it back to 1.

So this undefined behaviour has no visible effect.

Anyway, remove the undefined behaviour in clamp() by only calling it
and only doing the calculation of num if memory is still available.
Otherwise, if over-allocation occurred, directly set num to 1 as
intended by the author.

While at it, apply below checkpatch fix:

  WARNING: min() should probably be min_t(unsigned long, NFSD_MAX_MEM_PER_SESSION, total_avail)
  #100: FILE: fs/nfsd/nfs4state.c:1954:
  +		avail = min((unsigned long)NFSD_MAX_MEM_PER_SESSION, total_avail);

Fixes: 7f49fd5d7acd ("nfsd: handle drc over-allocation gracefully.")
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
Found by applying below patch from David:

  https://lore.kernel.org/all/34d53778977747f19cce2abb287bb3e6@AcuMS.aculab.com/

Doing so yield this report:

  In function ‘nfsd4_get_drc_mem’,
      inlined from ‘check_forechannel_attrs’ at fs/nfsd/nfs4state.c:3791:16,
      inlined from ‘nfsd4_create_session’ at fs/nfsd/nfs4state.c:3864:11:
  ././include/linux/compiler_types.h:542:38: error: call to ‘__compiletime_assert_3707’ declared with attribute error: clamp() low limit (unsigned long)(slotsize) greater than high limit (unsigned long)(total_avail/scale_factor)
    542 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
        |                                      ^
  ././include/linux/compiler_types.h:523:4: note: in definition of macro ‘__compiletime_assert’
    523 |    prefix ## suffix();    \
        |    ^~~~~~
  ././include/linux/compiler_types.h:542:2: note: in expansion of macro ‘_compiletime_assert’
    542 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
        |  ^~~~~~~~~~~~~~~~~~~
  ./include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
     39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
        |                                     ^~~~~~~~~~~~~~~~~~
  ./include/linux/minmax.h:114:2: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
    114 |  BUILD_BUG_ON_MSG(statically_true(ulo > uhi),    \
        |  ^~~~~~~~~~~~~~~~
  ./include/linux/minmax.h:121:2: note: in expansion of macro ‘__clamp_once’
    121 |  __clamp_once(val, lo, hi, __UNIQUE_ID(v_), __UNIQUE_ID(l_), __UNIQUE_ID(h_))
        |  ^~~~~~~~~~~~
  ./include/linux/minmax.h:275:36: note: in expansion of macro ‘__careful_clamp’
    275 | #define clamp_t(type, val, lo, hi) __careful_clamp((type)(val), (type)(lo), (type)(hi))
        |                                    ^~~~~~~~~~~~~~~
  fs/nfsd/nfs4state.c:1972:10: note: in expansion of macro ‘clamp_t’
   1972 |  avail = clamp_t(unsigned long, avail, slotsize,
        |          ^~~~~~~

Because David's patch is targetting Andrew's mm tree, I would suggest
that my patch also goes to that tree.
---
 fs/nfsd/nfs4state.c | 46 +++++++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 741b9449f727defc794347f1b116c955d715e691..eb91460c434e30f6df70f66d937f8c0f334b8e1b 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1944,35 +1944,39 @@ static u32 nfsd4_get_drc_mem(struct nfsd4_channel_attrs *ca, struct nfsd_net *nn
 {
 	u32 slotsize = slot_bytes(ca);
 	u32 num = ca->maxreqs;
-	unsigned long avail, total_avail;
-	unsigned int scale_factor;
 
 	spin_lock(&nfsd_drc_lock);
-	if (nfsd_drc_max_mem > nfsd_drc_mem_used)
+	if (nfsd_drc_max_mem > nfsd_drc_mem_used) {
+		unsigned long avail, total_avail;
+		unsigned int scale_factor;
+
 		total_avail = nfsd_drc_max_mem - nfsd_drc_mem_used;
-	else
+		avail = min_t(unsigned long,
+			      NFSD_MAX_MEM_PER_SESSION, total_avail);
+		/*
+		 * Never use more than a fraction of the remaining memory,
+		 * unless it's the only way to give this client a slot.
+		 * The chosen fraction is either 1/8 or 1/number of threads,
+		 * whichever is smaller.  This ensures there are adequate
+		 * slots to support multiple clients per thread.
+		 * Give the client one slot even if that would require
+		 * over-allocation--it is better than failure.
+		 */
+		scale_factor = max_t(unsigned int,
+				     8, nn->nfsd_serv->sv_nrthreads);
+
+		avail = clamp_t(unsigned long, avail, slotsize,
+				total_avail/scale_factor);
+		num = min_t(int, num, avail / slotsize);
+		num = max_t(int, num, 1);
+	} else {
 		/* We have handed out more space than we chose in
 		 * set_max_drc() to allow.  That isn't really a
 		 * problem as long as that doesn't make us think we
 		 * have lots more due to integer overflow.
 		 */
-		total_avail = 0;
-	avail = min((unsigned long)NFSD_MAX_MEM_PER_SESSION, total_avail);
-	/*
-	 * Never use more than a fraction of the remaining memory,
-	 * unless it's the only way to give this client a slot.
-	 * The chosen fraction is either 1/8 or 1/number of threads,
-	 * whichever is smaller.  This ensures there are adequate
-	 * slots to support multiple clients per thread.
-	 * Give the client one slot even if that would require
-	 * over-allocation--it is better than failure.
-	 */
-	scale_factor = max_t(unsigned int, 8, nn->nfsd_serv->sv_nrthreads);
-
-	avail = clamp_t(unsigned long, avail, slotsize,
-			total_avail/scale_factor);
-	num = min_t(int, num, avail / slotsize);
-	num = max_t(int, num, 1);
+		num = 1;
+	}
 	nfsd_drc_mem_used += num * slotsize;
 	spin_unlock(&nfsd_drc_lock);
 

---
base-commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
change-id: 20241209-nfs4state_fix-bc6f1c1fc1d1

Best regards,
-- 
Vincent Mailhol <mailhol.vincent@wanadoo.fr>



