Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A184B7646
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Feb 2022 21:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237486AbiBOTWE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Feb 2022 14:22:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbiBOTWD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Feb 2022 14:22:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DC977A9B
        for <linux-nfs@vger.kernel.org>; Tue, 15 Feb 2022 11:21:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20CE26179B
        for <linux-nfs@vger.kernel.org>; Tue, 15 Feb 2022 19:21:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D880C340F0;
        Tue, 15 Feb 2022 19:21:52 +0000 (UTC)
From:   Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v8 1/9] rpcctl: Add a rpcctl.py tool
Date:   Tue, 15 Feb 2022 14:21:42 -0500
Message-Id: <20220215192150.53811-2-Anna.Schumaker@Netapp.com>
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

This will be used to print and manipulate the sunrpc sysfs directory
files. Running without arguments prints both usage information and the
location of the sunrpc sysfs directory.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 tools/rpcctl/rpcctl.py | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100755 tools/rpcctl/rpcctl.py

diff --git a/tools/rpcctl/rpcctl.py b/tools/rpcctl/rpcctl.py
new file mode 100755
index 000000000000..9737ac4a9740
--- /dev/null
+++ b/tools/rpcctl/rpcctl.py
@@ -0,0 +1,25 @@
+#!/usr/bin/python3
+import argparse
+import pathlib
+import sys
+
+with open("/proc/mounts", 'r') as f:
+    mount = [ line.split()[1] for line in f if "sysfs" in line ]
+    if len(mount) == 0:
+        print("ERROR: sysfs is not mounted")
+        sys.exit(1)
+
+sunrpc = pathlib.Path(mount[0]) / "kernel" / "sunrpc"
+if not sunrpc.is_dir():
+    print("ERROR: sysfs does not have sunrpc directory")
+    sys.exit(1)
+
+parser = argparse.ArgumentParser()
+
+def show_small_help(args):
+    parser.print_usage()
+    print("sunrpc dir:", sunrpc)
+parser.set_defaults(func=show_small_help)
+
+args = parser.parse_args()
+args.func(args)
-- 
2.35.1

