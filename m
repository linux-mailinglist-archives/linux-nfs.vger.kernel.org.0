Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B5E39FE1E
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jun 2021 19:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbhFHRuA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Jun 2021 13:50:00 -0400
Received: from mail-qk1-f177.google.com ([209.85.222.177]:46808 "EHLO
        mail-qk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233821AbhFHRt7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Jun 2021 13:49:59 -0400
Received: by mail-qk1-f177.google.com with SMTP id f70so5820240qke.13
        for <linux-nfs@vger.kernel.org>; Tue, 08 Jun 2021 10:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4zJwskrhg2xmjIMfnlMJyQayKAwR6dqMI8RYPyrldHg=;
        b=G2XVAkNfsE2H48ajOG59ysiXM8URgdDTSZEGZDTHRHTY/AyGrdfDPM1uOPhePQgq52
         C4dpYl+jU6cakMd12wIZXxvQ8WrUG89msGPlOyX1v12LLZ8JxfEuCnKRJCytIsG8rinG
         J55+zkixWbuZ9Obvy1khFvX/iC20QtMZJyHHzwfIZXTMXydRR8Z7I9XVDuCOlHuveWmG
         VHmPh3QIRX61o9XC+dpYojyUWHjEX9DxOP9WXA95d3ahj9s8eW4LhzgVJz8kuVH8Izg4
         r+OWGCMH9p1FXFLO7gtCZbMgF1BxwFInIpcte9RGRnR/NMlVvU2c+U6R5XkbkSrQ9WkG
         lvQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=4zJwskrhg2xmjIMfnlMJyQayKAwR6dqMI8RYPyrldHg=;
        b=CjuIqpNdnLSloOtJXYkCmPQwtUARFmkrDGwYqfHkWJxGEwLxVhjT+ld/s3I5BQHWpC
         CQtSOD3WX19jWox9PGmRbtgWjgEKyQHLi7cyvXHltYNoJ6sqXY1LzsyfiN/A6XintB1K
         jIHcQRVzLkmF+11wbPUDjuoEs7rMmjEbpStW6vNDSBYwoaA5LjDLt0i7aaOuVH3pGWba
         2eTA1NCgVK8A5vT2Fjc6ifHUjbAozgjbHzxXwW5oqnWbPFLV5Xjk6QKrsHPfdYyuvkmr
         HLPzgQ6SxMlZS6kYOmUselVJ+5Q185oeOhwj69dOnbS7KMyGH/Db+vMdjk2X7dSQ4/YD
         Kk7w==
X-Gm-Message-State: AOAM531x9hAF/cJwY/3ODmnxWopfzV0CZR99iPN01xuoT0V7XK2I6TJW
        PGDKld3jhsY2PHs1cHyt5dxDmn3fYpU=
X-Google-Smtp-Source: ABdhPJxVEyR8A3MJNykG2W3iaDshS9ezryCtYkv1foVUu5bjLH9CBesxOA6zS2WrZRgRIWGBjtFlgg==
X-Received: by 2002:a37:a548:: with SMTP id o69mr16965902qke.376.1623174419888;
        Tue, 08 Jun 2021 10:46:59 -0700 (PDT)
Received: from localhost.localdomain ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id h2sm12963080qkf.106.2021.06.08.10.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 10:46:59 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [RFC PATCH 1/6] nfs-sysfs: Add an nfs-sysfs.py tool
Date:   Tue,  8 Jun 2021 13:46:52 -0400
Message-Id: <20210608174657.603256-2-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210608174657.603256-1-Anna.Schumaker@Netapp.com>
References: <20210608174657.603256-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

This will be used to print and manipulate the sunrpc sysfs directory
files. Running without arguments prints both usage information and the
location of the sunrpc sysfs directory.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 tools/nfs-sysfs/nfs-sysfs.py | 13 +++++++++++++
 tools/nfs-sysfs/sysfs.py     | 18 ++++++++++++++++++
 2 files changed, 31 insertions(+)
 create mode 100755 tools/nfs-sysfs/nfs-sysfs.py
 create mode 100644 tools/nfs-sysfs/sysfs.py

diff --git a/tools/nfs-sysfs/nfs-sysfs.py b/tools/nfs-sysfs/nfs-sysfs.py
new file mode 100755
index 000000000000..8ff59ea9e81b
--- /dev/null
+++ b/tools/nfs-sysfs/nfs-sysfs.py
@@ -0,0 +1,13 @@
+#!/usr/bin/python
+import argparse
+import sysfs
+
+parser = argparse.ArgumentParser()
+
+def show_small_help(args):
+    parser.print_usage()
+    print("sunrpc dir:", sysfs.SUNRPC)
+parser.set_defaults(func=show_small_help)
+
+args = parser.parse_args()
+args.func(args)
diff --git a/tools/nfs-sysfs/sysfs.py b/tools/nfs-sysfs/sysfs.py
new file mode 100644
index 000000000000..0b358f57bb28
--- /dev/null
+++ b/tools/nfs-sysfs/sysfs.py
@@ -0,0 +1,18 @@
+import pathlib
+import sys
+
+MOUNT = None
+with open("/proc/mounts", 'r') as f:
+    for line in f:
+        if "sysfs" in line:
+            MOUNT = line.split()[1]
+            break
+
+if MOUNT == None:
+    print("ERROR: sysfs is not mounted")
+    sys.exit(1)
+
+SUNRPC = pathlib.Path(MOUNT) / "kernel" / "sunrpc"
+if not SUNRPC.is_dir():
+    print("ERROR: sysfs does not have sunrpc directory")
+    sys.exit(1)
-- 
2.32.0

