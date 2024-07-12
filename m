Return-Path: <linux-nfs+bounces-4859-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD5A92F986
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jul 2024 13:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 345981C21FDC
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jul 2024 11:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0FB15E5CF;
	Fri, 12 Jul 2024 11:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9OsW5rK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22E013CFB0;
	Fri, 12 Jul 2024 11:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720783620; cv=none; b=iPRzRMsFnHWZK3+h1VKNxNqT/c/OuaL0ZXy4OZe2iu7G9szAytXGp3NV2uM1n6RwR64wYo/NYJqctUYppq06gUvb16C5Fa7tGv5z0Y/X1Ft6WzPUc3uFCqNtXJMGCmSXDI1LBFw5oL54grmuSXKHhBvu4zPG18CMsWAOdjeejhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720783620; c=relaxed/simple;
	bh=d+i6p3adtKB4lAk4zPNrKwoUSQaYQ4zTp32AjrUwHvs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JlxpgyHSM3fHFBumjyGNK8rrH4JJAZ1468o1nQXgL+xWFjIy10P+jKN444DGENso9CQqLqBsRCKdPNlN0V+h/cEpIN2As9oLoj3GHZUYVRKq7MS+l8zhSV641IBErFnui5lXmQjozM41JDtvsyEYpJuINNQczw2UuCMFyixTveg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9OsW5rK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C66DAC32782;
	Fri, 12 Jul 2024 11:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720783619;
	bh=d+i6p3adtKB4lAk4zPNrKwoUSQaYQ4zTp32AjrUwHvs=;
	h=From:Date:Subject:To:Cc:From;
	b=V9OsW5rKEwG2lQtqGRJH5USGQUL/mDgX7CF8DH/315oFwWrTdNVIZNTOeFLhEe7Gk
	 es8a0Y1i2g1upkzVEG+e6Vg1FzdFgGSRqNsDCoB9j6ZtT/R6cgq2QJocTbWJwKsNK9
	 pkrKNei7+oLDUf1fGu8k2tWPeUucJoF0iC8TAOEgMPQ8G2NyLXAq87D3znAOQc1JYm
	 x8xLU9U2i8EzXJhKxkoODZX7kaC/QTWzf7byrdty8uBFweM5FTMHRmSNWOnWa/tf6a
	 PVC+BeNv2ysojEPzGt8qqLOX+kbnVjyK0vS4s+DL4HV2r7wr6CrpTIhA4C5W0dKcT8
	 sJtZGeVws9FkA==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 12 Jul 2024 07:26:44 -0400
Subject: [PATCH] nfsd: nfsd_file_lease_notifier_call gets a file_lease as
 an argument
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240712-nfsd-next-v1-1-58c5f2557436@kernel.org>
X-B4-Tracking: v=1; b=H4sIAPMSkWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDc0Mj3by04hTdvNSKEt2kRFODlCRDk7RkC1MloPqCotS0zAqwWdGxtbU
 A/yearlsAAAA=
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1000; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=d+i6p3adtKB4lAk4zPNrKwoUSQaYQ4zTp32AjrUwHvs=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmkRL8O3mpdod0yII9RJTTjU6UmyzKpxZ1dNxH2
 TjeopISUM2JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZpES/AAKCRAADmhBGVaC
 FX9uD/4qj3yarbtD70WTCTlJIi9x/C5fhd0FI0fMiDwnBKUb0OgXS44+ONiAEGQQG3y59k0KlBO
 /OGY4mcX7zTOiWBqxqT6aZtev1DQjef5hh7pWNWpeJ8e5jFaFOl+2wVf1e/T0P/0aTZ3CzRjJyj
 3NvFgYbG+SLsk/ybFhBacqxEqmjw4xdV0/85quPOjdp8JnBLJtlx6lfFjryML0+NpSduuy+33Tw
 tyStyYnMUSj/ccx2WlWGwWeCrHJoYlxW8gGAVXDi7LqtGMshUKAGtkSeCAn74yFTcKVAQVJy0K4
 hY/1AXXp3OIhRS0AnGlJEFeEmRSIu3T/rdQ9CHDY5LyyTYdxRL+4espSt5BaP/anYKg2kNwKoif
 alaGIfltCfL8nnXRc5BlgUqlG3pp+QJbwJBgngdWqTW82c9tc2TU+zWnj1QHyWWKehUYBI6T9uh
 kab2nHqJavITSlEJbPB9eY19iWjtV7MbLZmbF8KcaeNGWHHphEt/gX3+EME9nDTQ32T5WOvbWcd
 BJjJTZKXxdrhiCpwpQ1qorDzO2T6tkONPzPOwW5NZQuu6VYmY4qu5h0mvEMKKVwN3Xfnl/Rd6Fr
 C5S6bBC9XncVV4vJkYpyQhbObUe8eaKuOriXM1SSrFPQGLKNYkvY8QoiNFPbt1czrLRyMM+0rNp
 ZJMYeHfHGpPtDKg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

"data" actually refers to a file_lease and not a file_lock. Both structs
have their file_lock_core as the first field though, so this bug should
be harmless without struct randomization in play.

Fixes: 05580bbfc6bc ("nfsd: adapt to breakup of struct file_lock")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/filecache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 88dac1abdde3..ea506882fec2 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -667,7 +667,7 @@ static int
 nfsd_file_lease_notifier_call(struct notifier_block *nb, unsigned long arg,
 			    void *data)
 {
-	struct file_lock *fl = data;
+	struct file_lease *fl = data;
 
 	/* Only close files for F_SETLEASE leases */
 	if (fl->c.flc_flags & FL_LEASE)

---
base-commit: f862772862db0e2bbd711a03ac6e6cff89e306cb
change-id: 20240712-nfsd-next-ba50db14fc85

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


