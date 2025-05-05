Return-Path: <linux-nfs+bounces-11470-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A215CAAB3BC
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 06:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12081188950B
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 04:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CC733C575;
	Tue,  6 May 2025 00:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xd2xT2AW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677D3288C16;
	Mon,  5 May 2025 23:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486400; cv=none; b=nXSoUl5SbFWNnpnI7dyIewzsXQrrvx5J2q3eosolOKeoWwY7S7fd2yp70keT6M+FssXeAeF1mQ7p31ZaUV3a7+ILWkwtNDVKk1Y9/iHgmhO78MC0Ub8hqyf1cH/blP/J9ZFnM+lLYPgZSCcUjm4Z8+iREbJkSC9QP7NWBH6VnJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486400; c=relaxed/simple;
	bh=qHENiOabmT77UFCXK7h2Oxu5/iLS0ySjclWVOhKY/ws=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qoXtdOOcPOBqSVlU9aIWBehG95iF+RQ6zC1cLPXkimQ55JasuKmiy4A+yCMIPW0kyEUuCwU65P79fmz0lXrU+QHkHXsMaqxlLw1PFW5GPu2m3TKA/CdAvMIl6j19g+AHODQq59EL9KUAwkcgaW/K6I8wknseAOoCmIkXNysKTJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xd2xT2AW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C780AC4CEEF;
	Mon,  5 May 2025 23:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486400;
	bh=qHENiOabmT77UFCXK7h2Oxu5/iLS0ySjclWVOhKY/ws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xd2xT2AWbqtId6TGX7pEjr+0gYhjWXkSwl0Ug1vnsViXVd0alIED1/u/CllNJxqk5
	 wCnSlbfmO1ZCX9fcuLvQHVi3zstEuKZ56I4fPlchDMN++5T80UfnXI+Qn1Jio/DWwv
	 wG5F9kmgcBLRHVJpR/8kxEWY9WVmu9PrhkvPwCXWKly0ielE5cZAQK90KU8SDqzGMz
	 Gdmoq3nFf/RifxGqcq8PjQQW/oteVoBxQyTUN18W3yhVsReOp7GaWgVyAIQDTEISkn
	 TSVgAUR79HqxAYUVm/L5d4dG54yA2tWu0aW0ajCjZshyqAiwI7COL+47GgHluApLLw
	 gZ5jJ8aslypRw==
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
Subject: [PATCH AUTOSEL 6.1 009/212] SUNRPC: Don't allow waiting for exiting tasks
Date: Mon,  5 May 2025 19:03:01 -0400
Message-Id: <20250505230624.2692522-9-sashal@kernel.org>
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


