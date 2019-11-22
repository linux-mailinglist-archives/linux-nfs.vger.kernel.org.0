Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83B44107B46
	for <lists+linux-nfs@lfdr.de>; Sat, 23 Nov 2019 00:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfKVXYR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Nov 2019 18:24:17 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44506 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfKVXYR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Nov 2019 18:24:17 -0500
Received: by mail-wr1-f66.google.com with SMTP id i12so10523804wrn.11
        for <linux-nfs@vger.kernel.org>; Fri, 22 Nov 2019 15:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a76zDfEBpH6vuiT8+TXWhih72W09jzbyP2Vr4QklfYk=;
        b=UY/vcjKItvN+knOHMnaLvAgmqloxQe6Dw+87QS+j8NwCFDD6QGL7zfOsfhaBWaGgAC
         xgm3iIif0Cd/FbLboQh93edl1vZJY74iJGubgYVd09SibUAJXTRqsT0YEA2Lz0kWYpJy
         GAWghAcROCA7UU8o205NQEU1jdaGRZ5nc3VwMLUaP5UyMyFIs85vmRunDUgE1jTIj9gS
         9668PUsSEODPUyrSIvxQO8HhVZCI/QU6+Q+7+f8gxjy2TUPyOkmUBVk02S8R8vkL6DW9
         r5ulwtkL7WKEn59bo4CJqeMPKTq8RRWiYJ71JJ9dp2XcOIoErw0LSD9jXI6SSkXrIHMA
         +MTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a76zDfEBpH6vuiT8+TXWhih72W09jzbyP2Vr4QklfYk=;
        b=O9BbNSSjFMaOL6WPTQQXOxIft2+XC2ALZi9w3iro4V/HD+4xQPuIPNIpfqZj5TPj3V
         lXdBaYk69JL8u5Lu7kvr59Oaf2u/dM2bpqvxiKlp6loqammLu53E7o3ynxsQAFvRHtD5
         V9/FyU9dbpYBP8jq5fFauupTCYKCTuFEETj3QyHRr65x4lXXUUTqjOs9zVhuqIXbUhRm
         +JVxoUwP9ec5mB3HkX8tTTNQnaOl1SSXEDw6YYliY2gOBrRNy0QEmXRPoCgj2weqJyur
         0+iVnU/pmEMR6Xj8efHRZgrqJXuQRPtGNLsuoGj0uqXGer03FxBj0RgiL1ovZSuWNffi
         /NOw==
X-Gm-Message-State: APjAAAW963XcnWGBVIPUG6uIBYqb/mW6+6AR1t6yOGHMkYdMvPcnuop2
        w7lBt52TPkQkqWpuXOjSBMRWsyso
X-Google-Smtp-Source: APXvYqwGYfSrbilYFRksqnKCQNflBzm/3/Frggd00VUPTzdo/2j7Z3Aov2rv2KxuJiSOwqpCla97cw==
X-Received: by 2002:adf:ea88:: with SMTP id s8mr20150015wrm.120.1574465054574;
        Fri, 22 Nov 2019 15:24:14 -0800 (PST)
Received: from localhost.localdomain (133.125.broadband12.iol.cz. [90.179.125.133])
        by smtp.gmail.com with ESMTPSA id y21sm650071wmi.6.2019.11.22.15.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 15:24:13 -0800 (PST)
From:   Petr Vorel <petr.vorel@gmail.com>
To:     linux-nfs@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Petr Vorel <petr.vorel@gmail.com>
Subject: [nfs-utils PATCH 1/1] Let the configure script find getrpcbynumber in libtirpc
Date:   Sat, 23 Nov 2019 00:24:06 +0100
Message-Id: <20191122232406.202016-1-petr.vorel@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

The getrpcbynumber() function may not be available in the C library,
but only in the libtirpc library. Take this into account when checking
for the existence of getrpcbynumber() and getrpcbynumber_r().

Reviewed-by: Petr Vorel <petr.vorel@gmail.com>
[ pvorel: patch taken from Buildroot distribution ]
Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 configure.ac | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 949ff9fc..e9699752 100644
--- a/configure.ac
+++ b/configure.ac
@@ -534,11 +534,23 @@ AC_FUNC_STAT
 AC_FUNC_VPRINTF
 AC_CHECK_FUNCS([alarm atexit dup2 fdatasync ftruncate getcwd \
                gethostbyaddr gethostbyname gethostname getmntent \
-               getnameinfo getrpcbyname getrpcbynumber getrpcbynumber_r getifaddrs \
+               getnameinfo getrpcbyname getifaddrs \
                gettimeofday hasmntopt inet_ntoa innetgr memset mkdir pathconf \
                ppoll realpath rmdir select socket strcasecmp strchr strdup \
                strerror strrchr strtol strtoul sigprocmask name_to_handle_at])
 
+save_CFLAGS=$CFLAGS
+save_LIBS=$LIBS
+CFLAGS="$CFLAGS $AM_CPPFLAGS"
+LIBS="$LIBS $LIBTIRPC"
+AC_CHECK_FUNCS([getrpcbynumber getrpcbynumber_r])
+CFLAGS=$save_CFLAGS
+LIBS=$save_LIBS
+
+if test "$ac_cv_func_getrpcbynumber_r" != "yes" -a "$ac_cv_func_getrpcbynumber" != "yes"; then
+   AC_MSG_ERROR([Neither getrpcbynumber_r nor getrpcbynumber are available])
+fi
+
 dnl *************************************************************
 dnl Check for data sizes
 dnl *************************************************************
-- 
2.24.0

