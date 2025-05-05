Return-Path: <linux-nfs+bounces-11462-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17927AAAFE3
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 05:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17CA77A7D06
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 03:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E75E202C5C;
	Mon,  5 May 2025 23:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHsvez8f"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C13D3AAC9B;
	Mon,  5 May 2025 23:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487121; cv=none; b=sG2uofVXC6yc/xi23nubqrUhMkNyzwkuyTHMYqFL0fjYFyi/K1jg8/OUSmSVOoSYxnNHeE/VR+EDZWRomISwvnxZOJScSatK69SC8T64IKFgSj10u5jJAxUODguCX6YX5B7FXxITT6vh5eMCfdjCN6+3Dcl6tIXoPeN7N7UPcqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487121; c=relaxed/simple;
	bh=Z0ttmRYVVdxOD0UDIR1vXxrkZblPfNce2r7moqOmxgw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dpfM4Cc1vJBFTlywcrQNJiJMOTFPWXVFovGZ8QUtH79tAI7X6Ul7R29w5ahA388u+nEh7/OllOsGQ1nZugbJuyYL0Rwd+MhoYHQ69cOv5ALJ50BRWEGObq31Bg91LFiLaiZp0bAJU6zWc6haJNXPG02krbJ1yQEAkssuUVgdQAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHsvez8f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E63DC4CEEE;
	Mon,  5 May 2025 23:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487119;
	bh=Z0ttmRYVVdxOD0UDIR1vXxrkZblPfNce2r7moqOmxgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KHsvez8fy9aXjUDjH4N1L3stkUclTwkk4SOux8JsMyJ+jcTANzXxacpGgLP2KNTYi
	 4WA11sdc4Y7Sl8yaA7xtthbgqYSxopbssUbo+isdh0d9+oyhdokD/lAnvmmSdyb76R
	 P3N4CUxWYlM6hd/VURPz3sJ7q+UZ66JZMe/R2w4toJ/vpw3m8iF1SjTwTTwsjc21+I
	 UvVhj0MA9oKhLKn/3QDyQYWVYE5/ClGGinXJ6uUFMAPbtIFfjwiBNskFFuMw9fd+l+
	 p+Fy9dO6KpIExNyx/vmONxk76JB/m6ltqL70hY6oVp+T/EPkZx+NX0SSNZA3uWa49V
	 qoHyZYbR+sLsw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Jeff Layton <jlayton@kernel.org>,
	Benjamin Coddington <bcodding@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	chuck.lever@oracle.com,
	trondmy@kernel.org,
	anna@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 008/114] SUNRPC: rpc_clnt_set_transport() must not change the autobind setting
Date: Mon,  5 May 2025 19:16:31 -0400
Message-Id: <20250505231817.2697367-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231817.2697367-1-sashal@kernel.org>
References: <20250505231817.2697367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.237
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
index 7ec5b0bc48ebf..0a4b4870c4d99 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -273,9 +273,6 @@ static struct rpc_xprt *rpc_clnt_set_transport(struct rpc_clnt *clnt,
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


