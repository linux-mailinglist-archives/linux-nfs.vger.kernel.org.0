Return-Path: <linux-nfs+bounces-11475-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35767AAB736
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 08:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C424F7A84AC
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 06:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757C838DC3B;
	Tue,  6 May 2025 00:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tmdNe/Uy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA862F2C58;
	Mon,  5 May 2025 23:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486826; cv=none; b=nANvbjKTGVAwxHUOa6cC24GpBNnIIU1pbxkD9OidRdaZuSa2QX8VpUNEdfHi33Fd1hoWK3JCb0iiutcaKZo+6Wd+JJ/udkAi2xbhK2JWpB4MtYV9PEhr1mJrRfC4+QW2DJjj9DQfDTM+S4hxrCxhn5BfsBYIG52yDrEZHLBzfRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486826; c=relaxed/simple;
	bh=5zCAUR5fKm9UzdL5/oPX1lm7XAncAkCAaeT6OXBH1Ak=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hh7jko7Ka5KLKnbVV8lEI0FRuFyIBZNo8woJvL/M1EqM23wt0MOeRUnH2r3VWi65px9gRrG3PdrvpgkX6M4NS4EthsU4faDFIJf1VNjyicMBXXbOCLSebjKFQrDhfIH5yXeW7siLhVScvFiGQd233LScRTSMKTiRo/FKbYy/qFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tmdNe/Uy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 749E7C4CEED;
	Mon,  5 May 2025 23:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486826;
	bh=5zCAUR5fKm9UzdL5/oPX1lm7XAncAkCAaeT6OXBH1Ak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tmdNe/UyZQZP1nziO5XkoXFitc1fkwACYkXzyTZ/YFb/HFE4390mzuuG1GXOVRnec
	 U8Fz611TATT/pJnFJ3B+rIBxbpzlpR6xhz7YWcIRVpJXW7BNbLxCHIm9h/2dzY+Ujt
	 HMf5oRbtFbJG7nW9E/c+/Kw7V3pwq4XhliHpKEuS0LLWu6HycfUB9/joadUkHBue7+
	 g/gR9h+F7GnytH91bvORtV8gAXrMFPn37dxU9oWWIrREWtXtAxbtZREoBmsl44NTC4
	 EXcNaEnUb7Ql+Ys4m0cY9RkqgsA682HW1RjgUmsC2uz3BGUfQP1adeSVFABu3A31Dc
	 hsOyeBpYAuSPA==
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
Subject: [PATCH AUTOSEL 5.15 010/153] SUNRPC: rpcbind should never reset the port to the value '0'
Date: Mon,  5 May 2025 19:10:57 -0400
Message-Id: <20250505231320.2695319-10-sashal@kernel.org>
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

[ Upstream commit 214c13e380ad7636631279f426387f9c4e3c14d9 ]

If we already had a valid port number for the RPC service, then we
should not allow the rpcbind client to set it to the invalid value '0'.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/rpcb_clnt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/rpcb_clnt.c b/net/sunrpc/rpcb_clnt.c
index 638b14f28101e..c49f9295fce97 100644
--- a/net/sunrpc/rpcb_clnt.c
+++ b/net/sunrpc/rpcb_clnt.c
@@ -797,9 +797,10 @@ static void rpcb_getport_done(struct rpc_task *child, void *data)
 	}
 
 	trace_rpcb_setport(child, map->r_status, map->r_port);
-	xprt->ops->set_port(xprt, map->r_port);
-	if (map->r_port)
+	if (map->r_port) {
+		xprt->ops->set_port(xprt, map->r_port);
 		xprt_set_bound(xprt);
+	}
 }
 
 /*
-- 
2.39.5


