Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A23EF49BBCD
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jan 2022 20:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiAYTJz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jan 2022 14:09:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiAYTJx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jan 2022 14:09:53 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB6CC06173B
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jan 2022 11:09:53 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id g11so20235043qvu.3
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jan 2022 11:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PIWBNnsksAL2n2J/iW8XJV9eJgoiGZJ8Gy0i0a++uEU=;
        b=fstn4Xgba3zBbYwlgtF3pkscIsJ/6u9hAXLM0w7xZr1NKmL3AmYznTvmkJFxAa14xh
         Ko9tYuysgqb2Shw50OE1TR5UTa42XzDZ9d1XEiVWC1Y7j3ffiez+KCDvh5WcM8m4ZkUD
         F5McHxNKzo6J3ck53zRLNkVZDVtLhX0dGo1bNf2u8qPoIfDt0HuoQAH7Zmx4ukrQdcK4
         EkABnDWhwgbCRFZZR1Qsz4vTMUDkOQBwsBu+LCVNeYi4U7fZVBNY962V1rHnrPBrzOdo
         FqzMYu2hiiNBFekKK/CRRDY1mKExt4X47CVzaasmjr/QF68zUJy3zqiKmXE6PHSIQze3
         a25w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=PIWBNnsksAL2n2J/iW8XJV9eJgoiGZJ8Gy0i0a++uEU=;
        b=HLgtkOle621ATe8ZepcebHMICJ84FwDYaBZrrRWw8/Aq6O+mXBuznixHiZ9ZNBuJ4g
         28lcCoUv9a/EQYqFYd5mMAz1+siLdPburFToAxor/yD9UQa9Pg0gd9GAGrfYtogMPtu4
         ZgwBEYWrIceWFkOWiGKW++gIpXBYSbvANcs452CgyfOOp9HvJIyxpRD32vp1BXRb6C3A
         jcgdix/YJod79M+x3LnjYj7NtL8A0E7vz0mqU2X17BDfQMqcKXn245ThUZFa+lecyAOR
         snvZH7HqX3XSC+AxKLix3ldA4t2uNC2QMEMDjfhDHCDKiGL+/BYkWiFP5DbG0qdqnDqb
         DU7g==
X-Gm-Message-State: AOAM530xU8BDD2K5dD75KLn3YxA2ZFARNhmv9p+IQ7MNs4YZJyL4bJ5m
        BVSf45V8C0KQrrMroIjo618=
X-Google-Smtp-Source: ABdhPJyvy9e1diJhoyIDeoRr4WOAJxwLufObRALXMlY/aca+zjvGphwQ1frb+u8c+vA1iI58DQlSxA==
X-Received: by 2002:ad4:5be6:: with SMTP id k6mr20426222qvc.69.1643137792426;
        Tue, 25 Jan 2022 11:09:52 -0800 (PST)
Received: from gouda.nowheycreamery.com ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id n6sm34802qtx.23.2022.01.25.11.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 11:09:52 -0800 (PST)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v6 5/9] rpcctl: Add a command for changing xprt dstaddr
Date:   Tue, 25 Jan 2022 14:09:42 -0500
Message-Id: <20220125190946.23586-6-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220125190946.23586-1-Anna.Schumaker@Netapp.com>
References: <20220125190946.23586-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

Using the socket module for dns resolution

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
v6: Continued work to squash into a single file
---
 tools/rpcctl/rpcctl.py | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tools/rpcctl/rpcctl.py b/tools/rpcctl/rpcctl.py
index 169a2a3c0ef9..a5f83c46298f 100755
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
2.34.1

