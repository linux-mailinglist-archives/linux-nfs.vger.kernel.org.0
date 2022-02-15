Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7840F4B75D8
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Feb 2022 21:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240215AbiBOTWK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Feb 2022 14:22:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239959AbiBOTWJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Feb 2022 14:22:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760D178064
        for <linux-nfs@vger.kernel.org>; Tue, 15 Feb 2022 11:21:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 24B38B81C69
        for <linux-nfs@vger.kernel.org>; Tue, 15 Feb 2022 19:21:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A7AFC340EC;
        Tue, 15 Feb 2022 19:21:55 +0000 (UTC)
From:   Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v8 7/9] rpcctl: Add a command for changing xprt state
Date:   Tue, 15 Feb 2022 14:21:48 -0500
Message-Id: <20220215192150.53811-8-Anna.Schumaker@Netapp.com>
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

We can set it offline or online, or we can remove an xprt. The kernel
only supports removing offlined transports, so we make sure to set the
state to "offline" before sending the remove command.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 tools/rpcctl/rpcctl.py | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/tools/rpcctl/rpcctl.py b/tools/rpcctl/rpcctl.py
index 0fbce99fff5b..b8df556b682c 100755
--- a/tools/rpcctl/rpcctl.py
+++ b/tools/rpcctl/rpcctl.py
@@ -48,9 +48,7 @@ class Xprt:
         self.info = read_info_file(path / "xprt_info")
         self.dstaddr = read_addr_file(path / "dstaddr")
         self.srcaddr = read_addr_file(path / "srcaddr")
-
-        with open(path / "xprt_state") as f:
-            self.state = ','.join(f.readline().split()[1:])
+        self.read_state()
 
     def __lt__(self, rhs):
         return self.name < rhs.name
@@ -74,9 +72,16 @@ class Xprt:
                f"backlog {self.info['backlog_q_len']}, tasks {self.info['tasks_queuelen']}"
 
     def __str__(self):
+        if not self.path.exists():
+            return f"{self.name}: has been removed"
         return "\n".join([self._xprt(), self._src_reqs(),
                           self._cong_slots(), self._queues() ])
 
+    def read_state(self):
+        if self.path.exists():
+            with open(self.path / "xprt_state") as f:
+                self.state = ','.join(f.readline().split()[1:])
+
     def small_str(self):
         main = " [main]" if self.info.get("main_xprt") else ""
         return f"{self.name}: {self.type}, {self.dstaddr}{main}"
@@ -84,11 +89,21 @@ class Xprt:
     def set_dstaddr(self, newaddr):
         self.dstaddr = write_addr_file(self.path / "dstaddr", newaddr)
 
+    def set_state(self, state):
+        with open(self.path / "xprt_state", 'w') as f:
+            f.write(state)
+        self.read_state()
+
     def add_command(subparser):
         parser = subparser.add_parser("xprt", help="Commands for individual xprts")
         parser.set_defaults(func=Xprt.show, xprt=None)
         subparser = parser.add_subparsers()
 
+        remove = subparser.add_parser("remove", help="Remove an xprt")
+        remove.add_argument("xprt", metavar="XPRT", nargs=1,
+                            help="Name of the xprt to remove")
+        remove.set_defaults(func=Xprt.set_property, property="remove")
+
         show = subparser.add_parser("show", help="Show xprts")
         show.add_argument("xprt", metavar="XPRT", nargs='?',
                           help="Name of a specific xprt to show")
@@ -98,6 +113,10 @@ class Xprt:
         set.add_argument("xprt", metavar="XPRT", nargs=1,
                          help="Name of a specific xprt to modify")
         subparser = set.add_subparsers(required=True)
+        online = subparser.add_parser("online", help="Set an xprt online")
+        online.set_defaults(func=Xprt.set_property, property="online")
+        offline = subparser.add_parser("offline", help="Set an xprt offline")
+        offline.set_defaults(func=Xprt.set_property, property="offline")
         dstaddr = subparser.add_parser("dstaddr", help="Change an xprt's dstaddr")
         dstaddr.add_argument("newaddr", metavar="NEWADDR", nargs=1,
                              help="The new address for the xprt")
@@ -119,6 +138,11 @@ class Xprt:
         for xprt in Xprt.get_by_name(args.xprt[0]):
             if args.property == "dstaddr":
                 xprt.set_dstaddr(socket.gethostbyname(args.newaddr[0]))
+            elif args.property == "remove":
+                xprt.set_state("offline")
+                xprt.set_state("remove")
+            else:
+                args.set_state(args.property)
         print(xprt)
 
 
-- 
2.35.1

