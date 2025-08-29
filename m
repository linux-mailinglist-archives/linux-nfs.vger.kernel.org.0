Return-Path: <linux-nfs+bounces-13955-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D5BB3C167
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Aug 2025 18:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 569CA3BF81B
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Aug 2025 16:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D73D340D91;
	Fri, 29 Aug 2025 16:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KSXb9DTd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36059340D8D
	for <linux-nfs@vger.kernel.org>; Fri, 29 Aug 2025 16:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756486667; cv=none; b=pjUUmWvwunhodlLLkpRjI6s0M2ZdFWqN52AnRPpbOjOq4eLVk4kqJtA5RG8NmXuFCaKdYFelka9s4E0YO7oLCPp5JgH4QHH/F8JvSW5Qsit8vSrd+eJygZQbxPEu6+GqAjJ0JD7sMxMwLymKWkMJaIrSA93wEH4zvvnEFuysAGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756486667; c=relaxed/simple;
	bh=7d9FovC3Kpy4hcFYzWdo3y54qz9mhFPfy6X/lwwa4UY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P8EsmF5KdmsR2fqQ8n3GxLqzxehcIi7idZ15keLb17eegIiaHp/Yb6ZiLz/qDCOZGdR4TUArnTqQW5a0Kq/QVV/P2zxchRpaQ4ELBNvgHvqEe5BjEzgiPVfVe3gh+hf1MZSDkEj5wx59oPfOw2XC5eHI7T8eNgc70fh/3P6CnZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KSXb9DTd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF9CC4CEF5;
	Fri, 29 Aug 2025 16:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756486666;
	bh=7d9FovC3Kpy4hcFYzWdo3y54qz9mhFPfy6X/lwwa4UY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=KSXb9DTdU17XbdMrPt7sNmFgNJ0BvW6hPgSuZPxFJWLFpwtlY+WWgEsoQGbbpmH4C
	 9+qBkRuvnTfYP326MZ/Rf4Zeom6BaUMDUEtP5dtHqKhC7L53EkE3HkEmOOuOssrLW7
	 /yCKRFqhXC2reZJh0yjkXGKoTZSAzC28hUwqbTz/qHQpfcKRfaNTJd9Oujq4auJSiA
	 4+7TETjVgMSsFlyL7gwEz/KhJUFqM4nTpFPmzlxCbMYXv/ex8zFHa2wLmgJtejw8J9
	 K16+N4UN4w5tGBYf3tnWOJVKTcKqHa+2L8D/Aej5mDHH0rU2qDh9Bn7FEjIaXreANm
	 Vs3/3dqc4ensg==
From: Trond Myklebust <trondmy@kernel.org>
To: linux-nfs@vger.kernel.org,
	Scott Haiden <scott.b.haiden@gmail.com>
Subject: [PATCH 4/4] NFSv4: Clear the NFS_CAP_XATTR flag if not supported by the server
Date: Fri, 29 Aug 2025 12:57:42 -0400
Message-ID: <4fb2b677fc1f70ee642c0beecc3cabf226ef5707.1756486626.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1756486626.git.trond.myklebust@hammerspace.com>
References: <528e7a88-9c63-43d4-8c67-50a36ceda8a7@gmail.com> <cover.1756486626.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

nfs_server_set_fsinfo() shouldn't assume that NFS_CAP_XATTR is unset
on entry to the function.

Fixes: b78ef845c35d ("NFSv4.2: query the server for extended attribute support")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/client.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 8fb4a950dd55..4e3dcc157a83 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -888,6 +888,8 @@ static void nfs_server_set_fsinfo(struct nfs_server *server,
 
 	if (fsinfo->xattr_support)
 		server->caps |= NFS_CAP_XATTR;
+	else
+		server->caps &= ~NFS_CAP_XATTR;
 #endif
 }
 
-- 
2.51.0


