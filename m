Return-Path: <linux-nfs+bounces-11441-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C71AFAA9F01
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 00:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C7313A78CA
	for <lists+linux-nfs@lfdr.de>; Mon,  5 May 2025 22:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928FC27C853;
	Mon,  5 May 2025 22:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exGn1nF2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C0827C17C;
	Mon,  5 May 2025 22:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483283; cv=none; b=e5vbjDn6Xop1l05xoMhzBnz8YWO6rswHU8D172T/hvzka0y+nbW7ZDT/rz1Ig16tAgjAQEz0OL/bdf/ZENVAccyJxYswCNPv/DUNqMC9g28bDS5Rki4qgYZdiBSxeHHfwlyRzUxVJniiFpxOJ2NN5V8jJVP9V+U9FOpRcjw7UGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483283; c=relaxed/simple;
	bh=qHENiOabmT77UFCXK7h2Oxu5/iLS0ySjclWVOhKY/ws=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=plXIpQ8Z+qvmNhw2smJlF7bk0JZnY1op6wNmRJycmElDwNEtgTgqo4hi0pEbxeJrW68lVyRvbZ2KB7j/n83g3tcEbGMPLr5w+N2fjMbNs293VQQBUYhRhB6+EGJN5iXAIij1o6Fw0kPD4jkQebUU7VG9n45iu4RG7j6t5r+HHMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exGn1nF2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B71BAC4CEF1;
	Mon,  5 May 2025 22:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483283;
	bh=qHENiOabmT77UFCXK7h2Oxu5/iLS0ySjclWVOhKY/ws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=exGn1nF211ZU/LdpgClgOJDYWbadM9ACef62sLsYsKlQaKaBD9/U92KjM4xQk2VNg
	 CHDNDd6eFg4RQTdxdFhx6kDQPRsl25DnGEOMtk9E0LfUziLaivwD9NeumKAqhaTDDZ
	 7FsRSUvyK9uaLs70sNqDX+Ndvvm1+XcvxydOypB8CTVdH4UKjn07MPBkr7XWUlMyc3
	 N6cO4igFVe/KftxBPZOUZEaG3jYyjrgjCCaVwNyr3NS9NVquaGperDaupUov/ScelR
	 8ng+n7NrPBrEUuQuGkYkRWnrYNttTfdFW0y2idmSe8gnM0yR7Nb+/lW5OKq3W8T8Kv
	 nvPL3EqRCNxmA==
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
Subject: [PATCH AUTOSEL 6.14 014/642] SUNRPC: Don't allow waiting for exiting tasks
Date: Mon,  5 May 2025 18:03:50 -0400
Message-Id: <20250505221419.2672473-14-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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


