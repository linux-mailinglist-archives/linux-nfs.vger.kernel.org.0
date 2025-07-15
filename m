Return-Path: <linux-nfs+bounces-13093-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D0FB0696C
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jul 2025 00:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A29C65653C6
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Jul 2025 22:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56AB2D130B;
	Tue, 15 Jul 2025 22:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BeCJxWiA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23CE2D0C9F
	for <linux-nfs@vger.kernel.org>; Tue, 15 Jul 2025 22:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752619974; cv=none; b=AW9KWblBPrdrDZtPmD2O3HhcPZVqK1hPPjpprThCVI8F9p87Kioj5y480L4UJEx2prLBevmAL4mSDTSlWtCahZ+SVV1VM8lc6iQBLDv77w42UGn865H6m4ziGBZQVOxZIEGYNBW2gCGk1Vnj4UDAs/KpRA7cqkVlXc77EmUyjhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752619974; c=relaxed/simple;
	bh=Ojby/sAEJ3Q72dCQrj8loP7i6dk9kUDHOuwiXePmfxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kh5Mh9Z2KecYF07687+rbeybyQ3faOPQCYPT5GBquiDAn5CAQX0Y2xV6MGYRqVGTbe4uPgHS69B9Yn/3xAEcmZDKLj8baKNhbO/6wchJuyel7V1ar+Y8oNm7w0pCbCh55HvB1gvuBs/WtqLsnvdMf7lLe2As7HAiThnqXHwNWQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BeCJxWiA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25AAEC4CEF6;
	Tue, 15 Jul 2025 22:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752619974;
	bh=Ojby/sAEJ3Q72dCQrj8loP7i6dk9kUDHOuwiXePmfxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BeCJxWiAzNCQQyCSoZF94gQduKaNUQRnLrnBm+BD/UBQbI/qIhpZSf35PKzJm6v8R
	 NfFc7t55gxaVcbGZBcsjw9/VOmNwuNip3/pAcPmtx/f8wXqG3bJUWXiiVCV2/2IwaR
	 ABaimvOH+EuxScw10iPSFxnHKRlV2LUCMDmsTZZ6INKGdakJCr7z1PFWKcm6LIqJlK
	 cfkvAH0XtyvoFmVd5K9xqNvG5Msie7apDkCM6N0rzqVQN5J6r+vnCVg3jyo1pc3rvi
	 8Mwco1JJ+H4SFwfTwrmdnDu+bn8VebCzqsqaHlv39yNJqHxsrLkBTwOx4l/nVPdRz8
	 +qj3tmwyldVyg==
From: Trond Myklebust <trondmy@kernel.org>
To: Anna Schumaker <anna.schumaker@oracle.com>
Cc: NeilBrown <neil@brown.name>,
	Mike Snitzer <snitzer@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 3/3] NFS/localio: nfs_uuid_put() fix the wake up after unlinking the file
Date: Tue, 15 Jul 2025 15:52:50 -0700
Message-ID: <2d9b6631ff2256320208250fbec9bc6e0918377e.1752618161.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1752618161.git.trond.myklebust@hammerspace.com>
References: <cover.1752618161.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

After setting nfl->nfs_uuid to NULL, dereferences of nfl should be
avoided, since there are no further guarantees that the memory is still
allocated.
Also change the wake_up_var_locked() to be a regular wake_up_var(),
since nfs_close_local_fh() cannot retake the nfs_uuid->lock after
dropping it.

Acked-by: Mike Snitzer <snitzer@kernel.org>
Tested-by: Mike Snitzer <snitzer@kernel.org>
Fixes: 21fb44034695 ("nfs_localio: protect race between nfs_uuid_put() and nfs_close_local_fh()")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs_common/nfslocalio.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
index d157fdc068d7..27ad5263e400 100644
--- a/fs/nfs_common/nfslocalio.c
+++ b/fs/nfs_common/nfslocalio.c
@@ -199,8 +199,8 @@ static bool nfs_uuid_put(nfs_uuid_t *nfs_uuid)
 		/* Now we can allow racing nfs_close_local_fh() to
 		 * skip the locking.
 		 */
-		RCU_INIT_POINTER(nfl->nfs_uuid, NULL);
-		wake_up_var_locked(&nfl->nfs_uuid, &nfs_uuid->lock);
+		rcu_assign_pointer(nfl->nfs_uuid, NULL);
+		wake_up_var(nfl);
 	}
 
 	/* Remove client from nn->local_clients */
@@ -321,8 +321,7 @@ void nfs_close_local_fh(struct nfs_file_localio *nfl)
 		 */
 		spin_unlock(&nfs_uuid->lock);
 		rcu_read_unlock();
-		wait_var_event(&nfl->nfs_uuid,
-			       rcu_access_pointer(nfl->nfs_uuid) == NULL);
+		wait_var_event(nfl, rcu_access_pointer(nfl->nfs_uuid) == NULL);
 		return;
 	}
 	/* tell nfs_uuid_put() to wait for us */
-- 
2.50.1


