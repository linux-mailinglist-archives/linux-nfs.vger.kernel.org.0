Return-Path: <linux-nfs+bounces-13116-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F85B07A83
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jul 2025 17:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0FB0A43B98
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jul 2025 15:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EB42F50B1;
	Wed, 16 Jul 2025 15:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCBZsM8z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73ADA29E0EE
	for <linux-nfs@vger.kernel.org>; Wed, 16 Jul 2025 15:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752681562; cv=none; b=fIA7nT3fKeXYCsMM5pcUYyDS4inCra4Xqn5HscbEbGOhpeBuk/d9drl/MiA1/UGnMux/6qMm0+0yE7TqT2gRoWHueYLI/5VLm2yEpYcozPo5VndhzFOsSi13XP1Rizp/q9ItQk5u5F+TTpcTLgckYNontSWXrrXWTKCiKnWqs60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752681562; c=relaxed/simple;
	bh=1g2KMa62oGfjw9F3hqcRJvvYTtl+XYT7fW+AtZ1/BxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qoUBHAojoJO8aF7dnZr4HkCxQOI08ZaRtoHhYNWSh561GMaPaazPuHf6Fx/Wjs7MGf2F90oj9sHOO77aYBRnzYJ1OYjgvEqj5PJefzszgedDq0TTgmQyYEebgRWjpLLkTKT8u+P+6Wbr6DS/ZcRJejibldSk7Mfq2XqGMVvty0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCBZsM8z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA94C4CEE7;
	Wed, 16 Jul 2025 15:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752681562;
	bh=1g2KMa62oGfjw9F3hqcRJvvYTtl+XYT7fW+AtZ1/BxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VCBZsM8z57xUelMnUMl46MWC8U1DX4hw+g7AG2AbyHiB8jj4Yo4WGdbpYDuWlDODM
	 uYUDTj/9yZtYMim5yoUHVezDJdyu/tu7l4E8jaqSV/MwUo0vwowEyaxOQ6kfnvzGmE
	 Ha82ZJBpjSPwhPjwr9KISt99PhbAh89cAMXtR2gO0RPMQ/rlPWJvAo/TCyFtFULDaO
	 e2nl2tMVC29PtIQo3yk1mkJ35Q1rSTB69FEQkbIbwTU92/04ydDZwOy5qZjVtuyq1q
	 dQP5XqO/NOQCmO92bnO9DZ3mBl6biz4ZceK8F96Sk7ElwNOSiTuG23TW3SOEoz+4on
	 zTft2AHpWg9xA==
From: Trond Myklebust <trondmy@kernel.org>
To: Anna Schumaker <anna.schumaker@oracle.com>
Cc: NeilBrown <neil@brown.name>,
	Mike Snitzer <snitzer@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v2 3/3] NFS/localio: nfs_uuid_put() fix the wake up after unlinking the file
Date: Wed, 16 Jul 2025 08:59:18 -0700
Message-ID: <9cb0e62f0121e229e235af44e756521e7386630f.1752671200.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1752671200.git.trond.myklebust@hammerspace.com>
References: <cover.1752671200.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Use store_release_wake_up() instead of wake_up_var_locked(), because the
waiter cannot retake the nfs_uuid->lock.

Acked-by: Mike Snitzer <snitzer@kernel.org>
Tested-by: Mike Snitzer <snitzer@kernel.org>
Suggested-by: NeilBrown <neil@brown.name>
Link: https://lore.kernel.org/all/175262948827.2234665.1891349021754495573@noble.neil.brown.name/
Fixes: 21fb44034695 ("nfs_localio: protect race between nfs_uuid_put() and nfs_close_local_fh()")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs_common/nfslocalio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
index f1f1592ac134..dd715cdb6c04 100644
--- a/fs/nfs_common/nfslocalio.c
+++ b/fs/nfs_common/nfslocalio.c
@@ -198,8 +198,7 @@ static bool nfs_uuid_put(nfs_uuid_t *nfs_uuid)
 		/* Now we can allow racing nfs_close_local_fh() to
 		 * skip the locking.
 		 */
-		RCU_INIT_POINTER(nfl->nfs_uuid, NULL);
-		wake_up_var_locked(&nfl->nfs_uuid, &nfs_uuid->lock);
+		store_release_wake_up(&nfl->nfs_uuid, RCU_INITIALIZER(NULL));
 	}
 
 	/* Remove client from nn->local_clients */
-- 
2.50.1


