Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7FB943E860
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Oct 2021 20:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbhJ1Shz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Oct 2021 14:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbhJ1Shy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Oct 2021 14:37:54 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6F3C061767
        for <linux-nfs@vger.kernel.org>; Thu, 28 Oct 2021 11:35:27 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id i9so6282964qki.3
        for <linux-nfs@vger.kernel.org>; Thu, 28 Oct 2021 11:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P96dwD493nRuMBr4TlxvNv4S0sXk48KeDkmUiAdO3Kg=;
        b=Xb8IgEz3Shr4Wqa1rcWGedbEXIdRCKt+LWieHT44pMDohsSRAvuAw55ccbU8dtW22G
         V/NFgOVRvARbYozM7YvhHfV1JtBmMYYTNfDt0hD9PJWi41l9JJR9fult+Oya/KKI6VY8
         TvyXYQaPvjYIB7H4YhbWtsVfUFA7SE69t8+2Y6qJyEYHKDyoNsfzH3huZxv5SxAcOzaO
         Uz6zVVF7RV2/34ylhIuRPezVNi5Ydx6XWZItKFTP6PBh2/9CKRHqPhrVmzmp6Lje1n7N
         vwIzMeaOZ1YPsaFNysCom4wWOOYqRBO9LuqEVUapK1qhDW+pW4/z9BL/7B5tQfe5EXhK
         fwkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=P96dwD493nRuMBr4TlxvNv4S0sXk48KeDkmUiAdO3Kg=;
        b=O5szaZY++veVY1prcyxqWQ0qvqFNM7wbWzSeWJvmJAXsekRjN6ayUvnNG4Q7B7yQNW
         yh69+wLeUF/+z/7g+j95i1SB2vF3pH+zgDj+urPDiri4WYS7UWhPHummNBomsy3gIodi
         e4WitdwAHGp4cK3X7PXijgLl/gO+Cgv1HMv0wS1jFOJ1WcCe49GObAzCYa1BVdII305S
         3mG4hAV3xp8UDVkuq6ymq66NdfbrKNb4a8KaGWylWfDdR13HcW9txiF9hqgcyYgYwfI3
         JVPVf5m3y54newqgRSgukbEvXl+QdDVgnIDhMj+2LiQQFk1gjRnK158ePSETlRMPL1gY
         sIXw==
X-Gm-Message-State: AOAM533mNvd+HtmtMmw+FnS40Tap9J3EUwKWZANf5X6gsEdErOU9d5qf
        UnxzUs0lHHzChn6zyO1CPPY=
X-Google-Smtp-Source: ABdhPJwwOBWE2II6D5Wx5Y08cmT81WJWFXL/KMvk33C6Lv3YKJbFqaoacajoDKGb9FzevsoR/bgciA==
X-Received: by 2002:ae9:ef0d:: with SMTP id d13mr5043757qkg.290.1635446126220;
        Thu, 28 Oct 2021 11:35:26 -0700 (PDT)
Received: from gouda.nowheycreamery.com ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id q13sm2556476qkl.7.2021.10.28.11.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 11:35:25 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v5 5/9] rpcctl: Add a command for changing xprt dstaddr
Date:   Thu, 28 Oct 2021 14:35:15 -0400
Message-Id: <20211028183519.160772-6-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211028183519.160772-1-Anna.Schumaker@Netapp.com>
References: <20211028183519.160772-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

Using the socket module for dns resolution

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 tools/rpcctl/sysfs.py |  5 +++++
 tools/rpcctl/xprt.py  | 26 ++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/tools/rpcctl/sysfs.py b/tools/rpcctl/sysfs.py
index c05d2d591175..27726c56bb80 100644
--- a/tools/rpcctl/sysfs.py
+++ b/tools/rpcctl/sysfs.py
@@ -27,6 +27,11 @@ def read_addr_file(path):
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
diff --git a/tools/rpcctl/xprt.py b/tools/rpcctl/xprt.py
index f8c8110eeed6..1201140ce5af 100644
--- a/tools/rpcctl/xprt.py
+++ b/tools/rpcctl/xprt.py
@@ -1,3 +1,4 @@
+import socket
 import sysfs
 
 class Xprt:
@@ -41,6 +42,10 @@ class Xprt:
         main = " [main]" if self.info.get("main_xprt") else ""
         return f"xprt {self.id}: {self.type}, {self.dstaddr}{main}"
 
+    def set_dstaddr(self, newaddr):
+        resolved = socket.gethostbyname(newaddr)
+        self.dstaddr = sysfs.write_addr_file(self.path / "dstaddr", resolved)
+
 
 def list_xprts(args):
     xprts = [ Xprt(f) for f in (sysfs.SUNRPC / "xprt-switches").glob("**/xprt-*") ]
@@ -49,7 +54,28 @@ def list_xprts(args):
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
2.33.1

