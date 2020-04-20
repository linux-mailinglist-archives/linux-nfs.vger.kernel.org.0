Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C64C1B1303
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Apr 2020 19:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbgDTRaQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Apr 2020 13:30:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:49798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbgDTRaP (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 20 Apr 2020 13:30:15 -0400
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65E2820782
        for <linux-nfs@vger.kernel.org>; Mon, 20 Apr 2020 17:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587403815;
        bh=JzU1EqfFVVnu55CR6op9j5KhVe5lT0PMXI8tGH2yiqg=;
        h=From:To:Subject:Date:From;
        b=lOpL9OAlIXMGgvEtpiUgTFFdFTxfauwCCP1Ewh23wm/gKpRRDee/gkI46d8SnKteo
         hRyIW9yi5BifTRGOBYzyobRmsW0IT7Hk5SuH8okjqjQwTLFJReQvtD0zEn3nKc2KTW
         Si8ywl1ExiS9aniDs+OZPYTym0+CmX+i3/cuJUdM=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFS/pnfs: Fix a credential use-after-free issue in pnfs_roc()
Date:   Mon, 20 Apr 2020 13:28:07 -0400
Message-Id: <20200420172807.398960-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.25.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the credential returned by pnfs_prepare_layoutreturn()
does not match the credential of the RPC call, then we do
end up calling pnfs_send_layoutreturn() with that credential,
so don't free it!

Fixes: 44ea8dfce021 ("NFS/pnfs: Reference the layout cred in pnfs_prepare_layoutreturn()")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pnfs.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 3bf6899cba95..dd2e14f5875d 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -1458,18 +1458,15 @@ bool pnfs_roc(struct inode *ino,
 	/* lo ref dropped in pnfs_roc_release() */
 	layoutreturn = pnfs_prepare_layoutreturn(lo, &stateid, &lc_cred, &iomode);
 	/* If the creds don't match, we can't compound the layoutreturn */
-	if (!layoutreturn)
+	if (!layoutreturn || cred_fscmp(cred, lc_cred) != 0)
 		goto out_noroc;
-	if (cred_fscmp(cred, lc_cred) != 0)
-		goto out_noroc_put_cred;
 
 	roc = layoutreturn;
 	pnfs_init_layoutreturn_args(args, lo, &stateid, iomode);
 	res->lrs_present = 0;
 	layoutreturn = false;
-
-out_noroc_put_cred:
 	put_cred(lc_cred);
+
 out_noroc:
 	spin_unlock(&ino->i_lock);
 	rcu_read_unlock();
-- 
2.25.3

