Return-Path: <linux-nfs+bounces-11477-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB37AAAB57B
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 07:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D78B188340F
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 05:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9ACF3AB10B;
	Tue,  6 May 2025 00:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XN1Fd4MJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B303AAC95;
	Mon,  5 May 2025 23:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487118; cv=none; b=fmND5kOh7hIiXUi4JgHOov6hIp/QVc8XDH5UgZDX1FUqJ5Y/0MidUdEg4dy11+ZA787C+V1Hk+tzyAJ2OQUhNgu4zxI8aeq8n9eIxoKddeC/6sLY32FethA2RZiSvgZQoTVzawwLDVbba9huWtCypOaL1ckcrqa++P4CAbDnx9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487118; c=relaxed/simple;
	bh=1uJYtZLv/i7rmWQRFKwjzOnmleVkBzj0dXcjr893/44=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WHmvRM9FxJd5Wn54v/2kyZRuBbpCqA3PmzqBoRIOJrn7DHBd4KdYIxycYZQ4KbYRBQR11NDLgf45BINhievqqdUr0dNjHxnyiFa93fhcSqKjUC4hIXfQwvFYSv9JQZR/eygdJuFdYCOYqWlj/j1vb5KLob0y8czim/x1Es4e21Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XN1Fd4MJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4B92C4CEF1;
	Mon,  5 May 2025 23:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487117;
	bh=1uJYtZLv/i7rmWQRFKwjzOnmleVkBzj0dXcjr893/44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XN1Fd4MJ09iCL/fHCMuJaeojoPjYLC8I7LD++5zCa35apJ2DL+VPrCf1pStfX7XGG
	 dQHgbLwvQU2dDTeMxMs5JegYuUYz9FUIUieZBEvPlym614uQB9FVKJyJgfv/I2rDqK
	 p51Et7Ktnl2nAsjg+Dvrzl3RELHFHtINghIEmpF7F/AFjHPg9/ouyqS9bDH8vGg9+5
	 CtEYJLrdiEQkkfyVqGyNLDxoO5ucwpBu1fZv9NRx5HJjJJpZbIqg4rNUd5PC4Srin5
	 VBbVrOzLkVzX+rMd/LgA9xPMdTZo9MXOUC9D/N1gCAa+It/UEGf5p/9u4/iquLYaXz
	 ZNxTgdWMDQmqA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Jeff Layton <jlayton@kernel.org>,
	Benjamin Coddington <bcodding@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	trondmy@kernel.org,
	anna@kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 007/114] NFSv4: Treat ENETUNREACH errors as fatal for state recovery
Date: Mon,  5 May 2025 19:16:30 -0400
Message-Id: <20250505231817.2697367-7-sashal@kernel.org>
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

[ Upstream commit 0af5fb5ed3d2fd9e110c6112271f022b744a849a ]

If a containerised process is killed and causes an ENETUNREACH or
ENETDOWN error to be propagated to the state manager, then mark the
nfs_client as being dead so that we don't loop in functions that are
expecting recovery to succeed.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/nfs4state.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 807dd6f17e1bd..e3cabced1aead 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -2719,7 +2719,15 @@ static void nfs4_state_manager(struct nfs_client *clp)
 	pr_warn_ratelimited("NFS: state manager%s%s failed on NFSv4 server %s"
 			" with error %d\n", section_sep, section,
 			clp->cl_hostname, -status);
-	ssleep(1);
+	switch (status) {
+	case -ENETDOWN:
+	case -ENETUNREACH:
+		nfs_mark_client_ready(clp, -EIO);
+		break;
+	default:
+		ssleep(1);
+		break;
+	}
 out_drain:
 	memalloc_nofs_restore(memflags);
 	nfs4_end_drain_session(clp);
-- 
2.39.5


