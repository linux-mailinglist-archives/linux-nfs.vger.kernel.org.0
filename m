Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 853CB3FB980
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Aug 2021 17:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237723AbhH3P6D (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Aug 2021 11:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237526AbhH3P57 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Aug 2021 11:57:59 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2ACC061796
        for <linux-nfs@vger.kernel.org>; Mon, 30 Aug 2021 08:57:01 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id gf5so8544721qvb.9
        for <linux-nfs@vger.kernel.org>; Mon, 30 Aug 2021 08:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HiRxPZuzFnyvuD5q3Dy856rG1m2Sv7MpUGVlgQKyeBA=;
        b=KEuZH9h9n8os/Lp6LxzQ5f/ahxJ1zF7IVosBWhESBfBJqH4uj/+Cy1h88wP8UpB3qx
         EDGq+jYWd/TDzqu3FAYZjDLnqx++i5J8f9XuNWdka/wRoFsx78dWdV7NVAZ7Vr2754SW
         I7IdmMf+qcdRUNrXsizmwIRVSSS/dDDwqqqrFIowuO5YLqhIbDg7Xf5gGTaknRG8ilXH
         4+huxzXHViEatiYyStUaGaGmMYCgx10hiRXCm2csxyXJOwrDY6s+s30zZQd/q/Jx+Wpj
         hkXaJzCEGK1g6MSWVBehKzuCtHiau1WT8d18SoQ5IeLYl1sHfBXd+0M9w6CMOcJFTbfp
         B5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=HiRxPZuzFnyvuD5q3Dy856rG1m2Sv7MpUGVlgQKyeBA=;
        b=LbMIdBUCrYtQJQFalH72Q5LY8KDewPFms+SmYweq2bAxOUxRko8lNoOm3dS7zmdO6I
         n3IW+BxXwJ709zFWsbmqgwN9c8hEEW6mQCqpS+6nBUONAJL/E4OIQWEYNclUy2VCtHOm
         ENHxNLQmNiy/DN3L9FkpQYocKQJUBaN1ryj3y8OXFC1ETC/posJpDw98aQvVZfVkma9r
         plmY0jcuCIrgK6okOo1puk2KtQTMUaaVhNfxguD0royAa8I+3O3jxtQHvC3kknoMhMHb
         KAoAC0dWFIUAxVmU4Vfb111s1yVJ6y+HG5/5T+swzdwcyNN9F8Vz4EGGbqh2C+Cvuybc
         Q0yw==
X-Gm-Message-State: AOAM530lzKOtJTqfcs9b1kQvQ1Ifnb0BCn16DUH327wDwYw0+w0xfU8D
        gUW/mMJ7WmzRqhDUw3a5wUU=
X-Google-Smtp-Source: ABdhPJw5V7aLABXHhRw54PgqzuyWPNtH4isZyib1MLFNjOahopiLDW88hG5E5IlPOIpG9cl1hLvOzw==
X-Received: by 2002:a0c:aac5:: with SMTP id g5mr19459216qvb.23.1630339020728;
        Mon, 30 Aug 2021 08:57:00 -0700 (PDT)
Received: from localhost.localdomain ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id 12sm8585217qtt.16.2021.08.30.08.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 08:57:00 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v3 5/9] nfssysfs.py: Add a command for changing xprt dstaddr
Date:   Mon, 30 Aug 2021 11:56:49 -0400
Message-Id: <20210830155653.1386161-6-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210830155653.1386161-1-Anna.Schumaker@Netapp.com>
References: <20210830155653.1386161-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

Using the socket module for dns resolution

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 tools/nfssysfs/xprt.py | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/nfssysfs/xprt.py b/tools/nfssysfs/xprt.py
index fbdd9bfc9375..2160cb0a9575 100644
--- a/tools/nfssysfs/xprt.py
+++ b/tools/nfssysfs/xprt.py
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
2.33.0

