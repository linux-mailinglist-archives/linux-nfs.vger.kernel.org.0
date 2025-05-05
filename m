Return-Path: <linux-nfs+bounces-11448-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9E0AAA885
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 02:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CFEB988294
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 00:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC16D296FB4;
	Mon,  5 May 2025 22:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6xryH2c"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9050734C0FF;
	Mon,  5 May 2025 22:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484785; cv=none; b=TXj70cTmOc/bilAAJHlN6eLYd+q9fvJsKdFbvmdAFtgOaBNRHg3/XFRKv4rmZmcc7e70juJSEa6sHiGRQ918iTI22rpsunrNaT9nqDoaL0BaQnz67Jlq5YgFpA7Q7gAJeQEwuSiTfvXpLLV1fzxxFHJ1kQXxuZHABEdyVARfhuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484785; c=relaxed/simple;
	bh=qHENiOabmT77UFCXK7h2Oxu5/iLS0ySjclWVOhKY/ws=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bg9fxQvxxzw7sv+PRDmoUvwgrh3XqyVQ+8jAeZVcvKfDQYiiDiYBcI3ZgCikwAy6JmTJgO2nHG2sdAvZCp/+/2aXpoiATtS1iQPjRNW1LN57ylrvTY9ocjl4m46NccdiPqVKqUWI1xfaRYAbNF1yM45r7KDEGvdXwNIEcDYq1dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6xryH2c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5275BC4CEED;
	Mon,  5 May 2025 22:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484785;
	bh=qHENiOabmT77UFCXK7h2Oxu5/iLS0ySjclWVOhKY/ws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R6xryH2coRRB70Os0zVbb591Yj7uNoN797O68HFXCY3cFduWExitfeViSiZjGq0C+
	 FJrPEK4ev0wK+Rehz/sfuwZVTEKiwCtt7HanwUwmblBOAMSTZ/WBEYAITtdmmYiU/W
	 0Tw8UQrU1TvOz42lGNjirD7UzMJ5uFUvadlzt8CIY6WRrf9vRTIyI+cfkkiqS1HUKW
	 ZxPLjjkA0Ao9Bo2MhL8dTuHJW2NIJjdNeayY9Y86bTtAbamw3Sw8i+E3eV7SuSYc2w
	 RZdcIqWTn0TZZKLobmD8KpNsiNgSu5J5zsZexglO7Vvmi28Bt/Ym2YJYO7lmHufh3z
	 Uz1zzm/nnyWDw==
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
Subject: [PATCH AUTOSEL 6.12 013/486] SUNRPC: Don't allow waiting for exiting tasks
Date: Mon,  5 May 2025 18:31:29 -0400
Message-Id: <20250505223922.2682012-13-sashal@kernel.org>
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


