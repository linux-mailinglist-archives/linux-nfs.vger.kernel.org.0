Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B93F67F0AC
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Jan 2023 22:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjA0VzB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Jan 2023 16:55:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbjA0VzA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Jan 2023 16:55:00 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B92716AF5;
        Fri, 27 Jan 2023 13:54:59 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id fl11-20020a05600c0b8b00b003daf72fc844so6318360wmb.0;
        Fri, 27 Jan 2023 13:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3sUXq/W8BEZIBDYYVZQ1mnxogvWQtdcjY0PJMAjAJSM=;
        b=UwI8uf9zgKWWBCv5264lTfvKd7BbaCbH15YY4LLLbTx2uLxQPSjpuuXSwtkFO8BjeH
         62Ag4W1HOQ3hsdfQxVDehNVVb5PJod899hLGE0H94l7b7k6v7Ai8mIO1gBJrNuU2vJ1c
         1DUEYx/PPTGEzn7SmOh/nxPks43Z3gCOfd26P7LJCJ/jUSPnmHFJz5WrYjDsXFhd2gTW
         dezaQE6/SidtcpiYSQH6Fqpm1uHJ8qiwmkNKYSCLiMO24G2mWxl52bO2IHhOrO1S48+W
         UxJ82P7mZ+K9WIyWD3qPZQuKqE0B0Ao5kgOH98WLfteeW9MJU0uFNQjb7WByaKwhuOqK
         sTLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3sUXq/W8BEZIBDYYVZQ1mnxogvWQtdcjY0PJMAjAJSM=;
        b=nxqAGYR5ws+skvjFabK0T4LhQou49hKWU0bBudgbg1mLtUmFIg/Oa4saefOnJ1t2zU
         pCN8CauhvmMHWriv1SLNWG1oQMYu3zBAFwaUAzxB96uVtSz6XvkIYyNxEsNBTDiDEh26
         mh4Zkar13OqqWj454EkDatdL9LXMwZNiiYX3GO0rW54xBMcJKRCTsiIjlHPkuwVNrN28
         ZH9EKHMwcIaA822aR3Qx4pwX0A9OPbFU2jhnWA4AZlp4J+IufKUUL9EKvbvrW+1mUz6p
         X8BYVHFZt05wR3PSk4xHnHQaHwMEEkDXvr4LSbiw8w64LuD6SLDKX70ncY8HDieR3NFj
         NmGg==
X-Gm-Message-State: AFqh2kqqSbuF9WCj65E1Fs/luo4poEW2Co3v+fTnXu5PgWgiegO8+JtH
        6676nVorMvl0nSc3EVbUWzc=
X-Google-Smtp-Source: AMrXdXu8k0vp+ioGOVn9ul8IRoSc2tgoAWt1mbIs2ouKiCtWeiO/aYu0n8tOumMgfrc8tghf4YgVbg==
X-Received: by 2002:a05:600c:510b:b0:3db:d3f:a919 with SMTP id o11-20020a05600c510b00b003db0d3fa919mr39209411wms.1.1674856497629;
        Fri, 27 Jan 2023 13:54:57 -0800 (PST)
Received: from localhost.localdomain (host-82-60-215-65.retail.telecomitalia.it. [82.60.215.65])
        by smtp.gmail.com with ESMTPSA id n20-20020a05600c465400b003dc43a10fa5sm859717wmo.13.2023.01.27.13.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 13:54:56 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH] fs/nfs: Replace kmap_atomic() with kmap_local_page() in dir.c
Date:   Fri, 27 Jan 2023 22:54:52 +0100
Message-Id: <20230127215452.6399-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

kmap_atomic() is deprecated in favor of kmap_local_page().

With kmap_local_page() the mappings are per thread, CPU local, can take
page-faults, and can be called from any context (including interrupts).
Furthermore, the tasks can be preempted and, when they are scheduled to
run again, the kernel virtual addresses are restored and still valid.

kmap_atomic() is implemented like a kmap_local_page() which also disables
page-faults and preemption (the latter only for !PREEMPT_RT kernels,
otherwise it only disables migration).

