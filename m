Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E61D1364667
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Apr 2021 16:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240506AbhDSOse (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Apr 2021 10:48:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:37856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240158AbhDSOsd (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 19 Apr 2021 10:48:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BFD4960FEF
        for <linux-nfs@vger.kernel.org>; Mon, 19 Apr 2021 14:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618843683;
        bh=NyE7lgW7JS68D+jqPJw5rVuyTCrhw4jAOADTQwHAVl0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=kBOXRZxqZ9ipDpYyQmG0cZvq6cm05EvG0tH/GfRToTgDL5HwTwUWBf9wSYxM6mNV2
         8N3c7FI8exFio/r5bnYe+c8FmrQ0GdVg9v7kxa7m355t9KBg+M7gL3zSMyJe8YHjpg
         51VCCubfgoEegR0XvVzanb7fuYnJ+rOzS1+g78xuP3bsTvzKqldKSaxZiby7U8Trdm
         UISqcIysiMys94NkGmW7kQSCtHabAyNc3+s7preRUGUCoeRar2zli+HVEmX5JJToHs
         G2R9yhRya1jdZIAtRUjEGG/nlDaWYjVBwhXNSTTrM4oDKOxD/PvUkYis3Jsj03Gurp
         e/59qB+jWXmSw==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 4/4] NFSv4.1: Simplify layout return in pnfs_layout_process()
Date:   Mon, 19 Apr 2021 10:47:59 -0400
Message-Id: <20210419144759.41900-4-trondmy@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210419144759.41900-3-trondmy@kernel.org>
References: <20210419144759.41900-1-trondmy@kernel.org>
 <20210419144759.41900-2-trondmy@kernel.org>
 <20210419144759.41900-3-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the server hands us a layout that does not match the one we currently
hold, then have pnfs_mark_matching_lsegs_return() just ditch the old
layout if NFS_LSEG_LAYOUTRETURN is not set.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pnfs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index f726f8b12b7e..03e0b34c4a64 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -2410,9 +2410,7 @@ pnfs_layout_process(struct nfs4_layoutget *lgp)
 			.iomode = IOMODE_ANY,
 			.length = NFS4_MAX_UINT64,
 		};
-		pnfs_set_plh_return_info(lo, IOMODE_ANY, 0);
-		pnfs_mark_matching_lsegs_return(lo, &lo->plh_return_segs,
-						&range, 0);
+		pnfs_mark_matching_lsegs_return(lo, &free_me, &range, 0);
 		goto out_forget;
 	} else {
 		/* We have a completely new layout */
-- 
2.31.1

