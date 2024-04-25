Return-Path: <linux-nfs+bounces-3007-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D718B29AD
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Apr 2024 22:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F3FEB20D57
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Apr 2024 20:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E0C15350B;
	Thu, 25 Apr 2024 20:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cW+4wj2P"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF175153504
	for <linux-nfs@vger.kernel.org>; Thu, 25 Apr 2024 20:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714076671; cv=none; b=K8BjLRdJftNif2Ajn3DM+mD77huxu8Ky237J2S+Hw+JNXxr25EUjUk7Jl66ASSkzYvzjDnMYEFvR7UkUKpG3+mg/z89A2Wpw7Fo8UmUD+Nu+3oGsAQSsj2D9aaXW0nRzwydc6APwSc9N/WOTFrhyeg2181Lt2dI8/Ns5/hNThpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714076671; c=relaxed/simple;
	bh=giqIYydmORUrfq2me0HxmPc1r99/geNucjSKFzlMvB8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XkmAI916DybrlPq8i6pmVzH+sVGw+6bRrJuDCFQqfAUL+2pwUWaXJ8SCMNaL01rOr/92ezgITYkyO42D1XqWF+jmKkbc0kB+Tg7ZofYOa5Y8zKoSxbA6n8oZ0TxTXUREHjKSx5hS7ceHTpv1RQ9oaFUZWJroJeY/FFeHmffkzio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cW+4wj2P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 067C5C113CC;
	Thu, 25 Apr 2024 20:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714076671;
	bh=giqIYydmORUrfq2me0HxmPc1r99/geNucjSKFzlMvB8=;
	h=From:To:Cc:Subject:Date:From;
	b=cW+4wj2PH/A1smswoyE5p427zx10MH1TXQQvg1t7m0Zi3kvBSkAzLkd8jif43tNnE
	 hrLKms7BriGj5XzpFuCSsA98EBmHazV1uE4EBZPjz/gbUJ/RNix5BNh11/nV79tb7P
	 HzCqZ3e4NksO8Z9xgwwpz6eUe5q4cSCHW8cfd9SO+MZn3a2ULmNeNtRidVPF0YPFe6
	 O6qXX9ZQhjY8a6z7xnJo75W2cFpYVsJC/m1RMK3imV8AeE/EZZpjq/UHe7n/J1xc6s
	 qwW2nRW9zpTmcPjidKQEQmvdIWIkV998mjKJo7/o7rJTusW6WIWNiAtzpzXM7Dh2om
	 fgsVXKwtSiSHg==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH] NFS: Fix READ_PLUS when server doesn't support OP_READ_PLUS
Date: Thu, 25 Apr 2024 16:24:29 -0400
Message-ID: <20240425202429.439014-1-anna@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

Olga showed me a case where the client was sending multiple READ_PLUS
calls to the server in parallel, and the server replied
NFS4ERR_OPNOTSUPP to each. The client would fall back to READ for the
first reply, but fail to retry the other calls.

I fix this by removing the test for NFS_CAP_READ_PLUS in
nfs4_read_plus_not_supported(). This allows us to reschedule any
READ_PLUS call that has a NFS4ERR_OPNOTSUPP return value, even after the
capability has been cleared.

Reported-by: Olga Kornievskaia <kolga@netapp.com>
Fixes: c567552612ec ("NFS: Add READ_PLUS data segment support")
Cc: stable@vger.kernel.org # v5.10+
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/nfs4proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index ea390db94b62..c93c12063b3a 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -5456,7 +5456,7 @@ static bool nfs4_read_plus_not_supported(struct rpc_task *task,
 	struct rpc_message *msg = &task->tk_msg;
 
 	if (msg->rpc_proc == &nfs4_procedures[NFSPROC4_CLNT_READ_PLUS] &&
-	    server->caps & NFS_CAP_READ_PLUS && task->tk_status == -ENOTSUPP) {
+	    task->tk_status == -ENOTSUPP) {
 		server->caps &= ~NFS_CAP_READ_PLUS;
 		msg->rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_READ];
 		rpc_restart_call_prepare(task);
-- 
2.44.0


