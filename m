Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E02C93E303E
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Aug 2021 22:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244867AbhHFUSG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Aug 2021 16:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244855AbhHFUSF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Aug 2021 16:18:05 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9F7C0613CF
        for <linux-nfs@vger.kernel.org>; Fri,  6 Aug 2021 13:17:49 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id t66so11290858qkb.0
        for <linux-nfs@vger.kernel.org>; Fri, 06 Aug 2021 13:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qm5U6m2KjT7/L5AwY34w+AvyfUCTptq1jUMCaApc9+M=;
        b=IK/8BcSxgOz0YL3MMB2ZXAR5CMOMoQrZhqrl7svKlZJQyfsh05b1a8qbJgU8ZmhOV/
         odjUOx9Ct792uuJ9sBaGEm7+YSDxLB+6I32PkQyropJNZwt6BtfXRci87R9HusQQeeiJ
         bNdJ/RzRA4ZgU5W6L/gSdjHjn81LAjTNmp6aCTSwoxOUO5uzPptVNfy1F9hhT4m4mEnI
         5Ksi7hYZj6nUwPEp8KkVLPdtydVoU020aVNz29oCwVdJ9RslAEpwbhsxmZfMo7FMGifn
         oSAf849IsbYyjWGaxDMppM9amYTttuy3blFQXXKEHEhRKGwgOdKETKgt9PAXj7VMiFz0
         faUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Qm5U6m2KjT7/L5AwY34w+AvyfUCTptq1jUMCaApc9+M=;
        b=BHFIVPAgsN/J6sHoYX3d/3/N6J/XSrGJAarnVhDlaZGTtTfJLgucTbjsj57nWYpELD
         bhR/Q/1OeW4sS+q8p52uvDCUuckj07zc3/T3X3/6F07AezPu7w/azUtLcHI2tym12fll
         dL9/vesr3WJbXhXE7+XZ2l5iAmLY/JaZ4AS0Z3n354qTu/ihdmUsXO7vV2/Y0yDaaJuI
         U744cQo6hLJaxGB/Ed3Ib1gYpzvCqvFZWaKCuChzePC5n2vBeCI9/kyRaq5hsytd7Hmx
         iO+96Cq8p/zbgojNIa8QLFbhqLPtIPfKRMcd4vMuga8x7g+euQZg7mO0nyavu17787dF
         QXHg==
X-Gm-Message-State: AOAM530csf9EOZpu4pu7jmrVgo4Zl0MCC+SoTSvff//fMJ6nEBCEYnV/
        bzSk9FA71ZYRaWATnCHVvQYJRrwd+jX19w==
X-Google-Smtp-Source: ABdhPJwQj8WIskgAeho3fuG/l8xKb991rt1qgny22a2gI5xuVaff2fkABxztUkHe3pnhAfnV3nN1TQ==
X-Received: by 2002:a37:cc1:: with SMTP id 184mr62960qkm.323.1628281068305;
        Fri, 06 Aug 2021 13:17:48 -0700 (PDT)
Received: from localhost.localdomain ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id g11sm3705720qtk.91.2021.08.06.13.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 13:17:47 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v2 7/9] nfs-sysfs.py: Add a command for changing xprt state
Date:   Fri,  6 Aug 2021 16:17:37 -0400
Message-Id: <20210806201739.472806-8-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210806201739.472806-1-Anna.Schumaker@Netapp.com>
References: <20210806201739.472806-1-Anna.Schumaker@Netapp.com>
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
 tools/nfs-sysfs/xprt.py | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/tools/nfs-sysfs/xprt.py b/tools/nfs-sysfs/xprt.py
index 2160cb0a9575..92b83ebc4cd1 100644
--- a/tools/nfs-sysfs/xprt.py
+++ b/tools/nfs-sysfs/xprt.py
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
+        if self.exists == False:
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
+        if args.offline == True:
+            xprt.set_state("offline")
+        elif args.online == True:
+            xprt.set_state("online")
+        elif args.remove == True:
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
2.32.0

