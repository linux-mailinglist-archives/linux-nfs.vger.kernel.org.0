Return-Path: <linux-nfs+bounces-11474-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99516AAB77E
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 08:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED4EE1894D16
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 06:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A6738DC0B;
	Tue,  6 May 2025 00:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9Y9U0/C"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3296B2F2C51;
	Mon,  5 May 2025 23:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486825; cv=none; b=B8g6dEZkwX+uruo+KE/83P7xGT3ZDuDPvRsxceqcbuR2jbfSwA2Z6m3OjjovLdXaPt759C6AjVu/0Ko/5xMA87YdlJbBUIUa8Nx97jqq87GnZaXjx3MSdLaMIStyMnsk2ilx+W4cDrTRAXyKblLygmYzA7VB6P9AyTIqxMw9u4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486825; c=relaxed/simple;
	bh=IgM49T9ksnvRHRuSeR0og7Jw/nAXyFhvqciGhoiWpq0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=io1MWKRPlxOOQW02tHi1/G/VHNJQedK6/MHznlJpKlaxd1+ckEl6anstUhoSY2bSQ+yh2RpLq10A0hB0wBgbI5Q5WOKPGYjkBx0Caa/dN9p28ehb44Jv0VWd0hkgBppJRJlc1qQBLLHYN90FK1K2QV0anCSCcpN5b5YyjoBg4TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9Y9U0/C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 800C0C4CEE4;
	Mon,  5 May 2025 23:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486824;
	bh=IgM49T9ksnvRHRuSeR0og7Jw/nAXyFhvqciGhoiWpq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q9Y9U0/CSq5T4vxjkYK/oIKDxxkCG/5eCBi7E35qOuBT4H70yzMWkTj/WbZW+a6JR
	 6N6cjbhXRNAjDKvtEN+VRryjrzvGwjU3BPtpn9yYoCdQPjfLREEnJtR7EXwM55Zusq
	 shQGusD27xQrqZ684f5EFnjbk/m8t4B0YnklQ5a8NWL99VZl1Gt0fRe4ko+EV9iYLM
	 w0NObSEwJ+0KzjzxMvNF/hWAItSIBXHzlFysBXfbgJNIUzb4hqhhlBSvfYXzZDi6JW
	 QuLbcqJgU9s2s+j22bSVFvR7ksUbwqNiIUHRL5biJFdndWX14LZ9x00BQ1dZ1CeByZ
	 Xy9qAAfP4jBZA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Jeff Layton <jlayton@kernel.org>,
	Benjamin Coddington <bcodding@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	trondmy@kernel.org,
	anna@kernel.org,
	chuck.lever@oracle.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 009/153] SUNRPC: rpc_clnt_set_transport() must not change the autobind setting
Date: Mon,  5 May 2025 19:10:56 -0400
Message-Id: <20250505231320.2695319-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit bf9be373b830a3e48117da5d89bb6145a575f880 ]

The autobind setting was supposed to be determined in rpc_create(),
since commit c2866763b402 ("SUNRPC: use sockaddr + size when creating
remote transport endpoints").

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/clnt.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 5de2fc7af268a..48ffdd4192538 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -275,9 +275,6 @@ static struct rpc_xprt *rpc_clnt_set_transport(struct rpc_clnt *clnt,
 	old = rcu_dereference_protected(clnt->cl_xprt,
 			lockdep_is_held(&clnt->cl_lock));
 
-	if (!xprt_bound(xprt))
-		clnt->cl_autobind = 1;
-
 	clnt->cl_timeout = timeout;
 	rcu_assign_pointer(clnt->cl_xprt, xprt);
 	spin_unlock(&clnt->cl_lock);
-- 
2.39.5


