Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA59E39FE1D
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jun 2021 19:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbhFHRt4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Jun 2021 13:49:56 -0400
Received: from mail-qt1-f177.google.com ([209.85.160.177]:42532 "EHLO
        mail-qt1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233843AbhFHRt4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Jun 2021 13:49:56 -0400
Received: by mail-qt1-f177.google.com with SMTP id v6so7014736qta.9
        for <linux-nfs@vger.kernel.org>; Tue, 08 Jun 2021 10:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VXO6A1fFPYXH5Z8ZqtWOt/eu1D5T/QlkTGPxMiAjCkY=;
        b=f8q9o4AKu+5vJSZwSvTndNsy1iKfxFbxQm5KQfw4UyLgnDRtaI9OgAZtG6173wwFbp
         qM4R59MT9cOVmtdAB461BebnPNvOlZ1qrt5CL2OHckLIo21jbU985zBBsgi199+Guski
         zFoVGkg9W7ID0hzzNMrNvXm26UxXA86AP4T1+77xekaBfaL/c2M2If+ZKV2kLMljGCI5
         N7qweu2Tr6mpRo0fJVbpcXezPCuAZ0EnfkS9LrZUFOXqLfkJeMdSXBXzgoMSLumBmgfC
         yiNNzDqx2V3Ff+sOCCJjPbwofPAuBUO/CbJ+XsEkKZrrBOeqXGWDP9AMH7nfE4i+FRBI
         nItw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=VXO6A1fFPYXH5Z8ZqtWOt/eu1D5T/QlkTGPxMiAjCkY=;
        b=YToU2Z97i7+vohVVe395AH3NrzlpKLRmrcWdl8SfkoqVO21RlZ4RIbDcs/vWyB+piB
         juf7zPTHEAvUCuZxMRNG6Nx6CP+hY7rTB/rmPYdJ+FgC+42xdxp4KN8xwher3+JsOHMe
         9bO/CSEI49EaRYYDYFKLgonfVAbLl2PHl2b/67PUD05OVwZV6kQbXvIcX6n4uBwylq+T
         vHZFh707nD76csYQRVLLW0Qd0ZmvlGW9cMKIdpCtQh2Uq9JrKyiCI5m4CO1vqpwuHAtL
         IzP4a2e/b7B8ApBgpq1h+Ab9orCl5gm84xqoit1lvymsRIF4JcYKxQur7gdm+GLrRm95
         KzBw==
X-Gm-Message-State: AOAM532/qQ6n7tamxnnvwe+ZQzSgdCs713sjYc/afkTdF3SxNas49lxb
        jua3lPMuDDV+dJVTz/LzlFa0kfRLfCc=
X-Google-Smtp-Source: ABdhPJwhVLo6vdmwiveE3wJkGWBUAZQtmqVtOfPYmxA4+1QHAAOL7o3/EsUB1Bxsnr9poLaTJ48LeA==
X-Received: by 2002:ac8:6f37:: with SMTP id i23mr23006262qtv.376.1623174422281;
        Tue, 08 Jun 2021 10:47:02 -0700 (PDT)
Received: from localhost.localdomain ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id h2sm12963080qkf.106.2021.06.08.10.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 10:47:01 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [RFC PATCH 4/6] nfs-sysfs.py: Add a command for printing rpc-client information
Date:   Tue,  8 Jun 2021 13:46:55 -0400
Message-Id: <20210608174657.603256-5-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210608174657.603256-1-Anna.Schumaker@Netapp.com>
References: <20210608174657.603256-1-Anna.Schumaker@Netapp.com>
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

