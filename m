Return-Path: <linux-nfs+bounces-11450-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF32AAA8AF
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 02:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37C1E9819A0
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 00:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B7934F3FD;
	Mon,  5 May 2025 22:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQv0VYFj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6656834F3F5;
	Mon,  5 May 2025 22:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484819; cv=none; b=rm8udc0vJ9jWS0CgGtEtvCyzzN+5/daNGy5OWFaJLcyf0TyMyLj55Voo+VrYUpHEIiigeIAnwyzlip0/29/C0NzqDTikNTAWVYjk0K5wBPBu7/ZhWGqMaMclfFJKmWqBgaXFW5GG1rFMJGEjWSZdRszU8fQNDsaNL958uN+y6Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484819; c=relaxed/simple;
	bh=I6VG9Pixgg4LLA3tT9Zm4qv06ripXUr6WYd2xPhr65A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c+UAnyiyDUV2MQGwQoJc4sjPHhQtuSvvdmVB44l3emmrFZE6iv2CGm2v058kJYnBSQPyLkGGmrIv9ohkm4QhIGNQgI/x3yjhEj9O+3DoinBJQXYL/LLhg7KiIiUUxJfo051aTvbY/sfimks58m29wzdOuE6HUSdRZo1vOXbBnB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pQv0VYFj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C14F3C4CEE4;
	Mon,  5 May 2025 22:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484819;
	bh=I6VG9Pixgg4LLA3tT9Zm4qv06ripXUr6WYd2xPhr65A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pQv0VYFj+ifgOBf8bdtJxroh+fplRUj8jiEUGreCCUh4gEyKp9ilXTXTkLE+O+Kvg
	 +BrMz3K8GNTpnCenV/X6IBMdG+h8J+/arQUoQD6yamMTT4oZCfJwLY2vfarNx4PzMK
	 vlZV6V3Nr89jlNCNN54iuf+Sj9ZoeUFcqoQdx4ocPjF9N5u/QsOfUaCkKWfnj5hGra
	 XLAfgW0tbg6kQLuy6BZ5RypgPhqxAD03ThAfiYJRLJo0FWKAMZsTi2OyeVsde0/MmX
	 gs0N0LHVby4aqeA+7iga3VUcvZL0NgJXMC5gjdsdv6PrWBYH40+70UAdioXnnGCGzV
	 bjyhoXiv37qBw==
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
Subject: [PATCH AUTOSEL 6.12 029/486] SUNRPC: rpc_clnt_set_transport() must not change the autobind setting
Date: Mon,  5 May 2025 18:31:45 -0400
Message-Id: <20250505223922.2682012-29-sashal@kernel.org>
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
index 0090162ee8c35..17a4de75bfaf6 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -270,9 +270,6 @@ static struct rpc_xprt *rpc_clnt_set_transport(struct rpc_clnt *clnt,
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


