Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B420F73003E
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Jun 2023 15:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245025AbjFNNiV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Jun 2023 09:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245023AbjFNNiU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 14 Jun 2023 09:38:20 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C034A1FF9;
        Wed, 14 Jun 2023 06:38:18 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-77acb944bdfso375550239f.0;
        Wed, 14 Jun 2023 06:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686749898; x=1689341898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OcMpIHdjKp1THv65PvIPUr0YhjndAMsASg3ywF4WkSk=;
        b=TMs/pAzNollaH2DS13pnVn8it1HkV9hqXZyhXw7W3eBeMLtTMJMbuXrJ0gWPRn2DvW
         V4YJEDbsGmXp7SjtsJ3WxoYBSpAgI48j4zg+QgWHj9auVIYSwdir26qBBIVARp6qtyfx
         Utn+1PjVx+qGNxU6jIlpFQ5DJnqprMaBlb+7ESS8tYiCcoxTa2Ak/OgqtdeuXnrKfogf
         zccffifvA6uVfoE7EGloY10axykms28UXt/1drp4bJo7qSDkyHycQwqvD5LFVLqLhh/Y
         1XjLv/ZmiRvVJ5XZFGMiK3biQZRmHP9hvouKsZpL0mMg9PeRWUIO5pXsIudkIOqUTp20
         lRvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686749898; x=1689341898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OcMpIHdjKp1THv65PvIPUr0YhjndAMsASg3ywF4WkSk=;
        b=MhYUp728oiPK51HEDRIdt99Ym1c/XCNR62yQF0WAeRaSkjE6H+Eavzp7z4DSCu8S0k
         A/WKFd5htLYhgnF5UiDLi45LRF9gRI15LPeHdn+13G3LrmONHVNSVLccJ5v9VrikFaRS
         e2yr8nWukDzJy8J3T6Lh5VdOcKnFlq4MaX7Mwi8TmcnQE+uXl9eROxhtGv4HNztVJsG6
         t8bRm9OjvP51LZMH9XJrc0rhcB0wWkAcJNzFBDix3vsP5PX4uVfdD7PDrQN9EyJ27xUy
         86QqBQvjss7cc7zKTPjGpgCzBTAYtmBAc7MtjMnaWg4eG9kY6hyHhBc/qt4msH/VCdkm
         X58Q==
X-Gm-Message-State: AC+VfDwQDmUqhvwOp/C+fOWOR2Fhow91C6qOZ2s19n2cD88hRqDQksLw
        ATWzRS4Dygc20iZygmqXa7U=
X-Google-Smtp-Source: ACHHUZ7FFYwn9TAuhIaV3IPsryiva/NLrrg5aB2dNwsbpVo1p4MaX1lDfyst9q3lQTlhQBPPaWTY5A==
X-Received: by 2002:a05:6602:2747:b0:774:8786:1b59 with SMTP id b7-20020a056602274700b0077487861b59mr14607161ioe.11.1686749897893;
        Wed, 14 Jun 2023 06:38:17 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id z23-20020a02ceb7000000b00420d6fd5c06sm5022647jaq.80.2023.06.14.06.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 06:38:17 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: [PATCH v3] SUNRPC: Use sysfs_emit in place of strlcpy/sprintf
Date:   Wed, 14 Jun 2023 13:37:57 +0000
Message-ID: <20230614133757.2106902-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Part of an effort to remove strlcpy() tree-wide [1].

Direct replacement is safe here since the getter in kernel_params_ops
handles -errno return [2].

[1] https://github.com/KSPP/linux/issues/89
[2] https://elixir.bootlin.com/linux/v6.4-rc6/source/include/linux/moduleparam.h#L52

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
 net/sunrpc/svc.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index e6d4cec61e47..b011c318fef1 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -109,15 +109,15 @@ param_get_pool_mode(char *buf, const struct kernel_param *kp)
 	switch (*ip)
 	{
 	case SVC_POOL_AUTO:
-		return strlcpy(buf, "auto\n", 20);
+		return sysfs_emit(buf, "auto\n");
 	case SVC_POOL_GLOBAL:
-		return strlcpy(buf, "global\n", 20);
+		return sysfs_emit(buf, "global\n");
 	case SVC_POOL_PERCPU:
-		return strlcpy(buf, "percpu\n", 20);
+		return sysfs_emit(buf, "percpu\n");
 	case SVC_POOL_PERNODE:
-		return strlcpy(buf, "pernode\n", 20);
+		return sysfs_emit(buf, "pernode\n");
 	default:
-		return sprintf(buf, "%d\n", *ip);
+		return sysfs_emit(buf, "%d\n", *ip);
 	}
 }
 
-- 
2.41.0.162.gfafddb0af9-goog


