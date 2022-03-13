Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2EC4D7730
	for <lists+linux-nfs@lfdr.de>; Sun, 13 Mar 2022 18:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235111AbiCMRNT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 13 Mar 2022 13:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235096AbiCMRNQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 13 Mar 2022 13:13:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529D8139CDA
        for <linux-nfs@vger.kernel.org>; Sun, 13 Mar 2022 10:12:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5F8F61228
        for <linux-nfs@vger.kernel.org>; Sun, 13 Mar 2022 17:12:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D15EC340E8
        for <linux-nfs@vger.kernel.org>; Sun, 13 Mar 2022 17:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647191527;
        bh=yLr8IkkHWvZRHwxq1yjZixPXjlXDD2Jltl9nkaxNcXo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=WukW4CIeIu2r/LxJR7LYZPOK/+2j/hDE0D8HkPkfUoeHRutG7t1eGur3exuArKhfR
         VFwOnTHlUrzgk7NxI/Jf/I7Yhr16ZjnWekRvF9icrhtofTXZ6Qg4YWALTqg3Xahsfi
         vsdwMic7YMZYY5Nd9IcRSVoLnsR3NFWNzKCrEPWnkSqo0eC+eCLGmeVKpwbECKGo66
         38xYae9JuZqyA9hJMLYJ51LFFCxPCqgNCBJ4rW4FwsTOMvkhOSzagw06kBNU72I0uP
         14DC0yXvJy77cDCW7KmUMRwWMj5MLXhhurg/iil3cE0QrbpgpA5KaLugaZNXkxcxzX
         TP3q0ABuWOY3Q==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v10 09/26] NFS: Don't advance the page pointer unless the page is full
Date:   Sun, 13 Mar 2022 13:05:40 -0400
Message-Id: <20220313170557.5940-10-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220313170557.5940-9-trondmy@kernel.org>
References: <20220313170557.5940-1-trondmy@kernel.org>
 <20220313170557.5940-2-trondmy@kernel.org>
 <20220313170557.5940-3-trondmy@kernel.org>
 <20220313170557.5940-4-trondmy@kernel.org>
 <20220313170557.5940-5-trondmy@kernel.org>
 <20220313170557.5940-6-trondmy@kernel.org>
 <20220313170557.5940-7-trondmy@kernel.org>
 <20220313170557.5940-8-trondmy@kernel.org>
 <20220313170557.5940-9-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

When we hit the end of the data in the readdir page, we don't want to
start filling a new page, unless this one is full.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 93f70698e401..60f7feee0a16 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -417,6 +417,18 @@ bool nfs_readdir_use_cookie(const struct file *filp)
 	return true;
 }
 
+static void nfs_readdir_seek_next_array(struct nfs_cache_array *array,
+					struct nfs_readdir_descriptor *desc)
+{
+	if (array->page_full) {
+		desc->last_cookie = array->last_cookie;
+		desc->current_index += array->size;
+		desc->cache_entry_index = 0;
+		desc->page_index++;
+	} else
+		desc->last_cookie = array->array[0].cookie;
+}
+
 static int nfs_readdir_search_for_pos(struct nfs_cache_array *array,
 				      struct nfs_readdir_descriptor *desc)
 {
@@ -428,6 +440,7 @@ static int nfs_readdir_search_for_pos(struct nfs_cache_array *array,
 	if (diff >= array->size) {
 		if (array->page_is_eof)
 			goto out_eof;
+		nfs_readdir_seek_next_array(array, desc);
 		return -EAGAIN;
 	}
 
@@ -500,7 +513,8 @@ static int nfs_readdir_search_for_cookie(struct nfs_cache_array *array,
 		status = -EBADCOOKIE;
 		if (desc->dir_cookie == array->last_cookie)
 			desc->eof = true;
-	}
+	} else
+		nfs_readdir_seek_next_array(array, desc);
 out:
 	return status;
 }
@@ -517,11 +531,6 @@ static int nfs_readdir_search_array(struct nfs_readdir_descriptor *desc)
 	else
 		status = nfs_readdir_search_for_cookie(array, desc);
 
-	if (status == -EAGAIN) {
-		desc->last_cookie = array->last_cookie;
-		desc->current_index += array->size;
-		desc->page_index++;
-	}
 	kunmap_atomic(array);
 	return status;
 }
@@ -998,7 +1007,7 @@ static void nfs_do_filldir(struct nfs_readdir_descriptor *desc,
 {
 	struct file	*file = desc->file;
 	struct nfs_cache_array *array;
-	unsigned int i = 0;
+	unsigned int i;
 
 	array = kmap(desc->page);
 	for (i = desc->cache_entry_index; i < array->size; i++) {
@@ -1011,10 +1020,13 @@ static void nfs_do_filldir(struct nfs_readdir_descriptor *desc,
 			break;
 		}
 		memcpy(desc->verf, verf, sizeof(desc->verf));
-		if (i < (array->size-1))
-			desc->dir_cookie = array->array[i+1].cookie;
-		else
+		if (i == array->size - 1) {
 			desc->dir_cookie = array->last_cookie;
+			nfs_readdir_seek_next_array(array, desc);
+		} else {
+			desc->dir_cookie = array->array[i + 1].cookie;
+			desc->last_cookie = array->array[0].cookie;
+		}
 		if (nfs_readdir_use_cookie(file))
 			desc->ctx->pos = desc->dir_cookie;
 		else
-- 
2.35.1

