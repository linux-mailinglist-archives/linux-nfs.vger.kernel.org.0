Return-Path: <linux-nfs+bounces-11453-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4ADAAAEA2
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 05:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4505B3AAF75
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 02:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A53635AED8;
	Mon,  5 May 2025 23:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFV5ElRQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B4136E084;
	Mon,  5 May 2025 22:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485845; cv=none; b=YzRamGoTMEJeCsGPzTP8a7ueyGMwDEKmTIgtdWHvgBmroF/cfsZd5l1TF0/qkOYJEwfNL4RFnzfIze8r+FS8MZpps7WvGq2yMKY1J1ZRPWHxAn9y9p1uMQM8VXjBuUeCANiUiU5HLUgscCb+qIcil2+a/KEiA/XbuTKYd6s2MI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485845; c=relaxed/simple;
	bh=BYmx1SoM6cZjl6yYUpyus6wm6SDYezgd/kLQ4Fl4VDg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Okqfcs4riMMCnf4CQfktVjj1zAWS/T+1nnJF5ytAxhcuK8vkma+jP7lof2nSbupnBuR026BMhIaY5QBuyt+tgsHPDDkr09NaL72ZUtKScyvFEzEOBFa4jT3Uwb71XMJmszPpQTnf1CTQiUZVa89vAwlemhge5Zku/49dK+nsPGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFV5ElRQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4652AC4CEE4;
	Mon,  5 May 2025 22:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485843;
	bh=BYmx1SoM6cZjl6yYUpyus6wm6SDYezgd/kLQ4Fl4VDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EFV5ElRQrki9YQMhBEsQx3PoIC6dy2baLUqIqTiyxmsfcJaQlDmfQ8SUB8PIPokYn
	 ahNIxnYEDGokMpE0AhqkorrybpryrCbSa/IjP11RGZZkR9Y/QIjbqQu93oCz8WEnIr
	 N2JEldHJaiXBJZStEu3xH0Yg/rYVDKo2HzW4AIN87/bQUklIf1KLkd+QzRdxA/WVnP
	 0ewm1sx9KvYsoSQsNoTEMsz2yUPBjCzjMkf3dyZ2UTzgZM/62LViYs/14unXa+P9Vb
	 wI9CTrZh2x7n1LeFWI2cFQPECBJnJgOw2I+YB4YcOpyof/b0IYWBjM1UkGgpNJofg1
	 M++MS0XiweFjg==
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
Subject: [PATCH AUTOSEL 6.6 024/294] SUNRPC: rpcbind should never reset the port to the value '0'
Date: Mon,  5 May 2025 18:52:04 -0400
Message-Id: <20250505225634.2688578-24-sashal@kernel.org>
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


