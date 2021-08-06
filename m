Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50A763E3039
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Aug 2021 22:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbhHFUSA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Aug 2021 16:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244827AbhHFUSA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Aug 2021 16:18:00 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B3CC061798
        for <linux-nfs@vger.kernel.org>; Fri,  6 Aug 2021 13:17:44 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id c5so7357886qtp.13
        for <linux-nfs@vger.kernel.org>; Fri, 06 Aug 2021 13:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o9bYo5fP3VxJGTa5w7iwXg2aImIDXtHPxGkN8GuDhl0=;
        b=I2bx0YVvSaGAKIZJ6YaBJGUy3hkw+Ck4BH22O/SlFc3+EKeAYJP3X0nYPNpNbAJIBJ
         1EzRKQHvq22oMsy+4q38W9bhxM3LF40+utf1OgQvjd1ZfY0E/xwvc/RrKvREp7nN6UQV
         Z6w0ZLOmJnt6DqbXLCs1LU2hu9TGoIMYS9FpDptfG93g3+IBKqI7h7Y6WB81QCxAjyuq
         KYgsMzI3mZf3B6OhiaBEkAqGdQR4iLb+j1ztH9wcTCLrYgoi6nBLGXduNc4ZqjYVPCka
         O8fHzKVaAl2XQ2ahLIpHdMGbSSLdGNoSiyPNtnHPVHYm80fQxcTjT4WGGBCN4T2xc7y1
         AVLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=o9bYo5fP3VxJGTa5w7iwXg2aImIDXtHPxGkN8GuDhl0=;
        b=hvPkNLkP4F5dK6l+6XgP+2Tc8R8fultPpgrllxhnXJ7wfy4gJUGYc/Hr5QGsZ+Jn1a
         bzmJSbOCJhpOt1LlZk4lzDu8NO3UwXhE1zTJhjpZtUj3tsFvGm5gu4sJ6HJ+kTnPR0vz
         zT1HHNBnvM1e8cXCyrpVSkTJm5J58cNOfaS9bcyASRxCDBjSsdxd5//nXSNf27d9YQoy
         0Xnm/uGm9BsSbP3jk1ubZZZiFwr2GKiQ9kg8wYVSYRZnmMbD945mcHgoRWOo8dZOUhd4
         J0LhfeYgPTKjEir3+x53RXaCy6jenCsgGUEa/hOt/eUzYyVy/qrJJI6kOPkYNKsCcl0n
         aW5w==
X-Gm-Message-State: AOAM530uZBSK4ZKb/SsxpGecOQKxZHRCKbx+LLIlq2nbDQYsfms7NCo2
        /sN7W+Sse4HlVf0/GzGes5iuIw04PXtsRQ==
X-Google-Smtp-Source: ABdhPJxfIkGwrK23SjYC6C9v3pnMZSxmcea58HOcDtZSbpSX/US/XCthpNDiaWTeBabGi4avtezceA==
X-Received: by 2002:a05:622a:1487:: with SMTP id t7mr10731255qtx.19.1628281063104;
        Fri, 06 Aug 2021 13:17:43 -0700 (PDT)
Received: from localhost.localdomain ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id g11sm3705720qtk.91.2021.08.06.13.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 13:17:42 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v2 2/9] nfs-sysfs.py: Add a command for printing xprt switch information
Date:   Fri,  6 Aug 2021 16:17:32 -0400
Message-Id: <20210806201739.472806-3-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210806201739.472806-1-Anna.Schumaker@Netapp.com>
References: <20210806201739.472806-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

This combines the information found in xprt_switch_info with a subset of
the information found in each xprt subdirectory

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 tools/nfs-sysfs/nfs-sysfs.py |  6 ++++++
 tools/nfs-sysfs/switch.py    | 35 +++++++++++++++++++++++++++++++++++
 tools/nfs-sysfs/sysfs.py     | 10 ++++++++++
 tools/nfs-sysfs/xprt.py      | 12 ++++++++++++
 4 files changed, 63 insertions(+)
 create mode 100644 tools/nfs-sysfs/switch.py
 create mode 100644 tools/nfs-sysfs/xprt.py

