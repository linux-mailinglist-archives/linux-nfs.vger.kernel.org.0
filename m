Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36354B75FB
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Feb 2022 21:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237918AbiBOTWF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Feb 2022 14:22:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbiBOTWE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Feb 2022 14:22:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A91278064
        for <linux-nfs@vger.kernel.org>; Tue, 15 Feb 2022 11:21:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9965D6179D
        for <linux-nfs@vger.kernel.org>; Tue, 15 Feb 2022 19:21:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF6A3C340F2;
        Tue, 15 Feb 2022 19:21:52 +0000 (UTC)
From:   Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v8 2/9] rpcctl: Add a command for printing xprt switch information
Date:   Tue, 15 Feb 2022 14:21:43 -0500
Message-Id: <20220215192150.53811-3-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220215192150.53811-1-Anna.Schumaker@Netapp.com>
References: <20220215192150.53811-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

This combines the information found in xprt_switch_info with a subset of
the information found in each xprt subdirectory

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
v8: Handle Exceptions when running commands
---
 tools/rpcctl/rpcctl.py | 80 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 79 insertions(+), 1 deletion(-)

diff --git a/tools/rpcctl/rpcctl.py b/tools/rpcctl/rpcctl.py
index 9737ac4a9740..1eb0454aaf58 100755
--- a/tools/rpcctl/rpcctl.py
+++ b/tools/rpcctl/rpcctl.py
@@ -1,5 +1,6 @@
 #!/usr/bin/python3
 import argparse
+import collections
 import pathlib
 import sys
 
@@ -14,6 +15,76 @@ if not sunrpc.is_dir():
     print("ERROR: sysfs does not have sunrpc directory")
     sys.exit(1)
 
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
+
+
+class Xprt:
+    def __init__(self, path):
+        self.path = path
+        self.name = path.stem.rsplit("-", 1)[0]
+        self.type = path.stem.split("-")[2]
+        self.dstaddr = read_addr_file(path / "dstaddr")
+
+    def __lt__(self, rhs):
+        return self.name < rhs.name
+
+    def small_str(self):
+        return f"{self.name}: {self.type}, {self.dstaddr}"
+
+
+class XprtSwitch:
+    def __init__(self, path):
+        self.path = path
+        self.name = path.stem
+        self.info = read_info_file(path / "xprt_switch_info")
+        self.xprts = sorted([ Xprt(p) for p in self.path.iterdir() if p.is_dir() ])
+
+    def __lt__(self, rhs):
+        return self.name < rhs.name
+
+    def __str__(self):
+        switch =  f"{self.name}: " \
+                  f"xprts {self.info['num_xprts']}, " \
+                  f"active {self.info['num_active']}, " \
+                  f"queue {self.info['queue_len']}"
+        xprts = [ f"	{x.small_str()}" for x in self.xprts ]
+        return "\n".join([ switch ] + xprts)
+
+    def add_command(subparser):
+        parser = subparser.add_parser("switch", help="Commands for xprt switches")
+        parser.set_defaults(func=XprtSwitch.show, switch=None)
+        subparser = parser.add_subparsers()
+
+        show = subparser.add_parser("show", help="Show xprt switches")
+        show.add_argument("switch", metavar="SWITCH", nargs='?',
+                          help="Name of a specific switch to show")
+        show.set_defaults(func=XprtSwitch.show)
+
+    def get_by_name(name):
+        xprt_switches = sunrpc / "xprt-switches"
+        if name:
+            return [ XprtSwitch(xprt_switches / name) ]
+        return [ XprtSwitch(f) for f in sorted(xprt_switches.iterdir()) ]
+
+    def show(args):
+        for switch in XprtSwitch.get_by_name(args.switch):
+            print(switch)
+
+
 parser = argparse.ArgumentParser()
 
 def show_small_help(args):
@@ -21,5 +92,12 @@ def show_small_help(args):
     print("sunrpc dir:", sunrpc)
 parser.set_defaults(func=show_small_help)
 
+subparser = parser.add_subparsers(title="commands")
+XprtSwitch.add_command(subparser)
+
 args = parser.parse_args()
-args.func(args)
+try:
+    args.func(args)
+except Exception as e:
+    print(str(e))
+    sys.exit(1)
-- 
2.35.1

