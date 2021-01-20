Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA75A2FD66E
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Jan 2021 18:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391250AbhATRFT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 Jan 2021 12:05:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50016 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391641AbhATRBf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 20 Jan 2021 12:01:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611161999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OtOrA4Ys6J1Bm2BQBSBbJM8oiwkdvUMixkAPEQdoyU8=;
        b=LVo+HrhkW4+adRoLBSWxDt56udxlpD2nI5zzGJ1/2m/O0in+Cjoan1e2/jXtxQQP0nIdFD
        trrZLEBG8I7yqsXhw0v1BsYxq3sQuYapkVTiQN2pWu/dQ9iqWwHdP2cXPBsb8B1lf2THgP
        /HbxGk2Mz92V5fEtSPcJE2qkFxPadwk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-5HBUKXXdOwuanCod0c_NVA-1; Wed, 20 Jan 2021 11:59:56 -0500
X-MC-Unique: 5HBUKXXdOwuanCod0c_NVA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 398838735C3
        for <linux-nfs@vger.kernel.org>; Wed, 20 Jan 2021 16:59:55 +0000 (UTC)
Received: from bcodding.csb (ovpn-64-66.rdu2.redhat.com [10.10.64.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0BC5560D11
        for <linux-nfs@vger.kernel.org>; Wed, 20 Jan 2021 16:59:55 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id A09E810E3EF8; Wed, 20 Jan 2021 11:59:54 -0500 (EST)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v1 04/10] NFS: Keep the readdir pagecache cursor updated
Date:   Wed, 20 Jan 2021 11:59:48 -0500
Message-Id: <f803021382040dba38ce8414ed1db8e400c0cc49.1611160121.git.bcodding@redhat.com>
In-Reply-To: <cover.1611160120.git.bcodding@redhat.com>
References: <cover.1611160120.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Whenever we successfully locate our dir_cookie within the pagecache, or
finish emitting entries to userspace, update the pagecache cursor.  These
updates provide marker points to validate pagecache pages in a future
patch.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/dir.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 6626aff9f54d..7f6c84c8a412 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -150,6 +150,10 @@ struct nfs_cache_array {
 	struct nfs_cache_array_entry array[];
 };
 
+static const int cache_entries_per_page =
+	(PAGE_SIZE - sizeof(struct nfs_cache_array)) /
+	sizeof(struct nfs_cache_array_entry);
+
 struct nfs_readdir_descriptor {
 	struct file	*file;
 	struct page	*page;
@@ -251,6 +255,21 @@ static bool nfs_readdir_array_is_full(struct nfs_cache_array *array)
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
@@ -424,7 +443,7 @@ static int nfs_readdir_search_for_pos(struct nfs_cache_array *array,
 
 	index = (unsigned int)diff;
 	desc->dir_cookie = array->array[index].cookie;
-	desc->pgc.entry_index = index;
+	nfs_readdir_set_cursor(desc, index);
 	return 0;
 out_eof:
 	desc->eof = true;
@@ -492,7 +511,7 @@ static int nfs_readdir_search_for_cookie(struct nfs_cache_array *array,
 			else
 				desc->ctx->pos = new_pos;
 			desc->prev_index = new_pos;
-			desc->pgc.entry_index = i;
+			nfs_readdir_set_cursor(desc, i);
 			return 0;
 		}
 	}
@@ -519,9 +538,9 @@ static int nfs_readdir_search_array(struct nfs_readdir_descriptor *desc)
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
@@ -1035,6 +1054,8 @@ static void nfs_do_filldir(struct nfs_readdir_descriptor *desc)
 		desc->eof = true;
 
 	kunmap(desc->page);
+	desc->pgc.entry_index = i-1;
+	nfs_readdir_cursor_next(&desc->pgc, desc->dir_cookie);
 	dfprintk(DIRCACHE, "NFS: nfs_do_filldir() filling ended @ cookie %llu\n",
 			(unsigned long long)desc->dir_cookie);
 }
-- 
2.25.4

