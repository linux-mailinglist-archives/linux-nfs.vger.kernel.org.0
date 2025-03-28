Return-Path: <linux-nfs+bounces-10944-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DF8A74F9D
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Mar 2025 18:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 840FD16A204
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Mar 2025 17:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC121DD0D5;
	Fri, 28 Mar 2025 17:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4p8SM7Z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164E049625
	for <linux-nfs@vger.kernel.org>; Fri, 28 Mar 2025 17:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743183647; cv=none; b=mibJCchFL5ZBffjX4PuDT0lWs6ElGu/+VBaX96Qp4CaG2eR2FqKxmEETXtCP5yzix2RPGFBAVTykyhRyqi2v3fDoUufQudUwTL8uv71jBKNhSA08Cx/pF9OsD0Y0VXMidDKurtcNb+oYVYuJYHn+0IhMaSiLg0tzEg+s8t7Ay7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743183647; c=relaxed/simple;
	bh=cwXGJRpvPBuSWtVkBl/2/ikLZMnzRICAnuQbEHlJk7E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=XpOvQraFDPY/cI3TEGVFXHOo00UwL9ECSTZtnWf8Y/kIUUYYGO9QeUBeH0llvm39cueiBBC424jQyqIVig0/1NMboTAis1LK9S9Vk5hY9p59Mztf37Lpe378xnF043o1VfldxzeL0uu0IhQvKlpR+RDHol/pYDwd5Q39Kw1M0U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4p8SM7Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CCF8C4CEE4
	for <linux-nfs@vger.kernel.org>; Fri, 28 Mar 2025 17:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743183646;
	bh=cwXGJRpvPBuSWtVkBl/2/ikLZMnzRICAnuQbEHlJk7E=;
	h=From:To:Subject:Date:From;
	b=U4p8SM7Zl1HLBRBTD5W1fvm/e0IxxdD08vjwQWfkXhztZN3cCb1JqtGyRxHaQoRQo
	 BAujqWW6VOxtD5Wr6EWeqDq8rUbpYK9apcBUoE03TSP4aAlUotGM5Gfn8LjqdQPcih
	 KDopP99O0BK48NiddYTIxJfCFgjRsMJ4g5tOMyKSd5anR8ngnQNhn2QDSulqT+KEbP
	 d/zbQjbXJLsx256aLveN4EP7oWcW9U9tYNdPl0Z7Dq/2TS+SeBPQl9xPeacYM19rBH
	 nP0JR/oBQ6qmYNfgX53PihIhd3SAAmgyxTE9M8mJp8yzMoLeLvb5uQ/3EziHav1Yq+
	 oAAFkIM1BQEbw==
From: trondmy@kernel.org
To: linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] SUNRPC: Don't allow waiting for exiting tasks
Date: Fri, 28 Mar 2025 13:40:44 -0400
Message-ID: <f301a88d04e1929a313c458bd8ce1218903b648a.1743183579.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Once a task calls exit_signals() it can no longer be signalled. So do
not allow it to do killable waits.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/sched.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index 9b45fbdc90ca..73bc39281ef5 100644
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
2.49.0


