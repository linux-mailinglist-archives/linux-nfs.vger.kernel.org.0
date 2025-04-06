Return-Path: <linux-nfs+bounces-11018-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7039BA7CECC
	for <lists+linux-nfs@lfdr.de>; Sun,  6 Apr 2025 17:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D75DA16B9BD
	for <lists+linux-nfs@lfdr.de>; Sun,  6 Apr 2025 15:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43977204F94;
	Sun,  6 Apr 2025 15:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MgaLKq3c"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0BD13AD05
	for <linux-nfs@vger.kernel.org>; Sun,  6 Apr 2025 15:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743954363; cv=none; b=WnW47N3AOM/F77SxhiLMivPBWjA3GRmcKuo8TDBdXL6CfpkVafKfTwtBk2YehTZsmJWxQgkwiAhfzulQLLXRan7/ovxSQdjPNDY7S3kgBn+JFHYi3/+/sEQlwVRlbI9MT8gfMlKmKWrFATRJesZ6lsuoE7AnHLepzzrheJfYbEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743954363; c=relaxed/simple;
	bh=AOd/I5N+viIKkZqCR2/zYFgert0d7f4ZM5GENyALsIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iCpKF2zdnGXKDTUIMnFEEVx/hrRzBfumfUI0qyLwIc3YQlvuRX/H8EFWB8QxrOW+cXAj4Qe7v4QMW9GzvZciBhPIs1JgvGHRO/+godSQrKxk0SQF5It+s+EawqSXtvyAlpX2X832Tpe27wsCgBFp2Cw2r+FXJsmVK/HcxTDgmu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MgaLKq3c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0000FC4CEEA;
	Sun,  6 Apr 2025 15:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743954362;
	bh=AOd/I5N+viIKkZqCR2/zYFgert0d7f4ZM5GENyALsIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MgaLKq3cC5LmoTXLpsbtSyRIAvwyw0AphmxazWZ7jg7gQcI/pIOM6Xo42qG86BGQx
	 cjuaiDovWorvF7Tw0ZtCSkmPO0sDGSlIIW3miUzZMwRrZZVIyIGPhxR4M9DEMzjnbh
	 utp73N5iX7CuDN+mQtJ6IDhtNaWDlBtTkxblN9lokqGxLUZgBORgBCwxlzbVn1YgjI
	 wF7EJi3Jg3KVkWWZTej5U0EMdvFg1rc6ftpkssH/+oM7/fOP1GfUSbTHksk9GjTGxt
	 h2z4+tzohr/UlPHmuGxDK8rVDkjNRq//P07b1cT90WdiXZKiKaykgkC+ADyCp/Fa3B
	 sGFLPPRr1OOZQ==
From: trondmy@kernel.org
To: Omar Sandoval <osandov@osandov.com>
Cc: Jeff Layton <jlayton@kernel.org>,
	Chris Mason <clm@meta.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v2 2/2] NFSv4/pnfs: Layoutreturn on close must handle fatal networking errors
Date: Sun,  6 Apr 2025 17:45:53 +0200
Message-ID: <d45398aaaa1db68cd8bd7eac86acc4e04866f177.1743954240.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1743954240.git.trond.myklebust@hammerspace.com>
References: <cover.1743954240.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If we have a fatal ENETDOWN or ENETUNREACH error, then the layoutreturn
on close code should also handle that as fatal, and free the layouts.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pnfs.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 5f582713bf05..10fdd065a61c 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -1661,6 +1661,18 @@ int pnfs_roc_done(struct rpc_task *task, struct nfs4_layoutreturn_args **argpp,
 		/* Was there an RPC level error? If not, retry */
 		if (task->tk_rpc_status == 0)
 			break;
+		/*
+		 * Is there a fatal network level error?
+		 * If so release the layout, but flag the error.
+		 */
+		if ((task->tk_rpc_status == -ENETDOWN ||
+		     task->tk_rpc_status == -ENETUNREACH) &&
+		    task->tk_flags & RPC_TASK_NETUNREACH_FATAL) {
+			*ret = 0;
+			(*respp)->lrs_present = 0;
+			retval = -EIO;
+			break;
+		}
 		/* If the call was not sent, let caller handle it */
 		if (!RPC_WAS_SENT(task))
 			return 0;
-- 
2.49.0


