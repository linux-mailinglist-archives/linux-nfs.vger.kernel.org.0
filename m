Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191FE6FDD3F
	for <lists+linux-nfs@lfdr.de>; Wed, 10 May 2023 13:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbjEJL46 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 10 May 2023 07:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbjEJL45 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 10 May 2023 07:56:57 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289D53C16
        for <linux-nfs@vger.kernel.org>; Wed, 10 May 2023 04:56:55 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2ac82c08542so71955251fa.2
        for <linux-nfs@vger.kernel.org>; Wed, 10 May 2023 04:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683719813; x=1686311813;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=01DOxGWaKMv0xzZNrctBlV7kzsI5IKgFoVE/rKSLpT0=;
        b=oWLZ5V79fhh6oTojY7cTDLyT541291+CAS+uctWxcEnPiKeVyeRj2atKe8lNbRMTt9
         hvhQp6aU4z5QzQx/+UhFyuZsvEeBAxgDOYT2Jn6FcXiJwSw3xTkO4JMTFUfOfh1gOlax
         FDKvpKMasFq0PjcQelQsG8s2WpEPWp2YjlPw42uUMnTkBUTJx54FBcf0uwTqCMmJyjT/
         aiL+Hnwogpcavbz3oYpMeLLghXiH54pyrCgcHUBZO32ycQyQQK5uBDWffpFM3cFxGasN
         RmEGPZ8PQKmBAVbJmWprR3Q+0PuCfh9BJHiNRyWAplPdw+xpLlDym17i0H4Sab7IOjCL
         3bWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683719813; x=1686311813;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=01DOxGWaKMv0xzZNrctBlV7kzsI5IKgFoVE/rKSLpT0=;
        b=ej4TOY2huVKMDwnIeYzAzEEOHMOucts15bMTwP7Qop+ywFTqd4d25ldLFpVb8EhyeA
         B6cX4UbfHI7rDA2XxxfILWA4hdwE1zQqTmnjGLMaspbWijYaghLwbmv5hOkZHDX0t4K3
         7oQaUGE8eKSm/FbxUX1Yv8JJuFjuMehkoR/uDEDnq9gNbmtIW5QT6jBk3dTObqvxcDbe
         aDBDeTap3fIg5RhFC55sHvqqQ+7BQfohD5qHPiSn2ktV3/qR1haRx2o3sa/i3jhdTYXu
         dFfq7ElQ9QevgCAsOwoeZQVQ26SDJx6/Z8DPMW3VpZXQ3fp4Wiyia3dmrWgjIqP3hs0i
         BxjA==
X-Gm-Message-State: AC+VfDxa1+cS5LqQ892AKvFAkCXca0CmDjRaP9Ltzkzy+X8nV4Td0XQw
        e5vN4L70XFbhcyVvK5I037Wo23l2tflMpg==
X-Google-Smtp-Source: ACHHUZ7g1APEj4OTPVTdI2MWeSUM5pbOrlAfSG31PX9MZSl6aVHhSJudlitbIwwrjUDPrzewg37aTw==
X-Received: by 2002:a05:651c:150:b0:2ad:9c26:3638 with SMTP id c16-20020a05651c015000b002ad9c263638mr2098591ljd.52.1683719813250;
        Wed, 10 May 2023 04:56:53 -0700 (PDT)
Received: from GDN-N-WIKTORJ.advaoptical.com (188.147.96.20.nat.umts.dynamic.t-mobile.pl. [188.147.96.20])
        by smtp.gmail.com with ESMTPSA id a5-20020a05651c010500b002ac9138a419sm1937784ljb.80.2023.05.10.04.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 04:56:52 -0700 (PDT)
From:   Wiktor Jaskulski <wikjas97@gmail.com>
X-Google-Original-From: Wiktor Jaskulski <wjaskulski@adva.com>
To:     linux-nfs@vger.kernel.org
Cc:     wjaskulski <wjaskulski@adva.com>
Subject: [PATCH] libevent and libsqlite3 checked when nfsv4 is disabled
Date:   Wed, 10 May 2023 13:56:37 +0200
Message-Id: <20230510115637.29271-1-wjaskulski@adva.com>
X-Mailer: git-send-email 2.34.1
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

From: wjaskulski <wjaskulski@adva.com>

Even if nfsv4 is disabled component fsidd has libevent and libsqlite3 as dependencies.

Problems with compilation and error logs can be found at:
https://github.com/gentoo/gentoo/pull/30789
https://bugs.gentoo.org/904718

Signed-off-by: Wiktor Jaskulski <wjaskulski@adva.com>
---
 configure.ac | 38 +++++++++++++++-----------------------
 1 file changed, 15 insertions(+), 23 deletions(-)

diff --git a/configure.ac b/configure.ac
index 4ade528d..519cacbf 100644
--- a/configure.ac
+++ b/configure.ac
@@ -335,42 +335,34 @@ AC_CHECK_HEADER(rpc/rpc.h, ,
                 AC_MSG_ERROR([Header file rpc/rpc.h not found - maybe try building with --enable-tirpc]))
 CPPFLAGS="${nfsutils_save_CPPFLAGS}"
 
+dnl check for libevent libraries and headers
+AC_LIBEVENT
+
+dnl Check for sqlite3
+AC_SQLITE3_VERS
+
+case $libsqlite3_cv_is_recent in
+yes) ;;
+unknown)
+   dnl do not fail when cross-compiling
+   AC_MSG_WARN([assuming sqlite is at least v3.3]) ;;
+*)
+   AC_MSG_ERROR([nfsdcld requires sqlite-devel]) ;;
+esac
+
 if test "$enable_nfsv4" = yes; then
-  dnl check for libevent libraries and headers
-  AC_LIBEVENT
 
   dnl check for the keyutils libraries and headers
   AC_KEYUTILS
 
-  dnl Check for sqlite3
-  AC_SQLITE3_VERS
-
   if test "$enable_nfsdcld" = "yes"; then
 	AC_CHECK_HEADERS([libgen.h sys/inotify.h], ,
 		AC_MSG_ERROR([Cannot find header needed for nfsdcld]))
-
-    case $libsqlite3_cv_is_recent in
-    yes) ;;
-    unknown)
-      dnl do not fail when cross-compiling
-      AC_MSG_WARN([assuming sqlite is at least v3.3]) ;;
-    *)
-      AC_MSG_ERROR([nfsdcld requires sqlite-devel]) ;;
-    esac
   fi
 
   if test "$enable_nfsdcltrack" = "yes"; then
 	AC_CHECK_HEADERS([libgen.h sys/inotify.h], ,
 		AC_MSG_ERROR([Cannot find header needed for nfsdcltrack]))
-
-    case $libsqlite3_cv_is_recent in
-    yes) ;;
-    unknown)
-      dnl do not fail when cross-compiling
-      AC_MSG_WARN([assuming sqlite is at least v3.3]) ;;
-    *)
-      AC_MSG_ERROR([nfsdcltrack requires sqlite-devel]) ;;
-    esac
   fi
 
 else
-- 
2.34.1

