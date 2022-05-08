Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D05651ED90
	for <lists+linux-nfs@lfdr.de>; Sun,  8 May 2022 14:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbiEHNCG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 May 2022 09:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233652AbiEHM6r (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 8 May 2022 08:58:47 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F86BBCBB
        for <linux-nfs@vger.kernel.org>; Sun,  8 May 2022 05:54:54 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id c190-20020a1c35c7000000b0038e37907b5bso9392763wma.0
        for <linux-nfs@vger.kernel.org>; Sun, 08 May 2022 05:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KmpGvp+sd61rqwq02G+sX/SLC6UQmVcIzaMDS+Mw1d8=;
        b=BZ8D8dFdG66QYF2+e7yFP8cci+PwwVrhkFgco2P4Y040Nrw+OXjeMUsMXA7GuoeGxx
         YkKOTjalHyqlfVaNo1oiZXX/zAV/8YFsHnZELG5ENsGTIgEZg0CgfTkvVCrwoGj5Z9CW
         2DDKVg/3kaop/Ti9hXNdDWGRw07qj5jNIiI+UGOWX0U3z3iQdAo3VBDMJXWhv36jTMhY
         EjRueFF9pl0CLWnJT8qinLGBeqjh/IwQxqR1PwwPsjwFGydJ8U0Z+ZkvzdR2U6CJqQgs
         LweLZoFLLNelmEQB0pQVkDpaGqgb6ekYM0LJPLtoWaE4ayY3dxYzrF8yLF7ek7qfBYK4
         huJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KmpGvp+sd61rqwq02G+sX/SLC6UQmVcIzaMDS+Mw1d8=;
        b=k5QVueuCi8yguYVdICB9oyNenZr4heBrxYBPtgm+vxe/XMqZH3ljKPv5hbxyWJ+D0Z
         8T9ax5Kd/ioGVY5QMoQ5+xduSX82qZoKsom2g8HZRTLDUodP4DVCrxN0O75693lxgt0Z
         CeK47utupYJCRsMbRFKkHFR9aAkj63tHf5ibhFxLs89apKXLyIfymXOhxUkVBOj2JTYn
         vJSIAvFudGBCWenwH8K8pIRfXUnXCMtPZrJsicL48UYJGlbLwo8TAn47wDqlOcIhz6mS
         Itf3Tc9At2MS49VOwf2G3QjdS00Rs/GFz08nRAbkT3rRUtdN3n54oNFAjB9dfmRYxllK
         tVkA==
X-Gm-Message-State: AOAM533vnFMPYRoubogqyKYJwc8qCOe17ToTec3bfIiBprRo6OCZ5nY8
        /4RiKlbTtM6RmhCuNljvF9GHsQ==
X-Google-Smtp-Source: ABdhPJw2BdhLCrchI7zO7pxnZIUT2vKDBdmmibHhBYe8mcApFgZoJ77nSXynQ0pANwDMqVAmr8pOuA==
X-Received: by 2002:a05:600c:1c97:b0:394:7a2e:a83c with SMTP id k23-20020a05600c1c9700b003947a2ea83cmr11437760wms.175.1652014492690;
        Sun, 08 May 2022 05:54:52 -0700 (PDT)
Received: from jupiter.lan ([2a0d:6fc2:4951:4400:aa5e:45ff:fee1:90a8])
        by smtp.gmail.com with ESMTPSA id bg9-20020a05600c3c8900b00394755b4479sm8975777wmb.21.2022.05.08.05.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 05:54:52 -0700 (PDT)
From:   Dan Aloni <dan.aloni@vastdata.com>
To:     Anna Schumaker <Anna.Schumaker@Netapp.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        linux-nfs@vger.kernel.org
Subject: [PATCH] nfs: fix broken handling of the softreval mount option
Date:   Sun,  8 May 2022 15:54:50 +0300
Message-Id: <20220508125450.2176603-1-dan.aloni@vastdata.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Turns out that ever since this mount option was added, passing
`softreval` in NFS mount options cancelled all other flags while not
affecting the underlying flag `NFS_MOUNT_SOFTREVAL`.

Fixes: c74dfe97c104 ("NFS: Add mount option 'softreval'")
Signed-off-by: Dan Aloni <dan.aloni@vastdata.com>
---
 fs/nfs/fs_context.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index e2d59bb5e6bb..9a16897e8dc6 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -517,7 +517,7 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
 		if (result.negated)
 			ctx->flags &= ~NFS_MOUNT_SOFTREVAL;
 		else
-			ctx->flags &= NFS_MOUNT_SOFTREVAL;
+			ctx->flags |= NFS_MOUNT_SOFTREVAL;
 		break;
 	case Opt_posix:
 		if (result.negated)
-- 
2.23.0

