Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986697509F2
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jul 2023 15:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjGLNtA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 Jul 2023 09:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbjGLNs7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 12 Jul 2023 09:48:59 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70632E8;
        Wed, 12 Jul 2023 06:48:58 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b8b318c5a7so51431055ad.3;
        Wed, 12 Jul 2023 06:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689169738; x=1691761738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6EgqmrzSssssNh5CkkOVdmZdM6BNgW/wAfPysQBcRX8=;
        b=L9RMDDVBjIHOcoJEG/ZxYxyaiskEgXuIehhsGQXBhous/f5f3MU6IbJ7NkfVB10QlQ
         ZZq12PRQgr2t7PupMacJMJSjszILlrEts32rXU0GkAfYJIWGD1sYS8aHLJzDUXt7Flet
         LNBSlwDZ4XzHBWZTYlLwhysbF+2NwcSW2Vx+IMeQogCrAJuJfy572dXmDZLhr9LNsQjW
         FF5rOaXsXcHH3LBqE+bLd44O4oMwDl+kqNEaCG1/KhLbGTRYbtGTs3fzumhQr5ChpbVr
         kxHMP4eQ3jI8U9w2RCDqbgPzwIwbrnr0XCmMc7I+DDrVaJQs+5RkxpvIIrhqKXwTs/eI
         PYkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689169738; x=1691761738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6EgqmrzSssssNh5CkkOVdmZdM6BNgW/wAfPysQBcRX8=;
        b=LrZAG1pwqtEP4VS2Z7gohHWgCbAXFyUaeUiFS4OYI0QNlk8YpnmZGhQ489WGobz68D
         9L8NCdaPtMlDSq2qHtfMoElY6ufU8xxQoiUN6mpgXOd+pKT+Hb3WfK19cefKOR1HPXim
         sJZN+OXHY1sRm5CRvRlv+3RhLJu7noGLj35h1KnZ+i4Q5x62s2MNC4E+ctFLkvtYkmMN
         FH8PRXHcY8g15l7wdUjtX98vF5wIfpUWEyUdseLRKUpww7lFxpSupfzh/VdIo+HWwFb+
         vzRTgsH6BZtoa/C2Za3nVAxLdBRf3ZiyXzfjpI0PNOBUmKkbkiX6sUMD8wvY1fuo/99Q
         io4w==
X-Gm-Message-State: ABy/qLZyiNO31w1C39L4C4xMRONXkw0PKV7Knd/LPF5K9JGDVgixoM8y
        HMk3yzE40eq5+QoB1kiFMKU=
X-Google-Smtp-Source: APBJJlHOSCfGhYLwqA5z3fJZpDC8GXQCZmzvrmDeWgOiSWiSZCuktVSP6duGm1O5HJGFvWfGLbuaqw==
X-Received: by 2002:a17:903:41c7:b0:1ac:aba5:7885 with SMTP id u7-20020a17090341c700b001acaba57885mr20664253ple.47.1689169737927;
        Wed, 12 Jul 2023 06:48:57 -0700 (PDT)
Received: from fedora.. ([125.118.239.175])
        by smtp.gmail.com with ESMTPSA id s11-20020a170902a50b00b001b53be3d956sm3982225plq.167.2023.07.12.06.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 06:48:57 -0700 (PDT)
From:   Wenchao Hao <haowenchao22@gmail.com>
X-Google-Original-From: Wenchao Hao <haowenchao2@huawei.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Wenchao Hao <haowenchao2@huawei.com>
Subject: [PATCH] NFS: Fix memleak in nfs_sysfs_move_sb_to_server
Date:   Wed, 12 Jul 2023 21:48:53 +0800
Message-Id: <20230712134853.1044134-1-haowenchao2@huawei.com>
X-Mailer: git-send-email 2.35.3
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

call kfree() to free memory allocated in kasprintf() to fix
memleak. It's easy to recurrent this memleak, just mount and
remount nfs at NFS client.

The bug is detected by kmemleak with following stack:
unreferenced object 0xffffa31a91fdf2c0 (size 16):
  comm "mount.nfs", pid 960, jiffies 4294724478 (age 111892.067s)
  hex dump (first 16 bytes):
    73 65 72 76 65 72 2d 30 00 f2 fd 91 1a a3 ff ff  server-0........
  backtrace:
    [<00000000de9b21a9>] create_object+0x11/0x17
    [<00000000ed17aa96>] kmemleak_alloc+0x6c/0x7a
    [<000000009f4acc69>] slab_post_alloc_hook.constprop.0+0x81/0x99
    [<00000000d2446455>] __kmem_cache_alloc_node+0x10c/0x13a
    [<00000000eca4a704>] __kmalloc_node_track_caller+0x83/0xb7
    [<0000000076cdb22f>] kvasprintf+0x65/0xc3
    [<00000000f6f2e879>] kasprintf+0x4e/0x69
    [<00000000e49d03be>] nfs_sysfs_move_sb_to_server+0x24/0x5f
    [<0000000039127597>] nfs_kill_super+0x25/0x49
    [<00000000e6ecf809>] deactivate_locked_super+0x35/0x74
    [<000000003b9c3350>] deactivate_super+0x3c/0x44
    [<00000000777c86be>] cleanup_mnt+0x6c/0xe7
    [<000000009f181749>] __cleanup_mnt+0x12/0x18
    [<00000000a709602e>] task_work_run+0x75/0x8c
    [<0000000075da06ba>] exit_to_user_mode_prepare+0x79/0x102
    [<0000000093a53d48>] syscall_exit_to_user_mode+0x1c/0x30

Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
---
 fs/nfs/sysfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
index acda8f033d30..bf378ecd5d9f 100644
--- a/fs/nfs/sysfs.c
+++ b/fs/nfs/sysfs.c
@@ -345,8 +345,10 @@ void nfs_sysfs_move_sb_to_server(struct nfs_server *server)
 	int ret = -ENOMEM;
 
 	s = kasprintf(GFP_KERNEL, "server-%d", server->s_sysfs_id);
-	if (s)
+	if (s) {
 		ret = kobject_rename(&server->kobj, s);
+		kfree(s);
+	}
 	if (ret < 0)
 		pr_warn("NFS: rename sysfs %s failed (%d)\n",
 					server->kobj.name, ret);
-- 
2.35.3

