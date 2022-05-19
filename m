Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B769252E020
	for <lists+linux-nfs@lfdr.de>; Fri, 20 May 2022 00:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234717AbiESWvj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 May 2022 18:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233763AbiESWvj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 May 2022 18:51:39 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CA0527DC;
        Thu, 19 May 2022 15:51:37 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id e28so8594478wra.10;
        Thu, 19 May 2022 15:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GI34kzBKuYQh9uywbjb0xAvbaF4aR8hu5vI+4PO4FOc=;
        b=VOrG4BNYIuH5A6cSmQfq11P2wjExA+4i6dXvGapAcArmljtSyhLFdJJYs2kaFkBCSj
         6+jUTqFDldGodKJoS8TD7hJHz0U2Li+zVIhaxxwMYhPaDGA1GoZT+twUN9r/d1/bPqgn
         C7nV2jYSocKOri0h424rRSL4K2rr1820wD3VI6bKJC83ccKLlauZWZA4I7h5yQRZXet0
         QVsHV1V5aSIt9a58sVLQVC/Yl05ptJ7LHsQZtLpsZiaV++howOEPEybFyTony25UC4cD
         Q9/ABwrkOen3chev0Rt77U7qaSDAJpMjI2dPohxJfYbv+BowWyCefIQcAMSlqyQ4ByA3
         XE/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GI34kzBKuYQh9uywbjb0xAvbaF4aR8hu5vI+4PO4FOc=;
        b=VADi6Ae7F9VQ5iXGRUZCnR9+8blas/Ga+oTx2kOUDVKyvnH8ActXdhVT2pyNJCvxjl
         s0PyxMVplaR95kMukwQdB6ix0jj9SY29uTDCTVzYUXtyAn4vS7nR3a+SBLDFstl81qcK
         1Y2FvB6dpABY9Z05rzdKAKtxpzjMVcJIocW/OSNFzF448/2rk0mXq1nPbghMnmgCLw4n
         iipi0L65onbNz0IT86uXqcYuXPgirGHaQzxWxI7H1gsRj5acljotGkIMRSvlMNtnlHSj
         kfi2fjxpAD1B1rSHI1666oT0J1SWmRQnPOsvh3WnUS2nccww5vc26H/MWN2h1KiS6l5R
         CHtA==
X-Gm-Message-State: AOAM530+KPB9DuVcARXkftqbcaHahZkB10lj95h4eh4rzLF9azBdRNv+
        9b00xeSSLO4y4WBWTKv98bE=
X-Google-Smtp-Source: ABdhPJxdOSaIFvAGgkCbs7cnod83Zd1cj9S8fCo48A/XB7yHUqQXgiZ+Rt7h4iGX4QvygK+5ET6vrg==
X-Received: by 2002:a5d:64ab:0:b0:20c:64d4:d565 with SMTP id m11-20020a5d64ab000000b0020c64d4d565mr5856599wrp.683.1653000696039;
        Thu, 19 May 2022 15:51:36 -0700 (PDT)
Received: from localhost.localdomain ([45.158.103.138])
        by smtp.googlemail.com with ESMTPSA id t21-20020adfa2d5000000b0020c5253d8d2sm790255wra.30.2022.05.19.15.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 15:51:35 -0700 (PDT)
From:   Javier Abrego <javier.abrego.lorente@gmail.com>
To:     trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier.abrego.lorente@gmail.com
Subject: [PATCH] FS: nfs: removed goto statement
Date:   Fri, 20 May 2022 00:51:15 +0200
Message-Id: <20220519225115.35431-1-javier.abrego.lorente@gmail.com>
X-Mailer: git-send-email 2.25.1
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

In this function goto can be replaced. Avoiding goto will improve the
readability

Signed-off-by: Javier Abrego<javier.abrego.lorente@gmail.com>
---
 fs/nfs/nfs42xattr.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/fs/nfs/nfs42xattr.c b/fs/nfs/nfs42xattr.c
index e7b34f7e0..2fc806454 100644
--- a/fs/nfs/nfs42xattr.c
+++ b/fs/nfs/nfs42xattr.c
@@ -743,25 +743,19 @@ void nfs4_xattr_cache_set_list(struct inode *inode, const char *buf,
 	struct nfs4_xattr_entry *entry;
 
 	cache = nfs4_xattr_get_cache(inode, 1);
-	if (cache == NULL)
-		return;
-
-	entry = nfs4_xattr_alloc_entry(NULL, buf, NULL, buflen);
-	if (entry == NULL)
-		goto out;
-
-	/*
-	 * This is just there to be able to get to bucket->cache,
-	 * which is obviously the same for all buckets, so just
-	 * use bucket 0.
-	 */
-	entry->bucket = &cache->buckets[0];
-
-	if (!nfs4_xattr_set_listcache(cache, entry))
-		kref_put(&entry->ref, nfs4_xattr_free_entry_cb);
-
-out:
-	kref_put(&cache->ref, nfs4_xattr_free_cache_cb);
+	if (cache == NULL) {
+		kref_put(&cache->ref, nfs4_xattr_free_cache_cb);
+	} else {
+	       /*
+		* This is just there to be able to get to bucket->cache,
+		* which is obviously the same for all buckets, so just
+		* use bucket 0.
+		*/
+		entry->bucket = &cache->buckets[0];
+
+		if (!nfs4_xattr_set_listcache(cache, entry))
+			kref_put(&entry->ref, nfs4_xattr_free_entry_cb);
+	}
 }
 
 /*
-- 
2.25.1

