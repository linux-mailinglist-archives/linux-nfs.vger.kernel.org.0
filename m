Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8864C1463
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Feb 2022 14:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241000AbiBWNlI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Feb 2022 08:41:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240999AbiBWNlI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Feb 2022 08:41:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E371AC06A
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 05:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645623639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vha02VFW5Iw1IQcPMRwnb3PRTXDYtnVPVn1kQ09IAtM=;
        b=Ugj1zYDB7Mp3Uh92fOw/rPXjRb45FWDE5GyYixdCShtDWkL4j6l0acheV2QzJTIVMdsEPU
        tk+CZcCDq4dBkWH3uYNQE7s262vgxYzp3z041b/jolkOWS1m5F1ZCFMKC3Rv4XIss/Plz8
        kFbVp1t8IVuKWCEtK/RrFDhWOLIt9S4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-407-k1icQD9nM-aRhaCh4ULf2A-1; Wed, 23 Feb 2022 08:40:37 -0500
X-MC-Unique: k1icQD9nM-aRhaCh4ULf2A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1B88800425
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 13:40:36 +0000 (UTC)
Received: from bcodding.csb (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 605EA7A537
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 13:40:36 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id 01DA310C3101; Wed, 23 Feb 2022 08:40:36 -0500 (EST)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 4/8] NFS: Keep the readdir pagecache cursor updated
Date:   Wed, 23 Feb 2022 08:40:31 -0500
Message-Id: <5479c8c5be9cf3f387edac54f170461f8f7b89e2.1645623510.git.bcodding@redhat.com>
In-Reply-To: <aaedb2e378800a5cdb7071d65690b981274f2c22.1645623510.git.bcodding@redhat.com>
References: <d759b6df8acd82b8d44e2afcf11a7a94dcf85ba6.1645623510.git.bcodding@redhat.com> <eedb07d14a96caef1de663a436a326b2c5012ab4.1645623510.git.bcodding@redhat.com> <aaedb2e378800a5cdb7071d65690b981274f2c22.1645623510.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Whenever we successfully locate our dir_cookie within the pagecache, or
finish emitting entries to userspace, update the pagecache cursor.  These
updates provide marker points to validate pagecache pages in a future
patch.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/dir.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 009187c0ae0f..2b1a0c1cdce4 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -154,6 +154,10 @@ struct nfs_cache_array {
 	struct nfs_cache_array_entry array[];
 };
 
+static const int cache_entries_per_page =
+	(PAGE_SIZE - sizeof(struct nfs_cache_array)) /
+	sizeof(struct nfs_cache_array_entry);
+
 struct nfs_readdir_descriptor {
 	struct file	*file;
 	struct page	*page;
@@ -282,6 +286,21 @@ static bool nfs_readdir_array_is_full(struct nfs_cache_array *array)
 	return array->page_full;
 }
 
+static void nfs_readdir_set_cursor(struct nfs_readdir_descriptor *desc, int index)
+{
+	desc->pgc.entry_index = index;
+	desc->pgc.index_cookie = desc->dir_cookie;
+}
+
+static void nfs_readdir_cursor_next(struct nfs_dir_page_cursor *pgc, u64 cookie)
+{
+	pgc->index_cookie = cookie;
+	if (++pgc->entry_index == cache_entries_per_page) {
+		pgc->entry_index = 0;
+		pgc->page_index++;
+	}
+}
+
 /*
  * the caller is responsible for freeing qstr.name
  * when called by nfs_readdir_add_to_array, the strings will be freed in
@@ -455,7 +474,7 @@ static int nfs_readdir_search_for_pos(struct nfs_cache_array *array,
 
 	index = (unsigned int)diff;
 	desc->dir_cookie = array->array[index].cookie;
-	desc->pgc.entry_index = index;
+	nfs_readdir_set_cursor(desc, index);
 	return 0;
 out_eof:
 	desc->eof = true;
@@ -524,7 +543,7 @@ static int nfs_readdir_search_for_cookie(struct nfs_cache_array *array,
 			else
 				desc->ctx->pos = new_pos;
 			desc->prev_index = new_pos;
-			desc->pgc.entry_index = i;
+			nfs_readdir_set_cursor(desc, i);
 			return 0;
 		}
 	}
@@ -551,9 +570,9 @@ static int nfs_readdir_search_array(struct nfs_readdir_descriptor *desc)
 		status = nfs_readdir_search_for_cookie(array, desc);
 
 	if (status == -EAGAIN) {
-		desc->pgc.index_cookie = array->last_cookie;
+		desc->pgc.entry_index = array->size - 1;
+		nfs_readdir_cursor_next(&desc->pgc, array->last_cookie);
 		desc->current_index += array->size;
-		desc->pgc.page_index++;
 	}
 	kunmap_atomic(array);
 	return status;
@@ -1084,6 +1103,8 @@ static void nfs_do_filldir(struct nfs_readdir_descriptor *desc,
 		desc->eof = !desc->eob;
 
 	kunmap(desc->page);
+	desc->pgc.entry_index = i-1;
+	nfs_readdir_cursor_next(&desc->pgc, desc->dir_cookie);
 	dfprintk(DIRCACHE, "NFS: nfs_do_filldir() filling ended @ cookie %llu\n",
 			(unsigned long long)desc->dir_cookie);
 }
@@ -1118,8 +1139,7 @@ static int uncached_readdir(struct nfs_readdir_descriptor *desc)
 		goto out;
 
 	desc->pgc.page_index = 0;
-	desc->pgc.entry_index = 0;
-	desc->pgc.index_cookie = desc->dir_cookie;
+	nfs_readdir_set_cursor(desc, 0);
 	desc->duped = 0;
 	desc->page_index_max = 0;
 
-- 
2.31.1

