Return-Path: <linux-nfs+bounces-4908-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DEB931348
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 13:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5F13B22695
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 11:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C727318A938;
	Mon, 15 Jul 2024 11:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pbCJDr4n"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40B818A92F
	for <linux-nfs@vger.kernel.org>; Mon, 15 Jul 2024 11:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721043789; cv=none; b=ReMxx4K6/yOONx6qwUdBLc/SoWGzrTVlSZTAQV9om64QWF5RbWtK5yp68ik3/JtCF43eXXaYGwy8NHvDbFYAwtc4ouPcRY9/HMctjkiqRj4EZ6bdhqDa0ZPLk9MnpJb12QEIKI7v9krulBlDeCVKxRqgcy29RF7hs8pCVZHl3Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721043789; c=relaxed/simple;
	bh=9ndgA6SeamOVqIvnSLALNTaJ/1qk+hDAUaUia2oMyWo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=huf+t/KgxPLqp15n/LaO/Ve/vi8GDWzOWMLoP4Rc57yB+yTgHbXVfba1UUnJJmcjM2ysVgbF5ZBv7Qg+2yE8pSMvpF8W3vYau2+yLZkkM653e1RkONy97kj7cimEBqwDGOMxma2N21RGAPTwrh5rsTQJwcmbIDSQkeyqxvAE0MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pbCJDr4n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB7C9C4AF0B;
	Mon, 15 Jul 2024 11:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721043789;
	bh=9ndgA6SeamOVqIvnSLALNTaJ/1qk+hDAUaUia2oMyWo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pbCJDr4nQCvvBYAfuj3504REOUmnbGuIMehXo7MD2qcE2Yiwrpd1cb2V7pa1xAbpk
	 mU7Q9l2QC4yDoFq0gIIx6Kfvb58bdTnou1hdlQuSRZDSvjxXN+oCyotJAk/JkZ/Yx1
	 9ztJb4EHC6vR83XalMTQaZGKcYSBr07iY6ZIxzsRbCk1PqMtTv4D48Xl6ucWVa8QoT
	 SXEtHl1KXE00ULj1d8p4qWE/RjSR/r1bQSSgg+smteP7O2JGKZBur+3ucd2Ni34/+P
	 29EKiEa5HGSjIaFNDRQEi/4c2oMY/TlKimue8koDvUR7uRR7R+vLtsofrNKgYj0FTa
	 +gENtvEeaH5xA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 15 Jul 2024 07:43:01 -0400
Subject: [PATCH 1/2] nfsdctl: make "autostart" default to 16 threads
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-nfsdctl-v1-1-c09c314f540d@kernel.org>
References: <20240715-nfsdctl-v1-0-c09c314f540d@kernel.org>
In-Reply-To: <20240715-nfsdctl-v1-0-c09c314f540d@kernel.org>
To: Steve Dickson <steved@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 Neil Brown <neilb@suse.de>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2425; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=9ndgA6SeamOVqIvnSLALNTaJ/1qk+hDAUaUia2oMyWo=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmlQtLnK6pKUWJCjyXPMYVOsL65XCYTP5NhcSpY
 eOukxtor6qJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZpULSwAKCRAADmhBGVaC
 FV2TD/9zZtI/vedDrTy96AC8cI7i2jC9LY1OAN0NoAgel/BeFn6k9RjMTxIQWQbiH2o6gV/3MnP
 AxZTCYCKkdAx8JoJ/LxOofGJkV9as2F6pRvEdCbEKqpM0oN2BCSHx+y8wEnDbhreyaJ15S6BK7G
 WGK1oTeFp5bepzFbdrBqFIPOJa+H9uBcBVBKJI87kGmsDlwhH+m6Pg0sTS1vul5x5rCPZj9juq0
 R7c4hi26Ps6IrOd4hYTLRqd2675pVV3O2rz8TX9X+Oed+0MoT2jLfselRBPqe6d120MaGE+n2UF
 VzrHalOrwXSfEMxcVUSiLmZ1bV7InDyBh5dntAjDTIV3nq7Z/4kzMJRHxiwkLMDKZ45Izs1vGr+
 wb9AaLd8iDzQA+qIqo9/TSlvXPHQHOwRBPp6SBGklmMXcn36ivp65/TLsjGYEX3l5Ak5n0tlEC1
 Cycz+tnTyixMwAk8MwRtWrEHHc6J2SyHtMj3Qzfl6zuj7mviD6vXwQpeVxujMEI36Djk69bGbpE
 wJSxDmFj4/wQH47TExYxkvURiJcKKHxVAS7QD2emnR3oLdNtraDPpNpsPzHeKxnGLrv4T28+rIH
 345rkK8BZMa67b2y/u9adtoyIo33qET3VA3LIYCtZZ4mwKMEPc87RGGF/n56oy18gB4CK4IHJs9
 ytfYBJZtVhVEaDA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