diff --git a/tools/nfs-sysfs/nfs-sysfs.py b/tools/nfs-sysfs/nfs-sysfs.py
index 8ff59ea9e81b..90efcbed7ac8 100755
--- a/tools/nfs-sysfs/nfs-sysfs.py
+++ b/tools/nfs-sysfs/nfs-sysfs.py
@@ -9,5 +9,11 @@ def show_small_help(args):
     print("sunrpc dir:", sysfs.SUNRPC)
 parser.set_defaults(func=show_small_help)
 
+
+import switch
+subparser = parser.add_subparsers(title="commands")
+switch.add_command(subparser)
+
+
 args = parser.parse_args()
 args.func(args)
diff --git a/tools/nfs-sysfs/switch.py b/tools/nfs-sysfs/switch.py
new file mode 100644
index 000000000000..afb6963a0a1f
--- /dev/null
+++ b/tools/nfs-sysfs/switch.py
@@ -0,0 +1,35 @@
+import sysfs
+import xprt
+
+class XprtSwitch:
+    def __init__(self, path):
+        self.path = path
+        self.id = int(str(path).rsplit("-", 1)[1])
+
+        self.xprts = [ xprt.Xprt(p) for p in self.path.iterdir() if p.is_dir() ]
+        self.xprts.sort()
+
+        self.__dict__.update(sysfs.read_info_file(path / "xprt_switch_info"))
+
+    def __lt__(self, rhs):
+        return self.path < rhs.path
+
+    def __str__(self):
+        line = "switch %s: num_xprts %s, num_active %s, queue_len %s" % \
+                (self.id, self.num_xprts, self.num_active, self.queue_len)
+        for x in self.xprts:
+            line += "\n	%s" % x.small_str()
+        return line
+
+
+def list_xprt_switches(args):
+    switches = [ XprtSwitch(f) for f in (sysfs.SUNRPC / "xprt-switches").iterdir() ]
+    switches.sort()
+    for xs in switches:
+        if args.id == None or xs.id == args.id[0]:
+            print(xs)
+
+def add_command(subparser):
+    parser = subparser.add_parser("xprt-switch", help="Commands for xprt switches")
+    parser.add_argument("--id", metavar="ID", nargs=1, type=int, help="Id of a specific xprt-switch to show")
+    parser.set_defaults(func=list_xprt_switches)
diff --git a/tools/nfs-sysfs/sysfs.py b/tools/nfs-sysfs/sysfs.py
index 0b358f57bb28..32dcf74438de 100644
--- a/tools/nfs-sysfs/sysfs.py
+++ b/tools/nfs-sysfs/sysfs.py
@@ -16,3 +16,13 @@ SUNRPC = pathlib.Path(MOUNT) / "kernel" / "sunrpc"
 if not SUNRPC.is_dir():
     print("ERROR: sysfs does not have sunrpc directory")
     sys.exit(1)
+
+
+def read_info_file(path):
+    res = dict()
+    with open(path) as info:
+        for line in info:
+            if "=" in line:
+                (key, val) = line.strip().split("=")
+                res[key] = int(val)
+    return res
diff --git a/tools/nfs-sysfs/xprt.py b/tools/nfs-sysfs/xprt.py
new file mode 100644
index 000000000000..d37537771c1d
--- /dev/null
+++ b/tools/nfs-sysfs/xprt.py
@@ -0,0 +1,12 @@
+class Xprt:
+    def __init__(self, path):
+        self.path = path
+        self.id = int(str(path).rsplit("-", 2)[1])
+        self.type = str(path).rsplit("-", 2)[2]
+        self.dstaddr = open(path / "dstaddr", 'r').readline().strip()
+
+    def __lt__(self, rhs):
+        return self.id < rhs.id
+
+    def small_str(self):
+        return "xprt %s: %s, %s" % (self.id, self.type, self.dstaddr)
-- 
2.32.0

