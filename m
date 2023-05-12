Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F40700C69
	for <lists+linux-nfs@lfdr.de>; Fri, 12 May 2023 17:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241710AbjELP6C (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 12 May 2023 11:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241557AbjELP6B (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 12 May 2023 11:58:01 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE82B2703;
        Fri, 12 May 2023 08:58:00 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-335394455ecso45769035ab.1;
        Fri, 12 May 2023 08:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683907080; x=1686499080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sHwPboqB1nqzl1kjx9zTJePYQXkxcLvuHwgoOC8pDRY=;
        b=SSKVUnADLZfHx6pqdz6uabK6cdQhsDEBPggP1x1T69bgGGJ3hJtoP6qEg7vSWPKn24
         mVKmWQjw4w1yEA+Axz5cDuk+647LW4X0Mb88WKaaoJhm7FPNA4yPysx9193NOLYCM2Ey
         oyhya9k/kAsCKc612Ioj57qS/GzPqlAVqv6qvLfggLRCI6hTU7Ok+wlD/fHR0om4TuBL
         mU1tsE08CaZmAaBWIWqg3VODl+RPnwSzORjpFQutZyMLrb10SNScxq1QVK0K7N27UXrg
         HLZ+2otQ6urj0bi9UjwaweFUFuYKggvQzaPQQjkeWN5A4/ry8Mrh8E+bgzKzUT/89E0c
         jMXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683907080; x=1686499080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sHwPboqB1nqzl1kjx9zTJePYQXkxcLvuHwgoOC8pDRY=;
        b=islguDPX9ZO6mk/bOX82+KfDYjSsfxSmx0t/at390prUV18SxbUInGutxzS/M46eMB
         g6HyVxiiZxsKnBKRAmUJxwqqlLaTC/CYkhcGancTdHdesKnah99e2iZO4OIJkj15rEDb
         ugqec6ZlNh6RpcDe2LXuhHzZzaPKQ+d6IA8d/I3q0+Qw8BiBRWz6rd/KA7HyFGAMzWaY
         8jNx6cgbnT25nsPDk19aeKwRC/29xY8rVrcpP7JT3Hz8Twc5kL9WGt0rsI2x+izp1VSg
         Bvq/vG4vOJQ03wdo1us/oFd5xMitJ1tphkZ+TENEARd1vqulul+eOCfsCFEujHWuKgjx
         FvyA==
X-Gm-Message-State: AC+VfDyn5t7POX7cdy/JxGpSZGHYjilb3sT9v32AmgyFbyW6Kw+T1E1I
        hqPf6bDNjXcK/Xfp3Eoqs1o=
X-Google-Smtp-Source: ACHHUZ6/OlNTy3CccjqM+V82eYYo4ZWPc1zfHCaAezC2DpM52VZ+IQFuoz8LHCWDRvJyhCHLxUTuZQ==
X-Received: by 2002:a92:c682:0:b0:331:3fe3:d111 with SMTP id o2-20020a92c682000000b003313fe3d111mr17233361ilg.25.1683907079924;
        Fri, 12 May 2023 08:57:59 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id q7-20020a92c007000000b0032b54912651sm5033741ild.5.2023.05.12.08.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 08:57:59 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] NFS: Prefer strscpy over strlcpy calls
Date:   Fri, 12 May 2023 15:57:49 +0000
Message-ID: <20230512155749.1356958-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

strlcpy() reads the entire source buffer first.
This read may exceed the destination size limit.
This is both inefficient and can lead to linear read
overflows if a source string is not NUL-terminated [1].
Check for strscpy()'s return value of -E2BIG on truncate for safe
replacement with strlcpy().

This is part of a tree-wide cleanup to remove the strlcpy() function
entirely from the kernel [2].

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
Note to reviewers: the one case where this patch would modify existing behavior
is when strlen(src)==destlen==0. Current behavior returns 0, with this patch it
would return -1.

Not sure what the implication of this updated behavior would be,
so bringing it to your attention.

 fs/nfs/nfsroot.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfsroot.c b/fs/nfs/nfsroot.c
index 620329b7e6ae..7600100ba26f 100644
--- a/fs/nfs/nfsroot.c
+++ b/fs/nfs/nfsroot.c
@@ -164,7 +164,7 @@ __setup("nfsroot=", nfs_root_setup);
 static int __init root_nfs_copy(char *dest, const char *src,
 				     const size_t destlen)
 {
-	if (strlcpy(dest, src, destlen) > destlen)
+	if (strscpy(dest, src, destlen) == -E2BIG)
 		return -1;
 	return 0;
 }
-- 
2.40.1.606.ga4b1b128d6-goog