The code within the mappings/un-mappings in the functions of dir.c don't
depend on the above-mentioned side effects of kmap_atomic(), so that mere
replacements of the old API with the new one is all that is required
(i.e., there is no need to explicitly add calls to pagefault_disable()
and/or preempt_disable()).

Therefore, replace kmap_atomic() with kmap_local_page() in fs/nfs/dir.c.

Tested in a QEMU/KVM x86_32 VM, 6GB RAM, booting a kernel with
HIGHMEM64GB enabled.

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 fs/nfs/dir.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index f7e4a88d5d92..dec18c9f7650 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -203,14 +203,14 @@ static void nfs_readdir_page_init_array(struct page *page, u64 last_cookie,
 {
 	struct nfs_cache_array *array;
 
-	array = kmap_atomic(page);
+	array = kmap_local_page(page);
 	array->change_attr = change_attr;
 	array->last_cookie = last_cookie;
 	array->size = 0;
 	array->page_full = 0;
 	array->page_is_eof = 0;
 	array->cookies_are_ordered = 1;
-	kunmap_atomic(array);
+	kunmap_local(array);
 }
 
 /*
@@ -221,11 +221,11 @@ static void nfs_readdir_clear_array(struct page *page)
 	struct nfs_cache_array *array;
 	unsigned int i;
 
-	array = kmap_atomic(page);
+	array = kmap_local_page(page);
 	for (i = 0; i < array->size; i++)
 		kfree(array->array[i].name);
 	array->size = 0;
-	kunmap_atomic(array);
+	kunmap_local(array);
 }
 
 static void nfs_readdir_free_folio(struct folio *folio)
@@ -371,14 +371,14 @@ static pgoff_t nfs_readdir_page_cookie_hash(u64 cookie)
 static bool nfs_readdir_page_validate(struct page *page, u64 last_cookie,
 				      u64 change_attr)
 {
-	struct nfs_cache_array *array = kmap_atomic(page);
+	struct nfs_cache_array *array = kmap_local_page(page);
 	int ret = true;
 
 	if (array->change_attr != change_attr)
 		ret = false;
 	if (nfs_readdir_array_index_cookie(array) != last_cookie)
 		ret = false;
-	kunmap_atomic(array);
+	kunmap_local(array);
 	return ret;
 }
 
@@ -418,9 +418,9 @@ static u64 nfs_readdir_page_last_cookie(struct page *page)
 	struct nfs_cache_array *array;
 	u64 ret;
 
-	array = kmap_atomic(page);
+	array = kmap_local_page(page);
 	ret = array->last_cookie;
-	kunmap_atomic(array);
+	kunmap_local(array);
 	return ret;
 }
 
@@ -429,9 +429,9 @@ static bool nfs_readdir_page_needs_filling(struct page *page)
 	struct nfs_cache_array *array;
 	bool ret;
 
-	array = kmap_atomic(page);
+	array = kmap_local_page(page);
 	ret = !nfs_readdir_array_is_full(array);
-	kunmap_atomic(array);
+	kunmap_local(array);
 	return ret;
 }
 
@@ -439,9 +439,9 @@ static void nfs_readdir_page_set_eof(struct page *page)
 {
 	struct nfs_cache_array *array;
 
-	array = kmap_atomic(page);
+	array = kmap_local_page(page);
 	nfs_readdir_array_set_eof(array);
-	kunmap_atomic(array);
+	kunmap_local(array);
 }
 
 static struct page *nfs_readdir_page_get_next(struct address_space *mapping,
@@ -568,14 +568,14 @@ static int nfs_readdir_search_array(struct nfs_readdir_descriptor *desc)
 	struct nfs_cache_array *array;
 	int status;
 
-	array = kmap_atomic(desc->page);
+	array = kmap_local_page(desc->page);
 
 	if (desc->dir_cookie == 0)
 		status = nfs_readdir_search_for_pos(array, desc);
 	else
 		status = nfs_readdir_search_for_cookie(array, desc);
 
-	kunmap_atomic(array);
+	kunmap_local(array);
 	return status;
 }
 
-- 
2.39.1

