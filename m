Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F29943E85E
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Oct 2021 20:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbhJ1Shw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Oct 2021 14:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbhJ1Shv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Oct 2021 14:37:51 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4F8C061570
        for <linux-nfs@vger.kernel.org>; Thu, 28 Oct 2021 11:35:24 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id d6so4695500qvb.3
        for <linux-nfs@vger.kernel.org>; Thu, 28 Oct 2021 11:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1fl2PgIKZ7d+0Ni8x29K1OlM/fBaw+yfeZ9qVart6y0=;
        b=XGUDpUJA7FsyAmKiUuqDjL1hdQA0ndiaDQ4FpWcPuHde6iyaWFGRltcIEZwu1IOm/U
         LxGP4v2X1WolBi61tNDrltvMfC9jcuxzXBNdEJWNed3WVIkL2YpTLPeehjOU2uTujhok
         YR8lPjx2o0gHlCLqHNkkBYBe8XOvFLLoAj1OgEm1WBs1z13iA1rHMHVlGOEUKxNh1HjM
         rAY41C+khpLW8g6hw4ol0PWW8OJPX7k3aRoiZewgoG9Yy47Ovxe4+xDqAw0+I412WSTm
         h/vAuGIVZGS150XST5YMgzbXCBlY9xVTroNeRdazvEAFf4u8YU/HhVHEBl7hSytXbIrs
         rqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=1fl2PgIKZ7d+0Ni8x29K1OlM/fBaw+yfeZ9qVart6y0=;
        b=7JvfsqmMlLG6/+f7mKxBkT7dajPCumCMZv1uopo2oI2EbcO86U13EWFxHqqgZjjTa7
         d+1I4HHvyelEMGszCxdMQPeiDzRCP3Ey4Ynye1stUxfyWbtTuqFNTYFT7tGxHh8oIOkt
         uDYnrWfpBJUFzx0UHWaPXGPAslT5veBgGb9WWFtVPzzqG4dL2ncuN3KNHzKAAnE42aoa
         N9KQw4NNnyItT67KMf6JbY9KKMgnombRgQhaPi05us2t88F1xdzivJXSdWbSE19+PonF
         YSIdJFyn1v9+GA/dyMVD58ntpThvbeLCpNu5+0vwozo0pbH0Ovz63J2EZCVpfS718Pzf
         1wgQ==
X-Gm-Message-State: AOAM531joYa0LW158/ugT73gC8eSAOHPMa03YBm8fHmEksOCrUiGu58E
        /AzLH26xfs5UfB7c8L602x4=
X-Google-Smtp-Source: ABdhPJye8XDDOLQi//xlp+2/xgCWp5HuiH7VJ84M8CjXL6PQqSaf1S+0Lxq3KJX7aa1p4U+8jYyZLw==
X-Received: by 2002:a05:6214:226e:: with SMTP id gs14mr5860713qvb.8.1635446123108;
        Thu, 28 Oct 2021 11:35:23 -0700 (PDT)
Received: from gouda.nowheycreamery.com ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id q13sm2556476qkl.7.2021.10.28.11.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 11:35:22 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v5 2/9] rpcctl: Add a command for printing xprt switch information
Date:   Thu, 28 Oct 2021 14:35:12 -0400
Message-Id: <20211028183519.160772-3-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211028183519.160772-1-Anna.Schumaker@Netapp.com>
References: <20211028183519.160772-1-Anna.Schumaker@Netapp.com>
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
v5: Clean up how the XprtSwitch __str__() function works
    Rename the subcommand to simply "switch"
---
 tools/rpcctl/rpcctl.py |  6 ++++++
 tools/rpcctl/switch.py | 35 +++++++++++++++++++++++++++++++++++
 tools/rpcctl/sysfs.py  | 18 ++++++++++++++++++
 tools/rpcctl/xprt.py   | 14 ++++++++++++++
 4 files changed, 73 insertions(+)
 create mode 100644 tools/rpcctl/switch.py
 create mode 100644 tools/rpcctl/xprt.py

diff --git a/tools/rpcctl/rpcctl.py b/tools/rpcctl/rpcctl.py
index 8ff59ea9e81b..90efcbed7ac8 100755
--- a/tools/rpcctl/rpcctl.py
+++ b/tools/rpcctl/rpcctl.py
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
diff --git a/tools/rpcctl/switch.py b/tools/rpcctl/switch.py
new file mode 100644
index 000000000000..c96e70b7710f
--- /dev/null
+++ b/tools/rpcctl/switch.py
@@ -0,0 +1,35 @@
+import sysfs
+import xprt
+
+class XprtSwitch:
+    def __init__(self, path):
+        self.path = path
+        self.id = int(path.stem.split("-")[1])
+        self.info = sysfs.read_info_file(path / "xprt_switch_info")
+
+        self.xprts = [ xprt.Xprt(p) for p in self.path.iterdir() if p.is_dir() ]
+        self.xprts.sort()
+
+    def __lt__(self, rhs):
+        return self.path < rhs.path
+
+    def __str__(self):
+        switch =  f"switch {self.id}: " \
+                  f"xprts {self.info['num_xprts']}, " \
+                  f"active {self.info['num_active']}, " \
+                  f"queue {self.info['queue_len']}"
+        xprts = [ f"	{x.small_str()}" for x in self.xprts ]
+        return "\n".join([ switch ] + xprts)
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
+    parser = subparser.add_parser("switch", help="Commands for xprt switches")
+    parser.add_argument("--id", metavar="ID", nargs=1, type=int, help="Id of a specific xprt-switch to show")
+    parser.set_defaults(func=list_xprt_switches)
diff --git a/tools/rpcctl/sysfs.py b/tools/rpcctl/sysfs.py
index c9d477063585..c05d2d591175 100644
--- a/tools/rpcctl/sysfs.py
+++ b/tools/rpcctl/sysfs.py
@@ -1,3 +1,4 @@
+import collections
 import pathlib
 import re
 import sys
@@ -17,3 +18,20 @@ SUNRPC = pathlib.Path(MOUNT) / "kernel" / "sunrpc"
 if not SUNRPC.is_dir():
     print("ERROR: sysfs does not have sunrpc directory")
     sys.exit(1)
+
+
+def read_addr_file(path):
+    try:
+        with open(path, 'r') as f:
+            return f.readline().strip()
+    except:
+        return "(enoent)"
+
+def read_info_file(path):
+    res = collections.defaultdict(int)
+    try:
+        with open(path) as info:
+            lines = [ l.split("=", 1) for l in info if "=" in l ]
+            res.update({ key:int(val.strip()) for (key, val) in lines })
+    finally:
+        return res
diff --git a/tools/rpcctl/xprt.py b/tools/rpcctl/xprt.py
new file mode 100644
index 000000000000..62859a23ea4d
--- /dev/null
+++ b/tools/rpcctl/xprt.py
@@ -0,0 +1,14 @@
+import sysfs
+
+class Xprt:
+    def __init__(self, path):
+        self.path = path
+        self.id = int(path.stem.split("-")[1])
+        self.type = path.stem.split("-")[2]
+        self.dstaddr = sysfs.read_addr_file(path / "dstaddr")
+
+    def __lt__(self, rhs):
+        return self.id < rhs.id
+
+    def small_str(self):
+        return f"xprt {self.id}: {self.type}, {self.dstaddr}"
-- 
2.33.1

