Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 210DE3E3038
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Aug 2021 22:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244832AbhHFUSA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Aug 2021 16:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbhHFUR7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Aug 2021 16:17:59 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73BCC0613CF
        for <linux-nfs@vger.kernel.org>; Fri,  6 Aug 2021 13:17:42 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id h27so7363373qtu.9
        for <linux-nfs@vger.kernel.org>; Fri, 06 Aug 2021 13:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xBbv87HeL7vxd5hlOBy/XvTz1626I03fsVDJ5SL9qM0=;
        b=m2S4bNoEmHwYy/ReroU37YgQCGvNKWkDyUL9Se26iwa6z4yQyZyM6MFM7M7pQsWq/+
         ataVpe2vxFKhSiSAVMJLbBO3J8SKsWqjc3HEx6W94kt7lpz8ph2yOjUWeDhpJXsROVXC
         Z4IaVt9S38wRGIFdPd/1DQDLSb7j+AVtrKq9rtUAvbj/L+qwjKlw2GwkEygwfFHPiY5R
         FGZmHroHLRsdxrvESjOgobL2N4FUBLzWAcJ6GzwnIyR57F7dDB5o7Z2MZdiN84rhLYEj
         jhGQsy83/ZUxhI+ohx8GsYt/ZqRh0V+QSLwNHtrFVo4BlKpoMdWVdsoJYMjqSO2HFqmi
         YjSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=xBbv87HeL7vxd5hlOBy/XvTz1626I03fsVDJ5SL9qM0=;
        b=EWjIOuSlE1eNdO6lphJbvwt6d2zTQHQ1b2tTsNsc+CYss7iVYDS8AHl5Tt/2cMsKps
         PbUE7jaQf355bupAP0LdqBYpmITOBw43PpzrGD1IvG+eriwJXurHOPgt0MIBpY2nGGeL
         wGwddnD43sYjKuQ/ypJIT6qWSXhmHVEyaTjZT6JEJMnrmhmd1IRddI4Z1jx8CGMzGcPe
         RBSrQkRB6gAV3ETImFBdsgZjgMj3T8BuQAP2wOrksSzZMtzWj2I7IVMrY8eSvBsm1aeA
         +GsVgw9lf+5sjWOnOmriLvXGbcOLrtU38AQ8eM8WfWnEdiuuUoNqeheWMA3oZ8gbmGXy
         AKCA==
X-Gm-Message-State: AOAM532h0LLQLgudSC446lMZrgXl168lkx/10hfv7pIrlIbzrr9cm3lx
        gWPyUJQvXwKptEnpeUCHqrv1mMVYXKoBPQ==
X-Google-Smtp-Source: ABdhPJyPjS4vFnfwJWvWBois4iW6xiHQJfkWNTJOVtqIKfDrJNFElrUJkDT5G7C2j3IpJ6h1BRV60A==
X-Received: by 2002:ac8:7a98:: with SMTP id x24mr10561530qtr.42.1628281061931;
        Fri, 06 Aug 2021 13:17:41 -0700 (PDT)
Received: from localhost.localdomain ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id g11sm3705720qtk.91.2021.08.06.13.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 13:17:41 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v2 1/9] nfs-sysfs: Add an nfs-sysfs.py tool
Date:   Fri,  6 Aug 2021 16:17:31 -0400
Message-Id: <20210806201739.472806-2-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210806201739.472806-1-Anna.Schumaker@Netapp.com>
References: <20210806201739.472806-1-Anna.Schumaker@Netapp.com>
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
 .gitignore                   |  2 ++
 tools/nfs-sysfs/nfs-sysfs.py | 13 +++++++++++++
 tools/nfs-sysfs/sysfs.py     | 18 ++++++++++++++++++
 3 files changed, 33 insertions(+)
 create mode 100755 tools/nfs-sysfs/nfs-sysfs.py
 create mode 100644 tools/nfs-sysfs/sysfs.py

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

