Return-Path: <linux-nfs+bounces-11463-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3416DAAACFB
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 04:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A5F616D6AB
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 02:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84223302220;
	Mon,  5 May 2025 23:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ors/B6xE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A9C28AB0F;
	Mon,  5 May 2025 23:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487122; cv=none; b=cPcLZxrWvaz3oMJJmBrPzr9E+/A7E2k3oex9rWYbKJzhyx5BkfEHmGhflcONLg+0yGPzX2TwlwpKYmh2pSU5Z0nZ/iby6fKDmwD40LRG/ZNMBtU+jcIiA8cmerKLbH/coWFaL5qn5hsGSU13qJOmqFSNTY2dEG72V1sv4xmb3dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487122; c=relaxed/simple;
	bh=5tlNQsO/DZGUsjYC+3qaziA6u0GM2G5/h4k4py1pbUo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=odTMNPJj3LEwxix1imy1abrTM9ddPKVWYEh0cMcaREIwp329lUnVaMhFQ7wvIT1NDVIRyrk0o722wJKcLzU7R7xYl8BRY/E/9o8O/B1WGL16aGsKPQk0X/l2+A9EfGjLgZV4FnP5TffMpYzC8UivH5hjDj4nCeZblN70eBRT0R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ors/B6xE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 287DFC4CEF1;
	Mon,  5 May 2025 23:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487121;
	bh=5tlNQsO/DZGUsjYC+3qaziA6u0GM2G5/h4k4py1pbUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ors/B6xEFlb0368UXTlH6meioL9PTfpt+Vs3OBLdY85A+w9EoP0G60Jk7FNWY11iU
	 OTp4oe8slD/FclWYC72l9EvpTn9NoMgPoZBDrpJ3sO06HHbs1VBjUOvRQ54kDMp1T9
	 /rlEHX0SEDyZvjhjHprATlDUAlfUVic+I2qkKmXieu8wBzqE9o6lPPVQpgLJpIhfnh
	 SIj9ddAPT0MCyRSvBi1MJNLf7RxJ9p5Pt3dKpaUeMSpxSzGGWqQzny6dPJdaEPfLHB
	 YMknf7agb3c47Q54BUsiT6LDVaD3vscJjsl6ZqqluZwiN8Tr92ZvFIKX5HbTyLyzm0
	 kDZwP0A8uAT9g==
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
Subject: [PATCH AUTOSEL 5.10 009/114] SUNRPC: rpcbind should never reset the port to the value '0'
Date: Mon,  5 May 2025 19:16:32 -0400
Message-Id: <20250505231817.2697367-9-sashal@kernel.org>
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
index 8fad45320e1b9..f1bb4fd2a2707 100644
--- a/net/sunrpc/rpcb_clnt.c
+++ b/net/sunrpc/rpcb_clnt.c
@@ -794,9 +794,10 @@ static void rpcb_getport_done(struct rpc_task *child, void *data)
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


