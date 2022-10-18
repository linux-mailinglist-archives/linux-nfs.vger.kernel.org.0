Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88DA7602328
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Oct 2022 06:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbiJREHo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Oct 2022 00:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbiJREHZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Oct 2022 00:07:25 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED186AE8D;
        Mon, 17 Oct 2022 21:07:20 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id h2so5315700plb.2;
        Mon, 17 Oct 2022 21:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uW1kxYY0TQ6+a/b17x4JrJXSQoPu6SYrVMBQ5HcdhcY=;
        b=bpoMKjCqc253jmF/9weUT0Z+MLQiJhKwArMTaoHraD40d3Qm6F0P0bj9EVyeVfLYQ3
         4zdwdY33opJMqnzdrhv4Jbz6AHgU7MtSdVJJz5YGkLG+p3Ur920Uf0e6DTvZ+HvBoDH8
         0jE+3XpXj5Zq1A4vqTz/QNqCBJtqriTS3KyHRlm6nnFSVZ032zZ3gC+GkFbDMjjmAJF4
         nB/wxDKQLujI5YgtbSh8FnQXrqDfTVGEoFBRGZid5fQ2n0ymYjXPV9QIhhWoXNVgNqEG
         5Ll5hAh4uIaqk6LX2MMRc1IkqeBI9hg9NOPKtxa/GG3EQdfrH5YgvVWz2FznX/JOmttG
         sIag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uW1kxYY0TQ6+a/b17x4JrJXSQoPu6SYrVMBQ5HcdhcY=;
        b=qrWiQtsmuDTPmAh3dg0VLIa1F2MigBLQX8K0vTeOHYBi4oowo7gXADdRDzV0dPhnbb
         xGBXxfoRxWMxp7hvlhBr0Fqy12A3snPWAISZ3yZhpBtC+67r6/hjgbTruksjWDrHPBEa
         CY2MU8CuSQoJQKabUzVjUuRUXXpbk9MstyJlo5EldR9BrKqRAMSpAQEyqcNEeQvyfkID
         A92tSnPfL8UqC31G+R62NU+SBWpMX+P72e/yYVJZ6HTG5M6GcycE2mh1Yq1nb0Fro4Mf
         nYjYQ7AoKDhuHnQpz/yZPrvHMruqdg1hwSS4kJGe9hVmYUwHiJoFNyBiaGPUkUpc2Hil
         Kc6A==
X-Gm-Message-State: ACrzQf3bMGZLRK64mIg3265AcAQP+LDn5rDgz9lSzUtlp3YwmMG/O7cg
        /gYc+oyNWisuIPKtEsl0TlaPQ/ZhljEjKg==
X-Google-Smtp-Source: AMsMyM5drBguVHfVil1k+x/b1i/5cmUgDk/iILmk+f0yfnj9zK2wgEm/pqH7DU5cQZFhcwJ8cIXLwA==
X-Received: by 2002:a17:902:e5c2:b0:186:2df3:c73 with SMTP id u2-20020a170902e5c200b001862df30c73mr1093287plf.30.1666066040010;
        Mon, 17 Oct 2022 21:07:20 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.9])
        by smtp.gmail.com with ESMTPSA id j9-20020a170902da8900b00174f7d10a03sm7460183plx.86.2022.10.17.21.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 21:07:19 -0700 (PDT)
From:   zys.zljxml@gmail.com
To:     trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yushan Zhou <katrinzhou@tencent.com>
Subject: [PATCH] nfs: Remove redundant null checks before kfree
Date:   Tue, 18 Oct 2022 12:07:08 +0800
Message-Id: <20221018040708.3801248-1-zys.zljxml@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Yushan Zhou <katrinzhou@tencent.com>

Fix the following coccicheck warning:
fs/nfs/dir.c:2494:2-7: WARNING:
NULL check before some freeing functions is not needed.

Signed-off-by: Yushan Zhou <katrinzhou@tencent.com>
---
 fs/nfs/dir.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 58036f657126..f594dac436a7 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2489,9 +2489,8 @@ int nfs_unlink(struct inode *dir, struct dentry *dentry)
 		spin_unlock(&dentry->d_lock);
 		goto out;
 	}
-	if (dentry->d_fsdata)
-		/* old devname */
-		kfree(dentry->d_fsdata);
+	/* old devname */
+	kfree(dentry->d_fsdata);
 	dentry->d_fsdata = NFS_FSDATA_BLOCKED;
 
 	spin_unlock(&dentry->d_lock);
-- 
2.27.0

