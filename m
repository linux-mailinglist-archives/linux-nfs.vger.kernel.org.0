Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E82C3E303B
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Aug 2021 22:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244827AbhHFUSC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Aug 2021 16:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244840AbhHFUSC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Aug 2021 16:18:02 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FBCC0613CF
        for <linux-nfs@vger.kernel.org>; Fri,  6 Aug 2021 13:17:46 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id b1so7442038qtx.0
        for <linux-nfs@vger.kernel.org>; Fri, 06 Aug 2021 13:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VXO6A1fFPYXH5Z8ZqtWOt/eu1D5T/QlkTGPxMiAjCkY=;
        b=c1cpU4MJGCw4qj6FAb6fdmZXSm6vvsCV8XYOXq6DEufcJnUPBjASRIbAA9w6al07ku
         jt1ZmXhq2FOMSyOW8Z7fsTHfiTrUpCD0rGMw6KTn7oOXfSrAISAgLDb1z7Y7Av7anxq3
         4q7tOPOESfdSE7o3b1+I1ebgTud8fVrXmOtDTiMWQNACZ+USkZevydWfOs+O1VoXLIZz
         PXL8YK0eL7CRFl4oQsO8kw2UErGqnYpq0YxXMowp0c64MJslU8dc5TfPiNBkLmI+1FVc
         lvw2BX7klwMY0ihx5zBHBmloNcMfx6g1FAA+hDYpM3vP5vZA7ACU3gYLDrxBfA3SlUmv
         icuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=VXO6A1fFPYXH5Z8ZqtWOt/eu1D5T/QlkTGPxMiAjCkY=;
        b=Q926wDvZ4Gv/Z7IF1FQF3+frEFjsyDXdQajQ2tUrjkiNUnrM1BKx3gs0CdUAOToAKM
         wQBrDzdc+PZ0MrUiFtzKPd6ROz2kbcEtjyLijdOW7UV9h/Lq/A6qKQSuhYMnv0FbP9V6
         vgXcror6DyDcQp0ND0UzPHBU+92tev/Mh7T+iQNPQ1b0/fdi0lwfip2703vZCMQwPnja
         708gZ1lQ6zFY8HwBM/xsu2hlgHxzqa2Z9ZivBP1LovyI6OHBmySKIfBPxmgbWOM8ATnW
         oRMzlhy6dFpZ4UnkR7MTaD30g/2AkOIh9RC3LFmLsv9UxbIiK5VeFfcEyGstHBvbatkX
         bhQw==
X-Gm-Message-State: AOAM530HIh2B7odyXtiXgu5/MPUSaJYq4AWcVLDRQ5+k4pP1QAbnZgDk
        9wZ4yHTWy8LtT5GbSOq8NOEfqluJm9GD+g==
X-Google-Smtp-Source: ABdhPJwERcHdRGbOZStp5Xccg/HFZq0lCrZ2IwY4mxiK52JQT8lAqio7dz3g00CCRDrv89HzwCuZpA==
X-Received: by 2002:a05:622a:199e:: with SMTP id u30mr8016086qtc.22.1628281065153;
        Fri, 06 Aug 2021 13:17:45 -0700 (PDT)
Received: from localhost.localdomain ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id g11sm3705720qtk.91.2021.08.06.13.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 13:17:44 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v2 4/9] nfs-sysfs.py: Add a command for printing rpc-client information
Date:   Fri,  6 Aug 2021 16:17:34 -0400
Message-Id: <20210806201739.472806-5-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210806201739.472806-1-Anna.Schumaker@Netapp.com>
References: <20210806201739.472806-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

It's mostly the same information as with xprt-switches, except with
rpc-client id prepended to the first line.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 tools/nfs-sysfs/client.py    | 27 +++++++++++++++++++++++++++
 tools/nfs-sysfs/nfs-sysfs.py |  2 ++
 tools/nfs-sysfs/switch.py    |  7 ++++---
 3 files changed, 33 insertions(+), 3 deletions(-)
 create mode 100644 tools/nfs-sysfs/client.py

diff --git a/tools/nfs-sysfs/client.py b/tools/nfs-sysfs/client.py
new file mode 100644
index 000000000000..5192cc226aed
--- /dev/null
+++ b/tools/nfs-sysfs/client.py
@@ -0,0 +1,27 @@
+import sysfs
+import switch
+
+class RpcClient:
+    def __init__(self, path):
+        self.path = path
+        self.id = int(str(path).rsplit("-", 1)[1])
+        self.switch = switch.XprtSwitch(path / (path / "switch").readlink(), sep=",")
+
+    def __lt__(self, rhs):
+        return self.id < rhs.id
+
+    def __str__(self):
+        return "client %s: %s" % (self.id, self.switch)
+
+
+def list_rpc_clients(args):
+    clients = [ RpcClient(f) for f in (sysfs.SUNRPC / "rpc-clients").iterdir() ]
+    clients.sort()
+    for client in clients:
+        if args.id == None or client.id == args.id[0]:
+            print(client)
+
+def add_command(subparser):
+    parser = subparser.add_parser("rpc-client", help="Commands for rpc clients")
+    parser.add_argument("--id", metavar="ID", nargs=1, type=int, help="Id of a specific client to show")
+    parser.set_defaults(func=list_rpc_clients)
diff --git a/tools/nfs-sysfs/nfs-sysfs.py b/tools/nfs-sysfs/nfs-sysfs.py
index dfad6ac08fa0..e2172cdfa4c1 100755
--- a/tools/nfs-sysfs/nfs-sysfs.py
+++ b/tools/nfs-sysfs/nfs-sysfs.py
@@ -10,9 +10,11 @@ def show_small_help(args):
 parser.set_defaults(func=show_small_help)
 
 
+import client
 import switch
 import xprt
 subparser = parser.add_subparsers(title="commands")
+client.add_command(subparser)
 switch.add_command(subparser)
 xprt.add_command(subparser)
 
diff --git a/tools/nfs-sysfs/switch.py b/tools/nfs-sysfs/switch.py
index afb6963a0a1f..5384f970235c 100644
--- a/tools/nfs-sysfs/switch.py
+++ b/tools/nfs-sysfs/switch.py
@@ -2,9 +2,10 @@ import sysfs
 import xprt
 
 class XprtSwitch:
-    def __init__(self, path):
+    def __init__(self, path, sep=":"):
         self.path = path
         self.id = int(str(path).rsplit("-", 1)[1])
+        self.sep = sep
 
         self.xprts = [ xprt.Xprt(p) for p in self.path.iterdir() if p.is_dir() ]
         self.xprts.sort()
@@ -15,8 +16,8 @@ class XprtSwitch:
         return self.path < rhs.path
 
     def __str__(self):
-        line = "switch %s: num_xprts %s, num_active %s, queue_len %s" % \
-                (self.id, self.num_xprts, self.num_active, self.queue_len)
+        line = "switch %s%s num_xprts %s, num_active %s, queue_len %s" % \
+                (self.id, self.sep, self.num_xprts, self.num_active, self.queue_len)
         for x in self.xprts:
             line += "\n	%s" % x.small_str()
         return line
-- 
2.32.0

