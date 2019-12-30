Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 968FC12D179
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Dec 2019 16:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbfL3Pcn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Dec 2019 10:32:43 -0500
Received: from xavier.telenet-ops.be ([195.130.132.52]:44050 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbfL3Pcm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Dec 2019 10:32:42 -0500
Received: from ramsan ([84.195.182.253])
        by xavier.telenet-ops.be with bizsmtp
        id kFYf2100M5USYZQ01FYfzW; Mon, 30 Dec 2019 16:32:40 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1ilx27-0002y1-BD; Mon, 30 Dec 2019 16:32:39 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1ilx27-0007md-7q; Mon, 30 Dec 2019 16:32:39 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Rik van Riel <riel@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC] nfs: NFS_SWAP should depend on SWAP
Date:   Mon, 30 Dec 2019 16:32:38 +0100
Message-Id: <20191230153238.29878-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If CONFIG_SWAP=n, it does not make much sense to offer the user the
option to enable support for swapping over NFS, as that will still fail
at run time:

    # swapon /swap
    swapon: /swap: swapon failed: Function not implemented

Fix this by adding a dependency on CONFIG_SWAP.

Fixes: a564b8f0398636ba ("nfs: enable swap on NFS")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Marked RFC, as this still doesn't seem to work.
When enabled, the kernel log is spammed with:

    [  449.371536] __swap_writepage: 413288 callbacks suppressed
    [  449.371577] Write error on dio swapfile (10047488)
    [  449.382435] Write error on dio swapfile (14147584)
    [  449.387320] Write error on dio swapfile (10919936)
    [  449.392474] Write error on dio swapfile (8945664)
    [  449.397263] Write error on dio swapfile (24256512)
    [  449.402330] Write error on dio swapfile (14307328)
    [  449.407195] Write error on dio swapfile (229376)
    [  449.412031] Write error on dio swapfile (10293248)
    [  449.416891] Write error on dio swapfile (2007040)

Platform is 32-bit Cortex A9 with 32 MiB of RAM (hence the need for
swap).
---
 fs/nfs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/Kconfig b/fs/nfs/Kconfig
index 295a7a21b7744014..e7dd07f47825939e 100644
--- a/fs/nfs/Kconfig
+++ b/fs/nfs/Kconfig
@@ -90,7 +90,7 @@ config NFS_V4
 config NFS_SWAP
 	bool "Provide swap over NFS support"
 	default n
-	depends on NFS_FS
+	depends on NFS_FS && SWAP
 	select SUNRPC_SWAP
 	help
 	  This option enables swapon to work on files located on NFS mounts.
-- 
2.17.1

