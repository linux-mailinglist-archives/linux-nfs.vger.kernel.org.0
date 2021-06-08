Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0AD639FE1C
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jun 2021 19:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbhFHRt4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Jun 2021 13:49:56 -0400
Received: from mail-qk1-f172.google.com ([209.85.222.172]:43679 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233905AbhFHRtz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Jun 2021 13:49:55 -0400
Received: by mail-qk1-f172.google.com with SMTP id j62so7251089qke.10
        for <linux-nfs@vger.kernel.org>; Tue, 08 Jun 2021 10:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o9bYo5fP3VxJGTa5w7iwXg2aImIDXtHPxGkN8GuDhl0=;
        b=gAMjtCQKwKFWlchM0ww63AINde1n4aMJZ2HqjEpOnrN9PVrA1wHp/s+IUj+SkXLgpK
         a8WDZFVfLdIXjSUdOSpJVNJzIEWoicVheKrhxlyhvvFZaz025kqR8ExXB4r0tFG8AO8u
         glDVsJ/E7ItyXh70IxHYc5W7vkdRQ0qnHUUYaxIXASLaGyL9gB728NtQwGpAfxggk7p8
         1CAf43yuKCW7ESbtqSlOEJ5CcVeGaeSKf6p5lsfno1eidak44ZkaJuIUhr9jo3L0JAnl
         WNmH5DIQHSZDYhMdKjlVi8gy+1uE/kF5f9yBULWv3HkEowGEDIrW3Dvf5l3QzeXvSEWd
         12cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=o9bYo5fP3VxJGTa5w7iwXg2aImIDXtHPxGkN8GuDhl0=;
        b=WkOiBVoNEUOQhZinVXfZ/8F8F4ZyGIkQ0LizyobKaKma5EQvfXCsmkCT5NzyDcIODK
         Sfuhk0Ho63lm4yUEJWdsWizd1bwbsoGabBaavOywkH2vZvfwzWwj4XmtoAV1UH6mGYk9
         t4yL80LgTsSSuRZZ9FmfdHLWgBo40xzrpbI9+arsYWYd1hS0S2Nj6ZUuuqjiq8n1qh05
         0ePOpM/DHG8SUvZ0ZagQAwZAbqJp3VL1lSFKxuZM9QvjT1pcYwA7T4zH0wAP8N/SkcGo
         dZwPvknPdOow5hLRD5dB3emAMqnLnSMvIDK/as7mL0LrKm+XozJRlJoBTmj3A5eRk2hg
         IcPQ==
X-Gm-Message-State: AOAM531hT9vF0LqBQxu805kWVAPnNU6+bF5oGDutIXUEJVEcoxgpZ2TX
        zCdyWpkAQOKVN+16pbxF1PORFJtWHQQ=
X-Google-Smtp-Source: ABdhPJwqWkjVILKHUFgf0qV5jR/FIxbXE4fX5KgxCBWBlmTbscftYy9u3dnLDqsdbCDIxbPCQMfriA==
X-Received: by 2002:a37:9d93:: with SMTP id g141mr22619366qke.350.1623174420791;
        Tue, 08 Jun 2021 10:47:00 -0700 (PDT)
Received: from localhost.localdomain ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id h2sm12963080qkf.106.2021.06.08.10.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 10:47:00 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [RFC PATCH 2/6] nfs-sysfs.py: Add a command for printing xprt switch information
Date:   Tue,  8 Jun 2021 13:46:53 -0400
Message-Id: <20210608174657.603256-3-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210608174657.603256-1-Anna.Schumaker@Netapp.com>
References: <20210608174657.603256-1-Anna.Schumaker@Netapp.com>
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

