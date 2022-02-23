Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5651B4C1464
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Feb 2022 14:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241003AbiBWNlI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Feb 2022 08:41:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237639AbiBWNlH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Feb 2022 08:41:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE59AAC05D
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 05:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645623638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dRQpV3tuiAuRESH2Zw0RYAHVDBG1KtyuQE/uQ/zmGug=;
        b=DKhRqsECglyhAXtfx2rKE3JJ3oQpiNvvHMPgWl28EE3sAJCrP0CNblUUNU0mDL6O+8Ib+A
        Z49lRq9Rjdc71L6FzP/y0DqURpEkGYCi8ndksN/EPGcPKnQnJA5AssmM3przdwGimuGvGC
        PVCDGIpvatCk6EQ/aOm19gYjviDYd2I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-482-TuJApbJgMw63qrgP8U-j-A-1; Wed, 23 Feb 2022 08:40:37 -0500
X-MC-Unique: TuJApbJgMw63qrgP8U-j-A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A01AD801AAD
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 13:40:36 +0000 (UTC)
Received: from bcodding.csb (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 52876106A7B2
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 13:40:36 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id E948B10C30F0; Wed, 23 Feb 2022 08:40:35 -0500 (EST)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 1/8] NFS: save the directory's change attribute on pagecache pages
Date:   Wed, 23 Feb 2022 08:40:28 -0500
Message-Id: <d759b6df8acd82b8d44e2afcf11a7a94dcf85ba6.1645623510.git.bcodding@redhat.com>
In-Reply-To: <20220221160851.15508-14-trondmy@kernel.org>
References: <20220221160851.15508-14-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

After a pagecache page has been filled with entries, set PagePrivate and
the directory's change attribute on the page.  This will help us perform
per-page invalidations in a later patch.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/dir.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 9f48c75dbf4c..79bdcedc0cad 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -54,6 +54,9 @@ static int nfs_closedir(struct inode *, struct file *);
 static int nfs_readdir(struct file *, struct dir_context *);
 static int nfs_fsync_dir(struct file *, loff_t, loff_t, int);
 static loff_t nfs_llseek_dir(struct file *, loff_t, int);
+static void nfs_readdir_invalidatepage(struct page *,
+			unsigned int, unsigned int);
+static int nfs_readdir_clear_page(struct page*, gfp_t);
 static void nfs_readdir_clear_array(struct page*);
 
 const struct file_operations nfs_dir_operations = {
@@ -66,6 +69,8 @@ const struct file_operations nfs_dir_operations = {
 };
 
 const struct address_space_operations nfs_dir_aops = {
+	.invalidatepage = nfs_readdir_invalidatepage,
+	.releasepage = nfs_readdir_clear_page,
 	.freepage = nfs_readdir_clear_array,
 };
 
@@ -212,6 +217,27 @@ static void nfs_readdir_page_init_array(struct page *page, u64 last_cookie)
 	array->last_cookie = last_cookie;
 	array->cookies_are_ordered = 1;
 	kunmap_atomic(array);
+	set_page_private(page, 0);
+}
+
+static int
+nfs_readdir_clear_page(struct page *page, gfp_t gfp_mask)
+{
+	detach_page_private(page);
+	return 1;
+}
+
+static void
+nfs_readdir_invalidatepage(struct page *page, unsigned int offset,
+							unsigned int length)
+{
+	nfs_readdir_clear_page(page, GFP_KERNEL);
+}
+
+static void
+nfs_readdir_set_page_verifier(struct page *page, unsigned long verf)
+{
+	attach_page_private(page, (void *)verf);
 }
 
 /*
@@ -794,6 +820,8 @@ static int nfs_readdir_page_filler(struct nfs_readdir_descriptor *desc,
 		if (status != -ENOSPC)
 			continue;
 
+		nfs_readdir_set_page_verifier(page, desc->dir_verifier);
+
 		if (page->mapping != mapping) {
 			if (!--narrays)
 				break;
@@ -822,10 +850,13 @@ static int nfs_readdir_page_filler(struct nfs_readdir_descriptor *desc,
 	case -EBADCOOKIE:
 		if (entry->eof) {
 			nfs_readdir_page_set_eof(page);
+			nfs_readdir_set_page_verifier(page, desc->dir_verifier);
 			status = 0;
 		}
 		break;
 	case -ENOSPC:
+		nfs_readdir_set_page_verifier(page, desc->dir_verifier);
+		fallthrough;
 	case -EAGAIN:
 		status = 0;
 		break;
-- 
2.31.1

