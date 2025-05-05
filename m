Return-Path: <linux-nfs+bounces-11471-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BD9AAB733
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 08:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 377EE3A22F6
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 05:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020BC33DE08;
	Tue,  6 May 2025 00:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqrs0urG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE06F397A6D;
	Mon,  5 May 2025 23:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486422; cv=none; b=RKDfbIyJIW8dRM1J2jcdhD79u3FCBDfSV9Gb8sAf1lMqNH3PNa0aGRW22TziOuanZ9VqKW4i8DHDNrAPH9vqBY0qZaKnkPiljhz4KA8u3qmn4k2zzWADVPvtjgmUJlRPVmIhbAHsTw+7jsuczEoZIWgVc17oQMWc2VilcwH1QcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486422; c=relaxed/simple;
	bh=A7i5tLEPyPySe+N7ZJRHPKe7cssth54UbZ58JOPmd6M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rUAtpUMiik0Urmpsa9i6evoYOQWBC3CsqxLH0jfOdfWYsJvMmxs0SJPtflwkfpt0+Pym8wEumQC+OWvWS1m1TMdR7E9yLx0HHPxAYrWVIgwQBfJM8f9MV0e/wCSywuHnS8J6ivhwCQJR+i+EDjPfDgo60ZMVaQjxhyRpg/59maU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqrs0urG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF9B0C4CEEE;
	Mon,  5 May 2025 23:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486422;
	bh=A7i5tLEPyPySe+N7ZJRHPKe7cssth54UbZ58JOPmd6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oqrs0urGF45oeOjih7Qr5CDMCv5s9VYKcDrwKQnduc4i8ObbnM8M0dtvPMriy3dtA
	 fG+U8vUhaK08VP2HsatpNei6S5XVIw6o4kGXjnGbt6frkMzSoCUrZ6Tj4yZa1BmvAC
	 3N/gsXnYbnJgDSfeXZyNlAKJ1F253QrF3eXJ3yo90K4tGSN5eQJx0FlZJmmwVyqVKB
	 rj1qWBEuYZ+ySfwzfdXBv19iyTq2H1xc6wMd3MYL9PL8/dgb3JmiD0UIiNJ4P8VxIl
	 uKE2R5JG7w14ecCppS1515plHNxRkg8NsEBzpyUqLWF7R+EXWxHJE3uix+qU3i7GRh
	 YNIev3Ah65KgA==
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
Subject: [PATCH AUTOSEL 6.1 018/212] SUNRPC: rpc_clnt_set_transport() must not change the autobind setting
Date: Mon,  5 May 2025 19:03:10 -0400
Message-Id: <20250505230624.2692522-18-sashal@kernel.org>
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
index b6529a9d37d37..a390a4e5592f2 100644
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


