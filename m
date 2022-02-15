Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51904B7869
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Feb 2022 21:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239151AbiBOTWF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Feb 2022 14:22:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238282AbiBOTWF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Feb 2022 14:22:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3E679C41
        for <linux-nfs@vger.kernel.org>; Tue, 15 Feb 2022 11:21:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4828061793
        for <linux-nfs@vger.kernel.org>; Tue, 15 Feb 2022 19:21:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA9C9C340EB;
        Tue, 15 Feb 2022 19:21:53 +0000 (UTC)
From:   Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v8 4/9] rpcctl: Add a command for printing rpc client information
Date:   Tue, 15 Feb 2022 14:21:45 -0500
Message-Id: <20220215192150.53811-5-Anna.Schumaker@Netapp.com>
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

It's mostly the same information as with xprt-switches, except with
rpc-client id prepended to the first line.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
v8: Better exception handling if an RpcClient isn't found
---
 tools/rpcctl/rpcctl.py | 39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/tools/rpcctl/rpcctl.py b/tools/rpcctl/rpcctl.py
index 6b9627318949..2e710b5627f0 100755
--- a/tools/rpcctl/rpcctl.py
+++ b/tools/rpcctl/rpcctl.py
@@ -99,17 +99,18 @@ class Xprt:
 
 
 class XprtSwitch:
-    def __init__(self, path):
+    def __init__(self, path, sep=":"):
         self.path = path
         self.name = path.stem
         self.info = read_info_file(path / "xprt_switch_info")
         self.xprts = sorted([ Xprt(p) for p in self.path.iterdir() if p.is_dir() ])
+        self.sep = sep
 
     def __lt__(self, rhs):
         return self.name < rhs.name
 
     def __str__(self):
-        switch =  f"{self.name}: " \
+        switch =  f"{self.name}{self.sep} " \
                   f"xprts {self.info['num_xprts']}, " \
                   f"active {self.info['num_active']}, " \
                   f"queue {self.info['queue_len']}"
@@ -137,6 +138,39 @@ class XprtSwitch:
             print(switch)
 
 
+class RpcClient:
+    def __init__(self, path):
+        self.path = path
+        self.name = path.stem
+        self.switch = XprtSwitch(path / (path / "switch").readlink(), sep=",")
+
+    def __lt__(self, rhs):
+        return self.name < rhs.name
+
+    def __str__(self):
+        return f"{self.name}: {self.switch}"
+
+    def add_command(subparser):
+        parser = subparser.add_parser("client", help="Commands for rpc clients")
+        parser.set_defaults(func=RpcClient.show, client=None)
+        subparser = parser.add_subparsers()
+
+        show = subparser.add_parser("show", help="Show rpc clients")
+        show.add_argument("client", metavar="CLIENT", nargs='?',
+                          help="Name of a specific rpc client to show")
+        parser.set_defaults(func=RpcClient.show)
+
+    def get_by_name(name):
+        rpc_clients = sunrpc / "rpc-clients"
+        if name:
+            return [ RpcClient(rpc_clients / name) ]
+        return [ RpcClient(f) for f in sorted(rpc_clients.iterdir()) ]
+
+    def show(args):
+        for client in RpcClient.get_by_name(args.client):
+            print(client)
+
+
 parser = argparse.ArgumentParser()
 
 def show_small_help(args):
@@ -145,6 +179,7 @@ def show_small_help(args):
 parser.set_defaults(func=show_small_help)
 
 subparser = parser.add_subparsers(title="commands")
+RpcClient.add_command(subparser)
 XprtSwitch.add_command(subparser)
 Xprt.add_command(subparser)
 
-- 
2.35.1

