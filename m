Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E66AC2A69B4
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Nov 2020 17:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730886AbgKDQ1Y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Nov 2020 11:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbgKDQ1X (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Nov 2020 11:27:23 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F534C0613D3
        for <linux-nfs@vger.kernel.org>; Wed,  4 Nov 2020 08:27:21 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id dj6so6183814qvb.3
        for <linux-nfs@vger.kernel.org>; Wed, 04 Nov 2020 08:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7PN4Vw59i214EUwCV4qZJILmXyvuZ2XbdjIb2vLc7fE=;
        b=U9X8cxRg9GbuExgMS7t2NBY/tlMPvf9/sjkDhBjgNWWh4xOlfQgAy6/c0lCATcyJDf
         6XvbvHz/eSbmSiOu80K1NpcoHMdcqOwRuOR/9pBtTCZYf28FUlP9QAwqknznzp0SRNzu
         LxGsStOzX1m7ksJ3f1yANcya84/VRboEbopGN2X+KFpNeTI/eT/S0ze2ZFLdvkjOHpmq
         Euh6mIAy4/ielDVhJjYGUNdEOX13fzns0zpWv1dGQI8XBZOX4J/UsjfBLNXFRX3z44dP
         T5CET19lT4xc5SYqlq1QWldemIC/1BrAup+nixUfGq74w466aHNzC7To6lL4PfQXMoj8
         GTZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7PN4Vw59i214EUwCV4qZJILmXyvuZ2XbdjIb2vLc7fE=;
        b=Rxp1uWiiJOopIg1Mkuap2Yw8oqbfysVnENw2XUyZAVKgVN9/4IlzSbpBFzow2RGHf8
         nGzOf8/qQaixPJN0JM443OfMwDJx/0CFHOZxY+G1GbJP5y6jhMGl8ZHWu+AhdYJ8dSqT
         bDmjy9igMMiUKAHLIz3S5xLc5CicAB64cAykAgn9zq0IoU+NpWIX5UpFcxtcsTSsxLAn
         lSWaK8qdv1vd0SVoHl6XMjTdNfsyLS3lZWgRdeLgOj9rc4gXqd0aV/dQDL5k1e83d1Kq
         ts1SiK3oWBbR4DLwd4/6CpOgi/FnTb4oqYGyD7vMrSEwYjfY0h4KknKyxZ6vCeJ+LZAE
         lulQ==
X-Gm-Message-State: AOAM532FGc4Z3W3gZCEh78XE89XF1S3m3UgjWC5ULHiWYTuy9czaQjnt
        8TwFJnDwh2iGLOqRD03w1L64grR4YfFc
X-Google-Smtp-Source: ABdhPJyv39HNcY+vbLpKPEPg1YC/R5WHpv3mpgfmYOC/4QJ6HfetsMOTlJ1s1ZeXf8Cutj3v5ijPrQ==
X-Received: by 2002:a05:6214:18e8:: with SMTP id ep8mr18339651qvb.61.1604507240229;
        Wed, 04 Nov 2020 08:27:20 -0800 (PST)
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net. [68.36.133.222])
        by smtp.gmail.com with ESMTPSA id g78sm2896924qke.88.2020.11.04.08.27.19
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:27:19 -0800 (PST)
From:   trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 17/17] NFS: Optimisations for monotonically increasing readdir cookies
Date:   Wed,  4 Nov 2020 11:16:38 -0500
Message-Id: <20201104161638.300324-18-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201104161638.300324-17-trond.myklebust@hammerspace.com>
References: <20201104161638.300324-1-trond.myklebust@hammerspace.com>
 <20201104161638.300324-2-trond.myklebust@hammerspace.com>
 <20201104161638.300324-3-trond.myklebust@hammerspace.com>
 <20201104161638.300324-4-trond.myklebust@hammerspace.com>
 <20201104161638.300324-5-trond.myklebust@hammerspace.com>
 <20201104161638.300324-6-trond.myklebust@hammerspace.com>
 <20201104161638.300324-7-trond.myklebust@hammerspace.com>
 <20201104161638.300324-8-trond.myklebust@hammerspace.com>
 <20201104161638.300324-9-trond.myklebust@hammerspace.com>
 <20201104161638.300324-10-trond.myklebust@hammerspace.com>
 <20201104161638.300324-11-trond.myklebust@hammerspace.com>
 <20201104161638.300324-12-trond.myklebust@hammerspace.com>
 <20201104161638.300324-13-trond.myklebust@hammerspace.com>
 <20201104161638.300324-14-trond.myklebust@hammerspace.com>
 <20201104161638.300324-15-trond.myklebust@hammerspace.com>
 <20201104161638.300324-16-trond.myklebust@hammerspace.com>
 <20201104161638.300324-17-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the server is handing out monotonically increasing readdir cookie values,
then we can optimise away searches through pages that contain cookies that
lie outside our search range.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 454377228167..b6c3501e8f61 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -140,7 +140,8 @@ struct nfs_cache_array {
 	u64 last_cookie;
 	unsigned int size;
 	unsigned char page_full : 1,
-		      page_is_eof : 1;
+		      page_is_eof : 1,
+		      cookies_are_ordered : 1;
 	struct nfs_cache_array_entry array[];
 };
 
@@ -178,6 +179,7 @@ static void nfs_readdir_page_init_array(struct page *page, u64 last_cookie)
 	array = kmap_atomic(page);
 	nfs_readdir_array_init(array);
 	array->last_cookie = last_cookie;
+	array->cookies_are_ordered = 1;
 	kunmap_atomic(array);
 }
 
@@ -269,6 +271,8 @@ int nfs_readdir_add_to_array(struct nfs_entry *entry, struct page *page)
 	cache_entry->name_len = entry->len;
 	cache_entry->name = name;
 	array->last_cookie = entry->cookie;
+	if (array->last_cookie <= cache_entry->cookie)
+		array->cookies_are_ordered = 0;
 	array->size++;
 	if (entry->eof != 0)
 		nfs_readdir_array_set_eof(array);
@@ -395,6 +399,19 @@ nfs_readdir_inode_mapping_valid(struct nfs_inode *nfsi)
 	return !test_bit(NFS_INO_INVALIDATING, &nfsi->flags);
 }
 
+static bool nfs_readdir_array_cookie_in_range(struct nfs_cache_array *array,
+					      u64 cookie)
+{
+	if (!array->cookies_are_ordered)
+		return true;
+	/* Optimisation for monotonically increasing cookies */
+	if (cookie >= array->last_cookie)
+		return false;
+	if (array->size && cookie < array->array[0].cookie)
+		return false;
+	return true;
+}
+
 static int nfs_readdir_search_for_cookie(struct nfs_cache_array *array,
 					 struct nfs_readdir_descriptor *desc)
 {
@@ -402,6 +419,9 @@ static int nfs_readdir_search_for_cookie(struct nfs_cache_array *array,
 	loff_t new_pos;
 	int status = -EAGAIN;
 
+	if (!nfs_readdir_array_cookie_in_range(array, desc->dir_cookie))
+		goto check_eof;
+
 	for (i = 0; i < array->size; i++) {
 		if (array->array[i].cookie == desc->dir_cookie) {
 			struct nfs_inode *nfsi = NFS_I(file_inode(desc->file));
@@ -435,6 +455,7 @@ static int nfs_readdir_search_for_cookie(struct nfs_cache_array *array,
 			return 0;
 		}
 	}
+check_eof:
 	if (array->page_is_eof) {
 		status = -EBADCOOKIE;
 		if (desc->dir_cookie == array->last_cookie)
-- 
2.28.0

