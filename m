Return-Path: <linux-nfs+bounces-11468-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0E5AAB6A8
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 07:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 403F61C21C3A
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 05:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882BB3380A5;
	Tue,  6 May 2025 00:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdZ134uX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF05336BA4B;
	Mon,  5 May 2025 22:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485812; cv=none; b=eQJuWlR7xNUW1zzrB3AeDf4rzsL4CUWthVsMOvsRolyHUK9bAIeFloIDCprX5zXGWWnugnnDHqv2cZ/khWFYr0tR41JnyNU/B5zPCPx31IvlBnNMeS4Jo4WJBBfz3Sp3Bp0iCGJJMRMMw5RNfAIYiFab9yN2kFZ0RB/f6PyOvGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485812; c=relaxed/simple;
	bh=qHENiOabmT77UFCXK7h2Oxu5/iLS0ySjclWVOhKY/ws=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JD2vU+N9h0vWaMmNJH7LFz/Kn4eEyVgQ7vnFmXeuKIfuqWXvccywSkt3btv6EGwFUtMTS2RxKlBAXkl1r/CGdURF2tsp3RDfBMYTXPEzM5Hwx/HljwXXVVDby74YSlXgM3ZSnfDgjmbiHe4rfEjQuD0y2normFgH9cxBwXOTnzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdZ134uX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDAD0C4CEEF;
	Mon,  5 May 2025 22:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485812;
	bh=qHENiOabmT77UFCXK7h2Oxu5/iLS0ySjclWVOhKY/ws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cdZ134uXiFi0SbiEdQwK6kGVwm7pFES8bCzpe4aWkpNCYchsM7ZrGdIq2K3+sz5fR
	 tPSd7hO+fw4Hgp/5nhxDXoJgT6vQ+357x3RZJd7HO1gZQ6jxs81gzSYLD/THY2j0IM
	 veZEvEZoLyQ1+2nyiwYTvlh6IJHr9TPPl8v1hPH0f/pNbhafc7AjXRe2/L42j3/XQt
	 1OWMk3SRNaJWN6uDmtK4GLNuZRZso3P3RAitE3L0+mZ+LY91uGvUXpWYm8RFiZQR5I
	 h3Ahi/5S26o4sQTsoYsf9bohvm5HbRfi2Q8iA3uZqU5suJvUTWqgjpD8p25NMhniz9
	 bpiYBQyTLWM+g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Jeff Layton <jlayton@kernel.org>,
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
Subject: [PATCH AUTOSEL 6.6 010/294] SUNRPC: Don't allow waiting for exiting tasks
Date: Mon,  5 May 2025 18:51:50 -0400
Message-Id: <20250505225634.2688578-10-sashal@kernel.org>
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

[ Upstream commit 14e41b16e8cb677bb440dca2edba8b041646c742 ]

Once a task calls exit_signals() it can no longer be signalled. So do
not allow it to do killable waits.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/sched.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index 9b45fbdc90cab..73bc39281ef5f 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -276,6 +276,8 @@ EXPORT_SYMBOL_GPL(rpc_destroy_wait_queue);
 
 static int rpc_wait_bit_killable(struct wait_bit_key *key, int mode)
 {
+	if (unlikely(current->flags & PF_EXITING))
+		return -EINTR;
 	schedule();
 	if (signal_pending_state(mode, current))
 		return -ERESTARTSYS;
-- 
2.39.5


