Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A6B762C17
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jul 2023 08:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbjGZG5X (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 26 Jul 2023 02:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbjGZG5B (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 26 Jul 2023 02:57:01 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD80270E
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jul 2023 23:56:57 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-686d8c8fc65so197053b3a.0
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jul 2023 23:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690354617; x=1690959417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+cgwSP2GNaLW2AkzC9d8O1n1TWu4WtyvNASMDUPgpTk=;
        b=WzCi3X8UUFacSHHlbGWOWEPQx8Di4kpfgwtRarTuL3eswLApCp4AQ4/zccZtRB1l3V
         KzalW09EmV4wt2OJ6ixa29jYdACsoUS0FRAKTMXl+3WLC1KlYOpEYCXIr9cgW+AZj2wb
         Twd/2ymUb5bqg/k12JnznrXIPOCUr33WjVA0Vq8Vp0sSq7qrm/ytjmVShi5p5U52hqM7
         LKTZ9tXLCX3l9QJF5+VLOGcIdrtiWceROCPGN07KjhjG2sXYd1fzfkX3Ac/i9G7cN+9y
         75Q/rY4pWdY6P3iU3GTSG9rX9goCIRgQspg+A+hY/b6HYVdzFS1mRQPWIBkbuyGqLmhl
         u87Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690354617; x=1690959417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+cgwSP2GNaLW2AkzC9d8O1n1TWu4WtyvNASMDUPgpTk=;
        b=U3UKohLGs+Kwqza0Mc6g2aAEyEaP0ED83ED6mM4OtwJ8UfRzm9UZaIMpO9lLsrxgg9
         Ogb5IjOITQQF4fSoEzslG06+vZOCOfeZ7HjnBhP3ndWqJRIDtEIIYcajwTU6Y6BhS5dy
         wdh0Yi5HbYRQfdPb7w3wcDtBHkWCLeffFGhCbh249NMJVcCYDlDaGqsRH9t/GbPiwdHG
         gSv+U4Rk9rOgqDq3FKjDgX5CjxjpPrDZP7O5QDVfXuTdIoRJ24rRtadLmmQI31rWvDt+
         QArfgOpdO2Tc6XORDfqDGG21kkxqsWTArNON9u+zshYg/ut04sLOcfF1ANlCi2KPWIHH
         2wdA==
X-Gm-Message-State: ABy/qLY6CnMtMxPr5lX4K/qMdYQtcHdRYNXl/BgOQE62B40w7CHKL6zj
        N/aOL4tkLywJTq4Unyq/rowqa3hdqAvy3w==
X-Google-Smtp-Source: APBJJlEyAWAI6eAWqXrJQtZiBckF99NtTd3wwlY0sEmkx+la2rr+Zc6QFCOD01WJa+hKLShZUv7oMw==
X-Received: by 2002:a05:6a00:244a:b0:67a:6ba0:3a6 with SMTP id d10-20020a056a00244a00b0067a6ba003a6mr1188893pfj.21.1690354616695;
        Tue, 25 Jul 2023 23:56:56 -0700 (PDT)
Received: from apollo.hsd1.ca.comcast.net ([2601:646:9100:6180::6adc])
        by smtp.gmail.com with ESMTPSA id n14-20020aa78a4e000000b00666b3706be6sm10675247pfa.107.2023.07.25.23.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 23:56:56 -0700 (PDT)
From:   Khem Raj <raj.khem@gmail.com>
To:     linux-nfs@vger.kernel.org
Cc:     Khem Raj <raj.khem@gmail.com>
Subject: [PATCH] tools/locktest: Use intmax_t to print off_t
Date:   Tue, 25 Jul 2023 23:56:53 -0700
Message-ID: <20230726065653.1336464-1-raj.khem@gmail.com>
X-Mailer: git-send-email 2.41.0
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

off_t could be 64bit on 32bit architectures which means using %z printf
modifier is not enough to print it and compiler will complain about
format mismatch

Fixes
| testlk.c:84:66: error: format '%zd' expects argument of type 'signed size_t', but argument 4 has type '__off64_t' {aka 'long long int'} [-Werror=format=]
|    84 |                         printf("%s: conflicting lock by %d on (%zd;%zd)\n",
|       |                                                                ~~^
|       |                                                                  |
|       |                                                                  int
|       |                                                                %lld
|    85 |                                 fname, fl.l_pid, fl.l_start, fl.l_len);
|       |                                                  ~~~~~~~~~~
|       |                                                    |
|       |                                                    __off64_t {aka long long int}

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 tools/locktest/testlk.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/locktest/testlk.c b/tools/locktest/testlk.c
index ea51f788..9d4c88c4 100644
--- a/tools/locktest/testlk.c
+++ b/tools/locktest/testlk.c
@@ -2,6 +2,7 @@
 #include <config.h>
 #endif
 
+#include <stdint.h>
 #include <stdlib.h>
 #include <stdio.h>
 #include <unistd.h>
@@ -81,8 +82,8 @@ main(int argc, char **argv)
 		if (fl.l_type == F_UNLCK) {
 			printf("%s: no conflicting lock\n", fname);
 		} else {
-			printf("%s: conflicting lock by %d on (%zd;%zd)\n",
-				fname, fl.l_pid, fl.l_start, fl.l_len);
+			printf("%s: conflicting lock by %d on (%jd;%jd)\n",
+				fname, fl.l_pid, (intmax_t)fl.l_start, (intmax_t)fl.l_len);
 		}
 		return 0;
 	}
-- 
2.41.0

