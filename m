Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61B1736203F
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Apr 2021 14:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234914AbhDPMvs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 16 Apr 2021 08:51:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:35718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235380AbhDPMvs (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 16 Apr 2021 08:51:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3CCD2611AF
        for <linux-nfs@vger.kernel.org>; Fri, 16 Apr 2021 12:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618577483;
        bh=cOdIbZKTeK6rt2Pws0vFZ/fMa+bF1QPSomfPQeBo/Kk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=JUjMz9iwiEfrgBOCT45FTIb2yJE15DHmGw4PWUsYwOhKjx6XlmQtJXpOaT8VJmIyu
         psvpK0x0xfTxYFxJpx2ENp1soQFr7Rua0G72XHfJuDCFP4mXJVWTKq3yJwUYX1rIst
         U/h5iW/htcvhQNa4x1iFb0aUM7GggfTIp9SFsi2az1UDD1AI0MEZC9XRC3HtJvdzv1
         /0uOYqbzWKgQy9nxcHZa+5SqcycWB2vPHjIqSi3xWiD9R6HU27KTO7AbZgvIdtjyMa
         ie1LTncUlFLCqftS50hSMy+Yre9A4rOuegDPLOLXOC74AGPgRh7wwY5zNJLSd4eRDE
         U6ZNi618FgugA==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/3] NFSv4.1: Simplify layout return in pnfs_layout_process()
Date:   Fri, 16 Apr 2021 08:51:21 -0400
Message-Id: <20210416125121.5753-3-trondmy@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210416125121.5753-2-trondmy@kernel.org>
References: <20210416125121.5753-1-trondmy@kernel.org>
 <20210416125121.5753-2-trondmy@kernel.org>
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
index 33574f47601f..fa22b4be9212 100644
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
2.30.2

