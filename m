Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F28C196709
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Mar 2020 16:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbgC1Pen (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 28 Mar 2020 11:34:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:40410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727179AbgC1Pem (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 28 Mar 2020 11:34:42 -0400
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86C7820748
        for <linux-nfs@vger.kernel.org>; Sat, 28 Mar 2020 15:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585409681;
        bh=NuMpFZor33KpgDCooyxC/0nGZA6wuMmyv4qL5T4CILA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=aX0P65PJNY4Qbpwv++JoYTRX4jsjeJ88kjBPJC9pczRZDck+mAeAJU/cQo6i4f7vE
         erBL6B+sgr7MRpyrvCUbdEfWs+2r62880KD1YppMmTVzzJzSuGOe7RfhQphRgNTKc2
         plg5Jiy0+K80j7YT35wWJvH4clkkVhmgjo3cMxqU=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 19/22] pNFS/flexfile: Don't merge layout segments if the mirrors don't match
Date:   Sat, 28 Mar 2020 11:32:17 -0400
Message-Id: <20200328153220.1352010-20-trondmy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200328153220.1352010-19-trondmy@kernel.org>
References: <20200328153220.1352010-1-trondmy@kernel.org>
 <20200328153220.1352010-2-trondmy@kernel.org>
 <20200328153220.1352010-3-trondmy@kernel.org>
 <20200328153220.1352010-4-trondmy@kernel.org>
 <20200328153220.1352010-5-trondmy@kernel.org>
 <20200328153220.1352010-6-trondmy@kernel.org>
 <20200328153220.1352010-7-trondmy@kernel.org>
 <20200328153220.1352010-8-trondmy@kernel.org>
 <20200328153220.1352010-9-trondmy@kernel.org>
 <20200328153220.1352010-10-trondmy@kernel.org>
 <20200328153220.1352010-11-trondmy@kernel.org>
 <20200328153220.1352010-12-trondmy@kernel.org>
 <20200328153220.1352010-13-trondmy@kernel.org>
 <20200328153220.1352010-14-trondmy@kernel.org>
 <20200328153220.1352010-15-trondmy@kernel.org>
 <20200328153220.1352010-16-trondmy@kernel.org>
 <20200328153220.1352010-17-trondmy@kernel.org>
 <20200328153220.1352010-18-trondmy@kernel.org>
 <20200328153220.1352010-19-trondmy@kernel.org>
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
index d37883a2b51f..3221001f2ea1 100644
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

