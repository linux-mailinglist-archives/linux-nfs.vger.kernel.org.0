Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63F2639FE20
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jun 2021 19:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbhFHRuL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Jun 2021 13:50:11 -0400
Received: from mail-qt1-f178.google.com ([209.85.160.178]:43545 "EHLO
        mail-qt1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233156AbhFHRuL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Jun 2021 13:50:11 -0400
Received: by mail-qt1-f178.google.com with SMTP id 93so8577846qtc.10
        for <linux-nfs@vger.kernel.org>; Tue, 08 Jun 2021 10:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A8+RkubmhiUGlgMZbxD8YgREz+LPON5cuR6XCKvqkKU=;
        b=UV9LDJyyYQiH4bFg6ZAbkNJ/HBa7XAn7CfH5eQXO7AGVQAXttO0QcVKyKWOHehu5Fq
         0Ju82HCWsZGlbJKjQ1mw4wKv7KYxtYpC9IGg1KfsIBx9WGZIgEOEquSOLS+YTslu3A41
         ylymGAubhxyWP5RmhqyZQ6z9WVjE3BFYIb9hUFeRl+OOrNUUJUuwySPQ8727Oc3kBM9G
         hmmBTWQrI3wnHfXdySTDtuxb0OzSX+oggwnwjQeGhdvRQJ5lnRmCDq/SFkeUD/WGMwT6
         eFTDOsEapImga+mC+j01UFk6AlzMNJRva6OUNeCwH8IJN/Vo0+Whi3coKCT3l0TizA8k
         b4gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=A8+RkubmhiUGlgMZbxD8YgREz+LPON5cuR6XCKvqkKU=;
        b=V0Z2tggaun0Qo+71bvPwNX28Fa7KjHl5auy/ttEuBjanoUBYnr4jjaSfC0PadyiZ1b
         E2iyrjYk0kOJ+2XCzFa6bk/giH3r33LM7LTmdGyJCEptF1OJKHt5gFrBRgDktMpEd/yg
         BUxhDqOkJ79u3BnjW9CmCkxWsNpUE072fi2IjNWmnrc4F/1Xl90loXVsyLyHz6Lo1ZE7
         vCWnFfPsWmS22YVGfMnr/e9Ixdmq048Gck6XVwdZrT6SnWyxXfKq6v3gVABfJ0Vn4uya
         h5kIZBTNdOjidfIlWfDL+1yyt2/Wc0ikb3Tu+cXjPkbjkQaE1IV7NRreWHTCyBYJFNTy
         +4lg==
X-Gm-Message-State: AOAM5333bh0MnhdSTdhMck34R21J5RKDeYBj2GxDbBjb+0OD0z6cVwA/
        caNpBnDgU+ZZT5RFAPqE4DBJDY+bNRs=
X-Google-Smtp-Source: ABdhPJz6RCLbNA97dFXuGMZoCdhNjD1tmWB98ZF51N/CHZE7W6rIAmSaF/eHbik+hBzkYku06oxr+A==
X-Received: by 2002:ac8:5894:: with SMTP id t20mr9687073qta.281.1623174422980;
        Tue, 08 Jun 2021 10:47:02 -0700 (PDT)
Received: from localhost.localdomain ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id h2sm12963080qkf.106.2021.06.08.10.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 10:47:02 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [RFC PATCH 5/6] nfs-sysfs.py: Add a command for changing xprt dstaddr
Date:   Tue,  8 Jun 2021 13:46:56 -0400
Message-Id: <20210608174657.603256-6-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210608174657.603256-1-Anna.Schumaker@Netapp.com>
References: <20210608174657.603256-1-Anna.Schumaker@Netapp.com>
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
index b95fb2d48829..167e5fa69df7 100644
--- a/tools/nfs-sysfs/xprt.py
+++ b/tools/nfs-sysfs/xprt.py
@@ -1,3 +1,4 @@
+import socket
 import sysfs
 
 class Xprt:
@@ -26,6 +27,12 @@ class Xprt:
     def small_str(self):
         return "xprt %s: %s, %s" % (self.id, self.type, self.dstaddr)
 
+    def set_dstaddr(self, newaddr):
+        resolved = socket.gethostbyname(newaddr)
+        with open(self.path / "dstaddr", 'w') as f:
+            f.write(resolved)
+        self.dstaddr = open(self.path / "dstaddr", 'r').readline().strip()
+
 
 def list_xprts(args):
     xprts = [ Xprt(f) for f in (sysfs.SUNRPC / "xprt-switches").glob("**/xprt-*") ]
@@ -34,7 +41,28 @@ def list_xprts(args):
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

