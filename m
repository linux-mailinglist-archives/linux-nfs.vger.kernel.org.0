Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41DF349BBCF
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jan 2022 20:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiAYTJ4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jan 2022 14:09:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiAYTJz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jan 2022 14:09:55 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05373C06173D
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jan 2022 11:09:55 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id d8so5626421qvv.2
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jan 2022 11:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o7ChbtkeVq8IE39aPHar6/G9s65bWpPz1oGjr0dqfEc=;
        b=nREy9/gF19a1n9sD2jtii6UbovMs7ShWGJNNyEy49us2EENbYSytRWagD5jKr8T8o5
         DBppP8H+HhFroMqt4GVfz7CO7KqBvuAEa48Jr4f5OieYOntlTAvu05UlKOaptjWff5Kk
         ZK2y9DO3r7ao1JoaLKOcPwl7bCTyefrDOPVJMxChHIyp7jBK9XWbzPZXUHSsDSC68OFY
         AEHkJ6fn+KNbNGdy2wqt3dLOEH9zs+vLxDtuVlqJ5cc+BiA4Aw+3k21kjfm7kkYZ8wkb
         9CKfRP9u3o+j/403m9fvAegd/9dSHdbISjyhl42FGyb++FrUh948HYSbLhXXdv9BqKH/
         SjBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=o7ChbtkeVq8IE39aPHar6/G9s65bWpPz1oGjr0dqfEc=;
        b=tR/A2PYDcYfHEunBlrW7U+9gkTsfpgpYkQhShT1EHyo+L3g5HiPO6jILEKDhq32nXt
         LTKYFA33WSM5SawFPNpJE4/8cx/rWGFAdieNYk39h++IYOomKvxxVDjD6l+R4wpllQeJ
         it3MmPcvSVwnThf9hz5eAidHmPibNC1pm20gqPiaD3hANnnmxFOhlQzkpI3cOei24CWn
         U5qVItc5zaKRsyQXXBiongjxpF6SpzPVaiME5GKZ7eQDSugJbhiz0XGbfvdX1pEtfu8p
         JxWlOEukbkPEUKdWC9r7t++mWS76ZCJh906oBoMdJd+bbr/kOKS9ja6ckb4bw56l0kso
         0+Zw==
X-Gm-Message-State: AOAM5315AvYBU8vX3Uf++mCdH6Iu3FL8CfmY/N1y7b8+/K/j4Pn8+Xd0
        ef0vXWmyw2PrseFL+b12ubxr3/8RQ9c=
X-Google-Smtp-Source: ABdhPJz9TwBlbs1HNi5wySySkAgOM1nNAHDw2tHcQuPbo17BeLgp5YA8R3Hqg7RN2FlM0aSxt66I9Q==
X-Received: by 2002:a05:6214:2466:: with SMTP id im6mr8022417qvb.8.1643137794056;
        Tue, 25 Jan 2022 11:09:54 -0800 (PST)
Received: from gouda.nowheycreamery.com ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id n6sm34802qtx.23.2022.01.25.11.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 11:09:53 -0800 (PST)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v6 7/9] rpcctl: Add a command for changing xprt state
Date:   Tue, 25 Jan 2022 14:09:44 -0500
Message-Id: <20220125190946.23586-8-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220125190946.23586-1-Anna.Schumaker@Netapp.com>
References: <20220125190946.23586-1-Anna.Schumaker@Netapp.com>
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
index 0c6c9d0f006c..48e5dd502f3d 100755
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
2.34.1

