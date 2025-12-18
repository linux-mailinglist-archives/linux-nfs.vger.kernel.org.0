Return-Path: <linux-nfs+bounces-17211-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C48ACCD7DD
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 21:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8C5323055F87
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 20:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE102D879B;
	Thu, 18 Dec 2025 20:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="smMl9tsg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082222D5419
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 20:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766088848; cv=none; b=DIh+UeSCWhg+VEBw1koLNsp/CvCe+h0PupDpIsDxSHlaR1AzhbJXo6azXkyzP/TksQAjsKWCRzlO3/XKHxOyfSPkkCBYtkT/Kr52rWA6+38FPqKlu0bJriOaYbWlFDHilcORWEQwi/aPfR6zNnWk9SsK4JGhMu3nN2YmMHIEheI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766088848; c=relaxed/simple;
	bh=nKXapqtidBtBgzpTlx/xYHppYByZjbvwEEJbQGkc4bo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nd469NKoBOGIkjEhoYR6Uoy5yBvO0u5x2GjAnUGbtGJ8KvYxG9sjRT08kAm9f8fouzmB33h5LIAr1V9/SgQ2jHGcApFWIiqwZnE0ElfAnrm2xqiShNxxnxRqtuKdleETRZAbh4rwRFTmHDr7KLd6PX3hKhgbcsqKavTfEz8ZZZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=smMl9tsg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E6AAC4CEFB;
	Thu, 18 Dec 2025 20:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766088847;
	bh=nKXapqtidBtBgzpTlx/xYHppYByZjbvwEEJbQGkc4bo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=smMl9tsgBKDvU96IK8Z1mg8saB/Q6xzKwCy3HV5HFyOAYoe31nwkBti/BjlyANcFJ
	 XHrsxXOWLa4XukSIBL0ZjM/RQT8WpA2p3M7I6smOu+9Vgn5gvBUPgNUHL8p2bGSnMU
	 YKfl4eGjriHb5ORDMcMIPmqLi/5XmuAPKpLgYPSTT5T5jSiw+0bkqB6gTxbA86dpvL
	 dufzb07EKssZrnH7yvmJUfT9N3cAECqEieXIn05PZU32TdJcYcmC5qgo1QEEzkY2uA
	 wSSr/SIJNIQ8glpavrCshN19mStTQM89Yq6Ec7vAffnoVF/u9+Xt7NH7UtoKUY0Pre
	 fyH8Hhb6OXaaQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 23/36] lockd: Convert server-side NLMPROC4_LOCK_RES to use xdrgen
Date: Thu, 18 Dec 2025 15:13:33 -0500
Message-ID: <20251218201346.1190928-24-cel@kernel.org>
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
index 2a2ec661c0f6..8fe6fb952089 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -1047,15 +1047,15 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_xdrressize	= XDR_void,
 		.pc_name	= "TEST_RES",
 	},
-	[NLMPROC_LOCK_RES] = {
-		.pc_func = nlm4svc_proc_null,
-		.pc_decode = nlm4svc_decode_void,
-		.pc_encode = nlm4svc_encode_void,
-		.pc_argsize = sizeof(struct nlm_res),
-		.pc_argzero = sizeof(struct nlm_res),
-		.pc_ressize = sizeof(struct nlm_void),
-		.pc_xdrressize = St,
-		.pc_name = "LOCK_RES",
+	[NLMPROC4_LOCK_RES] = {
+		.pc_func	= nlm4svc_proc_null,
+		.pc_decode	= nlm4_svc_decode_nlm4_res,
+		.pc_encode	= nlm4_svc_encode_void,
+		.pc_argsize	= sizeof(struct nlm4_res),
+		.pc_argzero	= 0,
+		.pc_ressize	= 0,
+		.pc_xdrressize	= XDR_void,
+		.pc_name	= "LOCK_RES",
 	},
 	[NLMPROC_CANCEL_RES] = {
 		.pc_func = nlm4svc_proc_null,
-- 
2.52.0


