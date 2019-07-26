Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2466676BE1
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jul 2019 16:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbfGZOoI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 26 Jul 2019 10:44:08 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52009 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfGZOoI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 26 Jul 2019 10:44:08 -0400
Received: by mail-wm1-f65.google.com with SMTP id 207so48251075wma.1
        for <linux-nfs@vger.kernel.org>; Fri, 26 Jul 2019 07:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0it7ph8pv0lc5cmLwYGtG491NIBpufEySPNyr9I0N7M=;
        b=hbddEW5VgITbW74v7jSaIMfJ8d/RmzjWulM+PFdBUjDyBJJEO/xS0B16wolGCSFl4g
         jzfP4YKriYkQBUfNI22dyKx1F6uvl5U9hifcTFY/1WXjOuWh6AlYdEDAnADOzvyWTCTl
         HxYB1T1RXSb7wS7uSL7eEUujb/mDsdYyed6Wvc/qOVTzIcSVUMq1tBbqqwTQ/I2TtbyF
         DQS43DtAtR0n8lxR906Em1EEJY2Q84NqyfoN+dt4QnRXdbk+0oH8YW/NMu0PMblZ18/f
         cDIRVxrEoi5ihe50/KzFNiEOrzuKMjPyhP9byW8cz5lnBvOQzT3sKqFYkAayH1CVL9rA
         Ipdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0it7ph8pv0lc5cmLwYGtG491NIBpufEySPNyr9I0N7M=;
        b=DYpC1aLxjV/DttjnvUmuX4kvdhYfkANZG5AzO3Im7jQ24XifH1smcSnpDnrjctdDVS
         bbgupNwcxN7oz2oT6XrIfA8RCH7G0kPSYPPRtgnWqWaKCsFJCUmsquFN8jsBHbYH9nIe
         FfquC2gSeECGL6Uetac9ekUD6xPdop2tT6KGYwB3Xm2fN5ojrS9pnimYWZ8CuhkUhG6Z
         n++NzwnGyqBdrBkx4Q2e92bWJyVQ/FWjZNqywW/F1hEnlKWD+uVrwBGJ+k6i6e+WHupc
         /PupVishQz4/6YtHrD9aYx9oFwtsV8Zs13HonjEaQIdafppKu2Me6dUGjHwWqS0aCa6t
         aVFQ==
X-Gm-Message-State: APjAAAV0wRDU7x8qUJdJ+ckZhQh0EyYzQ5W3NYR4fZW4xBHgfseyZ3YS
        4HZDI+YSbxepVVvp4TB/1s8=
X-Google-Smtp-Source: APXvYqxR24Prtl6P5Z8ryc8XWRCjisPD10vEa37CvREeweU0JVsSYq8Fbs9MrE7MSNkVD7+kNOsrpw==
X-Received: by 2002:a7b:c313:: with SMTP id k19mr19865834wmj.2.1564152246228;
        Fri, 26 Jul 2019 07:44:06 -0700 (PDT)
Received: from ?IPv6:2a01:36d:104:9516:55af:3507:6a9f:3d90? (2a01-036d-0104-9516-55af-3507-6a9f-3d90.pool6.digikabel.hu. [2a01:36d:104:9516:55af:3507:6a9f:3d90])
        by smtp.gmail.com with ESMTPSA id g12sm74963272wrv.9.2019.07.26.07.44.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 07:44:05 -0700 (PDT)
From:   Zoltan Karcagi <zkr7432@gmail.com>
Subject: [PATCH] Fix include order between config.h and stat.h
To:     linux-nfs@vger.kernel.org
Cc:     zkr7432@gmail.com
References: <5bcd51ef-9ffb-2650-108f-8d7b04beb655@gmail.com>
Message-ID: <5c60f0b3-4498-96ec-be59-2dce85de3680@gmail.com>
Date:   Fri, 26 Jul 2019 16:44:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5bcd51ef-9ffb-2650-108f-8d7b04beb655@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

At least on Arch linux ARM, the definition of struct stat in stat.h depends
on __USE_FILE_OFFSET64. This symbol comes from config.h when defined,
therefore config.h must always be included before stat.h. Fix all
occurrences where the order is wrong by moving config.h to the top.

This fixes the client side error "Stale file handle" when mounting from
a server running Arch Linux ARM.

Signed-off-by: Zoltan Karcagi <zkr7432@gmail.com>
---
 support/misc/nfsd_path.c         | 5 ++++-
 support/misc/xstat.c             | 5 ++++-
 utils/blkmapd/device-discovery.c | 8 ++++----
 utils/idmapd/idmapd.c            | 8 ++++----
 4 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/support/misc/nfsd_path.c b/support/misc/nfsd_path.c
index 84e48028..f078a668 100644
--- a/support/misc/nfsd_path.c
+++ b/support/misc/nfsd_path.c
@@ -1,3 +1,7 @@
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
 #include <errno.h>
 #include <sys/types.h>
 #include <sys/stat.h>
@@ -5,7 +9,6 @@
 #include <stdlib.h>
 #include <unistd.h>
 
-#include "config.h"
 #include "conffile.h"
 #include "xmalloc.h"
 #include "xlog.h"
diff --git a/support/misc/xstat.c b/support/misc/xstat.c
index fa047880..4c997eea 100644
--- a/support/misc/xstat.c
+++ b/support/misc/xstat.c
@@ -1,3 +1,7 @@
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
 #include <errno.h>
 #include <sys/types.h>
 #include <fcntl.h>
@@ -5,7 +9,6 @@
 #include <sys/sysmacros.h>
 #include <unistd.h>
 
-#include "config.h"
 #include "xstat.h"
 
 #ifdef HAVE_FSTATAT
diff --git a/utils/blkmapd/device-discovery.c b/utils/blkmapd/device-discovery.c
index e811703d..f5f9b10b 100644
--- a/utils/blkmapd/device-discovery.c
+++ b/utils/blkmapd/device-discovery.c
@@ -26,6 +26,10 @@
  * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif /* HAVE_CONFIG_H */
+
 #include <sys/sysmacros.h>
 #include <sys/types.h>
 #include <sys/stat.h>
@@ -51,10 +55,6 @@
 #include <errno.h>
 #include <libdevmapper.h>
 
-#ifdef HAVE_CONFIG_H
-#include "config.h"
-#endif /* HAVE_CONFIG_H */
-
 #include "device-discovery.h"
 #include "xcommon.h"
 #include "nfslib.h"
diff --git a/utils/idmapd/idmapd.c b/utils/idmapd/idmapd.c
index 62e37b8a..267acea5 100644
--- a/utils/idmapd/idmapd.c
+++ b/utils/idmapd/idmapd.c
@@ -34,6 +34,10 @@
  *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif /* HAVE_CONFIG_H */
+
 #include <sys/types.h>
 #include <sys/time.h>
 #include <sys/inotify.h>
@@ -62,10 +66,6 @@
 #include <libgen.h>
 #include <nfsidmap.h>
 
-#ifdef HAVE_CONFIG_H
-#include "config.h"
-#endif /* HAVE_CONFIG_H */
-
 #include "xlog.h"
 #include "conffile.h"
 #include "queue.h"
-- 
2.22.0
