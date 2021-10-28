Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB9CE43E85D
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Oct 2021 20:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbhJ1Shv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Oct 2021 14:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbhJ1Shu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Oct 2021 14:37:50 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6874DC061570
        for <linux-nfs@vger.kernel.org>; Thu, 28 Oct 2021 11:35:23 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id t40so6665194qtc.6
        for <linux-nfs@vger.kernel.org>; Thu, 28 Oct 2021 11:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZVRoHY9JRFv/k1KUIzj+9BKZjG6smOlHa2LwVuVuuP4=;
        b=gQwQH/AWEZDGimIdAkVKMDnLdJMEQzzhkKVsX33YiJI6sFbImtyyb9mkpzNd9DgLI0
         /PkxusnllDjyhIV0BraDWjb94KLot6iY3C3MTT+jHB7Zy+QaT2k304jYdoaR8yBlK9qk
         1biq7YGPxMSyFRkD3ZJXYYKqZcRrAzuLBBDOiMKQxyROuMQNyJXBbbNz5kOjEoAks8f+
         g6j0OI1o+E1NKX/lNMPvXC9g43PrpFDaxGX9OA8mzlzx9YMRXr/OQK+tH5CUw9zMPNSx
         603f/LdXAsvHHNZzDnujyM56vI6QZZxpRIbN6KfbbJyeU1rhTVY4k0BR5lP6SJtky7Au
         uY8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ZVRoHY9JRFv/k1KUIzj+9BKZjG6smOlHa2LwVuVuuP4=;
        b=G8JXrv/ZU4u1D94FFI+h/Y7GPnGmAGyUuMHRmTrR19UQvh2UyuRLE0T2FQVLWDm6oO
         xp5LEnqMNNY6+knRmFN/+k/e1SlbXYqbEGNLQKmVVi0/ncZLt4YloChKmsTLzNEP0/ut
         hKFtOna2EOO27GHRi+De28YCAYCL5CoZB3fdcbYmZM08TZUH+G9T4HK2EFTLHaDXMp7g
         pEirazkNAOZs7Em5O73X4BBSn/eKnkoW7y/TXJN8TsL4Nj7gtMsJXZmCt0dkKdIop1/i
         8bj3MQJ3MqtzZrYTrGaulZkdWafN4uLalU9tdtRmTPNcXrrr9LNVYQ3MDThbjY1ocgZf
         ajFg==
X-Gm-Message-State: AOAM530Fobaicoyyg5NstR4w3QBzUY4PhgHAim2GuIJwUC9z5iCkX6Br
        b+yfx29NDIGvoNBYgfPuQ3R3/dJgk1M=
X-Google-Smtp-Source: ABdhPJw7YSuw2xSvY8lKs5ygRIsAEQgCtt8nVI/yIkODKrkHPZ0zhFLlH5A6iYLN+aw7ffZwwrbjRg==
X-Received: by 2002:ac8:1e06:: with SMTP id n6mr6523660qtl.365.1635446122323;
        Thu, 28 Oct 2021 11:35:22 -0700 (PDT)
Received: from gouda.nowheycreamery.com ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id q13sm2556476qkl.7.2021.10.28.11.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 11:35:22 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v5 1/9] rpcctl: Add a rpcctl.py tool
Date:   Thu, 28 Oct 2021 14:35:11 -0400
Message-Id: <20211028183519.160772-2-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211028183519.160772-1-Anna.Schumaker@Netapp.com>
References: <20211028183519.160772-1-Anna.Schumaker@Netapp.com>
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
 .gitignore             |  2 ++
 tools/rpcctl/rpcctl.py | 13 +++++++++++++
 tools/rpcctl/sysfs.py  | 19 +++++++++++++++++++
 3 files changed, 34 insertions(+)
 create mode 100755 tools/rpcctl/rpcctl.py
 create mode 100644 tools/rpcctl/sysfs.py

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
diff --git a/tools/rpcctl/rpcctl.py b/tools/rpcctl/rpcctl.py
new file mode 100755
index 000000000000..8ff59ea9e81b
--- /dev/null
+++ b/tools/rpcctl/rpcctl.py
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
diff --git a/tools/rpcctl/sysfs.py b/tools/rpcctl/sysfs.py
new file mode 100644
index 000000000000..c9d477063585
--- /dev/null
+++ b/tools/rpcctl/sysfs.py
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
2.33.1

