Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC712B57C2
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Nov 2020 04:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgKQDSJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Nov 2020 22:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbgKQDSJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Nov 2020 22:18:09 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681F6C0617A6
        for <linux-nfs@vger.kernel.org>; Mon, 16 Nov 2020 19:18:09 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id B4FD57EC; Mon, 16 Nov 2020 22:18:08 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org B4FD57EC
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        linux-cachefs <linux-cachefs@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 4/4] nfs: support i_version in the NFSv4 case
Date:   Mon, 16 Nov 2020 22:18:06 -0500
Message-Id: <1605583086-19869-4-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1605583086-19869-1-git-send-email-bfields@redhat.com>
References: <20201117031601.GB10526@fieldses.org>
 <1605583086-19869-1-git-send-email-bfields@redhat.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

Currently when knfsd re-exports an NFS filesystem, it uses the ctime as
the change attribute.  But obviously we have a real change
attribute--the one that was returned from the original server.  We
should just use that.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 4034102010f0..ca85f81d1b9e 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1045,6 +1045,7 @@ static void nfs_fill_super(struct super_block *sb, struct nfs_fs_context *ctx)
 	} else {
 		sb->s_time_min = S64_MIN;
 		sb->s_time_max = S64_MAX;
+		sb->s_flags |= SB_I_VERSION;
 	}
 
 	sb->s_magic = NFS_SUPER_MAGIC;
-- 
2.28.0

