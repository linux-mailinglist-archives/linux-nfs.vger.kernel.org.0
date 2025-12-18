Return-Path: <linux-nfs+bounces-17198-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B377BCCD7C8
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 21:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F516302426A
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 20:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C0F2C3248;
	Thu, 18 Dec 2025 20:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUC516eR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7852C08C0
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 20:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766088838; cv=none; b=Lx6SQI7FacuPn5wNT5OQEjuQL7d5ek15c8DTIohFXrxUyV5eovofvxxEJvM27l6z5cY/0BJaE6jVAWu9/3enCDjVOqMpFbSOb3HA4lrIaXpf9eYVi9tVSLBUm5/WcEeuE4vc6JhI62Mf4lmpkFbfN3xF/nkGycr0xeoxq36HXCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766088838; c=relaxed/simple;
	bh=uf6TZuJ2uZqh0PfYHYz97OKozPt2cAgvnp7QlUG101o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wha2XrIKtFumllgazaNqV+3mToC6QAYJmKZKMUTHYPoaJIfuq7Y301mr8qY/bgWeDzS257ukm8gXBzAtIIwNpm4pc5lgOPN1OJXY9MfoLnazUPjkf4oodiclCj3GFY1NrthrQV19EVb9eipZCsCLGz+O/C8mDOIIscRe47ZJxDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JUC516eR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2377DC116D0;
	Thu, 18 Dec 2025 20:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766088837;
	bh=uf6TZuJ2uZqh0PfYHYz97OKozPt2cAgvnp7QlUG101o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JUC516eR7BPA3PQqNToDzmN8ygR9FDMXwkQYr3OILZy4Ev0FTAp8iktEdpgP60h6u
	 c0Dr1hXy4dpmyDBbI2cf2k1jlNOA7un4MuGCu8suISmQ8nBUsC49OVU9XyA62HLj4k
	 wSSWv+aPOKQaT73JCzeC1TBH+VhXJbv2JCoYCvNvnZA1PCCPdqW6iBked/hn3Z/sTC
	 wUcRc0zXT5a7PrzsHN/gswxojtUiAKU6y3ae4LRgYdOStlz63m6Qq0GDrnve4PKzB1
	 s/r8/kkwS1iRAFLD+Rl26zSz7UfKjyVCPBKui4rmPTOACVLn+1UFvMubMcy5iDs0bx
	 Wn5oSPPBReGZQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 10/36] lockd: Use xdrgen XDR functions for the NLMv4 NULL procedure
Date: Thu, 18 Dec 2025 15:13:20 -0500
Message-ID: <20251218201346.1190928-11-cel@kernel.org>
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

Update the NLM4PROC_NULL entry in the nlmsvc_procedures4 array to
use the generated XDR encoder and decoder functions
(nlm4_svc_decode_void and nlm4_svc_encode_void) instead of the hand-
written nlm4svc_decode_void and nlm4svc_encode_void functions.

Also update pc_xdrressize to 0 since the NULL procedure returns a
void result with no XDR-encoded data.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index b975bddf3776..468aa5060462 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -81,13 +81,16 @@ nlm4svc_retrieve_args(struct svc_rqst *rqstp, struct nlm_args *argp,
 	return nlm_lck_denied_nolocks;
 }
 
-/*
- * NULL: Test for presence of service
+/**
+ * nlm4svc_proc_null - NULL: Do nothing
+ * @rqstp: RPC transaction context
+ *
+ * Returns:
+ *   %rpc_success:		RPC executed successfully
  */
 static __be32
 nlm4svc_proc_null(struct svc_rqst *rqstp)
 {
-	dprintk("lockd: NULL          called\n");
 	return rpc_success;
 }
 
@@ -508,15 +511,15 @@ struct nlm_void			{ int dummy; };
 #define	Rg	4					/* range (offset + length) */
 
 const struct svc_procedure nlmsvc_procedures4[24] = {
-	[NLMPROC_NULL] = {
-		.pc_func = nlm4svc_proc_null,
-		.pc_decode = nlm4svc_decode_void,
-		.pc_encode = nlm4svc_encode_void,
-		.pc_argsize = sizeof(struct nlm_void),
-		.pc_argzero = sizeof(struct nlm_void),
-		.pc_ressize = sizeof(struct nlm_void),
-		.pc_xdrressize = St,
-		.pc_name = "NULL",
+	[NLMPROC4_NULL] = {
+		.pc_func	= nlm4svc_proc_null,
+		.pc_decode	= nlm4_svc_decode_void,
+		.pc_encode	= nlm4_svc_encode_void,
+		.pc_argsize	= XDR_void,
+		.pc_argzero	= 0,
+		.pc_ressize	= 0,
+		.pc_xdrressize	= XDR_void,
+		.pc_name	= "NULL",
 	},
 	[NLMPROC_TEST] = {
 		.pc_func = nlm4svc_proc_test,
-- 
2.52.0


