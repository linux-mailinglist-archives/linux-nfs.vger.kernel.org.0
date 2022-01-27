Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAA1349EB55
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Jan 2022 20:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245743AbiA0Tt7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Jan 2022 14:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245709AbiA0Tt6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Jan 2022 14:49:58 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E02C061714
        for <linux-nfs@vger.kernel.org>; Thu, 27 Jan 2022 11:49:58 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id b5so3401845qtq.11
        for <linux-nfs@vger.kernel.org>; Thu, 27 Jan 2022 11:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wIr4dYeXuycAWYUtMcxedVBml9BP+YdoGTwnU9TNSYc=;
        b=GcBguoaUdGo11/OFLksJ6gQC5pkJa8BMMBxZ4TQD8LmnJIuOUR9UWeLlRMrpgTZWQO
         zOS9e7+hKv4vbOcUyJZZgNVx5bR01KNG5pdQcCpJ3JD197nbn0yAOmdfJSViJBWuLU3/
         lDmWJJYautMfRcnOiYUSVSQ5DeEf63i1Pl1mg/ws8iZw3hxDOnpWGucT5OUW2+JoGj7d
         wXR740LfC1K0KHwRkOa0+tv6+JvRqJ+e7Gm2vd107BAqOEyZuqC65RD677Do+TQ06d5K
         koCit17bslWxOFYIud6eVz60lt8GXwOx08vT7NnCmwNYqjdPcGj2U8j6/tEE0+7kQScj
         v+jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=wIr4dYeXuycAWYUtMcxedVBml9BP+YdoGTwnU9TNSYc=;
        b=leGcn3Y6WSjsInAthM3lJlqHNqNEwjDSPwDqhDdELx8g55PSFJMdmJliM/Qcn39U32
         JQjN0v7LOvGcSwzgohSG5VwixD4nnWWS32zoq283yXW3pkbkbzg32/NfW/dkdZfsSqR3
         odgzQTXUKy9Qkooo44UImyA46xgRWRrDlfGr3+zgtTlGwxR8TrTG//qE7NFBIb8O/mfF
         nUoBV09HsScvgFq5fvscEtNops1gxYM1w/tGAdosS2ywi8GdnY9pzZ4RssJoSbtZvsiG
         LO7SVjB45WHVsFSK3msZucAi7gAY7JZVSg8Byerkg9haaNTWEb1O4SCU8F07XdO6UU6U
         SzaA==
X-Gm-Message-State: AOAM530PCKj/8g8ZMk7rDbK7dEut7B2WQZ9z6X6H6g629BZJcpzeKC2/
        T0WDZREDzclfRJRz+zKAz9k=
X-Google-Smtp-Source: ABdhPJyrBhyxzFpvKYAHflRNBcorpx5Z/Q7LoXaoT/OJHRrfFqj51Ecdlcx7BPKFgBFeAeo1uDcSiQ==
X-Received: by 2002:a05:622a:593:: with SMTP id c19mr1280673qtb.556.1643312997580;
        Thu, 27 Jan 2022 11:49:57 -0800 (PST)
Received: from gouda.nowheycreamery.com ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id g7sm1836483qkc.104.2022.01.27.11.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 11:49:57 -0800 (PST)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v7 5/9] rpcctl: Add a command for changing xprt dstaddr
Date:   Thu, 27 Jan 2022 14:49:48 -0500
Message-Id: <20220127194952.63033-6-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220127194952.63033-1-Anna.Schumaker@Netapp.com>
References: <20220127194952.63033-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

Using the socket module for dns resolution

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 tools/rpcctl/rpcctl.py | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tools/rpcctl/rpcctl.py b/tools/rpcctl/rpcctl.py
index bdb56d1f5476..c481f96333f9 100755
--- a/tools/rpcctl/rpcctl.py
+++ b/tools/rpcctl/rpcctl.py
@@ -2,6 +2,7 @@
 import argparse
 import collections
 import pathlib
+import socket
 import sys
 
 with open("/proc/mounts", 'r') as f:
@@ -22,6 +23,11 @@ def read_addr_file(path):
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
@@ -73,11 +79,21 @@ class Xprt:
         main = " [main]" if self.info.get("main_xprt") else ""
         return f"xprt {self.id}: {self.type}, {self.dstaddr}{main}"
 
+    def set_dstaddr(self, newaddr):
+        resolved = socket.gethostbyname(newaddr)
+        self.dstaddr = write_addr_file(self.path / "dstaddr", resolved)
+
     def add_command(subparser):
         parser = subparser.add_parser("xprt", help="Commands for individual xprts")
         parser.add_argument("--id", metavar="ID", nargs=1, type=int, help="Id of a specific xprt to show")
         parser.set_defaults(func=Xprt.list_all)
 
+        subparser = parser.add_subparsers()
+        parser = subparser.add_parser("set", help="Set an xprt property")
+        parser.add_argument("--id", metavar="ID", nargs=1, type=int, required=True, help="Id of a specific xprt to modify")
+        parser.add_argument("--dstaddr", metavar="dstaddr", nargs=1, type=str, help="New dstaddr to set")
+        parser.set_defaults(func=Xprt.set_property)
+
     def list_all(args):
         xprts = [ Xprt(f) for f in (sunrpc / "xprt-switches").glob("**/xprt-*") ]
         xprts.sort()
@@ -85,6 +101,21 @@ class Xprt:
             if args.id == None or xprt.id == args.id[0]:
                 print(xprt)
 
+    def get_by_id(id):
+        xprts = [ Xprt(f) for f in (sunrpc / "xprt-switches").glob("**/xprt-*") ]
+        for xprt in xprts:
+            if xprt.id == id:
+                return xprt
+
+    def set_property(args):
+        xprt = Xprt.get_by_id(args.id[0])
+        try:
+            if args.dstaddr != None:
+                xprt.set_dstaddr(args.dstaddr[0])
+            print(xprt)
+        except Exception as e:
+            print(e)
+
 
 class XprtSwitch:
     def __init__(self, path, sep=":"):
-- 
2.35.0

