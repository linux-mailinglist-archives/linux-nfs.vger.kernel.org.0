Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E38E54B75C3
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Feb 2022 21:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbiBOTWH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Feb 2022 14:22:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239427AbiBOTWG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Feb 2022 14:22:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B3D78064
        for <linux-nfs@vger.kernel.org>; Tue, 15 Feb 2022 11:21:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE47EB81C11
        for <linux-nfs@vger.kernel.org>; Tue, 15 Feb 2022 19:21:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B05EC340EC;
        Tue, 15 Feb 2022 19:21:53 +0000 (UTC)
From:   Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v8 3/9] rpcctl: Add a command for printing individual xprts
Date:   Tue, 15 Feb 2022 14:21:44 -0500
Message-Id: <20220215192150.53811-4-Anna.Schumaker@Netapp.com>
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

This shows more detailed information than what is presented with xprt
switches. I take the chance to add a main-export indicator to the
small_str() used when printing out xprt-switches.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
v8: Better exception handling if an Xprt isn't found
---
 tools/rpcctl/rpcctl.py | 55 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/tools/rpcctl/rpcctl.py b/tools/rpcctl/rpcctl.py
index 1eb0454aaf58..6b9627318949 100755
--- a/tools/rpcctl/rpcctl.py
+++ b/tools/rpcctl/rpcctl.py
@@ -1,6 +1,8 @@
 #!/usr/bin/python3
 import argparse
 import collections
+import errno
+import os
 import pathlib
 import sys
 
@@ -37,13 +39,63 @@ class Xprt:
         self.path = path
         self.name = path.stem.rsplit("-", 1)[0]
         self.type = path.stem.split("-")[2]
+        self.info = read_info_file(path / "xprt_info")
         self.dstaddr = read_addr_file(path / "dstaddr")
+        self.srcaddr = read_addr_file(path / "srcaddr")
+
+        with open(path / "xprt_state") as f:
+            self.state = ','.join(f.readline().split()[1:])
 
     def __lt__(self, rhs):
         return self.name < rhs.name
 
+    def _xprt(self):
+        main = ", main" if self.info.get("main_xprt") else ""
+        return f"{self.name}: {self.type}, {self.dstaddr}, " \
+               f"port {self.info['dst_port']}, state <{self.state}>{main}"
+
+    def _src_reqs(self):
+        return f"	Source: {self.srcaddr}, port {self.info['src_port']}, " \
+               f"Requests: {self.info['num_reqs']}"
+
+    def _cong_slots(self):
+        return f"	Congestion: cur {self.info['cur_cong']}, win {self.info['cong_win']}, " \
+               f"Slots: min {self.info['min_num_slots']}, max {self.info['max_num_slots']}"
+
+    def _queues(self):
+        return f"	Queues: binding {self.info['binding_q_len']}, " \
+               f"sending {self.info['sending_q_len']}, pending {self.info['pending_q_len']}, " \
+               f"backlog {self.info['backlog_q_len']}, tasks {self.info['tasks_queuelen']}"
+
+    def __str__(self):
+        return "\n".join([self._xprt(), self._src_reqs(),
+                          self._cong_slots(), self._queues() ])
+
     def small_str(self):
-        return f"{self.name}: {self.type}, {self.dstaddr}"
+        main = " [main]" if self.info.get("main_xprt") else ""
+        return f"{self.name}: {self.type}, {self.dstaddr}{main}"
+
+    def add_command(subparser):
+        parser = subparser.add_parser("xprt", help="Commands for individual xprts")
+        parser.set_defaults(func=Xprt.show, xprt=None)
+        subparser = parser.add_subparsers()
+
+        show = subparser.add_parser("show", help="Show xprts")
+        show.add_argument("xprt", metavar="XPRT", nargs='?',
+                          help="Name of a specific xprt to show")
+        show.set_defaults(func=Xprt.show)
+
+    def get_by_name(name):
+        glob = f"**/{name}-*" if name else "**/xprt-*"
+        res = [ Xprt(x) for x in (sunrpc / "xprt-switches").glob(glob) ]
+        if name and len(res) == 0:
+            raise FileNotFoundError(errno.ENOENT, os.strerror(errno.ENOENT),
+                                    f"{sunrpc / 'xprt-switches' / glob}")
+        return sorted(res)
+
+    def show(args):
+        for xprt in Xprt.get_by_name(args.xprt):
+            print(xprt)
 
 
 class XprtSwitch:
@@ -94,6 +146,7 @@ parser.set_defaults(func=show_small_help)
 
 subparser = parser.add_subparsers(title="commands")
 XprtSwitch.add_command(subparser)
+Xprt.add_command(subparser)
 
 args = parser.parse_args()
 try:
-- 
2.35.1

