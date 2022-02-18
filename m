Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35FED4BC210
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Feb 2022 22:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239882AbiBRVbJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 18 Feb 2022 16:31:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239869AbiBRVbI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 18 Feb 2022 16:31:08 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25ECA178958
        for <linux-nfs@vger.kernel.org>; Fri, 18 Feb 2022 13:30:51 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id v10so17283153qvk.7
        for <linux-nfs@vger.kernel.org>; Fri, 18 Feb 2022 13:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=rJbknmMMQc7P/Rh46YEuD8kUrCfShuy/PfuRnvuL8Ic=;
        b=OqY2s8p7lgRhY4i/gouPpBzq9DOUwny2Y+Y1euCihwHmC+KVAonVNaHygqzCT4RzP7
         o7SP7mXwrCJ3Xnp2x/ksvxWdyF7GM+SAO1ZIOUIfxJGCP6ZKTA3NJnvdsjpUSdfFPtBZ
         AIdKcbP8U12L+HSjkj+EpQuwH+bvyoeT9yWyqASkGK319IZ+6MFmqHO59k0MgCPgsTwh
         NEWLStjFHw3ZvdwNrrM2w3YgC2n90M2CqA/dStyRmikvsusuV9bVUHeR5eQJl9cczvxo
         jbv4Zqm7D6Sz85qpwQ5pGAw6VATCfXofKhsWvrGlMD3+PrYcnk0vupQXRuesE+4CvM4j
         ClVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rJbknmMMQc7P/Rh46YEuD8kUrCfShuy/PfuRnvuL8Ic=;
        b=X6cbJXUvFbhPBqSbeKNsJ4R5p3LQjeHQlcXIJXNpm/WTqCBvMK8GJ7i3vvHzTQFcNb
         iBUCMTlet60owEPRL3TzO5sgz1SbYsBzisvDx2bWcI2FyXQZC67du+Qsn/nEGJX8bPb+
         cIm44H/3XeOLuomRqF7eDefkLDFdb5kiQFWLpTZLFHyIbRBkrPgTEQNoXx0RMjJ0vp+W
         4Y+RFa2f3Uqli4EDq3L1GSV7Vke390vm5zlcdg6HOdgDDFUABaZoY1mc/qKeT6D2RjGo
         SVmDtb4j3Ehp+wdADVTg0NExn7vx8gB4I86uE9RuMReQgvrPjy6KINfEZ1tzGuMviPv9
         uRNA==
X-Gm-Message-State: AOAM530t0kVwFK9GRzUX8RRg+cW/WOjUauI0nUkWKZU1E2xkekH2+JlV
        XadWwWjwqDy6bGkXuUFHwMdXdEZsQA==
X-Google-Smtp-Source: ABdhPJynE1kZJXwarIXDmB6ogt15QCmL9tWO+RgOOCj+qrI9SHr4VXEE94jG42OYPmqD/ywKEIbsYw==
X-Received: by 2002:a05:622a:1c2:b0:2d4:b318:6949 with SMTP id t2-20020a05622a01c200b002d4b3186949mr8452881qtw.405.1645219849675;
        Fri, 18 Feb 2022 13:30:49 -0800 (PST)
Received: from localhost.localdomain (c-68-56-145-227.hsd1.mi.comcast.net. [68.56.145.227])
        by smtp.gmail.com with ESMTPSA id w22sm26928656qtk.7.2022.02.18.13.30.48
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 13:30:48 -0800 (PST)
From:   trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v5 2/6] NFS: Simplify nfs_readdir_xdr_to_array()
Date:   Fri, 18 Feb 2022 16:24:20 -0500
Message-Id: <20220218212424.1840077-3-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220218212424.1840077-2-trond.myklebust@hammerspace.com>
References: <20220218212424.1840077-1-trond.myklebust@hammerspace.com>
 <20220218212424.1840077-2-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Recent changes to readdir mean that we can cope with partially filled
page cache entries, so we no longer need to rely on looping in
nfs_readdir_xdr_to_array().

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index b0ee3a0e0f81..10421b5331ca 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -864,6 +864,7 @@ static int nfs_readdir_xdr_to_array(struct nfs_readdir_descriptor *desc,
 	size_t array_size;
 	struct inode *inode = file_inode(desc->file);
 	unsigned int dtsize = desc->dtsize;
+	unsigned int pglen;
 	int status = -ENOMEM;
 
 	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
@@ -881,28 +882,20 @@ static int nfs_readdir_xdr_to_array(struct nfs_readdir_descriptor *desc,
 	if (!pages)
 		goto out;
 
-	do {
-		unsigned int pglen;
-		status = nfs_readdir_xdr_filler(desc, verf_arg, entry->cookie,
-						pages, dtsize,
-						verf_res);
-		if (status < 0)
-			break;
-
-		pglen = status;
-		if (pglen == 0) {
-			nfs_readdir_page_set_eof(page);
-			break;
-		}
-
-		verf_arg = verf_res;
+	status = nfs_readdir_xdr_filler(desc, verf_arg, entry->cookie, pages,
+					dtsize, verf_res);
+	if (status < 0)
+		goto free_pages;
 
+	pglen = status;
+	if (pglen != 0)
 		status = nfs_readdir_page_filler(desc, entry, pages, pglen,
 						 arrays, narrays);
-		desc->buffer_fills++;
-	} while (!status && nfs_readdir_page_needs_filling(page) &&
-		page_mapping(page));
+	else
+		nfs_readdir_page_set_eof(page);
+	desc->buffer_fills++;
 
+free_pages:
 	nfs_readdir_free_pages(pages, array_size);
 out:
 	nfs_free_fattr(entry->fattr);
-- 
2.35.1

