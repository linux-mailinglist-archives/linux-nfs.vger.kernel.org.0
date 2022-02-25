Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5904C4DD2
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Feb 2022 19:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233355AbiBYSfX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Feb 2022 13:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbiBYSfR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Feb 2022 13:35:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C9E1B65D8
        for <linux-nfs@vger.kernel.org>; Fri, 25 Feb 2022 10:34:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1E1E0B83309
        for <linux-nfs@vger.kernel.org>; Fri, 25 Feb 2022 18:34:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 944D4C340F1
        for <linux-nfs@vger.kernel.org>; Fri, 25 Feb 2022 18:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645814083;
        bh=/Hh4ZDVLddAewg5KmSMUDCPnN6eJUtFDtuBUz+0xNek=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=KptbVm8hwLb+DfHvw+n9k5LS9+jG0h7FnB2OLPp75oKbNZlaC4/6KEA/wOL3SL0T3
         7dxolkBRQ8yOyjuzyIPys0sTJyIpVrrx8TxcrzJK+znIG4EgobzQfrjIM7ZNWe3xpa
         1Cc411/rEry1NXsd5hJJ7KAYXRn7LXWmWvkyi0JmoztgAIOkXnYU75W7VucY+ptB+9
         eOoWkrPePy0lXIZn0N8jJ+4Bj3McLD+JU8FwVyiXZ+30cmdo8H2yhOWtLJYKSiSOfI
         sux9iHzmtDO9UL8qmMvtWbjP3sVad2ZnzDkMVVMBvdoa52Iukqidvq93GLNOGfq5OF
         prqrPVK+6595A==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v8 19/24] NFS: Trace effects of readdirplus on the dcache
Date:   Fri, 25 Feb 2022 13:28:24 -0500
Message-Id: <20220225182829.1236093-20-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220225182829.1236093-19-trondmy@kernel.org>
References: <20220225182829.1236093-1-trondmy@kernel.org>
 <20220225182829.1236093-2-trondmy@kernel.org>
 <20220225182829.1236093-3-trondmy@kernel.org>
 <20220225182829.1236093-4-trondmy@kernel.org>
 <20220225182829.1236093-5-trondmy@kernel.org>
 <20220225182829.1236093-6-trondmy@kernel.org>
 <20220225182829.1236093-7-trondmy@kernel.org>
 <20220225182829.1236093-8-trondmy@kernel.org>
 <20220225182829.1236093-9-trondmy@kernel.org>
 <20220225182829.1236093-10-trondmy@kernel.org>
 <20220225182829.1236093-11-trondmy@kernel.org>
 <20220225182829.1236093-12-trondmy@kernel.org>
 <20220225182829.1236093-13-trondmy@kernel.org>
 <20220225182829.1236093-14-trondmy@kernel.org>
 <20220225182829.1236093-15-trondmy@kernel.org>
 <20220225182829.1236093-16-trondmy@kernel.org>
 <20220225182829.1236093-17-trondmy@kernel.org>
 <20220225182829.1236093-18-trondmy@kernel.org>
 <20220225182829.1236093-19-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Trace the effects of readdirplus on attribute and dentry revalidation.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c      | 5 +++++
 fs/nfs/nfstrace.h | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 9fc584c11e70..fa32eb5f6391 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -742,8 +742,12 @@ void nfs_prime_dcache(struct dentry *parent, struct nfs_entry *entry,
 			status = nfs_refresh_inode(d_inode(dentry), entry->fattr);
 			if (!status)
 				nfs_setsecurity(d_inode(dentry), entry->fattr);
+			trace_nfs_readdir_lookup_revalidate(d_inode(parent),
+							    dentry, 0, status);
 			goto out;
 		} else {
+			trace_nfs_readdir_lookup_revalidate_failed(
+				d_inode(parent), dentry, 0);
 			d_invalidate(dentry);
 			dput(dentry);
 			dentry = NULL;
@@ -765,6 +769,7 @@ void nfs_prime_dcache(struct dentry *parent, struct nfs_entry *entry,
 		dentry = alias;
 	}
 	nfs_set_verifier(dentry, dir_verifier);
+	trace_nfs_readdir_lookup(d_inode(parent), dentry, 0);
 out:
 	dput(dentry);
 }
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index c2d0543ecb2d..7c1102b991d0 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -432,6 +432,9 @@ DEFINE_NFS_LOOKUP_EVENT(nfs_lookup_enter);
 DEFINE_NFS_LOOKUP_EVENT_DONE(nfs_lookup_exit);
 DEFINE_NFS_LOOKUP_EVENT(nfs_lookup_revalidate_enter);
 DEFINE_NFS_LOOKUP_EVENT_DONE(nfs_lookup_revalidate_exit);
+DEFINE_NFS_LOOKUP_EVENT(nfs_readdir_lookup);
+DEFINE_NFS_LOOKUP_EVENT(nfs_readdir_lookup_revalidate_failed);
+DEFINE_NFS_LOOKUP_EVENT_DONE(nfs_readdir_lookup_revalidate);
 
 TRACE_EVENT(nfs_atomic_open_enter,
 		TP_PROTO(
-- 
2.35.1

