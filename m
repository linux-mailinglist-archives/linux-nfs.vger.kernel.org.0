Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 008661B13E5
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Apr 2020 20:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgDTSFZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Apr 2020 14:05:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:37778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726021AbgDTSFY (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 20 Apr 2020 14:05:24 -0400
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40351206D6
        for <linux-nfs@vger.kernel.org>; Mon, 20 Apr 2020 18:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587405924;
        bh=3SPBR//LidMYKzoM6R/P+kWbLSwVPSIwYawlII20+Ws=;
        h=From:To:Subject:Date:From;
        b=rQIDjBewLtzRV99YDUBx1e0KqzxMig04Cns3WTNqhBfPZy/CvE0gEvtJ5oMvFMk90
         8V+2I3USu2Ca6l+A+q1fi1qOTkFlmqo+Nf6RmQkMr+ElumIzsEBTNcj+2qeJmaGkit
         FxVSVt2j+R8yUFE6jDcRwgkseoWQzBi57QbOkweQ=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFS/pnfs: Ensure that _pnfs_return_layout() waits for layoutreturn completion
Date:   Mon, 20 Apr 2020 14:03:16 -0400
Message-Id: <20200420180316.399519-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.25.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

We require that any outstanding layout return completes before we can
free up the inode so that the layout itself can be freed.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pnfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index b8d78f393365..3bf6899cba95 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -1332,13 +1332,15 @@ _pnfs_return_layout(struct inode *ino)
 			!valid_layout) {
 		spin_unlock(&ino->i_lock);
 		dprintk("NFS: %s no layout segments to return\n", __func__);
-		goto out_put_layout_hdr;
+		goto out_wait_layoutreturn;
 	}
 
 	send = pnfs_prepare_layoutreturn(lo, &stateid, &cred, NULL);
 	spin_unlock(&ino->i_lock);
 	if (send)
 		status = pnfs_send_layoutreturn(lo, &stateid, &cred, IOMODE_ANY, true);
+out_wait_layoutreturn:
+	wait_on_bit(&lo->plh_flags, NFS_LAYOUT_RETURN, TASK_UNINTERRUPTIBLE);
 out_put_layout_hdr:
 	pnfs_free_lseg_list(&tmp_list);
 	pnfs_put_layout_hdr(lo);
-- 
2.25.3

