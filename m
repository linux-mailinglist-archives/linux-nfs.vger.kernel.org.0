Return-Path: <linux-nfs+bounces-3869-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 693DB90A1BB
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 03:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91AF31C21430
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 01:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716C2E542;
	Mon, 17 Jun 2024 01:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/h0t+0h"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFC98836
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 01:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718587514; cv=none; b=KlhKNzSNBi3fQlU2137NASFgN7jXzCjYIVe98hlvpaRW/E4qdC8055aHcmAuysJRGuqfCNX7gNfJVo94LpgNVhU6JJnU92laGSCMopwKrubXDDynVLz2JrzoqpPOqbyu2z+241YnvXipmi5qyISS7KxIJqa22fHFogZmV39Xv2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718587514; c=relaxed/simple;
	bh=u0m2Qekqox7a/+wsRz/htnWo29bY24C1eCoOvnXIhyE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pV4WT+WPVFHQVA5o46qdCVQ9nxEUwYCBR2OTFXv9PmV4D39D0a3w/eXX/Q+0OnPEUZI+4YplkrFZjl1viejQdeYjRWhfiNvxrc5iPXX16qk+WwP9+YFPtQ7Zu5sEHBZBxg+GqMlPZNGIqD6BryxJzJvhiwVeVY5s5sF/X1xIQQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/h0t+0h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A83D1C4AF1C
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 01:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718587513;
	bh=u0m2Qekqox7a/+wsRz/htnWo29bY24C1eCoOvnXIhyE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=B/h0t+0hRsMxdoDRhkl4BteoUx0Q0B2LN5zHQphYZT+qkVlTZSUN2R6c4qOWXIxyP
	 S2Dr2BrXAxdXjLTTh65oHK1mmzSqjmgKYCVK2PRUwI8jFLbE2M29DG8FJ0X1eXzJPJ
	 +50OYDmuHKsfbQtnw6n3VP9LI1/7eVFOQwKhzcxySr0oZAVmmdKKvMcvm6Awz3sJB0
	 Y8jV2TgT8mvvAQve6GZE5rEDZFbbGL6uE3Gp4/6PW/47O+Rf/4Y63NZB/BPTPAEuff
	 c748DlIr6PpPxC7pfh+NQtHG6q1vC8PHF42umeGeTUzsiMBvfLr++xaub5pk13UKzf
	 d5pKfvVlZz1fw==
From: trondmy@kernel.org
To: linux-nfs@vger.kernel.org
Subject: [PATCH v2 10/19] NFSv4: Enable attribute delegations
Date: Sun, 16 Jun 2024 21:21:28 -0400
Message-ID: <20240617012137.674046-11-trondmy@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240617012137.674046-10-trondmy@kernel.org>
References: <20240617012137.674046-1-trondmy@kernel.org>
 <20240617012137.674046-2-trondmy@kernel.org>
 <20240617012137.674046-3-trondmy@kernel.org>
 <20240617012137.674046-4-trondmy@kernel.org>
 <20240617012137.674046-5-trondmy@kernel.org>
 <20240617012137.674046-6-trondmy@kernel.org>
 <20240617012137.674046-7-trondmy@kernel.org>
 <20240617012137.674046-8-trondmy@kernel.org>
 <20240617012137.674046-9-trondmy@kernel.org>
 <20240617012137.674046-10-trondmy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@primarydata.com>

If we see that the server supports attribute delegations, then request
them by setting the appropriate OPEN arguments.

Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 03835c8a180f..1209ce22158e 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1339,8 +1339,13 @@ nfs4_map_atomic_open_share(struct nfs_server *server,
 	if (!(server->caps & NFS_CAP_ATOMIC_OPEN_V1))
 		goto out;
 	/* Want no delegation if we're using O_DIRECT */
-	if (openflags & O_DIRECT)
+	if (openflags & O_DIRECT) {
 		res |= NFS4_SHARE_WANT_NO_DELEG;
+		goto out;
+	}
+	/* res |= NFS4_SHARE_WANT_NO_PREFERENCE; */
+	if (server->caps & NFS_CAP_DELEGTIME)
+		res |= NFS4_SHARE_WANT_DELEG_TIMESTAMPS;
 out:
 	return res;
 }
-- 
2.45.2


