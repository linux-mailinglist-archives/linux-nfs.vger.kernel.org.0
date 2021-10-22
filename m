Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90590437FAC
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Oct 2021 22:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbhJVU62 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Oct 2021 16:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234190AbhJVU62 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Oct 2021 16:58:28 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A02C061764
        for <linux-nfs@vger.kernel.org>; Fri, 22 Oct 2021 13:56:10 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id a13so5728874qkg.11
        for <linux-nfs@vger.kernel.org>; Fri, 22 Oct 2021 13:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OpGx2h5N8nhRRTXLkKQvc2iaqAi/XhbAVvpt49qrdz8=;
        b=FpxddA26RaU770bh3d843f1eFbvbHhYUZap6CGEx0lDXKPWbSQy6X2ZhPgB8GkyiDP
         gSlYIGo5MeYcWkp9TcRoGNplI5XUgRBa7Zq+PZFDaOPSPi257dTrn80g/Uz2LKRss1/i
         yMFmyBRiVGoYWo0+J1qYHwaR77KqSECQgeQ3m03m6Xjf29OSfdV46qm5PCFWCZOhM2p2
         vRC6A0ozCq/3ssxR/xtQIiHWo3TaSxjZXyuz4Eh8XkGPN5dNIe64IOn/8Zhyu5U2qKL1
         Pi1TDe9/PAu+XuAtv1X2bbx1ub83T0EkD/Nemt6Q/H/FtyLOWGUPX3KTibnU+7Ekd7qF
         Y0+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=OpGx2h5N8nhRRTXLkKQvc2iaqAi/XhbAVvpt49qrdz8=;
        b=CkaADLG5aQ6GVg99Mo7gUlkXZvrpmX474WOyFDORqG2QpVOkWpM9mfGSrNQGBCdnlI
         QPaNkjVuUK534+z4T5En97Bre5RbvJpdcfn9yfyWg90s6zs/TZmDv7MeQI/BDY30pu0x
         iDRMt7oTMe1FyJWXdwcH+OV6qr0zmHqKJwJ4smKj8GGaeNIapglDULqwlhaKlyyBB8XW
         hbj0kWJ3zPlrKstKWZce6YPXkiY6ErN7Lx8tZ1jx7uHqSXpfr/ZayJTk/BI7OXPAaO5m
         ZXb94/2PadDxP8MyD9skWbopVZLx0QJMWnIM0GhiqSIkFIMsJacyXlHQ8elDBB53tL8k
         1mIg==
X-Gm-Message-State: AOAM532uVFx+bWvzLB+HF3RN+39K7ds1OrLUnjTBe5jTz+y3tJ6WwdU7
        Pjdx0kr9Y+1mtuHU8SraXSHCq25RsMk=
X-Google-Smtp-Source: ABdhPJyh8+ZFg3ORckuBOievTKbMujPSQfZPrmcNro+ZI7AqkhZIb7CUXK4jFkXV94ORcNnZh/FXNw==
X-Received: by 2002:a37:b7c2:: with SMTP id h185mr1992179qkf.311.1634936169078;
        Fri, 22 Oct 2021 13:56:09 -0700 (PDT)
Received: from gouda.nowheycreamery.com ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id p9sm4576279qki.51.2021.10.22.13.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 13:56:08 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v4 2/9] rpcsys: Add a command for printing xprt switch information
Date:   Fri, 22 Oct 2021 16:55:59 -0400
Message-Id: <20211022205606.66392-3-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211022205606.66392-1-Anna.Schumaker@Netapp.com>
References: <20211022205606.66392-1-Anna.Schumaker@Netapp.com>
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
 tools/rpcsys/rpcsys.py |  6 ++++++
 tools/rpcsys/switch.py | 35 +++++++++++++++++++++++++++++++++++
 tools/rpcsys/sysfs.py  | 10 ++++++++++
 tools/rpcsys/xprt.py   | 12 ++++++++++++
 4 files changed, 63 insertions(+)
 create mode 100644 tools/rpcsys/switch.py
 create mode 100644 tools/rpcsys/xprt.py

diff --git a/tools/rpcsys/rpcsys.py b/tools/rpcsys/rpcsys.py
index 8ff59ea9e81b..90efcbed7ac8 100755
--- a/tools/rpcsys/rpcsys.py
+++ b/tools/rpcsys/rpcsys.py
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
diff --git a/tools/rpcsys/switch.py b/tools/rpcsys/switch.py
new file mode 100644
index 000000000000..afb6963a0a1f
--- /dev/null
+++ b/tools/rpcsys/switch.py
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
diff --git a/tools/rpcsys/sysfs.py b/tools/rpcsys/sysfs.py
index c9d477063585..79f844af34a6 100644
--- a/tools/rpcsys/sysfs.py
+++ b/tools/rpcsys/sysfs.py
@@ -17,3 +17,13 @@ SUNRPC = pathlib.Path(MOUNT) / "kernel" / "sunrpc"
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
diff --git a/tools/rpcsys/xprt.py b/tools/rpcsys/xprt.py
new file mode 100644
index 000000000000..d37537771c1d
--- /dev/null
+++ b/tools/rpcsys/xprt.py
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
2.33.1