The original nfsdctl posting required the user to set a threads= value
in nfs.conf, or autostart wouldn't work properly. rpc.nfsd has a default
of 8 threads, which is pitifully low in the modern age. For nfsdctl,
double that value to default to 16 threads.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 utils/nfsdctl/nfsdctl.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
index 55bf5cd21783..eb2c8cca4f42 100644
--- a/utils/nfsdctl/nfsdctl.c
+++ b/utils/nfsdctl/nfsdctl.c
@@ -1356,9 +1356,12 @@ static void autostart_usage(void)
 	printf("    Start the server with the settings in /etc/nfs.conf.\n");
 }
 
+/* default number of nfsd threads when not specified in nfs.conf */
+#define DEFAULT_AUTOSTART_THREADS	16
+
 static int autostart_func(struct nl_sock *sock, int argc, char ** argv)
 {
-	int *threads, grace, lease, idx, ret, opt;
+	int *threads, grace, lease, idx, ret, opt, pools;
 	struct conf_list *thread_str;
 	struct conf_list_node *n;
 	char *scope, *pool_mode;
@@ -1399,26 +1402,29 @@ static int autostart_func(struct nl_sock *sock, int argc, char ** argv)
 	scope = conf_get_str("nfsd", "scope");
 
 	thread_str = conf_get_list("nfsd", "threads");
-	if (!thread_str || thread_str->cnt == 0)
-		return 0;
+	pools = thread_str ? thread_str->cnt : 1;
 
-	threads = calloc(thread_str->cnt, sizeof(int));
+	threads = calloc(pools, sizeof(int));
 	if (!threads)
 		return -ENOMEM;
 
-	idx = 0;
-	TAILQ_FOREACH(n, &(thread_str->fields), link) {
-		char *endptr = NULL;
+	if (thread_str) {
+		idx = 0;
+		TAILQ_FOREACH(n, &(thread_str->fields), link) {
+			char *endptr = NULL;
 
-		threads[idx++] = strtol(n->field, &endptr, 0);
-		if (!endptr || *endptr != '\0') {
-			fprintf(stderr, "Invalid threads value %s.\n", n->field);
-			ret = -EINVAL;
-			goto out;
+			threads[idx++] = strtol(n->field, &endptr, 0);
+			if (!endptr || *endptr != '\0') {
+				fprintf(stderr, "Invalid threads value %s.\n", n->field);
+				ret = -EINVAL;
+				goto out;
+			}
 		}
+	} else {
+		threads[0] = DEFAULT_AUTOSTART_THREADS;
 	}
 
-	ret = threads_doit(sock, NFSD_CMD_THREADS_SET, grace, lease, thread_str->cnt,
+	ret = threads_doit(sock, NFSD_CMD_THREADS_SET, grace, lease, pools,
 			   threads, scope);
 out:
 	free(threads);

-- 
2.45.2


