Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812D64C5FDE
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Feb 2022 00:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbiB0XTX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 27 Feb 2022 18:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbiB0XTV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 27 Feb 2022 18:19:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9065322501
        for <linux-nfs@vger.kernel.org>; Sun, 27 Feb 2022 15:18:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3F62BB80B9D
        for <linux-nfs@vger.kernel.org>; Sun, 27 Feb 2022 23:18:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE49DC340F0
        for <linux-nfs@vger.kernel.org>; Sun, 27 Feb 2022 23:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646003921;
        bh=84VHW+MjK2MciFRF+fkIQr8sxCTgy6uTxEIxU/lNyJE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=N4RrRIWXAruSmtoR5NAM6Qz9ril7NRAfg1r0hnjhWDxP2bbNygHsiLpYWE/2d6zIn
         IwxmoDDbuYeCxzmf5PH9ZxCLiZ5LTUer1F+1iiN0bgyUqyTka4kYR0B5SOhaEQ9Z6j
         Txl9SGsnY/dImBTFykm4Dtu0Hp1UPaEeZh1MpdNkx47sbPM2SZ4HxdsqfE6cbL8zX9
         lLh3/3HpMuCRzfjTGcsmt9iSg2ZmBSojVt6igBOkDuiAl0KEjvaUqII9AzB90WQbn0
         z3RSq27wBTrF1ydLvrK8SfnoMsK9Jxn163G3E2d8Jr5P3NzwEkHpvIslCbyFriUz8r
         lCjRi/QwCAW4w==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v9 20/27] NFS: Trace effects of readdirplus on the dcache
Date:   Sun, 27 Feb 2022 18:12:20 -0500
Message-Id: <20220227231227.9038-21-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220227231227.9038-20-trondmy@kernel.org>
References: <20220227231227.9038-1-trondmy@kernel.org>
 <20220227231227.9038-2-trondmy@kernel.org>
 <20220227231227.9038-3-trondmy@kernel.org>
 <20220227231227.9038-4-trondmy@kernel.org>
 <20220227231227.9038-5-trondmy@kernel.org>
 <20220227231227.9038-6-trondmy@kernel.org>
 <20220227231227.9038-7-trondmy@kernel.org>
 <20220227231227.9038-8-trondmy@kernel.org>
 <20220227231227.9038-9-trondmy@kernel.org>
 <20220227231227.9038-10-trondmy@kernel.org>
 <20220227231227.9038-11-trondmy@kernel.org>
 <20220227231227.9038-12-trondmy@kernel.org>
 <20220227231227.9038-13-trondmy@kernel.org>
 <20220227231227.9038-14-trondmy@kernel.org>
 <20220227231227.9038-15-trondmy@kernel.org>
 <20220227231227.9038-16-trondmy@kernel.org>
 <20220227231227.9038-17-trondmy@kernel.org>
 <20220227231227.9038-18-trondmy@kernel.org>
 <20220227231227.9038-19-trondmy@kernel.org>
 <20220227231227.9038-20-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index 0dda082610cc..9a2415b5be73 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -752,8 +752,12 @@ void nfs_prime_dcache(struct dentry *parent, struct nfs_entry *entry,
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
@@ -775,6 +779,7 @@ void nfs_prime_dcache(struct dentry *parent, struct nfs_entry *entry,
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

