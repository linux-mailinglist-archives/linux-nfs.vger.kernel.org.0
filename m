Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1B7A19E26B
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Apr 2020 05:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgDDDCm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Apr 2020 23:02:42 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:53883 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbgDDDCl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Apr 2020 23:02:41 -0400
Received: by mail-pj1-f66.google.com with SMTP id l36so3934812pjb.3
        for <linux-nfs@vger.kernel.org>; Fri, 03 Apr 2020 20:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JKl0SvnLAUkLiqnBo6JOuGYJiEqEsbOssjtoOxkju/U=;
        b=LCM74AgeiaLCOvardDRen/5lB49UYwRg3uPdivj8Cu6Yt4kMX/6LvmnWVhdnCuTZzP
         KJF8Yw5F1BTNHSzSizQn36u7lVKJTvUpnaDWGB0J97bbSlMAl4ZR5rNdcyyAyS/WaNhJ
         pZ2utaZTCxfaZmZix2mqsh3OFgQ0aTOrliOC3yt1MrY17bp5JxM4zkI4XIyjM14yRXcU
         oKTQ7xDHaa4zN6S/fYz/PI0E1H7bJoZPfCx4E65P7ZTHGZ5Sca1/3PqnDHZJUPfDryfS
         eKdSrT4WJFLRPtPmddoIjpFvGw64P3mjI0tsQmQp0qkHfjDazTScXeiB+OZ986HcnAq/
         P88A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JKl0SvnLAUkLiqnBo6JOuGYJiEqEsbOssjtoOxkju/U=;
        b=O14xqTmezEboXxd57jVFQfe9mWyA5Modwq/D6CvW3YPZBaw6x214CY32gQrR+aVxtY
         XWuDIsYEPoYyAUSmqqB6jZe9j1VRzAoTMnaOnZEqdPNifq/T8vmdrrP1OXlgI8DTw5k0
         xbZmCM/jiX/vjkZW3B3BtZqGSlddf0Oxah+akz6n1oGnkvPzCwuTU8U4yTlbfHDWGJsj
         ns02Hk7J9L22HxnoJ7szM/amJ/fyuyc1wJwMCpKZ8Qdj/u8/wbpFJ42Myw4KKrsswUAN
         yvsoQJT+uJOTjLInpc76ymhImaILeSvFcpCpbbCxxvejNrhHihOHNEITolKjKXjWYCwt
         9FIg==
X-Gm-Message-State: AGi0Pua95N+xWSxgjwwFZkQBlZSM7G+Taqi6xngcvncmwSaaF5pnhcbK
        1JqsUuWKjucoBhhSbVw6OJv5byWH394=
X-Google-Smtp-Source: APiQypIYUySl9xwACXswFJBufPg/nuP0FFk8E8ES4FGsSHMHts+6y4Tk/2AE6jYY4a58Iw9xJJPJ5g==
X-Received: by 2002:a17:90a:8d0c:: with SMTP id c12mr13145198pjo.170.1585969360216;
        Fri, 03 Apr 2020 20:02:40 -0700 (PDT)
Received: from localhost.localdomain (astound-69-42-19-227.ca.astound.net. [69.42.19.227])
        by smtp.gmail.com with ESMTPSA id x27sm6747294pff.200.2020.04.03.20.02.38
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 20:02:39 -0700 (PDT)
From:   Rosen Penev <rosenp@gmail.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] nfs-utils: tools: use nls.h
Date:   Fri,  3 Apr 2020 20:02:38 -0700
Message-Id: <20200404030238.505115-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.25.1
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

