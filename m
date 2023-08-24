Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91041787980
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Aug 2023 22:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjHXUoF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Aug 2023 16:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243581AbjHXUn5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Aug 2023 16:43:57 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1761707
        for <linux-nfs@vger.kernel.org>; Thu, 24 Aug 2023 13:43:55 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-34914064ea9so324685ab.1
        for <linux-nfs@vger.kernel.org>; Thu, 24 Aug 2023 13:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692909835; x=1693514635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eW83I81va1/rxligBeEcpAW5FnOTQlLewXPWTJCHJK8=;
        b=m7YGPTZxQ6MnQqocExdXpsbLFRQp9Z/jP1lSie8KkLR+7+kCkEoVQd69pfyq9/neeC
         ZFbnwI88ZDt+cOv9I6PSTYI6/LZPPeB+Pw2iS0SiUtmw60kvcUiuTr6yVC32+8I3PzFI
         7GB7/Gjjk5B5Kz6hGd2IHN2UzOimSsoeBAhN7eKrn8uGIgeb0H9HqWr/WZCcyeAp5zQV
         dLfZLhJJt+QoMDN/B87KYqe05Iy4AoLDcl83ztrOuJNvOG/+y+UjWKOuIGT7mbY/NeDa
         h7INvEvgAYsvcEYcARJd4V/mXSf4L4bijgWqhiZo07xfVFYtz+wQiZ9uv7NqIjb1mj+V
         /9Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692909835; x=1693514635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eW83I81va1/rxligBeEcpAW5FnOTQlLewXPWTJCHJK8=;
        b=laOfY46kJVJV/sVz7NgrdmFvvdsX8vIYPglLYG1pc+BVitVQMztqnjVUjmFMNBXmi5
         NvYXOp6oxV0dRBoq4ZZiD/2EeUWpsxNSWGfpx7bPR+zyMy8fb7AHy4/D13ou7Xm6e91Z
         G6ijfoUhUrhVAYmPGRGtupLxXAWCJoW650B8epmdTNd4G+bR37wuJRj2McvafKtm7IDw
         brnF0FtB03HvuzR67cYdDsJvqe9Q/LJafWZOk9tGrqQeWsU5oFeDj76K1xeO614bezdj
         oyd0FWWkyQ/6aagXk2q+nTt7vsKwR7UAME/BJRcXepnKPavtdK5itwCebimEocFqPNE2
         Y/FQ==
X-Gm-Message-State: AOJu0YwBIqWvRzjnthjyfMN3IFR/TbYL+piV2Wy2X5F2nJgIbDoGddWa
        1dNxMOonbQwYRyi7q+oHfTMwcXO48Kc=
X-Google-Smtp-Source: AGHT+IGIldcv1qSbeeLWHUzh8jLxE94LdS2cFutq1+a+ewRLMFqE8X45XrvJ4itKzMF9pFJWqcKmsQ==
X-Received: by 2002:a92:d6ce:0:b0:349:385e:287e with SMTP id z14-20020a92d6ce000000b00349385e287emr17232546ilp.1.1692909834828;
        Thu, 24 Aug 2023 13:43:54 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:617e:f3a9:5152:5207])
        by smtp.gmail.com with ESMTPSA id m6-20020a924b06000000b00348ab9bd829sm69081ilg.53.2023.08.24.13.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 13:43:54 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSv4.2: fix handling of COPY ERR_OFFLOAD_NO_REQ
Date:   Thu, 24 Aug 2023 16:43:53 -0400
Message-Id: <20230824204353.24549-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

If the client sent a synchronous copy and the server replied with
ERR_OFFLOAD_NO_REQ indicating that it wants an asynchronous
copy instead, the client should retry with asynchronous copy.

Fixes: 539f57b3e0fd ("NFS handle COPY ERR_OFFLOAD_NO_REQS")
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs42proc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 63802d195556..8854138a74de 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -471,8 +471,9 @@ ssize_t nfs42_proc_copy(struct file *src, loff_t pos_src,
 				continue;
 			}
 			break;
-		} else if (err == -NFS4ERR_OFFLOAD_NO_REQS && !args.sync) {
-			args.sync = true;
+		} else if (err == -NFS4ERR_OFFLOAD_NO_REQS &&
+				args.sync != res.synchronous) {
+			args.sync = res.synchronous;
 			dst_exception.retry = 1;
 			continue;
 		} else if ((err == -ESTALE ||
-- 
2.39.1

