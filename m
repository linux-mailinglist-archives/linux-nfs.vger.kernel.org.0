Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E6C6F5D04
	for <lists+linux-nfs@lfdr.de>; Wed,  3 May 2023 19:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjECRYV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 May 2023 13:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjECRYU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 May 2023 13:24:20 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C7944B8;
        Wed,  3 May 2023 10:24:18 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f1950f5676so56508875e9.3;
        Wed, 03 May 2023 10:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683134657; x=1685726657;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VcBYdC9ucUCD1QQtrLTk4bv8KELKis4uUuGk9WZeEew=;
        b=mAgAEjqJGOGBV0J/424+4JQvJtGvTcuibi8V7OsQUfbz1lczuF2xqRoJFjxuMhS69N
         W3Ac1dcvyD7Yd0Go/wkegXIXB5Y4/b6gyLcRK61qf/KbYBUEG9rQuFtoWyXFfyKT26u2
         3LnemjQcvavK8E1xjrZBpT85io1c35uELlDARj82hwIYupXAHQBKkkOvInJIkjdGpu4l
         V8si4rR2G05tsv2Z3eCMTcpVVyRC7BWwiew7dKz+gsgSBtdPvIKNB406Lc+iILFCjuEZ
         f+pBL3x9MSZf86XiygrBD4BE3FuvfX8GjaAkogQpHN8GOBSR7hsB97gZjnfWVZeGqob+
         BBgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683134657; x=1685726657;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VcBYdC9ucUCD1QQtrLTk4bv8KELKis4uUuGk9WZeEew=;
        b=JJb/dg5Yr97SyVzPCwFElZnbTOVecl/QanBdV0hJmcJcA0HjOqRjnTxJAn3E5YKChL
         GQNgahg7cRIj8J/+WrdBefSrwNSrSY/tWp9DrmyT1fRs/XmkoaLoqNFm7Y4GYaEZximZ
         IxYKzMsjOK3+r8P0ofDAOWWdNxTBCEnsHooFy78PmXZ4F7v6T8itO9o0ZeZb14NVWxK6
         uwYofLW1NR3EqSToQI9hDFGA/rYYaMSFqOq2iESklYKiAMCL3ood94CRHXRoFSgqUjvv
         mrpV25ByubjRnnsGFjfq4Ujpkr3Jd+GeuuHc8Nd4gLcFmplC2+uJsBMZX9d+1qePU9hk
         SpKQ==
X-Gm-Message-State: AC+VfDy+yIIJ34VJ99jelBbcVSjM+bqfGTIbuwnY9QiMLgPXWgkGiOXu
        hja+PRATUsO334D9AEeDRAk=
X-Google-Smtp-Source: ACHHUZ42wq4ZuApE1kE4LQjSm93UVJzJjGIpkN67dYoaLl58ee/5eW1BAJg64S0X3ve4QAIWDJzAfA==
X-Received: by 2002:a05:600c:378e:b0:3f0:3c2:3fa4 with SMTP id o14-20020a05600c378e00b003f003c23fa4mr15267893wmr.12.1683134657074;
        Wed, 03 May 2023 10:24:17 -0700 (PDT)
Received: from localhost.localdomain (host-212-171-7-24.pool212171.interbusiness.it. [212.171.7.24])
        by smtp.gmail.com with ESMTPSA id q6-20020a7bce86000000b003f1836c98b7sm2414776wmj.48.2023.05.03.10.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 10:24:16 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH] NFS: Convert kmap_atomic() to kmap_local_folio()
Date:   Wed,  3 May 2023 19:24:11 +0200
Message-Id: <20230503172411.3356-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.40.0
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

kmap_atomic() is deprecated in favor of kmap_local_{folio,page}().

Therefore, replace kmap_atomic() with kmap_local_folio() in
nfs_readdir_folio_array_append().

kmap_atomic() disables page-faults and preemption (the latter only for
!PREEMPT_RT kernels), However, the code within the mapping/un-mapping in
nfs_readdir_folio_array_append() does not depend on the above-mentioned
side effects.

Therefore, a mere replacement of the old API with the new one is all that
is required (i.e., there is no need to explicitly add any calls to
pagefault_disable() and/or preempt_disable()).

Tested with (x)fstests in a QEMU/KVM x86_32 VM, 6GB RAM, booting a kernel
with HIGHMEM64GB enabled.

Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

"./check -nfs -g quick", with or without this patch, always fails the
same 12 tests of 559: generic/053 generic/099 generic/105 generic/193
generic/294 generic/318 generic/319 generic/444 generic/465 generic/528
generic/529 generic/531.

Therefore, I think I can say that this patch does not introduce any
regressions.

 fs/nfs/dir.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 8257de6dba45..8fa8ae49d6cd 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -317,7 +317,7 @@ static int nfs_readdir_folio_array_append(struct folio *folio,
 
 	name = nfs_readdir_copy_name(entry->name, entry->len);
 
-	array = kmap_atomic(folio_page(folio, 0));
+	array = kmap_local_folio(folio, 0);
 	if (!name)
 		goto out;
 	ret = nfs_readdir_array_can_expand(array);
@@ -340,7 +340,7 @@ static int nfs_readdir_folio_array_append(struct folio *folio,
 		nfs_readdir_array_set_eof(array);
 out:
 	*cookie = array->last_cookie;
-	kunmap_atomic(array);
+	kunmap_local(array);
 	return ret;
 }
 
-- 
2.40.0

