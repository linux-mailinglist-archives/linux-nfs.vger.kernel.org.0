Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C25C52E80E
	for <lists+linux-nfs@lfdr.de>; Fri, 20 May 2022 10:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239607AbiETIuZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 May 2022 04:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347168AbiETIuY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 May 2022 04:50:24 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A761C6E77;
        Fri, 20 May 2022 01:50:23 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id w4so10505462wrg.12;
        Fri, 20 May 2022 01:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kKSrGrQ3KFhSHnYm0sBJhqBxqjSZZxv4rXZISo5LB2U=;
        b=HP/5VoY5DZ2nGZbwOPj5r9hJmyzEGFqfhl8h3H+XUc9mCrEGZkNh/M/MclZ37IlCHr
         QcY0prxvR3n/brwjgq9DSvqEN+bObsL5D6I4VpDTCNVRPWhvhHON13ckdSsEpeuzi5ox
         gCJgBxE9J9fH5hzeb49GDlSA6H6k8AtRhag7qxlvraPfcUCWJdsN+v/50GSE9a5jGIfn
         nP+R1dMx+PtsYZBqwk0/RzdUQ2ID3zem4B0K3Muamsx58HCFfFMzjtzJoIAn6aZSqnFg
         Vq199yxLkUYiBHXXzYTKWepW8QgMc5s3sbhyxKeQVKLzqrzTcT3nqzZquggaEFh3HrpU
         ybCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kKSrGrQ3KFhSHnYm0sBJhqBxqjSZZxv4rXZISo5LB2U=;
        b=P4AxXe8b6vR7UUkaoh3PN3gCFxSCOL5CXQFlEyTubjadUeeCaKOnl8ImgVRYBaurQb
         pTRom75D+EHZrhc0xUU4Be/l4twn5dJQab76z3unyJwMCPLlRU+5MlJCCIbmPm3uiA0e
         ZWo/Ql3QAlSP5WmDcUeYeibwcM+MmUxV0p8eWVgC20b81Pth3wbNwuwdSkp4CjtbOxll
         Aaac6FFIHMecjW/4F0TbU3cT7GUXBespu+uePD1g4PvcK/eFRrgZBO/stWxvLAn6Tkgc
         TvDftYcw2kZFkzDQqf2P6RklPobrZ/eS13DSmco0gIymSbQKWq003V0C/vyh2gO8pRCD
         U4Pg==
X-Gm-Message-State: AOAM531aHSPv53blCVfoZ6E3TmxXAkQN02A4ElU4lGyiWG1yTBJk3+P4
        pg/1keqAID8FNpG5kdI0Qhc=
X-Google-Smtp-Source: ABdhPJwGLeTHNPcglw6xcRgPlledKiZeb4vBth7DW6CwJ05UvdHdvw91ywCHLVVsaoCgM46M7LdjsA==
X-Received: by 2002:a05:6000:1a88:b0:20e:6ee9:c78e with SMTP id f8-20020a0560001a8800b0020e6ee9c78emr5406783wry.622.1653036621886;
        Fri, 20 May 2022 01:50:21 -0700 (PDT)
Received: from localhost.localdomain ([195.55.223.2])
        by smtp.googlemail.com with ESMTPSA id x6-20020a7bc206000000b003942a244f53sm1378944wmi.44.2022.05.20.01.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 01:50:21 -0700 (PDT)
From:   Javier Abrego <javier.abrego.lorente@gmail.com>
To:     trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier.abrego.lorente@gmail.com
Subject: [PATCH] FS: nfs: removed goto statement
Date:   Fri, 20 May 2022 10:50:19 +0200
Message-Id: <20220520085019.44138-1-javier.abrego.lorente@gmail.com>
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
 fs/nfs/nfs42xattr.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/fs/nfs/nfs42xattr.c b/fs/nfs/nfs42xattr.c
index e7b34f7e0..9bf3a88fd 100644
--- a/fs/nfs/nfs42xattr.c
+++ b/fs/nfs/nfs42xattr.c
@@ -747,21 +747,19 @@ void nfs4_xattr_cache_set_list(struct inode *inode, const char *buf,
 		return;
 
 	entry = nfs4_xattr_alloc_entry(NULL, buf, NULL, buflen);
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
+	if (entry == NULL) {
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

