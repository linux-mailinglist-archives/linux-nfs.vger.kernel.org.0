Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22D34302054
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Jan 2021 03:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbhAYCWy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 24 Jan 2021 21:22:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:42398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726915AbhAYBzY (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 24 Jan 2021 20:55:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4AE79207AB
        for <linux-nfs@vger.kernel.org>; Mon, 25 Jan 2021 01:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611539677;
        bh=Kq8s+A5QRTVAgmNA6JsSa0lAbw1Txw9em9g6cujZzJY=;
        h=From:To:Subject:Date:From;
        b=lP5cuMNPz3ocT0W7ZZ7gDuqgNa+6kiJxuy2aYh8ZdYf+zTE3Tz4rCKtyRVhRR3XOF
         m76gnbdr7+17TQqMnj/9uuBdtrrXdEgi0G91KzwfvyUUlhOyRpsgpfFgY7X4k7iHZr
         Ohvx8eD7x2tsEt7RfXheje9tFgK493sSwRc/hZV3s/MoNiIsIsKrfWoajcepEMhk+A
         ah05MQE9UCa0RsZ9kFkdddPDOmHeO+LeYrt4ETGLzE3nXSqyrSjUrJT96jDKfaCa4q
         cw0B2jcaWJv7oasTwpOgCjMfDmbUPOZlghdMtmkL0Uf3CuVIRMFxg5KFrpMg46d8pa
         HF2JhdK4gY0Fg==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/4] pNFS/NFSv4: Fix a layout segment leak in pnfs_layout_process()
Date:   Sun, 24 Jan 2021 20:54:32 -0500
Message-Id: <20210125015435.45979-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the server returns a new stateid that does not match the one in our
cache, then pnfs_layout_process() will leak the layout segments returned
by pnfs_mark_layout_stateid_invalid().

Fixes: 9888d837f3cf ("pNFS: Force a retry of LAYOUTGET if the stateid doesn't match our cache")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pnfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 4f274f21c4ab..e68e6f8cb407 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -2417,6 +2417,7 @@ pnfs_layout_process(struct nfs4_layoutget *lgp)
 	spin_unlock(&ino->i_lock);
 	lseg->pls_layout = lo;
 	NFS_SERVER(ino)->pnfs_curr_ld->free_lseg(lseg);
+	pnfs_free_lseg_list(&free_me);
 	return ERR_PTR(-EAGAIN);
 }
 
-- 
2.29.2

