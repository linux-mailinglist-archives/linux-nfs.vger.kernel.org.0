Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18BA919E301
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Apr 2020 07:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbgDDFY6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 4 Apr 2020 01:24:58 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37362 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgDDFY5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 4 Apr 2020 01:24:57 -0400
Received: by mail-pg1-f193.google.com with SMTP id r4so3195219pgg.4
        for <linux-nfs@vger.kernel.org>; Fri, 03 Apr 2020 22:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=JKl0SvnLAUkLiqnBo6JOuGYJiEqEsbOssjtoOxkju/U=;
        b=DL/91K8D8v+zhKRjYhY35qeKLAD+IelwhM/uOs1DZRvcs4k/52dVZoEsfiwBx2GcUf
         sJ3Ry8VHtNxuR3rNVwmiVFfYc/owzbCH949pi9SiQ3fBYmmjIFVWeJ7v/7xzulGjXGny
         GO/vKtZslXQxBvCca60tW1rURCme6WeX0RiR7MVneh8rBQ5VTtvBiuFi3jN5zf+rlyWz
         4+Tqmu0u6QN5lkKDcq6O+tZ2Jxq+2KO4OF0/G5ZhzSWYM7CAn2i1JnyAvrgoSrYt51lc
         8Da5HUYBmwjUfqb8OrV8Bmj9Rf5QnGS+qMyQ1tR1O+wcOQ4RRmc/5jkCYDAKe1Blxr2c
         xoJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JKl0SvnLAUkLiqnBo6JOuGYJiEqEsbOssjtoOxkju/U=;
        b=DaBdZRHdSv7WMwQ4eedoIBKOIfIZA7oHKuJvk1Vm6mskO28lZ1GhS5mXnKWN7Qm3rj
         QKHS22NewGretNE5Mb7uWNHi0G/63nZoaffPIQl85YidaDDzYCCRMh8cpeNZL1nXenHz
         9ADAjG9+YNrt47BJdpFJvOwnIMLtOq7kzeR+ClmcOOP9zqD7om7Bgjp3FsgUEMs43DFC
         vHmJCArIONmB50PipAWzbMrDN409WgvNZLhhmXbnmLNffUAvKDoqOu9siGD+AaLICsV/
         c/rnpzopbMpw1hJGoCtfdmQdOON4qNw8u20NYatybO+8sfQdc3APDS6Hp2yAKuzP0DG5
         Fcnw==
X-Gm-Message-State: AGi0PuYJW0GA9ZS4iD6iHeMz5cmnC30Bd1nCYEF3Pz8rDCKZdBMBYxbG
        wD+MP2K/9oX96WFTAyTzwm/74q0QT0k=
X-Google-Smtp-Source: APiQypJbN1EDYg2uxYzYdfY7wRtuOOjAG4303cjQ6jL1epbdz23MBlCywS9RHo0GrtUcWIEMzNFQxg==
X-Received: by 2002:a63:8b42:: with SMTP id j63mr10791334pge.27.1585977896425;
        Fri, 03 Apr 2020 22:24:56 -0700 (PDT)
Received: from localhost.localdomain (astound-69-42-19-227.ca.astound.net. [69.42.19.227])
        by smtp.gmail.com with ESMTPSA id n100sm6835531pjc.38.2020.04.03.22.24.55
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 22:24:55 -0700 (PDT)
From:   Rosen Penev <rosenp@gmail.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] nfs-utils: tools: use nls.h
Date:   Fri,  3 Apr 2020 22:24:53 -0700
Message-Id: <20200404052453.2631191-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200404052453.2631191-1-rosenp@gmail.com>
References: <20200404052453.2631191-1-rosenp@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

libintl.h is not available everywhere. This fixes compilation.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 tools/rpcgen/rpc_main.c | 2 +-
 tools/rpcgen/rpc_scan.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/rpcgen/rpc_main.c b/tools/rpcgen/rpc_main.c
index 1b26e522..e97940b9 100644
--- a/tools/rpcgen/rpc_main.c
+++ b/tools/rpcgen/rpc_main.c
@@ -42,7 +42,6 @@
 #include <stdio.h>
 #include <string.h>
 #include <unistd.h>
-#include <libintl.h>
 #include <locale.h>
 #include <ctype.h>
 #include <sys/types.h>
@@ -54,6 +53,7 @@
 #include "rpc_util.h"
 #include "rpc_scan.h"
 #include "proto.h"
+#include "nls.h"
 
 #ifndef _
 #define _(String) gettext (String)
diff --git a/tools/rpcgen/rpc_scan.c b/tools/rpcgen/rpc_scan.c
index 79eba964..7de61120 100644
--- a/tools/rpcgen/rpc_scan.c
+++ b/tools/rpcgen/rpc_scan.c
@@ -37,11 +37,11 @@
 #include <stdio.h>
 #include <ctype.h>
 #include <string.h>
-#include <libintl.h>
 #include "rpc_scan.h"
 #include "rpc_parse.h"
 #include "rpc_util.h"
 #include "proto.h"
+#include "nls.h"
 
 #ifndef _
 #define _(String) gettext (String)
-- 
2.25.1

