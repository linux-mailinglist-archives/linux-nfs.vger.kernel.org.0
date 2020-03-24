Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB576191DBB
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2020 00:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbgCXXtr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Mar 2020 19:49:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:35470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727176AbgCXXtr (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 24 Mar 2020 19:49:47 -0400
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net [68.40.189.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E89E2076A
        for <linux-nfs@vger.kernel.org>; Tue, 24 Mar 2020 23:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585093786;
        bh=xt+b6i6Dbj54XKSB1pNam2L2unBJ6u/n1S6L5zmv1Rw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=LbdEaGSOAIbmMAW1rFSxMTwDSjD6zH7p7s5eq6AL5BGIzNG7eKH/YH4tffLxGYJ5a
         HrwqRqFgUQaA0b5oAlYqeLvq50W/pq66dInzQ4ajyKQ8ESrRqC61278IsohP01EqG9
         pdj67aVohg193jXsPyxq+882Y3sd5PC3F6QrP7Sw=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 19/22] pNFS/flexfile: Don't merge layout segments if the mirrors don't match
Date:   Tue, 24 Mar 2020 19:47:25 -0400
Message-Id: <20200324234728.8997-20-trondmy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200324234728.8997-19-trondmy@kernel.org>
References: <20200324234728.8997-1-trondmy@kernel.org>
 <20200324234728.8997-2-trondmy@kernel.org>
 <20200324234728.8997-3-trondmy@kernel.org>
 <20200324234728.8997-4-trondmy@kernel.org>
 <20200324234728.8997-5-trondmy@kernel.org>
 <20200324234728.8997-6-trondmy@kernel.org>
 <20200324234728.8997-7-trondmy@kernel.org>
 <20200324234728.8997-8-trondmy@kernel.org>
 <20200324234728.8997-9-trondmy@kernel.org>
 <20200324234728.8997-10-trondmy@kernel.org>
 <20200324234728.8997-11-trondmy@kernel.org>
 <20200324234728.8997-12-trondmy@kernel.org>
 <20200324234728.8997-13-trondmy@kernel.org>
 <20200324234728.8997-14-trondmy@kernel.org>
 <20200324234728.8997-15-trondmy@kernel.org>
 <20200324234728.8997-16-trondmy@kernel.org>
 <20200324234728.8997-17-trondmy@kernel.org>
 <20200324234728.8997-18-trondmy@kernel.org>
 <20200324234728.8997-19-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Check that the number of mirrors, and the mirror information matches
before deciding to merge layout segments in pNFS/flexfiles.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index cdd0c87b03dc..3cc2d3165a11 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -283,6 +283,23 @@ static void _ff_layout_free_lseg(struct nfs4_ff_layout_segment *fls)
 	}
 }
 
+static bool
+ff_lseg_match_mirrors(struct pnfs_layout_segment *l1,
+		struct pnfs_layout_segment *l2)
+{
+	const struct nfs4_ff_layout_segment *fl1 = FF_LAYOUT_LSEG(l1);
+	const struct nfs4_ff_layout_segment *fl2 = FF_LAYOUT_LSEG(l1);
+	u32 i;
+
+	if (fl1->mirror_array_cnt != fl2->mirror_array_cnt)
+		return false;
+	for (i = 0; i < fl1->mirror_array_cnt; i++) {
+		if (fl1->mirror_array[i] != fl2->mirror_array[i])
+			return false;
+	}
+	return true;
+}
+
 static bool
 ff_lseg_range_is_after(const struct pnfs_layout_range *l1,
 		const struct pnfs_layout_range *l2)
@@ -318,6 +335,8 @@ ff_lseg_merge(struct pnfs_layout_segment *new,
 			new->pls_range.length);
 	if (new_end < old->pls_range.offset)
 		return false;
+	if (!ff_lseg_match_mirrors(new, old))
+		return false;
 
 	/* Mergeable: copy info from 'old' to 'new' */
 	if (new_end < old_end)
-- 
2.25.1

