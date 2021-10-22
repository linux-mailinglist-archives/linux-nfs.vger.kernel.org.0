Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01663437FAE
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Oct 2021 22:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234328AbhJVU6a (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Oct 2021 16:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234190AbhJVU63 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Oct 2021 16:58:29 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBFFC061766
        for <linux-nfs@vger.kernel.org>; Fri, 22 Oct 2021 13:56:11 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id r17so4656778qtx.10
        for <linux-nfs@vger.kernel.org>; Fri, 22 Oct 2021 13:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kb6sz5NU2w3wY8Uj3W+ORmwjW8uJ0z9LSlhatxIurXA=;
        b=jV9/xcdG6CSzQmgL4ZZln23s/4+erFjXwlVL/dWK0CYIsffbBFoc78iPjBWzAyOWa4
         9u2OgPgHvgs9ZnfLZqFxs6MTkDVgsVezlqQnTKNvCzQ9XqtBI/oDSVspJpuDNZ4P2cql
         B0pBoDFOKei4XS3xYmouCL/mtmchIPcsrHbqBOe6KtUADsQEKUNMHUOTpeGkMYJOl2cU
         zwkw4D25mkZz0aFvd+IRrb7cdC0AgKJU6jG38iuoTNHdYIMG84Ht6xiCDvHvFLpB0nO9
         dSwIB6LEGYg/oEMeDFeZY5vNXpY8RBHYbuaNiH7dvBhoPaADFqf+7VObqqT8QANcdbRM
         GLuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Kb6sz5NU2w3wY8Uj3W+ORmwjW8uJ0z9LSlhatxIurXA=;
        b=ONs49oz1zWzKq7opaHdyFspsobulRd0hHJKvArNdUUGjJVpr/tLZZdHT9/zReeIg1e
         xbDDvuC3L/7+ofrs1JT73SwhM9o60K35O0+GHW3lyo7w9H+5GeEw60us1rDtRUOEBshs
         V6bx20yUg7XIwEOIIOGY6ord3KPf+urWzieN7MAMwBcjLPvTPJqQ+YGzNGV37qis9lmz
         RVrzRe7quOKyX+k2voTBZYbPMKcmsqiuZVusdWVNeKnI+s0b4Alt9FVbWfUGnx7DJ3RO
         rQ4lSum1ORebtU9g5pGVbLbocRnK+0nuSUTap9gZ1tRZb55t9ERPdD7WNpZ7OGNKByMG
         3DDQ==
X-Gm-Message-State: AOAM533G+LT2IfjhGtRwYn9Bqav2oCBkTSsPqlhuNFnZHdDVbJZ3ESmE
        5VhhGaaOvxA2gxQpm5tviPk=
X-Google-Smtp-Source: ABdhPJyyxlQXPnH1nTDJ3wwM+yZaPxuwBtOV3Ghpjk2nskE+2wz9e6VChDIVdOI53ARiTdQXyemnHA==
X-Received: by 2002:ac8:57c3:: with SMTP id w3mr2427721qta.132.1634936170516;
        Fri, 22 Oct 2021 13:56:10 -0700 (PDT)
Received: from gouda.nowheycreamery.com ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id p9sm4576279qki.51.2021.10.22.13.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 13:56:10 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v4 4/9] rpcsys: Add a command for printing rpc-client information
Date:   Fri, 22 Oct 2021 16:56:01 -0400
Message-Id: <20211022205606.66392-5-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211022205606.66392-1-Anna.Schumaker@Netapp.com>
References: <20211022205606.66392-1-Anna.Schumaker@Netapp.com>
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
 tools/rpcsys/client.py | 27 +++++++++++++++++++++++++++
 tools/rpcsys/rpcsys.py |  2 ++
 tools/rpcsys/switch.py |  7 ++++---
 3 files changed, 33 insertions(+), 3 deletions(-)
 create mode 100644 tools/rpcsys/client.py

diff --git a/tools/rpcsys/client.py b/tools/rpcsys/client.py
new file mode 100644
index 000000000000..5192cc226aed
--- /dev/null
+++ b/tools/rpcsys/client.py
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
diff --git a/tools/rpcsys/rpcsys.py b/tools/rpcsys/rpcsys.py
index dfad6ac08fa0..e2172cdfa4c1 100755
--- a/tools/rpcsys/rpcsys.py
+++ b/tools/rpcsys/rpcsys.py
@@ -10,9 +10,11 @@ def show_small_help(args):
 parser.set_defaults(func=show_small_help)
 
 
+import client
 import switch
 import xprt
 subparser = parser.add_subparsers(title="commands")
+client.add_command(subparser)
 switch.add_command(subparser)
 xprt.add_command(subparser)
 
diff --git a/tools/rpcsys/switch.py b/tools/rpcsys/switch.py
index afb6963a0a1f..5384f970235c 100644
--- a/tools/rpcsys/switch.py
+++ b/tools/rpcsys/switch.py
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
2.33.1

