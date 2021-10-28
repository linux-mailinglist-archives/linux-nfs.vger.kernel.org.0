Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5590843E863
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Oct 2021 20:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbhJ1Sh5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Oct 2021 14:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbhJ1Sh4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Oct 2021 14:37:56 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E31C061570
        for <linux-nfs@vger.kernel.org>; Thu, 28 Oct 2021 11:35:29 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id h20so6757508qko.13
        for <linux-nfs@vger.kernel.org>; Thu, 28 Oct 2021 11:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pW5tXAaUICrJYuOC0zQmWxczkFbo232hvbVpGkDJMBo=;
        b=Ix4Xcdu8u4q9RNOhQXq7WcB7YjAHdxg+riugvpEjI7OVrlyBeNrTrT7jh3F0cZxEC5
         wuW0WtB/b1CJw8ba5BIFjnxq3J3Up8/2DnYUl4VghF12MP2vaslsmxKJxgj55LKR9j2F
         XfL+HjTRHMUL5FHk0toewTtpVLFNLTAwU1ls8lMFhKiKtKd4MVLk0WSaqY9o4Ojn9Xss
         HNEbwYvz1KMmCmAlQDbAl0eXZsmRtaC7rxCrmHJDd/PD/9eqgA2W9PU0Jtvv1l3fMzck
         mI+G2HuxCJYCy7P2OFQuo6HRsm/v8P7V9+RMwChCRpqqIGFqyGiNmUm603ZIO72SLHeD
         48mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=pW5tXAaUICrJYuOC0zQmWxczkFbo232hvbVpGkDJMBo=;
        b=Gl/YJt+0JJWXC9qe7aL9MRve/vUM/aNNzJk5GpRnrqtVLDbklIjwuMkfbrHZxFdxIB
         B94BizFqaqZ6ORpkKUhxXGpFkeq2/ypa5fpQbWXGDCGxINwOb+/mmA+tJUQkYNujkaqs
         m2jxOn1GYhikk0PfavmK0GD2XvGxADBuPCcTS1ecsMwIx0mXFhtLe8XxaWrUTXo8UdVN
         RhZxrvWCuCjVX9kBIQRXecRtwk1xctqnzlD/skIm9ij1lb8pf0YUo/+2VsGB9zurE92w
         Pa4NsyWqFBpQlKant/3beYvSQ5IAqVMUB0UjBNiXl9WFvX6fx7scik/IGX+hDyUxi2fo
         s4kw==
X-Gm-Message-State: AOAM5334+/l3tWzaGhR2MDU64yEHVCdOek2sSu1NWn+3krusawJRx04Y
        I0eHDX4yFUtEtmBZk+uXm5Q=
X-Google-Smtp-Source: ABdhPJyfMwavi2EAKfj8gMDm0/TypPmrkWv7WUbPditw94VeG3WNScc2kTDUs3SFn7EAuCD15Jwbqg==
X-Received: by 2002:a05:620a:578:: with SMTP id p24mr5142990qkp.237.1635446128096;
        Thu, 28 Oct 2021 11:35:28 -0700 (PDT)
Received: from gouda.nowheycreamery.com ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id q13sm2556476qkl.7.2021.10.28.11.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 11:35:27 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v5 7/9] rpcctl: Add a command for changing xprt state
Date:   Thu, 28 Oct 2021 14:35:17 -0400
Message-Id: <20211028183519.160772-8-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211028183519.160772-1-Anna.Schumaker@Netapp.com>
References: <20211028183519.160772-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

We can set it offline or online, or we can remove an xprt. The kernel
only supports removing offlined transports, so we make sure to set the
state to "offline" before sending the remove command.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 tools/rpcctl/xprt.py | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/tools/rpcctl/xprt.py b/tools/rpcctl/xprt.py
index 1201140ce5af..92db756c8374 100644
--- a/tools/rpcctl/xprt.py
+++ b/tools/rpcctl/xprt.py
@@ -9,9 +9,7 @@ class Xprt:
         self.info = sysfs.read_info_file(path / "xprt_info")
         self.dstaddr = sysfs.read_addr_file(path / "dstaddr")
         self.srcaddr = sysfs.read_addr_file(path / "srcaddr")
-
-        with open(path / "xprt_state") as f:
-            self.state = ','.join(f.readline().split()[1:])
+        self.read_state()
 
     def __lt__(self, rhs):
         return self.id < rhs.id
@@ -35,9 +33,16 @@ class Xprt:
                f"backlog {self.info['backlog_q_len']}, tasks {self.info['tasks_queuelen']}"
 
     def __str__(self):
+        if not self.path.exists():
+            return f"xprt {self.id}: has been removed" % self.id
         return "\n".join([self._xprt(), self._src_reqs(),
                           self._cong_slots(), self._queues() ])
 
+    def read_state(self):
+        if self.path.exists():
+            with open(self.path / "xprt_state") as f:
+                self.state = ','.join(f.readline().split()[1:])
+
     def small_str(self):
         main = " [main]" if self.info.get("main_xprt") else ""
         return f"xprt {self.id}: {self.type}, {self.dstaddr}{main}"
@@ -46,6 +51,11 @@ class Xprt:
         resolved = socket.gethostbyname(newaddr)
         self.dstaddr = sysfs.write_addr_file(self.path / "dstaddr", resolved)
 
+    def set_state(self, state):
+        with open(self.path / "xprt_state", 'w') as f:
+            f.write(state)
+        self.read_state()
+
 
 def list_xprts(args):
     xprts = [ Xprt(f) for f in (sysfs.SUNRPC / "xprt-switches").glob("**/xprt-*") ]
@@ -65,6 +75,13 @@ def set_xprt_property(args):
     try:
         if args.dstaddr != None:
             xprt.set_dstaddr(args.dstaddr[0])
+        if args.offline:
+            xprt.set_state("offline")
+        elif args.online:
+            xprt.set_state("online")
+        elif args.remove:
+            xprt.set_state("offline")
+            xprt.set_state("remove")
         print(xprt)
     except Exception as e:
         print(e)
@@ -78,4 +95,7 @@ def add_command(subparser):
     parser = subparser.add_parser("set", help="Set an xprt property")
     parser.add_argument("--id", metavar="ID", nargs=1, type=int, required=True, help="Id of a specific xprt to modify")
     parser.add_argument("--dstaddr", metavar="dstaddr", nargs=1, type=str, help="New dstaddr to set")
+    parser.add_argument("--offline", action="store_true", help="Set an xprt offline")
+    parser.add_argument("--online", action="store_true", help="Set an offline xprt back online")
+    parser.add_argument("--remove", action="store_true", help="Remove an xprt")
     parser.set_defaults(func=set_xprt_property)
-- 
2.33.1

