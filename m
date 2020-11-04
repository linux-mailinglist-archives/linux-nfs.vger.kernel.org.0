Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDDC2A69A4
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Nov 2020 17:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731175AbgKDQ1I (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Nov 2020 11:27:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728999AbgKDQ1I (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Nov 2020 11:27:08 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F5CC0613D3
        for <linux-nfs@vger.kernel.org>; Wed,  4 Nov 2020 08:27:07 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id da2so7969943qvb.0
        for <linux-nfs@vger.kernel.org>; Wed, 04 Nov 2020 08:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Ba9tEIiRCHCzAnjBVsi/HZFF1pWE6pK3yXz5LGvGLco=;
        b=HpVuAUY3RRQ6YTHbCTcIkF8SYFYVdOcRS72m3lveFz9M8Ys8bUcd2FAHSpkUVX0yPY
         xj7bgHH5gxAppkoR7QPz1ah8eCS6Y/Y+Wv82FGOwjTkg30w7nvF6xxGL5/DpKAUiqY9w
         aUpP66438XEl85fexAg4WQYYU899rgQeacw0jCrZNHTsPD7nivZdlrWb2S9qvB+D/YE+
         WNyfkrJ7LbRLVF8K1M1XU/Nqb0GBL/McIfVt9NcmlBjI/iZ1GwDV4vSd7/rTjg5t/anS
         pOLZ4cGtn4tVcVaLG41E7F/b5oUa+tXZYFlmNxmVKJ2UeKk4+vi6GLHTaMfeloRuYOGo
         MqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ba9tEIiRCHCzAnjBVsi/HZFF1pWE6pK3yXz5LGvGLco=;
        b=Aura9e3/6z5LI1sJh0vB+VTxNlpHJ/4wlZwrpPglDs1nhG+V6E8RPeSzz2PmRF+BV/
         BwFBoBNygzg8DoeU3AdgmXpLi8coUwSGbSpbYDxVaOALNbZGgWAsH1BfUg7KOF9FGs5H
         F2LerK3gJR/ycl7bb4efD78mDSRAnaBX/ls4JFf7x4IfEEfj8xZPUcD8OaAaBYBy+saG
         y21K0L3jvDNmY00eDL3R8K0GH5SfwtceLy0Pu4Qqh9Z/pbPnbd17ZK5oXtKzcUiTuafx
         HEnGN+jVwx5Xn70zQY6J0n6pEJYCbuKRoEqSILPEY8T3q+vXYNzefA+5KepEHmNQURHa
         84SA==
X-Gm-Message-State: AOAM532/WkvSnQ1AeYdM/R7uhXbw2g6wQjT74mvBbXRXM556J1jap2xw
        Oh4nDyaCaTKN9H1YfOZDjryR4d88NAXx
X-Google-Smtp-Source: ABdhPJyNKYUgY10qxi6C1OQW4rBqO0sZ3xQaJ77NZALSofiBpjOEhBH0WwseKbB43stsgmeA6h/2FQ==
X-Received: by 2002:ad4:4e2b:: with SMTP id dm11mr3327551qvb.41.1604507226804;
        Wed, 04 Nov 2020 08:27:06 -0800 (PST)
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net. [68.36.133.222])
        by smtp.gmail.com with ESMTPSA id g78sm2896924qke.88.2020.11.04.08.27.05
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:27:06 -0800 (PST)
From:   trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 05/17] NFS: Don't discard readdir results
Date:   Wed,  4 Nov 2020 11:16:26 -0500
Message-Id: <20201104161638.300324-6-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201104161638.300324-5-trond.myklebust@hammerspace.com>
References: <20201104161638.300324-1-trond.myklebust@hammerspace.com>
 <20201104161638.300324-2-trond.myklebust@hammerspace.com>
 <20201104161638.300324-3-trond.myklebust@hammerspace.com>
 <20201104161638.300324-4-trond.myklebust@hammerspace.com>
 <20201104161638.300324-5-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If a readdir call returns more data than we can fit into one page
cache page, then allocate a new one for that data rather than
discarding the data.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 46 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 42 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 842f69120a01..f7248145c333 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -320,6 +320,26 @@ static void nfs_readdir_page_set_eof(struct page *page)
 	kunmap_atomic(array);
 }
 
+static void nfs_readdir_page_unlock_and_put(struct page *page)
+{
+	unlock_page(page);
+	put_page(page);
+}
+
+static struct page *nfs_readdir_page_get_next(struct address_space *mapping,
+					      pgoff_t index, u64 cookie)
+{
+	struct page *page;
+
+	page = nfs_readdir_page_get_locked(mapping, index, cookie);
+	if (page) {
+		if (nfs_readdir_page_last_cookie(page) == cookie)
+			return page;
+		nfs_readdir_page_unlock_and_put(page);
+	}
+	return NULL;
+}
+
 static inline
 int is_32bit_api(void)
 {
@@ -637,13 +657,15 @@ void nfs_prime_dcache(struct dentry *parent, struct nfs_entry *entry,
 }
 
 /* Perform conversion from xdr to cache array */
-static
-int nfs_readdir_page_filler(nfs_readdir_descriptor_t *desc, struct nfs_entry *entry,
-				struct page **xdr_pages, struct page *page, unsigned int buflen)
+static int nfs_readdir_page_filler(struct nfs_readdir_descriptor *desc,
+				   struct nfs_entry *entry,
+				   struct page **xdr_pages,
+				   struct page *fillme, unsigned int buflen)
 {
+	struct address_space *mapping = desc->file->f_mapping;
 	struct xdr_stream stream;
 	struct xdr_buf buf;
-	struct page *scratch;
+	struct page *scratch, *new, *page = fillme;
 	int status;
 
 	scratch = alloc_page(GFP_KERNEL);
@@ -666,6 +688,19 @@ int nfs_readdir_page_filler(nfs_readdir_descriptor_t *desc, struct nfs_entry *en
 					desc->dir_verifier);
 
 		status = nfs_readdir_add_to_array(entry, page);
+		if (status != -ENOSPC)
+			continue;
+
+		if (page->mapping != mapping)
+			break;
+		new = nfs_readdir_page_get_next(mapping, page->index + 1,
+						entry->prev_cookie);
+		if (!new)
+			break;
+		if (page != fillme)
+			nfs_readdir_page_unlock_and_put(page);
+		page = new;
+		status = nfs_readdir_add_to_array(entry, page);
 	} while (!status && !entry->eof);
 
 	switch (status) {
@@ -681,6 +716,9 @@ int nfs_readdir_page_filler(nfs_readdir_descriptor_t *desc, struct nfs_entry *en
 		break;
 	}
 
+	if (page != fillme)
+		nfs_readdir_page_unlock_and_put(page);
+
 	put_page(scratch);
 	return status;
 }
-- 
2.28.0

