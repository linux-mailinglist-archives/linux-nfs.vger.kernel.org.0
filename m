Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3446863D8F8
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Nov 2022 16:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiK3PMq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Nov 2022 10:12:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiK3PMp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 30 Nov 2022 10:12:45 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAB513E36;
        Wed, 30 Nov 2022 07:12:43 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id r26so22366030edc.10;
        Wed, 30 Nov 2022 07:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kbYKqspQq7ax4MDUswX1OjlUU8+p93WbjYLSRqwiJew=;
        b=R+t5y81JP4tgtEYyEMxlPy4LqoSox4tKP3eUfV+5syyytXLwBi7PhD90AFmswGXJDA
         FNEsd+5b5Pa58ulNBsfUQenKqV9MW3boePe5OgmEc5Z/kErbP+6IqopIUIzil5rxkfeF
         4SDGwe2GPPGLCRuxXY5B/o5n0gp2B7wifG722mDxzf4ByUIX965oY4Y69LwqQ2aIxTe6
         H4AyOgN1ztVgTRYzJDsoRJ7tDPhXlQVBx0aWBXH5osBOONpbSU0o68DosQneFzKgDW2n
         z2Eav0WbcuICMujTojxConyeXGrOFYV5laACz6p5ylpNI78RYkvIq9kzW0O5HFoNWiGQ
         J0Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kbYKqspQq7ax4MDUswX1OjlUU8+p93WbjYLSRqwiJew=;
        b=l0Fyo7zlu8ftqxnCPw9Oi+NtiQvKZTk8gGBaJaTCXHPHIR4ciXw2Q53QJWY0sd1jHZ
         ts9xYv4D0A11CBgf6O+hGidlHp218UHzw0JXzBwaQFb0t9mTQ/sFCeNEW2Jh1afU3sPN
         f4S/gw5/ESomVlV3csvT9Kd4UPSz1JDpW7gRs135182ss6hwDhWbBGmtP+oGqIdgNBxJ
         WTxAjg/CP5adORm2WCS/QjZLzanYHX66nwR35YOVCMu5s1b1f2tg4WBEJoDYp8VW0d8Z
         hRWod4+ebPbyGZ73rW2pJelKnZfJG7ExR6s/OgqOt8pk3Fzf6+7+6Ek8u7mLE5qccM70
         25dw==
X-Gm-Message-State: ANoB5pm0dTtY2fmCF6Z7T8R9tIVckKqz47CUqTNhYuo1YuGX+k2CA1H7
        jod/cb1G3Hosudjii0DpK/TGN/rCnRyszw==
X-Google-Smtp-Source: AA0mqf7F36Mv0uwEK+8irgzU5CyMDX+bQ+SuiB2XyAm50r+HZ0J17Gbcdw7lVqhIRAqGAgkxn16zSA==
X-Received: by 2002:a05:6402:2074:b0:46a:bb9e:40d1 with SMTP id bd20-20020a056402207400b0046abb9e40d1mr23446050edb.242.1669821161602;
        Wed, 30 Nov 2022 07:12:41 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id j9-20020a17090623e900b007bf24b8f80csm743494ejg.63.2022.11.30.07.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 07:12:41 -0800 (PST)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Subject: [PATCH] nfs: Remove empty if statement from nfs3_prepare_get_acl
Date:   Wed, 30 Nov 2022 16:12:31 +0100
Message-Id: <20221130151231.3654-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.38.1
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

Remove empty if statement from nfs3_prepare_get_acl and
update comment to follow the one from the referred
fs/posix_acl.c:get_acl().

No functional change intended.

Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: Anna Schumaker <anna@kernel.org>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 fs/nfs/nfs3acl.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/nfs3acl.c b/fs/nfs/nfs3acl.c
index 93de0b58647a..957f954d3805 100644
--- a/fs/nfs/nfs3acl.c
+++ b/fs/nfs/nfs3acl.c
@@ -21,9 +21,8 @@ static void nfs3_prepare_get_acl(struct posix_acl **p)
 {
 	struct posix_acl *sentinel = uncached_acl_sentinel(current);
 
-	if (cmpxchg(p, ACL_NOT_CACHED, sentinel) != ACL_NOT_CACHED) {
-		/* Not the first reader or sentinel already in place. */
-	}
+	/* If the ACL isn't being read yet, set our sentinel. */
+	cmpxchg(p, ACL_NOT_CACHED, sentinel);
 }
 
 static void nfs3_complete_get_acl(struct posix_acl **p, struct posix_acl *acl)
-- 
2.38.1

