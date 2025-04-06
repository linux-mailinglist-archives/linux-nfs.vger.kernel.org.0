Return-Path: <linux-nfs+bounces-11017-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CBFA7CECB
	for <lists+linux-nfs@lfdr.de>; Sun,  6 Apr 2025 17:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3466A3AE5E2
	for <lists+linux-nfs@lfdr.de>; Sun,  6 Apr 2025 15:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050482192E3;
	Sun,  6 Apr 2025 15:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O154CVqz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C4713AD05
	for <linux-nfs@vger.kernel.org>; Sun,  6 Apr 2025 15:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743954360; cv=none; b=PcRDaaar1f5Hp+OmL/iCHcG+fkaRz/AJo1bv8+zwFBmKkNVELE8te62/pCZVvfv8qZ6D+m+0dXWGPM38YDgplp3cTXJ/B2dycA6nE6dsfQExwXdinAfQ7c1qVLK0JNbchlaiIrB4PMqJBdVG68YaB8mXtt31rxLZIr6Kl0UPUZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743954360; c=relaxed/simple;
	bh=KpOn2LYB3Dr6QIeHVQOZJ1JPb6pUecVCd6Kmkke8F6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sXvsbfUeyDxkuxBqPAvUbmnKDn7/Tn5ySeubQE0w5TyRnVmNVQtv1Mp0V6xvKAhCpRBmqTqrijbcnQXZ3aFTcX2f0OA++at5zJQZ35yxeVgIe2Cx1B6KwEPfjJJ8G242DyTIODaVK8HvqG/Je69KtOsFoyVRcZhtI4qxVX5/nxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O154CVqz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2FBAC4CEE7;
	Sun,  6 Apr 2025 15:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743954360;
	bh=KpOn2LYB3Dr6QIeHVQOZJ1JPb6pUecVCd6Kmkke8F6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O154CVqzJE0GkxkxPyE/DZvnu/VAdo/4H7Qzdjk6CzBXbtM6mnb3sPpYyD/rO4ggU
	 yuqEeoRQFqIOev5bYN2bmtaWzQ3ZZvbNYZf4aTNWv6urwG2fH9u6FfcO627S8n0GgM
	 l5Rd63VtHM9yqqXGWI8Go5l1Nk9GaayYf6K7fXj28kAbom7PZLuKkiK0BVwABKoGH3
	 +XVjK7p62UrEoo/1P2XkfH7HprdhL1A3KQ6dkPPzNF+JvsbnW2JjFtQtKDgp9RUcH8
	 I6g3c1d7dG/StsEWj8iu4jSn2oun+m4AAVyEIEBp+k4GYNlEcihBxZZgnImrSrZYYQ
	 swNrHJHktb5pw==
From: trondmy@kernel.org
To: Omar Sandoval <osandov@osandov.com>
Cc: Jeff Layton <jlayton@kernel.org>,
	Chris Mason <clm@meta.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/2] NFSv4: Handle fatal ENETDOWN and ENETUNREACH errors
Date: Sun,  6 Apr 2025 17:45:52 +0200
Message-ID: <2ed0d30380a95b8731f0afe433560d0545e65553.1743954240.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1743954240.git.trond.myklebust@hammerspace.com>
References: <cover.1743954240.git.trond.myklebust@hammerspace.com>
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
index da97f87ecaa9..01417e3099e3 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -671,6 +671,15 @@ nfs4_async_handle_exception(struct rpc_task *task, struct nfs_server *server,
 	struct nfs_client *clp = server->nfs_client;
 	int ret;
 
+	if ((task->tk_rpc_status == -ENETDOWN ||
+	     task->tk_rpc_status == -ENETUNREACH) &&
+	    task->tk_flags & RPC_TASK_NETUNREACH_FATAL) {
+		exception->delay = 0;
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


