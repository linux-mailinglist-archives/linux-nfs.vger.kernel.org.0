Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B4C4BDF6B
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Feb 2022 18:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379997AbiBUQRv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Feb 2022 11:17:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379995AbiBUQPa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Feb 2022 11:15:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED85723BD4
        for <linux-nfs@vger.kernel.org>; Mon, 21 Feb 2022 08:15:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 990FAB81258
        for <linux-nfs@vger.kernel.org>; Mon, 21 Feb 2022 16:15:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25984C340E9
        for <linux-nfs@vger.kernel.org>; Mon, 21 Feb 2022 16:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645460104;
        bh=XisaS5QIWRCnazYmX0T0WSJZm3m52nEkL8Rx78emNwc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=am5UT+4/nwGLKcIe4bW5QFN3ctAhNW7XZK7I3KxtknFxpFbZYV/9Qbtz7avRqtWGu
         NxHWXEgxVCteZ4Zi9psjo879218BDwd9dkl/7s3fjq7gL5HJW63hvmfnZn06lJGp2S
         tiO6hmPDj3hs5CnMuZbXse3+1JHVWKSn/ijUsq5knhF3dEBUYXLW70WYcU1WYHdQmv
         0Hkxi+saQ4E0CMBWm5wwilIEupRiUc4jwDpbGHyYAoKGd8xSqRFw33xSw8J5pQHRbK
         L2W/HUb+6rdKRvY4UkSNl/GGcKVvZfNMCG82LXAQ6fmV0fGhGv7QiphWXFzHnaSH/b
         cHlpmSY9I012g==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v6 12/13] NFS: Trace effects of readdirplus on the dcache
Date:   Mon, 21 Feb 2022 11:08:50 -0500
Message-Id: <20220221160851.15508-13-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220221160851.15508-12-trondmy@kernel.org>
References: <20220221160851.15508-1-trondmy@kernel.org>
 <20220221160851.15508-2-trondmy@kernel.org>
 <20220221160851.15508-3-trondmy@kernel.org>
 <20220221160851.15508-4-trondmy@kernel.org>
 <20220221160851.15508-5-trondmy@kernel.org>
 <20220221160851.15508-6-trondmy@kernel.org>
 <20220221160851.15508-7-trondmy@kernel.org>
 <20220221160851.15508-8-trondmy@kernel.org>
 <20220221160851.15508-9-trondmy@kernel.org>
 <20220221160851.15508-10-trondmy@kernel.org>
 <20220221160851.15508-11-trondmy@kernel.org>
 <20220221160851.15508-12-trondmy@kernel.org>
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
index 273a35851e42..bcbfe03e3835 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -725,8 +725,12 @@ void nfs_prime_dcache(struct dentry *parent, struct nfs_entry *entry,
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
@@ -748,6 +752,7 @@ void nfs_prime_dcache(struct dentry *parent, struct nfs_entry *entry,
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

