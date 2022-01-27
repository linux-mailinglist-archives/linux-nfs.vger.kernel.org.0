Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68D9549EB57
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Jan 2022 20:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245746AbiA0TuA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Jan 2022 14:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245709AbiA0TuA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Jan 2022 14:50:00 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8793C061714
        for <linux-nfs@vger.kernel.org>; Thu, 27 Jan 2022 11:49:59 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id w6so3434937qtk.4
        for <linux-nfs@vger.kernel.org>; Thu, 27 Jan 2022 11:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4eEDJovFmlLJ20QpwaSMs9dThSXRbe6m7jUaKUNoouM=;
        b=bLu5Fxy8NUZLTcIjzE7WDXEN7OTuSS4vNpGvo6/2kNElT6OHDr2Sl3bXc8vqvEdKso
         CfzWZaIG1pklcqcP8pk9Jh75iNNpD4pLcClTKY9hLlWtwVQXMozUtJV6Az2Zbr43huBo
         U409T3VRSCffbbXa2cARGUO05D2RcK6QTXhktMscdidb6Re/f4552dqQwzAuakfO/kXF
         qXI6rZY54rmUohETmJkErNVrKv0qh1bsfniWU9j9vQcnimMJ8emNkJlpXVbnpQ/eW5dK
         6RYrytfOX4mizgzhw4y0yiChlAspSLfKibqShUp9uM+LQUmElv5Kk9jx6BxNW4rFh72k
         ZR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=4eEDJovFmlLJ20QpwaSMs9dThSXRbe6m7jUaKUNoouM=;
        b=Pz7mKI3bkasfGGrdmNYwle/+tUpKPPvzBbSYC9FvS20kHG2JibeXrhBjal1kx2Av42
         63258TuLpNTokbHVCvWR25VEBHDXGJJWnSZnCcjsBMYZKyZNZfrRyr50jkXDSGEECC2K
         Ncb96QzlYqSNEu8Kz5BYfsuIIaUEB5rcm/Ct8FG0iZjMLpvzaPtkfAKM/nzmm191IGv+
         zYuoxkbEhNmJrFivGqtevLJUv0QZOA50NRR5RH9MwAdjpaamPNmNhxiR9+JFh30UohHn
         IQ9eF5+UOgsJrgcMv5DUoPM91FCoMn6KhNLKY/kf5HAsLX/YWzCG0WVXYEKv2OcfG/Fg
         Xpwg==
X-Gm-Message-State: AOAM530WN1Cg8Kzjx6RYFFBKVksOnbFWbIMI+SL+wHWnMSrUk1SBnISC
        VyyXUnrQJEotUwC6fMw8Ji01UNmYd0I=
X-Google-Smtp-Source: ABdhPJxOFvh1Xx5CQpbtYTWprWp2VhA4RSNZfuhMwx2CE/vaU2IZuA7i9qzjeNnHArhLieG1c5RO8Q==
X-Received: by 2002:a05:622a:38a:: with SMTP id j10mr4028514qtx.315.1643312998850;
        Thu, 27 Jan 2022 11:49:58 -0800 (PST)
Received: from gouda.nowheycreamery.com ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id g7sm1836483qkc.104.2022.01.27.11.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 11:49:58 -0800 (PST)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v7 7/9] rpcctl: Add a command for changing xprt state
Date:   Thu, 27 Jan 2022 14:49:50 -0500
Message-Id: <20220127194952.63033-8-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220127194952.63033-1-Anna.Schumaker@Netapp.com>
References: <20220127194952.63033-1-Anna.Schumaker@Netapp.com>
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
 tools/rpcctl/rpcctl.py | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/tools/rpcctl/rpcctl.py b/tools/rpcctl/rpcctl.py
index 9404b975e33d..0771c4e0d0b1 100755
--- a/tools/rpcctl/rpcctl.py
+++ b/tools/rpcctl/rpcctl.py
@@ -46,9 +46,7 @@ class Xprt:
         self.info = read_info_file(path / "xprt_info")
         self.dstaddr = read_addr_file(path / "dstaddr")
         self.srcaddr = read_addr_file(path / "srcaddr")
-
-        with open(path / "xprt_state") as f:
-            self.state = ','.join(f.readline().split()[1:])
+        self.read_state()
 
     def __lt__(self, rhs):
         return self.id < rhs.id
@@ -72,9 +70,16 @@ class Xprt:
                f"backlog {self.info['backlog_q_len']}, tasks {self.info['tasks_queuelen']}"
 
     def __str__(self):
+        if not self.path.exists():
+            return f"xprt {self.id}: has been removed"
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
@@ -83,6 +88,11 @@ class Xprt:
         resolved = socket.gethostbyname(newaddr)
         self.dstaddr = write_addr_file(self.path / "dstaddr", resolved)
 
+    def set_state(self, state):
+        with open(self.path / "xprt_state", 'w') as f:
+            f.write(state)
+        self.read_state()
+
     def add_command(subparser):
         parser = subparser.add_parser("xprt", help="Commands for individual xprts")
         parser.add_argument("--id", metavar="ID", nargs=1, type=int, help="Id of a specific xprt to show")
@@ -92,6 +102,10 @@ class Xprt:
         parser = subparser.add_parser("set", help="Set an xprt property")
         parser.add_argument("--id", metavar="ID", nargs=1, type=int, required=True, help="Id of a specific xprt to modify")
         parser.add_argument("--dstaddr", metavar="dstaddr", nargs=1, type=str, help="New dstaddr to set")
+        parser.add_argument("--offline", action="store_true", help="Set an xprt offline")
+        parser.add_argument("--online", action="store_true", help="Set an offline xprt back online")
+        parser.add_argument("--remove", action="store_true", help="Remove an xprt")
+
         parser.set_defaults(func=Xprt.set_property)
 
     def list_all(args):
@@ -112,6 +126,13 @@ class Xprt:
         try:
             if args.dstaddr != None:
                 xprt.set_dstaddr(args.dstaddr[0])
+            if args.offline:
+                 xprt.set_state("offline")
+            elif args.online:
+                xprt.set_state("online")
+            elif args.remove:
+                xprt.set_state("offline")
+                xprt.set_state("remove")
             print(xprt)
         except Exception as e:
             print(e)
-- 
2.35.0

