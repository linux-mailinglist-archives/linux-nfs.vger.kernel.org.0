Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68BF33D2769
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Jul 2021 18:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbhGVPfZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 22 Jul 2021 11:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhGVPfY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 22 Jul 2021 11:35:24 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF321C061757
        for <linux-nfs@vger.kernel.org>; Thu, 22 Jul 2021 09:15:58 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id p9so1569895wmq.5
        for <linux-nfs@vger.kernel.org>; Thu, 22 Jul 2021 09:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Obsm09FqhMZGle+78ROw0VtmFY/fWA9CVF1JdrgJm54=;
        b=N1p4ROaOYz3eViri6j/bDnDtyYHNOD2Hg+fxoYmLj2DU6kXzQuKlB+Pn8ZjT0eZz5z
         qnEb94o8mYBvW/kIyF+53EZU7yDwYpTom5ZI114Cn4vwcaeYTZnAGl7TAx1cfBnUrqfa
         UX9D4oXR0Y487x1xgeJDMD+QLH/98vO/dbEnvSsPhazPufDpm4jVXbDsePLL0DA6yzYB
         05URU2PNC0cLIbv5zKzWvHSqlslwh7n5w9E2GPrUVGbPpvIbtWjHqDAInzoTauJjD7pC
         kg5aT/dP6netGHTfiLNlY6U9b4knQamn2Uw09Yqedxk8cLYqapk2Q2wHsv560QR0sFTj
         ZaKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Obsm09FqhMZGle+78ROw0VtmFY/fWA9CVF1JdrgJm54=;
        b=LpJGtwHxVKm475q0FsRQfVtAQvXEMsDYSgPOTTzEGK5ikAo6+7EFkh3tnh8L17T77E
         Bl3VZYYxj3EDSS6THnPYI/aPlPf7Dzh3SOEY7q8JcuBSn1Qvz2L5XuPADcJf5+kaLQmp
         BmUQlUxpprt5Ot3HINRk8v2H+1foOe/JMnOzoLiyJRBhVoG1AIFvz1KiDfD2hylkedXt
         lgO+8tfHOel7sJ7flr5ZRfAFD46onl4/1GpmBRxHUeTMJcVGPKhKFDyTpgHDZuwuSA58
         A5f6kWnGPVoMQ6Z/1FigbZkqWT6W1JlMVV5l08mzbrmlVReeFXVxVq2CM+plYwIlWhy9
         /gnA==
X-Gm-Message-State: AOAM533cckwFp321erdAOrNGMCoKfejAr2NwjVXEdkJlgpmOxxs3biWK
        8j8VViVBM3EutIpjOaYE5EGAOgMScbNGNw==
X-Google-Smtp-Source: ABdhPJweL2iu096DL+nQhUsFX9svpmim42gfV3cRJjVmOeGwtMCUeXmUt1SzCi5AflTs2sriT1e96w==
X-Received: by 2002:a7b:c778:: with SMTP id x24mr360525wmk.77.1626970557427;
        Thu, 22 Jul 2021 09:15:57 -0700 (PDT)
Received: from dell5510.suse.de (gw.ms-free.net. [95.85.240.250])
        by smtp.gmail.com with ESMTPSA id q81sm3528547wme.18.2021.07.22.09.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 09:15:57 -0700 (PDT)
From:   Petr Vorel <petr.vorel@gmail.com>
To:     linux-nfs@vger.kernel.org
Cc:     Petr Vorel <petr.vorel@gmail.com>,
        Steve Dickson <steved@redhat.com>
Subject: [nfs-utils PATCH 2/2] nfsdcltrack/nfsdcltrack.c: Fix printf format
Date:   Thu, 22 Jul 2021 18:15:45 +0200
Message-Id: <20210722161545.26923-2-petr.vorel@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210722161545.26923-1-petr.vorel@gmail.com>
References: <20210722161545.26923-1-petr.vorel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

nfsdcltrack.c: In function 'cltrack_gracedone':
nfsdcltrack.c:528:47: error: format '%ld' expects argument of type 'long int', but argument 4 has type 'time_t' {aka 'long long int'} [-Werror=format=]
  528 |  xlog(D_GENERAL, "%s: grace done. gracetime=%ld", __func__, gracetime);
      |                                             ~~^             ~~~~~~~~~
      |                                               |             |
      |                                               long int      time_t {aka long long int}
      |                                             %lld

Found in Buildroot riscv32 build.

Link: http://autobuild.buildroot.net/results/9bc1d43a588338b7395af7bc97535ee16a6ea2d9/build-end.log

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 utils/nfsdcltrack/nfsdcltrack.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/utils/nfsdcltrack/nfsdcltrack.c b/utils/nfsdcltrack/nfsdcltrack.c
index e926f1c0..0b37c094 100644
--- a/utils/nfsdcltrack/nfsdcltrack.c
+++ b/utils/nfsdcltrack/nfsdcltrack.c
@@ -33,6 +33,7 @@
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <fcntl.h>
+#include <inttypes.h>
 #include <unistd.h>
 #include <libgen.h>
 #include <sys/inotify.h>
@@ -525,7 +526,7 @@ cltrack_gracedone(const char *timestr)
 	if (*tail)
 		return -EINVAL;
 
-	xlog(D_GENERAL, "%s: grace done. gracetime=%ld", __func__, gracetime);
+	xlog(D_GENERAL, "%s: grace done. gracetime=%"PRIu64, __func__, gracetime);
 
 	ret = sqlite_remove_unreclaimed(gracetime);
 
-- 
2.32.0

