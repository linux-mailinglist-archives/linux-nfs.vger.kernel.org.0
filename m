Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0526E3D2768
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Jul 2021 18:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhGVPfY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 22 Jul 2021 11:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhGVPfY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 22 Jul 2021 11:35:24 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C581C061575
        for <linux-nfs@vger.kernel.org>; Thu, 22 Jul 2021 09:15:58 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id n4so3671213wms.1
        for <linux-nfs@vger.kernel.org>; Thu, 22 Jul 2021 09:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pwx+1+dsCR4JcJW/IV9mp5L2Vn81NsvrUb0wunmAbLw=;
        b=tPGhLytzI6sEQrhigQ4uy6CVkxHaMfe4UteyKM/hy6vuih1gi1VqzdliscBVf0rrAt
         iUSQXDZJhUHQUZK4Pkx8wBve5oOZxqwGt6IozWYSncU7Tt3zzL4Ae05KTfCWSwA+YpI9
         KaH2butNZvOS+3SJb3FoGB2cM/kEjOTIbOiy5Jo+2+hVVeXB8d/gg1zb4uKehV9Kae4K
         cZqxI4mBURzUS2KhzJmPj3sLokvrmBbPnAYgg4d5D+CHoJLrAmP7bj3yWehxTp+FAPi6
         Y0FoSt6aOp/JPQBSS6ofKLvx/BNrJGdgt/e62uoYWDSrvI5XIYqC6b9Yy2+Uas5X1gOZ
         Z3yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pwx+1+dsCR4JcJW/IV9mp5L2Vn81NsvrUb0wunmAbLw=;
        b=AfR6xt6AMoc+OJJirtr0HeEVZi0ba+R9H7S3j26lNkiGKHEz/0xXctwiJ1WbI4AlN0
         ilxZFjvaPXbsMzVfSeIsnGu8HKDpqtahVoPpa4PX9jDYrKLsgAhNa29MCvOy4U+VV1fJ
         F4Mk3yMJZbXBfmVACM5nE6cv3sH8kksOJrRYT8GYjyoI3+7EuMcESymyVH06Nwku20GG
         xrNviBm/FUNEOGDU3Xe8fwkKIVuLHaq3mlVsLmVIBXrjI35ldWrVUomgqr39sBhaGDIm
         2ckchmBJsKTKkJRM14RjvZ82Nd/fKaNcIAeBRGa4fSkXaHqeupYAcknlFa4GB/WygYN0
         PuFw==
X-Gm-Message-State: AOAM531WYgd7Qx78prip4L/WL80IzHvrop9apSSu175Vfepspp2BLmwF
        q+HNHppwDGgd4Bm8XTUTKkHAmUqDiANZ2Q==
X-Google-Smtp-Source: ABdhPJxIdOc2hZ8VTcVZlc7vlYHQtiu76X2fHJf5n3Iefy6/hCuNFUaMnGmi3NEySx2gFxSCGbkYpg==
X-Received: by 2002:a1c:44d4:: with SMTP id r203mr364029wma.91.1626970556536;
        Thu, 22 Jul 2021 09:15:56 -0700 (PDT)
Received: from dell5510.suse.de (gw.ms-free.net. [95.85.240.250])
        by smtp.gmail.com with ESMTPSA id q81sm3528547wme.18.2021.07.22.09.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 09:15:56 -0700 (PDT)
From:   Petr Vorel <petr.vorel@gmail.com>
To:     linux-nfs@vger.kernel.org
Cc:     Petr Vorel <petr.vorel@gmail.com>,
        Steve Dickson <steved@redhat.com>
Subject: [nfs-utils PATCH 1/2] nfsdcltrack/sqlite: Fix printf format
Date:   Thu, 22 Jul 2021 18:15:44 +0200
Message-Id: <20210722161545.26923-1-petr.vorel@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

sqlite.c: In function 'sqlite_remove_unreclaimed':
sqlite.c:547:71: error: format '%ld' expects argument of type 'long int', but argument 4 has type 'time_t' {aka 'long long int'} [-Werror=format=]
  547 |  ret = snprintf(buf, sizeof(buf), "DELETE FROM clients WHERE time < %ld",
      |                                                                     ~~^
      |                                                                       |
      |                                                                       long int
      |                                                                     %lld
  548 |    grace_start);
      |    ~~~~~~~~~~~
      |    |
      |    time_t {aka long long int}

Found in Buildroot riscv32 build.

Link: http://autobuild.buildroot.net/results/9bc1d43a588338b7395af7bc97535ee16a6ea2d9/build-end.log

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 utils/nfsdcltrack/sqlite.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/utils/nfsdcltrack/sqlite.c b/utils/nfsdcltrack/sqlite.c
index f79aebb3..cea4a411 100644
--- a/utils/nfsdcltrack/sqlite.c
+++ b/utils/nfsdcltrack/sqlite.c
@@ -46,6 +46,7 @@
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <fcntl.h>
+#include <inttypes.h>
 #include <unistd.h>
 #include <sqlite3.h>
 #include <linux/limits.h>
@@ -544,7 +545,7 @@ sqlite_remove_unreclaimed(time_t grace_start)
 	int ret;
 	char *err = NULL;
 
-	ret = snprintf(buf, sizeof(buf), "DELETE FROM clients WHERE time < %ld",
+	ret = snprintf(buf, sizeof(buf), "DELETE FROM clients WHERE time < %"PRIu64,
 			grace_start);
 	if (ret < 0) {
 		return ret;
-- 
2.32.0

