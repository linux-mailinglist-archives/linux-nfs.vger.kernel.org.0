Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1810E3FB97F
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Aug 2021 17:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237815AbhH3P6C (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Aug 2021 11:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237723AbhH3P5y (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Aug 2021 11:57:54 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0F4C0613D9
        for <linux-nfs@vger.kernel.org>; Mon, 30 Aug 2021 08:57:00 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id m21so16120670qkm.13
        for <linux-nfs@vger.kernel.org>; Mon, 30 Aug 2021 08:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2HQsV1Lb5bqQh7jnJ54wWFpeDSoRXnVa5uQ5o2BzLvY=;
        b=Dq43En5lhA7sREJRIjZzwUH6Lxa+2LncoznjU+M8ED/cpFtcBht0bqg3yHa737WAP/
         OXoTZ3mg8mWkcGS/bYa6v7QJSV4gVxZFpZpFd9LPcBcZ71M6WTIS1U+TtVcerQcGWa+z
         YMB+zj3U6JtPhUo3+rpMKbEWTiNdtrnrwgXyyWim5lxlFQlOkoH5HvHneRcOiX/fxSZ7
         vnvdso/o1p1U2aXWa7UdZz2yPoVkQ2OflcUD+/oH5TqUCaUeVI/DuZ4UoMYc2YkWsmsd
         0AKUGSru2xqgA9olRUuyEt7/uR57JjcWTDW+3t6osfF/Vn3MAd22DrPdSGTA9I4/jMsp
         UDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=2HQsV1Lb5bqQh7jnJ54wWFpeDSoRXnVa5uQ5o2BzLvY=;
        b=DNPZT6oRCC/6h5wXg1nTopP4bvIuLY+f3UoDcmvpWuwBRNw04+fYmr7A9PO+EFSvYd
         PDuWNmbVjeoW1hL/XvUyyNBd96/BJ5U2kb1pqQ0c3uv0GjxJKCNiElMvzixbdgmnuuqr
         jJBGQZ3cYYPXot6PQByi5Qw7pwh1BOsxh3om5xaUmu1fhk0QNgh7DrwDxvbPZgUAZlGV
         Fr17RGos/2WRT5oeorfVUQIa3HfAuSz8huBM9nEe5RhVrbYx3rIy4LncPsc8jB3i5Vu9
         nNcIE5k7+rW9I02s3rx2HkKTeaFAxNmKQDzdJidc3QdJLhBdWxmEv31+NZO4CyLSk2uQ
         /t+w==
X-Gm-Message-State: AOAM532zUbG+WcvqY2XZ9PVpeYF09BaX5kHAV8oli1FRTcFLh/L9Ikp8
        +4YHbw+GGNY0buOD/XrK0fgVdckUJwt0xQ==
X-Google-Smtp-Source: ABdhPJw5BQsgz01CzLbk+utiNpYiXUYYwgEHRSQQuQcQr/lzrrDc1GH/iFHfnCVHeLeisL/0IFlNpw==
X-Received: by 2002:a37:989:: with SMTP id 131mr23919007qkj.472.1630339019776;
        Mon, 30 Aug 2021 08:56:59 -0700 (PDT)
Received: from localhost.localdomain ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id 12sm8585217qtt.16.2021.08.30.08.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 08:56:59 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v3 4/9] nfssysfs.py: Add a command for printing rpc-client information
Date:   Mon, 30 Aug 2021 11:56:48 -0400
Message-Id: <20210830155653.1386161-5-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210830155653.1386161-1-Anna.Schumaker@Netapp.com>
References: <20210830155653.1386161-1-Anna.Schumaker@Netapp.com>
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
 tools/nfssysfs/client.py   | 27 +++++++++++++++++++++++++++
 tools/nfssysfs/nfssysfs.py |  2 ++
 tools/nfssysfs/switch.py   |  7 ++++---
 3 files changed, 33 insertions(+), 3 deletions(-)
 create mode 100644 tools/nfssysfs/client.py

diff --git a/tools/nfssysfs/client.py b/tools/nfssysfs/client.py
new file mode 100644
index 000000000000..5192cc226aed
--- /dev/null
+++ b/tools/nfssysfs/client.py
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
diff --git a/tools/nfssysfs/nfssysfs.py b/tools/nfssysfs/nfssysfs.py
index dfad6ac08fa0..e2172cdfa4c1 100755
--- a/tools/nfssysfs/nfssysfs.py
+++ b/tools/nfssysfs/nfssysfs.py
@@ -10,9 +10,11 @@ def show_small_help(args):
 parser.set_defaults(func=show_small_help)
 
 
+import client
 import switch
 import xprt
 subparser = parser.add_subparsers(title="commands")
+client.add_command(subparser)
 switch.add_command(subparser)
 xprt.add_command(subparser)
 
diff --git a/tools/nfssysfs/switch.py b/tools/nfssysfs/switch.py
index afb6963a0a1f..5384f970235c 100644
--- a/tools/nfssysfs/switch.py
+++ b/tools/nfssysfs/switch.py
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
2.33.0

