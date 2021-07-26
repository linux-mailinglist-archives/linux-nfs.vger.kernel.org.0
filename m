Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDDCE3D58FD
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jul 2021 13:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbhGZLS4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Jul 2021 07:18:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:37456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233819AbhGZLSx (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 26 Jul 2021 07:18:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1840760F38
        for <linux-nfs@vger.kernel.org>; Mon, 26 Jul 2021 11:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627300761;
        bh=MMfyyZxqw5O4APMcwE3iA/CIXTgyGAHHU/8qhpzkU54=;
        h=From:To:Subject:Date:From;
        b=mi5MCR9u94xATS+xXYAZe5gPrLDNxs0gWjIRmiw5OhTzS1Oa4Y5n2bk+DInhIVowd
         CNVReQQJY3ufyfR3S+zlgVK0Em5ojs+o7KzetDgrS5eqPj9K2VA8uE+PN5xzZTJsPm
         TNfjb9C8Jg5r4BBxHRklg/OEqsNPhj3WwSGB0JexC7kzuGxSiS7Nj2dIKIBTR+V90j
         5gLbiuTmmMPPWw1REZ81NohVdZIOGweHUhnTGgQ4YRwqRzuGm/rbhkXnGR2m7zmxqg
         LFskn5AtQVkQCc5HPylxAxYqz+m/uP3KXZh0sTyrtDV/5+a1SfHnC6eEOkCwtr+fnk
         XcEEjpeB6TG4A==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] NFSv4/pNFS: Fix a layoutget livelock loop
Date:   Mon, 26 Jul 2021 07:59:19 -0400
Message-Id: <20210726115920.8518-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If NFS_LAYOUT_RETURN_REQUESTED is set, but there is no value set for
the layout plh_return_seq, we can end up in a livelock loop in which
every layout segment retrieved by a new call to layoutget is immediately
invalidated by pnfs_layout_need_return().
To get around this, we should just set plh_return_seq to the current
value of the layout stateid's seqid.

Fixes: d474f96104bd ("NFS: Don't return layout segments that are in use")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pnfs.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 4ed4586bc1a2..51049499e98f 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -347,11 +347,15 @@ pnfs_set_plh_return_info(struct pnfs_layout_hdr *lo, enum pnfs_iomode iomode,
 		iomode = IOMODE_ANY;
 	lo->plh_return_iomode = iomode;
 	set_bit(NFS_LAYOUT_RETURN_REQUESTED, &lo->plh_flags);
-	if (seq != 0) {
-		WARN_ON_ONCE(lo->plh_return_seq != 0 && lo->plh_return_seq != seq);
+	/*
+	 * We must set lo->plh_return_seq to avoid livelocks with
+	 * pnfs_layout_need_return()
+	 */
+	if (seq == 0)
+		seq = be32_to_cpu(lo->plh_stateid.seqid);
+	if (!lo->plh_return_seq || pnfs_seqid_is_newer(seq, lo->plh_return_seq))
 		lo->plh_return_seq = seq;
-		pnfs_barrier_update(lo, seq);
-	}
+	pnfs_barrier_update(lo, seq);
 }
 
 static void
-- 
2.31.1

