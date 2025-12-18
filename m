Return-Path: <linux-nfs+bounces-17210-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F12EECCD80D
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 21:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB49630528E2
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 20:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7882C08C0;
	Thu, 18 Dec 2025 20:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9RMbB5k"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351712D739D
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 20:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766088847; cv=none; b=LDmy4GbFWwgQJ1/t+orEjWZFVY6GBMZQDOO886ZUn25HmE/KHfxgB3eVVCPOMcGOsSU1MBmU+bFyataNEDHWZMM29amo5Phh/2JdwAuLsoEZvR7EwxtNbTeQx4/zxyLvHvnD1LpqFV2ON43TUa11pHYMba0zpAY3rOnlHpgBFIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766088847; c=relaxed/simple;
	bh=JtANydDH2EwRxa0/IgyMgz725J/yJHzarhJw6VXGeRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iz7rY0a6WvjW+JE5VP8uNTTGkIQoDSrUt6owMOJTQ9hE+ETsW/2pfWQPgjsh9Azg9GWfy+f3LILV3NO6l62aME4ZodTdOiirW2sWjM3RjY5jyJO1HG9o5x+g8ZhqEsmjOxaCqBgyhzpkauPnUTIriuLs8QjhpnBEKGGxmskyjYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9RMbB5k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83146C16AAE;
	Thu, 18 Dec 2025 20:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766088847;
	bh=JtANydDH2EwRxa0/IgyMgz725J/yJHzarhJw6VXGeRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I9RMbB5ktLqdiJs/rF/zbjddKV+e7yU3AnK6H/gH0H37XrRVroOLGHM/FQodW0B6J
	 U7gSXed/gJN75oATI015hvsfETa6txR32ui5Bq0zeubsp5UDAVl1O7WFZBfKZQRqBO
	 9Y+6iMTMMRNtJHhbb4M/DhtSx5/V3D4WdZzF1qoAk92eBFrt4vtK3HzHPi1jfqXIoa
	 cyXpzX36iYPntPiHbw5kSwCp741tF2KNSvB3EUYsnHkPlOeJGx9/SIzdSdIgBn4lFK
	 NcO30ZkujQ/axPHueJ2+MPE05tM0zaLBq3IlJT59xM+W27afxXljxKX73Xx0x6yMU0
	 Ep1Ujp4mvFhEw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 22/36] lockd: Convert server-side NLMPROC4_TEST_RES to use xdrgen
Date: Thu, 18 Dec 2025 15:13:32 -0500
Message-ID: <20251218201346.1190928-23-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251218201346.1190928-1-cel@kernel.org>
References: <20251218201346.1190928-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index f037281f93cc..2a2ec661c0f6 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -1037,15 +1037,15 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_xdrressize	= XDR_void,
 		.pc_name	= "GRANTED_MSG",
 	},
-	[NLMPROC_TEST_RES] = {
-		.pc_func = nlm4svc_proc_null,
-		.pc_decode = nlm4svc_decode_void,
-		.pc_encode = nlm4svc_encode_void,
-		.pc_argsize = sizeof(struct nlm_res),
-		.pc_argzero = sizeof(struct nlm_res),
-		.pc_ressize = sizeof(struct nlm_void),
-		.pc_xdrressize = St,
-		.pc_name = "TEST_RES",
+	[NLMPROC4_TEST_RES] = {
+		.pc_func	= nlm4svc_proc_null,
+		.pc_decode	= nlm4_svc_decode_nlm4_testres,
+		.pc_encode	= nlm4_svc_encode_void,
+		.pc_argsize	= sizeof(struct nlm4_testres),
+		.pc_argzero	= 0,
+		.pc_ressize	= 0,
+		.pc_xdrressize	= XDR_void,
+		.pc_name	= "TEST_RES",
 	},
 	[NLMPROC_LOCK_RES] = {
 		.pc_func = nlm4svc_proc_null,
-- 
2.52.0


