Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC9B4B779A
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Feb 2022 21:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239773AbiBOTWI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Feb 2022 14:22:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239247AbiBOTWH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Feb 2022 14:22:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CCC77A9B
        for <linux-nfs@vger.kernel.org>; Tue, 15 Feb 2022 11:21:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 78A98B81C6F
        for <linux-nfs@vger.kernel.org>; Tue, 15 Feb 2022 19:21:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D920BC340EB;
        Tue, 15 Feb 2022 19:21:54 +0000 (UTC)
From:   Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v8 6/9] rpcctl: Add a command for changing xprt switch dstaddrs
Date:   Tue, 15 Feb 2022 14:21:47 -0500
Message-Id: <20220215192150.53811-7-Anna.Schumaker@Netapp.com>
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

This is basically the same as for xprts, but it iterates through all
xprts attached to the switch to apply the new address.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
v8: Only call socket.gethostbyname() once instead of for each xprt
---
 tools/rpcctl/rpcctl.py | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/rpcctl/rpcctl.py b/tools/rpcctl/rpcctl.py
index 98e1f680ed72..0fbce99fff5b 100755
--- a/tools/rpcctl/rpcctl.py
+++ b/tools/rpcctl/rpcctl.py
@@ -82,7 +82,6 @@ class Xprt:
         return f"{self.name}: {self.type}, {self.dstaddr}{main}"
 
     def set_dstaddr(self, newaddr):
-        resolved = socket.gethostbyname(newaddr)
         self.dstaddr = write_addr_file(self.path / "dstaddr", newaddr)
 
     def add_command(subparser):
@@ -152,6 +151,15 @@ class XprtSwitch:
                           help="Name of a specific switch to show")
         show.set_defaults(func=XprtSwitch.show)
 
+        set = subparser.add_parser("set", help="Change an xprt switch property")
+        set.add_argument("switch", metavar="SWITCH", nargs=1,
+                         help="Name of a specific xprt switch to modify")
+        subparser = set.add_subparsers(required=True)
+        dstaddr = subparser.add_parser("dstaddr", help="Change an xprt switch's dstaddr")
+        dstaddr.add_argument("newaddr", metavar="NEWADDR", nargs=1,
+                             help="The new address for the xprt switch")
+        dstaddr.set_defaults(func=XprtSwitch.set_property, property="dstaddr")
+
     def get_by_name(name):
         xprt_switches = sunrpc / "xprt-switches"
         if name:
@@ -162,6 +170,13 @@ class XprtSwitch:
         for switch in XprtSwitch.get_by_name(args.switch):
             print(switch)
 
+    def set_property(args):
+        for switch in XprtSwitch.get_by_name(args.switch[0]):
+            resolved = socket.gethostbyname(args.newaddr[0])
+            for xprt in switch.xprts:
+                xprt.set_dstaddr(resolved)
+        print(switch)
+
 
 class RpcClient:
     def __init__(self, path):
-- 
2.35.1

