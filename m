Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85371437FB1
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Oct 2021 22:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234190AbhJVU6c (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Oct 2021 16:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbhJVU6b (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Oct 2021 16:58:31 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D625C061764
        for <linux-nfs@vger.kernel.org>; Fri, 22 Oct 2021 13:56:13 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id g20so5951976qka.1
        for <linux-nfs@vger.kernel.org>; Fri, 22 Oct 2021 13:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EbjeUo61Z/sdKXb9bGRqmA2PDU0uib8xLroHBEERW8E=;
        b=MAyXEbW/iKRmJ4vo1lOcFLv7Khmk1PyR7ICt3BIyAjaY5qLuR8RW6bvMSfz9celP4x
         9kn43SM93RxYhmZoX9SpFr+vkzpXRCEifMf6GKJzU/iIZiP2Rx5dtJifQwIGoZE9Dm1+
         X9ZX+tAiksXApzemXcf7gL08efHmGvk0oW7T0uweg/2ST7coCsRA3veYKs4d+7Ti34gn
         MptYTg11B2/jzy+CikbiJLpLsDW0T396Chz8ceuRbW+837UwqoFcqMDwZaMZCnacpP/J
         tQTwi5Yloxm0eBjJY6+NFuAmZ7O2zeQzEHecSGPsH8NbQvY6CjKzoAhX3MxnKLeFnSgr
         BIcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=EbjeUo61Z/sdKXb9bGRqmA2PDU0uib8xLroHBEERW8E=;
        b=3Atn+YlhnyXMbaHsslK23m3RR4RcJ1p5RLJSpL0dpjeIBz48k9lq+M0eWhlRg4Hifp
         MPUfcXxWlHtwpdQeg2XbTRS92zt7IDtLn4gKB75NxWx+gGVjF/aA7IjMc6Ade/2mTy9n
         7LjgxbsOnXs9oY45Zf09awI2slzhKY2WL9SGFX5QQTHxRPxf+AtjL+jMKWxhCCNztnyD
         qo3tZOZ1Rk8Z3GRGZhORCpVAWl0v0YaDhswLHXJLq3OlHGWn2D5ugsg+QeQQFFlzQz+d
         e2z+6cjEG9t9y0DyuwYtWxRPWbqmQd4IIzqrbQBziPPvZO52lYCjICZP4trWIGxxUePu
         ghyQ==
X-Gm-Message-State: AOAM5336MPGxGu+02VI7L4c+mYWp3zeBu+fwmJ+F/R+qZW7h/hXno0LL
        oNHsLEw42Msw86/FE7ARBDPtNZV8cP0=
X-Google-Smtp-Source: ABdhPJyEgzViXrMwN3uztMkRhmCiMdKHjx7p7+fJaOxfALSHfFhWzqM9hUrbKYRQfPz7w5s8SiJB7A==
X-Received: by 2002:a37:b4c2:: with SMTP id d185mr2018692qkf.504.1634936172314;
        Fri, 22 Oct 2021 13:56:12 -0700 (PDT)
Received: from gouda.nowheycreamery.com ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id p9sm4576279qki.51.2021.10.22.13.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 13:56:12 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v4 7/9] rpcsys: Add a command for changing xprt state
Date:   Fri, 22 Oct 2021 16:56:04 -0400
Message-Id: <20211022205606.66392-8-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211022205606.66392-1-Anna.Schumaker@Netapp.com>
References: <20211022205606.66392-1-Anna.Schumaker@Netapp.com>
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
 tools/rpcsys/xprt.py | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/tools/rpcsys/xprt.py b/tools/rpcsys/xprt.py
index 2160cb0a9575..9426c99dae2b 100644
--- a/tools/rpcsys/xprt.py
+++ b/tools/rpcsys/xprt.py
@@ -8,15 +8,18 @@ class Xprt:
         self.type = str(path).rsplit("-", 2)[2]
         self.dstaddr = open(path / "dstaddr", 'r').readline().strip()
         self.srcaddr = open(path / "srcaddr", 'r').readline().strip()
+        self.exists = True
 
-        with open(path / "xprt_state") as f:
-            self.state = ','.join(f.readline().split()[1:])
+        self.read_state()
         self.__dict__.update(sysfs.read_info_file(path / "xprt_info"))
 
     def __lt__(self, rhs):
         return self.id < rhs.id
 
     def __str__(self):
+        if not self.exists:
+            return "xprt %s: has been removed" % self.id
+
         state = self.state
         if self.main_xprt:
             state = "MAIN," + self.state
@@ -31,6 +34,13 @@ class Xprt:
                 (self.binding_q_len, self.sending_q_len, self.pending_q_len, self.backlog_q_len, self.tasks_queuelen)
         return line
 
+    def read_state(self):
+        if not self.path.exists():
+            self.exists = False
+            return
+        with open(self.path / "xprt_state") as f:
+            self.state = ','.join(f.readline().split()[1:])
+
     def small_str(self):
         return "xprt %s: %s, %s%s" % (self.id, self.type, self.dstaddr,
                                      f" [main]" if self.main_xprt else "" )
@@ -41,6 +51,11 @@ class Xprt:
             f.write(resolved)
         self.dstaddr = open(self.path / "dstaddr", 'r').readline().strip()
 
+    def set_state(self, state):
+        with open(self.path / "xprt_state", 'w') as f:
+            f.write(state)
+        self.read_state()
+
 
 def list_xprts(args):
     xprts = [ Xprt(f) for f in (sysfs.SUNRPC / "xprt-switches").glob("**/xprt-*") ]
@@ -60,6 +75,13 @@ def set_xprt_property(args):
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
@@ -73,4 +95,7 @@ def add_command(subparser):
     parser = subparser.add_parser("set", help="Set an xprt property")
     parser.add_argument("--id", metavar="ID", nargs=1, type=int, required=True, help="Id of a specific xprt to modify")
     parser.add_argument("--dstaddr", metavar="dstaddr", nargs=1, type=str, help="New dstaddr to set")
+    parser.add_argument("--offline", action="store_true", help="Set an xprt offline")
+    parser.add_argument("--online", action="store_true", help="Set an offline xprt back online")
+    parser.add_argument("--remove", action="store_true", help="Remove an xprt")
     parser.set_defaults(func=set_xprt_property)
-- 
2.33.1

