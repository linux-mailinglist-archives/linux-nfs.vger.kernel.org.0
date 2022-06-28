Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1625C55EC8A
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Jun 2022 20:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbiF1SYh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 Jun 2022 14:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbiF1SYg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 28 Jun 2022 14:24:36 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1282720F68;
        Tue, 28 Jun 2022 11:24:36 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id e40so18812828eda.2;
        Tue, 28 Jun 2022 11:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V2IHQlt5J2RLl/FoFe96r3K4rV7P3i767I9NfDgVrTc=;
        b=GV/rfU1OPyjnvUFP2xmY9VGAcwE4NCx9zFE8hiEkJSxpf62s0bOrLkqD5HqicKQtqn
         iQZhocArXrRhUeGH0eN8XxzZVWlYrJaAbsF6eacDg67FW6MwCOCt4uLYo8W69t7bJMW7
         9Zw8/l4qkiym5eHXKHTW8F2wQtxeW/rwbnqNrWcEIrJqlj+K18E2gJCZ8XGYbEypdyrc
         chAiu0eOzCtlGdWWo6bZCqNx8Ap1tL1cw9MBsLDvx1AgYzxZXjNFYSa8M/IEga2lcjGB
         qH+3so5Vs4HdK8CrjaYC/fZKWqX8Gq+XHOt4DRMQUQ2uNFpKLOLwqB4givvbgBWco07E
         yGVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V2IHQlt5J2RLl/FoFe96r3K4rV7P3i767I9NfDgVrTc=;
        b=xEygv0a5ekittt59HTmsRe4xHsuf01YSyiT6FxmUb5BnCIN1GWuvXxS1Nz1Xq/sNNT
         VmE4fiA8pelv0ZSf+SbEXEiuN9hqKtTJKoDkLH6IAat9ISwxjyiXT9mjsV7YTGDHC9ux
         HH6ROpLrdpNP2lcceZI4cXbSV1NszjrGbS6s8mVOnbRsKREaj50QPskcl1vb//v5EX4c
         gFWXp5V42fxK59QNyvn3dHinyiBHsXF5YGTqeCU9VW5KdkbJ9l+ay/0Hf0XBYmN/DndS
         Gp9rFCCrczazhfMMLm83bodsI+csXx4FUE+xYsO+0dsL/4Ly4UAVqu+3po08Oh+FV8kF
         kNrQ==
X-Gm-Message-State: AJIora9ig4cW0Upd6ivtYEO/JrYhq9EpJcZRfgCuVxK+tG750HNQxJVn
        vWk7ASpQdVM5GGWCbniwz98=
X-Google-Smtp-Source: AGRyM1s3lzJXoDxdUPLCiy8B92PcHWC7eBdB2X8uQmr+gVObT96yCP8Dsgx7OCt8ZfGmkLJZo1qJcg==
X-Received: by 2002:aa7:dac2:0:b0:435:76a2:4ebe with SMTP id x2-20020aa7dac2000000b0043576a24ebemr25154951eds.196.1656440674434;
        Tue, 28 Jun 2022 11:24:34 -0700 (PDT)
Received: from localhost.localdomain (host-87-6-98-182.retail.telecomitalia.it. [87.6.98.182])
        by smtp.gmail.com with ESMTPSA id ox6-20020a170907100600b0072629ee85ecsm6682014ejb.108.2022.06.28.11.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 11:24:31 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Kees Cook <keescook@chromium.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Baptiste Lepers <baptiste.lepers@gmail.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH] nfs: Replace kmap() with kmap_local_page()
Date:   Tue, 28 Jun 2022 20:24:26 +0200
Message-Id: <20220628182426.944-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.36.1
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

The use of kmap() is being deprecated in favor of kmap_local_page().

With kmap_local_page(), the mapping is per thread, CPU local and not
globally visible. Furthermore, the mapping can be acquired from any context
(including interrupts).

Therefore, use kmap_local_page() in nfs_do_filldir() because this mapping
is per thread, CPU local, and not globally visible.

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

I cannot test this patch for several reasons. While these changes seem safe
and trivial, I would feel better if people familiar with NFS could take the
time to properly test this patch. Thank you.

 fs/nfs/dir.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 0c4e8dd6aa96..8b89f10d8899 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1084,7 +1084,7 @@ static void nfs_do_filldir(struct nfs_readdir_descriptor *desc,
 	struct nfs_cache_array *array;
 	unsigned int i;
 
-	array = kmap(desc->page);
+	array = kmap_local_page(desc->page);
 	for (i = desc->cache_entry_index; i < array->size; i++) {
 		struct nfs_cache_array_entry *ent;
 
@@ -1110,7 +1110,7 @@ static void nfs_do_filldir(struct nfs_readdir_descriptor *desc,
 	if (array->page_is_eof)
 		desc->eof = !desc->eob;
 
-	kunmap(desc->page);
+	kunmap_local(array);
 	dfprintk(DIRCACHE, "NFS: nfs_do_filldir() filling ended @ cookie %llu\n",
 			(unsigned long long)desc->dir_cookie);
 }
-- 
2.36.1

