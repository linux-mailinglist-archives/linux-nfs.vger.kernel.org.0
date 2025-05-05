Return-Path: <linux-nfs+bounces-11458-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C08EAAABC0
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 04:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BB633A75D9
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 01:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3602F8BCA;
	Mon,  5 May 2025 23:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DETAdiiF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61727397A7A;
	Mon,  5 May 2025 23:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486425; cv=none; b=oOVTy2sdG4gL5VPIAqhjN0CBsTwCqdJ+Ilw4poahl076REgMdpRlA2pYA5i6aBJOI/KXcv/TtUCiyvI30JHdq0DslhN46hFNSconvpIcLvnUmJoebApsRHEcFHsMXpJeHcIgocvv8ljxa3DkVU+FrlOEq3KmlltOq34qjGOxUgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486425; c=relaxed/simple;
	bh=iWcob6meNTskfImD0NHWwk6pQ0/76ij2r6zAjbghmU8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OpQiDORsRoPQA4SRwJEDDoPxuvg+pDCKG4CksVrYYv+DaWG3KZR5JqwpTB63R762pr3GX2ZQqne6YLzpzF1AYkr1V9UViZlFOAHSghyUskzdwyOeEkpcut3xMxKfjMxu8g5xJK7uuDfdN4xmfmlMfpR4rH8dn5ADveIX/7lZ9RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DETAdiiF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF65C4CEE4;
	Mon,  5 May 2025 23:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486424;
	bh=iWcob6meNTskfImD0NHWwk6pQ0/76ij2r6zAjbghmU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DETAdiiFUaITwpd4ZA0PNrBcT+atU7Dg14dRckFe+KFKqI1Rs4pFR/ZHVQoZlmXDU
	 cQk/2N3Eeg1EA4K91u8Y/WppwDF7VgicZMK6mo1n5mDJwUz5nJ04wXIHyewij0ZE1l
	 3U8DmfGRpp3lC98aTTf2jFAFxd/n+rMaxNnDbiKFhGP0ne/o4KMDiAF3HbxFn+IkH1
	 yxv47B2Ab5v0rBpRofbgL1JsYSQLnhHqoEBm58oQZglnszg4s6pw+vPQ8cKxnYxt4S
	 e/je2rxhLhQGHT0bjV8e/h/rR2CLc1bcZC4G0vomSsGZBOjGgNN3v757nI317c0Ykp
	 N9424aTv9AlhQ==
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
Subject: [PATCH AUTOSEL 6.1 019/212] SUNRPC: rpcbind should never reset the port to the value '0'
Date: Mon,  5 May 2025 19:03:11 -0400
Message-Id: <20250505230624.2692522-19-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
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
index 82afb56695f8d..1ec20163a0b7d 100644
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


