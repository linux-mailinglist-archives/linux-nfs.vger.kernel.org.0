Return-Path: <linux-nfs+bounces-11451-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6A2AAA8A9
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 02:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC8F17B13A9
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 00:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AF034FAEB;
	Mon,  5 May 2025 22:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eo9JhrvG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F1934FAE6;
	Mon,  5 May 2025 22:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484821; cv=none; b=rn6wmIBqLa7r4YJmRSC1DqvJewcijyxMYqHZMhSagjfowXZk6M/A1HibobVD4motjUlP5kIPkrGzvi+0bUGqm57Cc7IpPayFGD22Smv0YfxAays1ZKr6NpzSAAa6fJGLjTyulAkRq4nytSjNy72+Uzwq6gMgsu9+H60sKOem6fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484821; c=relaxed/simple;
	bh=BYmx1SoM6cZjl6yYUpyus6wm6SDYezgd/kLQ4Fl4VDg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XpAmIVKxch2dinWFmc6RLtyUZmxtaYthjVsco6vYXtmRooeg48Xr6W9SlgczKvgN7+43YF9RS+f4S7BVlqRzoNeae5RMz+h+l/jlGN4LCBqcBUbc822hH9M88qB9FAWfRnUBjt7q2KADjPhNF2T+VygwYKjJ05H0xhkX7fZpN04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eo9JhrvG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A894FC4CEED;
	Mon,  5 May 2025 22:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484821;
	bh=BYmx1SoM6cZjl6yYUpyus6wm6SDYezgd/kLQ4Fl4VDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Eo9JhrvGKBrKck7wmWvTh9RjSkiL1DxMWo12WTqJmQajssuC45TgDS8eYprvF+Y0y
	 jbLXck/6eVvTRspHRCMMtFTRftTYM8EY7hVB9hHPyaHuf/VyTAjI23w/NpoNyXtc29
	 320jlQ0eKcoJmpBOeOuYy7NzNFgWWJ+405t/VGDf+sOuVIPp0Vzd9oAC4oNHnVGw7x
	 JNBtr1/GDyCY7Tbve3o8UjlnrbrjJfEC8FANKu9ttQw+gNxGiDoKtiEH3LrwOZWXNr
	 yE3Bx3AIBsKAgGBXieNbResBjJPNRlelgHGda410rhxDh9xRwnla5EjB/m2iVFElvn
	 Wv7jQlJ5xg92g==
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
Subject: [PATCH AUTOSEL 6.12 030/486] SUNRPC: rpcbind should never reset the port to the value '0'
Date: Mon,  5 May 2025 18:31:46 -0400
Message-Id: <20250505223922.2682012-30-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index 102c3818bc54d..53bcca365fb1c 100644
--- a/net/sunrpc/rpcb_clnt.c
+++ b/net/sunrpc/rpcb_clnt.c
@@ -820,9 +820,10 @@ static void rpcb_getport_done(struct rpc_task *child, void *data)
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


