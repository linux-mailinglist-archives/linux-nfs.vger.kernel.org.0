Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1454B755E
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Feb 2022 21:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238282AbiBOTWG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Feb 2022 14:22:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238383AbiBOTWF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Feb 2022 14:22:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396CE78064
        for <linux-nfs@vger.kernel.org>; Tue, 15 Feb 2022 11:21:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA448617C3
        for <linux-nfs@vger.kernel.org>; Tue, 15 Feb 2022 19:21:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57010C340F0;
        Tue, 15 Feb 2022 19:21:54 +0000 (UTC)
From:   Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v8 5/9] rpcctl: Add a command for changing xprt dstaddr
Date:   Tue, 15 Feb 2022 14:21:46 -0500
Message-Id: <20220215192150.53811-6-Anna.Schumaker@Netapp.com>
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

Using the socket module for dns resolution

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 tools/rpcctl/rpcctl.py | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/rpcctl/rpcctl.py b/tools/rpcctl/rpcctl.py
index 2e710b5627f0..98e1f680ed72 100755
--- a/tools/rpcctl/rpcctl.py
+++ b/tools/rpcctl/rpcctl.py
@@ -4,6 +4,7 @@ import collections
 import errno
 import os
 import pathlib
+import socket
 import sys
 
 with open("/proc/mounts", 'r') as f:
@@ -24,6 +25,11 @@ def read_addr_file(path):
     except:
         return "(enoent)"
 
+def write_addr_file(path, newaddr):
+    with open(path, 'w') as f:
+        f.write(newaddr)
+    return read_addr_file(path)
+
 def read_info_file(path):
     res = collections.defaultdict(int)
     try:
@@ -75,6 +81,10 @@ class Xprt:
         main = " [main]" if self.info.get("main_xprt") else ""
         return f"{self.name}: {self.type}, {self.dstaddr}{main}"
 
+    def set_dstaddr(self, newaddr):
+        resolved = socket.gethostbyname(newaddr)
+        self.dstaddr = write_addr_file(self.path / "dstaddr", newaddr)
+
     def add_command(subparser):
         parser = subparser.add_parser("xprt", help="Commands for individual xprts")
         parser.set_defaults(func=Xprt.show, xprt=None)
@@ -85,6 +95,15 @@ class Xprt:
                           help="Name of a specific xprt to show")
         show.set_defaults(func=Xprt.show)
 
+        set = subparser.add_parser("set", help="Change an xprt property")
+        set.add_argument("xprt", metavar="XPRT", nargs=1,
+                         help="Name of a specific xprt to modify")
+        subparser = set.add_subparsers(required=True)
+        dstaddr = subparser.add_parser("dstaddr", help="Change an xprt's dstaddr")
+        dstaddr.add_argument("newaddr", metavar="NEWADDR", nargs=1,
+                             help="The new address for the xprt")
+        dstaddr.set_defaults(func=Xprt.set_property, property="dstaddr")
+
     def get_by_name(name):
         glob = f"**/{name}-*" if name else "**/xprt-*"
         res = [ Xprt(x) for x in (sunrpc / "xprt-switches").glob(glob) ]
@@ -97,6 +116,12 @@ class Xprt:
         for xprt in Xprt.get_by_name(args.xprt):
             print(xprt)
 
+    def set_property(args):
+        for xprt in Xprt.get_by_name(args.xprt[0]):
+            if args.property == "dstaddr":
+                xprt.set_dstaddr(socket.gethostbyname(args.newaddr[0]))
+        print(xprt)
+
 
 class XprtSwitch:
     def __init__(self, path, sep=":"):
-- 
2.35.1

