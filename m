Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFD93E303C
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Aug 2021 22:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244845AbhHFUSD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Aug 2021 16:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244843AbhHFUSD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Aug 2021 16:18:03 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2344EC0613CF
        for <linux-nfs@vger.kernel.org>; Fri,  6 Aug 2021 13:17:47 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id o13so11215367qkk.9
        for <linux-nfs@vger.kernel.org>; Fri, 06 Aug 2021 13:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BEv+jmiol5oBFuUYDafXvybYRbXLmvt5HuyjSVgRuHI=;
        b=PG+6hTXuHFENkmLF3WEA/lYTYGimAlYH8Ku56Os8yrv+Pku2T/GFxcbMHK34zpddKz
         icXXRgtdqmCKrFQuSRCGgAD97qbaeAWrKR2RB3/YiZrMKjovUyhh+jxgD5G6AkKbXDYv
         tD1m3AzRMU/y9wbnLpC2RPMNb/ud2wX2/Gh6N/oqv4rQo8oJ11/u08jh5che4OWEwonp
         ahgXdQu1ZnT1W3q0CPtLXfD/3f1XY0QtWkvY6t1dAMeS2QenJDabvemXbReaSoeJ6j0m
         lGTaN7AO9DRFCg2fQuE0V2nMCfMhlCVbLDn3lstcF16WwO7Dcuc5J2Jq34rQoTzJGcJ8
         z3rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=BEv+jmiol5oBFuUYDafXvybYRbXLmvt5HuyjSVgRuHI=;
        b=rRk3XG0XvvBLUbowkOwbwK9URRfb2qXKYJFEnTj4ga17d5nvsZehQOoYUlHZgIgREx
         4bB7uDmMGUbX0ib9WvOf5YV+Da2bjUQd2r1TfV6/k66ClhzAnAhMvhxxJGhnydhe1yEU
         FpAJ2UDwySziteTbRsfHj8JtpwAjykE4vY3f5JfeEeWcI4kmX0JrHiMqz1zMwfZpfWB9
         U7QmC5by/Ca4bGXqGwBhcMIO7nruf66zpG0cQmWCNwz9B7wD6eLoNLBzQj2oozcGtwaI
         Lp5z33F5oVLNMBnS/UDlcy55NM006xzIGX4RCPyB/LNW/BzRmqREwCLbeQBcWQrjOAas
         IMaQ==
X-Gm-Message-State: AOAM530H2zJlenNKFCrTACLZBaNmq8XEDhnZcII1wNmtgxM7Ro9cX4PR
        vYm14g1HHzdWOEpgzyBGtXR+IBvQAVxCMQ==
X-Google-Smtp-Source: ABdhPJyYFBBvSDcPCUvsNYs0TQSZhNF5cdjDmman4VPmbJlEJPd9ME9dimF2KjhG5n2g93Oq7gAZEw==
X-Received: by 2002:a37:84c1:: with SMTP id g184mr12144518qkd.102.1628281066247;
        Fri, 06 Aug 2021 13:17:46 -0700 (PDT)
Received: from localhost.localdomain ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id g11sm3705720qtk.91.2021.08.06.13.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 13:17:45 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v2 5/9] nfs-sysfs.py: Add a command for changing xprt dstaddr
Date:   Fri,  6 Aug 2021 16:17:35 -0400
Message-Id: <20210806201739.472806-6-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210806201739.472806-1-Anna.Schumaker@Netapp.com>
References: <20210806201739.472806-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

Using the socket module for dns resolution

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 tools/nfs-sysfs/xprt.py | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/nfs-sysfs/xprt.py b/tools/nfs-sysfs/xprt.py
index fbdd9bfc9375..2160cb0a9575 100644
--- a/tools/nfs-sysfs/xprt.py
+++ b/tools/nfs-sysfs/xprt.py
@@ -1,3 +1,4 @@
+import socket
 import sysfs
 
 class Xprt:
@@ -34,6 +35,12 @@ class Xprt:
         return "xprt %s: %s, %s%s" % (self.id, self.type, self.dstaddr,
                                      f" [main]" if self.main_xprt else "" )
 
+    def set_dstaddr(self, newaddr):
+        resolved = socket.gethostbyname(newaddr)
+        with open(self.path / "dstaddr", 'w') as f:
+            f.write(resolved)
+        self.dstaddr = open(self.path / "dstaddr", 'r').readline().strip()
+
 
 def list_xprts(args):
     xprts = [ Xprt(f) for f in (sysfs.SUNRPC / "xprt-switches").glob("**/xprt-*") ]
@@ -42,7 +49,28 @@ def list_xprts(args):
         if args.id == None or xprt.id == args.id[0]:
             print(xprt)
 
+def get_xprt(id):
+    xprts = [ Xprt(f) for f in (sysfs.SUNRPC / "xprt-switches").glob("**/xprt-*") ]
+    for xprt in xprts:
+        if xprt.id == id:
+            return xprt
+
+def set_xprt_property(args):
+    xprt = get_xprt(args.id[0])
+    try:
+        if args.dstaddr != None:
+            xprt.set_dstaddr(args.dstaddr[0])
+        print(xprt)
+    except Exception as e:
+        print(e)
+
 def add_command(subparser):
     parser = subparser.add_parser("xprt", help="Commands for individual xprts")
     parser.add_argument("--id", metavar="ID", nargs=1, type=int, help="Id of a specific xprt to show")
     parser.set_defaults(func=list_xprts)
+
+    subparser = parser.add_subparsers()
+    parser = subparser.add_parser("set", help="Set an xprt property")
+    parser.add_argument("--id", metavar="ID", nargs=1, type=int, required=True, help="Id of a specific xprt to modify")
+    parser.add_argument("--dstaddr", metavar="dstaddr", nargs=1, type=str, help="New dstaddr to set")
+    parser.set_defaults(func=set_xprt_property)
-- 
2.32.0

