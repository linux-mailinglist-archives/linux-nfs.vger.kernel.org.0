Return-Path: <linux-nfs+bounces-11478-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A19CAAB5EC
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 07:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 403863A3EE4
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 05:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023A734C990;
	Tue,  6 May 2025 00:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/qIrMJc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D533B96F7;
	Mon,  5 May 2025 23:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487325; cv=none; b=TaaAd7CerSYgHUX1aLXDcidp0xO4oLv7SRqdMcUKpqj6c6FXvqW4rh/d0EdNtbhyJdEINJRM46xW95sTiB9H5gyKVbffvBOzfYMvjZ1CL+VnOK17rYLuuYS47tC9S4D33TsHXmtD8+6dqe0YE5LCA4yelwf6JtbLRqoypHNg/Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487325; c=relaxed/simple;
	bh=r2MZUQHt6DwOgzB2vWJnhnSAR1QWjHGXqGvtKXBEtog=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NAUkZe+upwL1bZkU4xHVjt/6ZAsS10NZbdMCCeFlIQ0eVMem0EEK5G7u61u1JngY9BJCpohv6CuCGeJf8qikRGUCr3AMYPpVxFd1L2lIMn+Ej1DV+7u3wAHk2+HBesSVDFivIzjhhtBuwpdXGBDXhkvis4oOrlEaIgKTwGo8y+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/qIrMJc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89055C4CEEF;
	Mon,  5 May 2025 23:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487324;
	bh=r2MZUQHt6DwOgzB2vWJnhnSAR1QWjHGXqGvtKXBEtog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q/qIrMJcVh0pUQ7yQm4G3j/TKIlCRDYXUdiEaTZa3J2FquicV8JrDh+WrfsVHH5AZ
	 EyDwlRDyaZfDHwYwNEZFWgL7EDR8YbiZTuyU98CeB+cOrOKQm2/4cdKX8cJtZJkYyJ
	 ZABkXHCkMNzn+BdMgqQV7ecmDg8npCZnGLyZjSYs/cKlrtUCUYReXo8O7RCvH+V756
	 7G1Ngvru+euMivhsRQMPg0rX1+FzRCfkHmoWw8d+1k1rSSV3dqqPEqK+klKDtMALKH
	 wLWx9HJbAUf5dPlp9g/N110FDNd/lbx7W23Is8K0JbH4hfUjIHL84Z8n6Q3Nxenprp
	 2bNZkOJwhiXZQ==
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
Subject: [PATCH AUTOSEL 5.4 06/79] SUNRPC: rpc_clnt_set_transport() must not change the autobind setting
Date: Mon,  5 May 2025 19:20:38 -0400
Message-Id: <20250505232151.2698893-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505232151.2698893-1-sashal@kernel.org>
References: <20250505232151.2698893-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.293
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
index f689c7b0c304d..d67cb10a11db6 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -277,9 +277,6 @@ static struct rpc_xprt *rpc_clnt_set_transport(struct rpc_clnt *clnt,
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


