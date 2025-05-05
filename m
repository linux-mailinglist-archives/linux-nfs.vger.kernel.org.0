Return-Path: <linux-nfs+bounces-11455-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2180FAAAA56
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 03:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 966E44A1EF4
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 01:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563672E5DE0;
	Mon,  5 May 2025 23:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYQeFRIV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043453628D5;
	Mon,  5 May 2025 22:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485843; cv=none; b=WYcc2fzH9hn4603kaHyBRYLxCmECXku4gBasccUbw/tv+S6xqfaCRE1zJbmRHuSgh/V5xeycnZ2QpL3EI/q+z03NoTu13uUIHNi2DZNkeHqg4Dn6sOLTLScpeJRcWxb26rnYGxs7YKO0jnG52GBNJhwSJCbJyUrY/b3Jt5JyqgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485843; c=relaxed/simple;
	bh=HeeP2xKYVYs1yu+7i+b43zQrFagrYyxzptijZfungNY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nKjLnZBU0WnSCPzmTQkYQ+RwbHcrD54eaS5XkRLIfYi+6V7N0PfsxoKlYfZj7yguEsBpldR/MtuFqZ3baeZ2JjG5RXkBptUyrvMRP48g6auSQIcqc2Cjz0t0fHHF4iptv4/YWPg7EfZIGgklLyebZuHsdjkCpv8LAX6spVKHPh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYQeFRIV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD6BC4CEED;
	Mon,  5 May 2025 22:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485841;
	bh=HeeP2xKYVYs1yu+7i+b43zQrFagrYyxzptijZfungNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SYQeFRIV1rcp6Go5LUDQB1Z6jjeWJSA0RsWEfGwBxx+pq9QStsBHd6iQgBalEOZS6
	 7U6MqipFPAawm8gd5FWc49xuVrGteHckU3AcCm1LsLtGUWWRqlOApxk4wgLFZVZQ+k
	 IXIlaxqLa0UganU94x/bqURLbqrD1KWiO8TI18haVNHFCqsvH1HOpLhcVf7qA4Z162
	 eJPNUsjnX/PDyH6W5rGh6GLuSrN0cLrQc2cmbB/Wqp6lD8JAp3B51xfQ0Dc8sOzIsP
	 Ys6PaMy0Bs4g8cee9SZwfF8+jzROIF/2ACHfWTA6th5Ay2CzbnMygVJ9BIRKhYq2Fp
	 Ciw2dLiXNW5bA==
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
Subject: [PATCH AUTOSEL 6.6 023/294] SUNRPC: rpc_clnt_set_transport() must not change the autobind setting
Date: Mon,  5 May 2025 18:52:03 -0400
Message-Id: <20250505225634.2688578-23-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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
index 142ee6554848a..4ffb2bcaf3648 100644
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


