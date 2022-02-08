Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588A44AE049
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Feb 2022 19:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238783AbiBHSD5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Feb 2022 13:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234348AbiBHSD4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Feb 2022 13:03:56 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75962C061576
        for <linux-nfs@vger.kernel.org>; Tue,  8 Feb 2022 10:03:55 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id c14so6804041qvl.12
        for <linux-nfs@vger.kernel.org>; Tue, 08 Feb 2022 10:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=D3jVA4kI/3uHSToBNzK3/6FZC7qMkmuINep6+t9P/Zw=;
        b=CR9oIGmG2LFC2AmdJZfw0DzKWFXikJmN+qrd1Ffd8AJ+Uugf+Q5b5eKoO3uKRUNEPe
         8andamcFH/cA99lZbbkLH0gsISvTektnn7eqf/MaKnCQxxasF5B27cjwWXCtamKH1pYf
         8MF/65Jyah/PRU8g7XLKCDtN+ZOwCgSz7kVdFeUokRX1JEAuCrxmo8I4PfJvkaNKvCuQ
         UGX69IbEghRfNeNGUD6vUSFqibUbzkDEghw5wY7uMAAW3eHQyhEIpu+j9aysrzfjwscJ
         fUZetcvbxBxy+QBKrBQg4PVulofarImABiOyiNVsU+51Kl49amz7S0sH7hoaDNX2M4HW
         JB1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D3jVA4kI/3uHSToBNzK3/6FZC7qMkmuINep6+t9P/Zw=;
        b=0N7nuE7/cJ98Cn/5myNqza7b6RasA2WE+hPuNWRK1WqFDoYquwkyWpocOK0G8Em1CW
         dx3/QndCDsTlgUFaq8L75UaW+ZBQmj/aOul9noak4zAP+UxL1WpYmTXaUkZxbh1df4UL
         SpQn55MLVM/KONAZVe4iCEDI5XcbTpyVD+eCU3CP97mpU5PdEt53dAPbLmQQEweVj334
         ZSe31GOA+RNkX2I+jwmbsooKWjk/dfcOYTvceYTCa8xSvyMvbabHUmBJiixr1mb6c3c2
         C8yxNWqR3q5RFCWEQErtI+eq2g4Bm8HjpSTHzJeMuWjJdc3elLc5oFfpeckcWaREFkcM
         Zl4w==
X-Gm-Message-State: AOAM531BmWD48eiJAgJkJpAeM+dNAfsegZ14X2EqcoUn0h4LSxttPHRg
        ykG52u+KU1lWMhAHhACmF943ND2Syw==
X-Google-Smtp-Source: ABdhPJyyWrkomGZr64FuMBcH8lrVpzBugrlkBouddiJaapxVs/vFvFk+e3574ibMLb8zqv80f0NWbg==
X-Received: by 2002:a05:6214:21a5:: with SMTP id t5mr4031411qvc.51.1644343433760;
        Tue, 08 Feb 2022 10:03:53 -0800 (PST)
Received: from localhost.localdomain (c-68-56-145-227.hsd1.mi.comcast.net. [68.56.145.227])
        by smtp.gmail.com with ESMTPSA id s2sm7000723qks.60.2022.02.08.10.03.52
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 10:03:52 -0800 (PST)
From:   trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 2/2] NFS: Simplify nfs_readdir_xdr_to_array()
Date:   Tue,  8 Feb 2022 12:57:02 -0500
Message-Id: <20220208175702.1389115-3-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220208175702.1389115-2-trond.myklebust@hammerspace.com>
References: <20220208175702.1389115-1-trond.myklebust@hammerspace.com>
 <20220208175702.1389115-2-trond.myklebust@hammerspace.com>
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
 fs/nfs/dir.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index a3d1f949b2e6..e128503728f2 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -863,6 +863,7 @@ static int nfs_readdir_xdr_to_array(struct nfs_readdir_descriptor *desc,
 	size_t array_size;
 	struct inode *inode = file_inode(desc->file);
 	unsigned int dtsize = desc->dtsize;
+	unsigned int pglen;
 	int status = -ENOMEM;
 
 	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
@@ -880,27 +881,19 @@ static int nfs_readdir_xdr_to_array(struct nfs_readdir_descriptor *desc,
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
+	status = nfs_readdir_xdr_filler(desc, verf_arg, entry->cookie,
+					pages, dtsize, verf_res);
+	if (status < 0)
+		goto free_pages;
 
+	pglen = status;
+	if (pglen != 0)
 		status = nfs_readdir_page_filler(desc, entry, pages, pglen,
 						 arrays, narrays);
-	} while (!status && nfs_readdir_page_needs_filling(page) &&
-		 page_mapping(page));
+	else
+		nfs_readdir_page_set_eof(page);
 
+free_pages:
 	nfs_readdir_free_pages(pages, array_size);
 out:
 	nfs_free_fattr(entry->fattr);
-- 
2.34.1

