Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C56B595363
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Aug 2022 09:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbiHPHH1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Aug 2022 03:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbiHPHHO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 Aug 2022 03:07:14 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC12712AC39
        for <linux-nfs@vger.kernel.org>; Mon, 15 Aug 2022 19:44:10 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id q16so8112186pgq.6
        for <linux-nfs@vger.kernel.org>; Mon, 15 Aug 2022 19:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=RbjAjy18aOpgDz5FKNXn/zg546d6IZ+raLXAHOpbUHI=;
        b=m+vsK2wVB14VtgaBJtUVfKcDZDk5KGPjFsHJEWvgdTSzrZnpUT7EOZyTwseFKDuOIZ
         vqcWTc8VnZs+CFYceUUIpBmmpL80h/YTvh9aprKHz+sIO7BYvnrq9nFYJb4savfAs8Db
         ttHswdZiVfIGmZPWyweBSSyf/ByF3zBM0Ak3Vhwmf8+/fzZvR1KU8ptMysCwgcumFTt2
         gShuMVPCBtIQfG3AE9fQkC9W0XSgdMXjfL5aMDn1z72SGyabhJpmOmDAkfpI56315Qpj
         S4WyVCjvStkr8kR/jztAM1VZfsYjhoz3B5M2TY9KokEQ4lamsUi7CKmrM39jif3yslJR
         Pkiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=RbjAjy18aOpgDz5FKNXn/zg546d6IZ+raLXAHOpbUHI=;
        b=eQCuwhIAfk07BnHhj5SpFb+ZFOIPP1qK/OjOpA32FqKjySQAVt91owYqxImtv/leZz
         7XrRpA9E0ejmBnJ+03wGoHf+pNMNxWJ2BErITp16k43o2n5j8AgZmvluxktAyXCwj+4r
         nLMNa1o7yT2M5BeDeXY/i1fnoMKoYJggeRmPeHnTow5uPXQbFHcYhsr4BvEslGkErxeE
         pT+MJhl6CeQvSk7MNae84uQAaAhoaZQdTdT9f7oCUDpclyvWs2sY9AOoc3Yd2RCE2AHx
         jpDktjyNW673ecrD/uPPN80dTkHkgB6gLUYWx3lL6Qv81ec7oCkmEY/pYIg4MvZjX2sV
         tmZQ==
X-Gm-Message-State: ACgBeo2TBFUkGhO4Bf4YNmYBH1ujgX6gTORjg8FSraf2xHNGav6gYdTe
        ynSbnWrgX8mytKgo0Gvz+qo=
X-Google-Smtp-Source: AA6agR4yBlNe78ueeJhyPTJAoeJEb6m1mkCdLXdatLHHCDYn2Q3wtQBJIYlN3ocIh1A3CCUZXt53tQ==
X-Received: by 2002:a05:6a00:1650:b0:52f:20d6:e858 with SMTP id m16-20020a056a00165000b0052f20d6e858mr18695775pfc.36.1660617850429;
        Mon, 15 Aug 2022 19:44:10 -0700 (PDT)
Received: from apollo.hsd1.ca.comcast.net ([2601:646:9200:a0f0::bb7a])
        by smtp.gmail.com with ESMTPSA id r15-20020aa7988f000000b0052d51acf115sm7160970pfl.157.2022.08.15.19.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 19:44:09 -0700 (PDT)
From:   Khem Raj <raj.khem@gmail.com>
To:     Steve Dickson <steved@redhat.com>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>,
        Khem Raj <raj.khem@gmail.com>,
        Konstantin Khorenko <khorenko@virtuozzo.com>
Subject: [PATCH v2 1/2] mountd: Check for return of stat function
Date:   Mon, 15 Aug 2022 19:44:02 -0700
Message-Id: <20220816024403.2694169-1-raj.khem@gmail.com>
X-Mailer: git-send-email 2.37.2
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

simplify the check, stat() return 0 on success -1 on failure

Fixes clang reported errors e.g.

| v4clients.c:29:6: error: logical not is only applied to the left hand side of this comparison [-Werror,-Wlogical-not-parentheses]
|         if (!stat("/proc/fs/nfsd/clients", &sb) == 0 ||
|             ^                                   ~~

Signed-off-by: Khem Raj <raj.khem@gmail.com>
Cc: Konstantin Khorenko <khorenko@virtuozzo.com>
Cc: Steve Dickson <steved@redhat.com>
---
v2: rebased

 support/export/v4clients.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/support/export/v4clients.c b/support/export/v4clients.c
index 5f15b61..3230251 100644
--- a/support/export/v4clients.c
+++ b/support/export/v4clients.c
@@ -26,7 +26,7 @@ void v4clients_init(void)
 {
 	struct stat sb;
 
-	if (!stat("/proc/fs/nfsd/clients", &sb) == 0 ||
+	if (stat("/proc/fs/nfsd/clients", &sb) != 0 ||
 	    !S_ISDIR(sb.st_mode))
 		return;
 	if (clients_fd >= 0)
-- 
2.37.2

