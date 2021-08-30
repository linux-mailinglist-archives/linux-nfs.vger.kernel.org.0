Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 763183FB97A
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Aug 2021 17:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237629AbhH3P6A (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Aug 2021 11:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237711AbhH3P5u (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Aug 2021 11:57:50 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3455DC06175F
        for <linux-nfs@vger.kernel.org>; Mon, 30 Aug 2021 08:56:57 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id b64so16315550qkg.0
        for <linux-nfs@vger.kernel.org>; Mon, 30 Aug 2021 08:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TElF6VSe1gc+dQ6uYO+dXFuLYzgXdsWmKiU8G6WAdWc=;
        b=vDoVqW50vmIsbU/7+07li24efH/bx/mIMkmiZnF4srEFA9RUZV3/idQ6RsztYAT9x5
         Y+xYJcmYVFjUiiSmov6YHEFJV98dwitcSfsqS0pvL0shBaMkz7V4XcReNs5hcazMVbco
         HpSuelFjEGOt6knktnwNdM25AqNs2tDm4uKCyifebuBX3zfldHKiXeYBDi2b/0qnjf8u
         MLkU0xOLg267YlgzkmYAAi/Dz3oGqqHDDPTxfWG3KHYBYVWbNjP5B1p/qD4tfzCBueiz
         ddmcqj+gP6k8lL84QdRAZnQUTWXLU59Y4yNTfsEEDgF4rJyKC/71Dd63CVqaULP0UbKd
         tytQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=TElF6VSe1gc+dQ6uYO+dXFuLYzgXdsWmKiU8G6WAdWc=;
        b=kCMgzCSB1Ixn090+rVKQGBVv0L4vOhvlq1t+qlq4IMXQWM5FUFV3fz2QyQxR4lIG/E
         APpibVVirjZg05/xRHqBN+VgLuf704YSPCTCZjkN3xWQFshsZvgEy49vGnjvJtlw051N
         6NUPliu3tCD3GPsM2SB2CAkx9Gl/d3D2dRTNAa6i9SH5u7zrE6w2P3r8UambJSvTQNQT
         5m9Xc7y+pNT4IIvD5i2o3zV7jHP1a867rvi4NfcTtjh3wrY7nJysYSC4o1QE3LRbKr4o
         g5K4dsZ2X7ZOroiNRkIFLNdDwIUPnjPkeIbalNZCvRbFwFjEbX/m+3vaIeHgy9zC0ecE
         Vivw==
X-Gm-Message-State: AOAM533HNhuWULyZ9PuHGuHClFxZ7y0LaBp/wWudB3AT0pm6i1FS2Gc5
        CUUBcmTvh3yGvhup3UEqC+I=
X-Google-Smtp-Source: ABdhPJw7cT8t3cmhbR9odwGnixM2ta4zz0qBKwVf1lRh3sOR9k8JV6aJTu8RKlHGicBg6ZGZnXPpJg==
X-Received: by 2002:a05:620a:b83:: with SMTP id k3mr22388363qkh.420.1630339016317;
        Mon, 30 Aug 2021 08:56:56 -0700 (PDT)
Received: from localhost.localdomain ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id 12sm8585217qtt.16.2021.08.30.08.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 08:56:55 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v3 1/9] nfssysfs: Add a nfssysfs.py tool
Date:   Mon, 30 Aug 2021 11:56:45 -0400
Message-Id: <20210830155653.1386161-2-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210830155653.1386161-1-Anna.Schumaker@Netapp.com>
References: <20210830155653.1386161-1-Anna.Schumaker@Netapp.com>
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
v3: Check for type: "sysfs" as the third column in the /proc/mounts file
    Rename from nfs-sysfs.py to nfssysfs.py
---
 .gitignore                 |  2 ++
 tools/nfssysfs/nfssysfs.py | 13 +++++++++++++
 tools/nfssysfs/sysfs.py    | 19 +++++++++++++++++++
 3 files changed, 34 insertions(+)
 create mode 100755 tools/nfssysfs/nfssysfs.py
 create mode 100644 tools/nfssysfs/sysfs.py

diff --git a/.gitignore b/.gitignore
index c89d1cd2583d..a476bd20bc3b 100644
--- a/.gitignore
+++ b/.gitignore
@@ -84,3 +84,5 @@ systemd/rpc-gssd.service
 cscope.*
 # generic editor backup et al
 *~
+# python bytecode
+__pycache__
diff --git a/tools/nfssysfs/nfssysfs.py b/tools/nfssysfs/nfssysfs.py
new file mode 100755
index 000000000000..8ff59ea9e81b
--- /dev/null
+++ b/tools/nfssysfs/nfssysfs.py
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
diff --git a/tools/nfssysfs/sysfs.py b/tools/nfssysfs/sysfs.py
new file mode 100644
index 000000000000..c9d477063585
--- /dev/null
+++ b/tools/nfssysfs/sysfs.py
@@ -0,0 +1,19 @@
+import pathlib
+import re
+import sys
+
+MOUNT = None
+with open("/proc/mounts", 'r') as f:
+    for line in f:
+        if re.search("^sys ", line):
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
2.33.0

