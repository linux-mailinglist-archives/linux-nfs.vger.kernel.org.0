Return-Path: <linux-nfs+bounces-11010-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF39A7CD68
	for <lists+linux-nfs@lfdr.de>; Sun,  6 Apr 2025 11:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A87763A9934
	for <lists+linux-nfs@lfdr.de>; Sun,  6 Apr 2025 09:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0958919D07C;
	Sun,  6 Apr 2025 09:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rbhj0LwD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E72380
	for <linux-nfs@vger.kernel.org>; Sun,  6 Apr 2025 09:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743930687; cv=none; b=oZUU1LF4sk2CdevEyUy7OIhbt5JDqOpkTjiDUq4BCmY5hIo5q+NZw3Q3ectVtWzNTUvTOXeK0UnMSziVio4raFJV5Dhs/l3oLgDhmSi8Lof7azqN6+lTMOg0JhkExr+i9q4gf+ewR5Cw8J+SLXIX0v+VSAmIUde91bWkkpcSDZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743930687; c=relaxed/simple;
	bh=QQ1/LRX6zAtO2EoryYvWx/p5rVyH6SYogM8Ng43wnIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kg3ImmIVYBfa7est8wQMLN/nDHJujIBdX+FYT3rhg4nCLDSwqZZF6az4dLnLo6Qk4TRdcIYYyPqw2QFOaw/SgQjvZeVIc9S0WbP/R5hg5n59mo2QaYLVpsTBI30WhNOH8ocDuvWwZ2NYPzwh+Ox9P70ch03zWmo+VUnUro5/dxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rbhj0LwD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40723C4CEEB;
	Sun,  6 Apr 2025 09:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743930687;
	bh=QQ1/LRX6zAtO2EoryYvWx/p5rVyH6SYogM8Ng43wnIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rbhj0LwDKDtSU/9bCdZO1inXxf0JH0TxlXwTDDMaAeBKfavQ6LUPwRkGRYn5Ga3NM
	 s79Hyta6qcLbv9jaEMVtoQX/pNzW4Q+3m21od9kxTQFYELKGcZin3+9OOeIDjjKgoA
	 GsgKRyedLgYBzOWnd1LJjU/6abF9xlCNb5jdFHXlOhotgVJjPNJQbqfnykqgYVN5iO
	 Z3PC9+9fuGHIoAWa2m8+RGu0i437+VfALsvFymZZiNPou3Yxh48LGZ0bhFaQqsVJBt
	 RQWhS57gKPwamkSoCIjzS75WLeiWUXZPV5/A5MentlQyCrqhFLNVv+Bo9Pv1KnXyWE
	 6EQmbRYMUtHJA==
From: trondmy@kernel.org
To: Omar Sandoval <osandov@osandov.com>
Cc: Jeff Layton <jlayton@kernel.org>,
	Chris Mason <clm@meta.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] NFSv4: Handle fatal ENETDOWN and ENETUNREACH errors
Date: Sun,  6 Apr 2025 11:11:20 +0200
Message-ID: <756e03b4405f80344f98a695f49e50dd3a1caca0.1743930506.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1743930506.git.trond.myklebust@hammerspace.com>
References: <cover.1743930506.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Ensure that the NFSv4 error handling code recognises the
RPC_TASK_NETUNREACH_FATAL flag, and handles the ENETDOWN and ENETUNREACH
errors accordingly.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index da97f87ecaa9..f862c862b3a3 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -671,6 +671,15 @@ nfs4_async_handle_exception(struct rpc_task *task, struct nfs_server *server,
 	struct nfs_client *clp = server->nfs_client;
 	int ret;
 
+	if ((task->tk_rpc_status == -ENETDOWN ||
+	     task->tk_rpc_status == -ENETUNREACH) &&
+	    task->tk_flags & RPC_TASK_NETUNREACH_FATAL) {
+		exception->retry = 0;
+		exception->recovering = 0;
+		exception->retry = 0;
+		return -EIO;
+	}
+
 	ret = nfs4_do_handle_exception(server, errorcode, exception);
 	if (exception->delay) {
 		int ret2 = nfs4_exception_should_retrans(server, exception);
-- 
2.49.0


